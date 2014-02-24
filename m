From: Maarten Baert <maarten-baert@hotmail.com>
Subject: Re: [PATCH] Bugfix: Fix resampling when client
 and	slave both use format float
Date: Mon, 24 Feb 2014 21:52:56 +0100
Message-ID: <BLU0-SMTP4567C0162DA792F75B98686E2860@phx.gbl>
References: <BLU0-SMTP134831A0E1EA4F209F321CAE2850@phx.gbl>
 <s5hwqgkyimw.wl%tiwai@suse.de> <BLU0-SMTP25F099B950B03725BED93DE2860@phx.gbl>
 <s5hios4ps18.wl%tiwai@suse.de> <s5hha7opr7l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090606080909080301050105"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s6.blu0.hotmail.com (blu0-omc3-s6.blu0.hotmail.com
 [65.55.116.81]) by alsa0.perex.cz (Postfix) with ESMTP id B436426527F
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 21:53:00 +0100 (CET)
In-Reply-To: <s5hha7opr7l.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--------------090606080909080301050105
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 24/02/14 14:37, Takashi Iwai wrote:

> Looking at the code again, the PCM rate plugin version checks are done
> slightly differently from ext-plugin or io-plugin; it's rather done in
> the plugin side.  pcm_rate.c repeats to trying to hook a plugin until
> it matches by degrading the version.  In the plugin side, it provides
> additional ops depending on the version it's asked.

That complicates things a lot. Currently the format conversion is
decided before the rate conversion is done. If not all rate conversion
plugins support float, then the format conversion plugin needs to know
this ahead of time to make the right decision. Or the plugin insertion
code needs to be changed so the plugins aren't created in a fixed order.
They are currently created back-to-front, it would probably make more
sense to choose a rate conversion and channel remapping plugin first,
and then insert format conversions where needed.

Re-submitting my original patch as requested.

Maarten Baert


--------------090606080909080301050105
Content-Type: text/x-patch; name="fix-float-resampling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fix-float-resampling.patch"

snd_pcm_plug_change_format: Insert linear-to-float conversion when rate
or channel count is incorrect.

This fixes a bug where snd_pcm_plug_insert_plugins fails when both
client and slave use format float, but the rate or channel count does
not match. I also removed some redundant code.

Signed-off-by: Maarten Baert <maarten-baert@hotmail.com>

diff --git a/src/pcm/pcm_plug.c b/src/pcm/pcm_plug.c
index fa84eaa..ede9c15 100644
--- a/src/pcm/pcm_plug.c
+++ b/src/pcm/pcm_plug.c
@@ -522,15 +522,13 @@ static int snd_pcm_plug_change_format(snd_pcm_t *pcm, snd_pcm_t **new, snd_pcm_p
 		}
 #ifdef BUILD_PCM_PLUGIN_LFLOAT
 	} else if (snd_pcm_format_float(slv->format)) {
-		/* Conversion is done in another plugin */
-		if (clt->format == slv->format &&
-		    clt->rate == slv->rate &&
-		    clt->channels == slv->channels)
-			return 0;
-		cfmt = clt->format;
-		if (snd_pcm_format_linear(clt->format))
+		if (snd_pcm_format_linear(clt->format)) {
+			cfmt = clt->format;
 			f = snd_pcm_lfloat_open;
-		else
+		} else if (clt->rate != slv->rate || clt->channels != slv->channels) {
+			cfmt = SND_PCM_FORMAT_S16;
+			f = snd_pcm_lfloat_open;
+		} else
 			return -EINVAL;
 #endif
 #ifdef BUILD_PCM_NONLINEAR

--------------090606080909080301050105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090606080909080301050105--
