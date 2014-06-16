From: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Subject: =?utf-8?q?alsa-lib=3A_pcm=5Fplug=3A_fix_float_conver?=
 =?utf-8?q?sion_for_user_specified_ttable?=
Date: Mon, 16 Jun 2014 19:52:51 +0400
Message-ID: <1402933971.835286264@f359.i.mail.ru>
Reply-To: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f359.i.mail.ru (f359.i.mail.ru [217.69.141.1])
 by alsa0.perex.cz (Postfix) with ESMTP id A9135265466
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 17:52:52 +0200 (CEST)
Received: from mail by f359.i.mail.ru with local (envelope-from
 <sergemp@mail.ru>) id 1WwZDH-0003PX-TK
 for alsa-devel@alsa-project.org; Mon, 16 Jun 2014 19:52:52 +0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?YWxzYS1kZXZlbA==?= <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Move custom ttable with equal channels case from a separate ttable_last
exception into a common plugins insertion loop.
Fixes plug with ttable for float pcms (jack, ladspa).
Example: aplay -fFLOAT_LE /dev/zero
pcm.!default {
    type plug
    slave.pcm { type null }
    ttable.0.0 1
}
---
 src/pcm/pcm_plug.c |   36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/src/pcm/pcm_plug.c b/src/pcm/pcm_plug.c
index ede9c15..6d0454f 100644
--- a/src/pcm/pcm_plug.c
+++ b/src/pcm/pcm_plug.c
@@ -53,7 +53,7 @@ typedef struct {
 	const snd_config_t *rate_converter;
 	enum snd_pcm_plug_route_policy route_policy;
 	snd_pcm_route_ttable_entry_t *ttable;
-	int ttable_ok, ttable_last;
+	int ttable_ok;
 	unsigned int tt_ssize, tt_cused, tt_sused;
 } snd_pcm_plug_t;
 
@@ -380,7 +380,7 @@ static int snd_pcm_plug_change_channels(snd_pcm_t *pcm, snd_pcm_t **new, snd_pcm
 	snd_pcm_route_ttable_entry_t *ttable;
 	int err;
 	if (clt->channels == slv->channels &&
-	    (!plug->ttable || !plug->ttable_last))
+	    (!plug->ttable || plug->ttable_ok))
 		return 0;
 	if (clt->rate != slv->rate &&
 	    clt->channels > slv->channels)
@@ -485,13 +485,15 @@ static int snd_pcm_plug_change_format(snd_pcm_t *pcm, snd_pcm_t **new, snd_pcm_p
 	/* No conversion is needed */
 	if (clt->format == slv->format &&
 	    clt->rate == slv->rate &&
-	    clt->channels == slv->channels)
+	    clt->channels == slv->channels &&
+	    (!plug->ttable || plug->ttable_ok))
 		return 0;
 
 	if (snd_pcm_format_linear(slv->format)) {
 		/* Conversion is done in another plugin */
 		if (clt->rate != slv->rate ||
-		    clt->channels != slv->channels)
+		    clt->channels != slv->channels ||
+		    (plug->ttable && !plug->ttable_ok))
 			return 0;
 		cfmt = clt->format;
 		switch (clt->format) {
@@ -525,7 +527,8 @@ static int snd_pcm_plug_change_format(snd_pcm_t *pcm, snd_pcm_t **new, snd_pcm_p
 		if (snd_pcm_format_linear(clt->format)) {
 			cfmt = clt->format;
 			f = snd_pcm_lfloat_open;
-		} else if (clt->rate != slv->rate || clt->channels != slv->channels) {
+		} else if (clt->rate != slv->rate || clt->channels != slv->channels ||
+		           (plug->ttable && !plug->ttable_ok)) {
 			cfmt = SND_PCM_FORMAT_S16;
 			f = snd_pcm_lfloat_open;
 		} else
@@ -641,11 +644,12 @@ static int snd_pcm_plug_insert_plugins(snd_pcm_t *pcm,
 	};
 	snd_pcm_plug_params_t p = *slave;
 	unsigned int k = 0;
-	plug->ttable_ok = plug->ttable_last = 0;
+	plug->ttable_ok = 0;
 	while (client->format != p.format ||
 	       client->channels != p.channels ||
 	       client->rate != p.rate ||
-	       client->access != p.access) {
+	       client->access != p.access ||
+	       (plug->ttable && !plug->ttable_ok)) {
 		snd_pcm_t *new;
 		int err;
 		if (k >= sizeof(funcs)/sizeof(*funcs))
@@ -660,24 +664,6 @@ static int snd_pcm_plug_insert_plugins(snd_pcm_t *pcm,
 		}
 		k++;
 	}
-#ifdef BUILD_PCM_PLUGIN_ROUTE
-	/* it's exception, user specified ttable, but no reduction/expand */
-	if (plug->ttable && !plug->ttable_ok) {
-		snd_pcm_t *new;
-		int err;
-		plug->ttable_last = 1;
-		err = snd_pcm_plug_change_channels(pcm, &new, client, &p);
-		if (err < 0) {
-			snd_pcm_plug_clear(pcm);
-			return err;
-		}
-		assert(err);
-		assert(plug->ttable_ok);
-		plug->gen.slave = new;
-		pcm->fast_ops = new->fast_ops;
-		pcm->fast_op_arg = new->fast_op_arg;
-	}
-#endif
 	return 0;
 }
 
-- 
1.7.10.4
