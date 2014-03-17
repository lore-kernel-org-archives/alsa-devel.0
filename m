From: Matthias Larisch <mail@matthias-larisch.de>
Subject: [RFC PATCH] alsa-lib: Call LADSPA activate after all
 ports are setup
Date: Mon, 17 Mar 2014 19:40:00 +0100
Message-ID: <20140317194000.5fa76393@purefruit.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mlh-server.de (mail.mlh-server.de [5.9.104.232])
 by alsa0.perex.cz (Postfix) with ESMTP id D46B7261A48
 for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2014 19:40:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.mlh-server.de (Postfix) with ESMTP id 852F73074D7
 for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2014 19:40:02 +0100 (CET)
Received: from mail.mlh-server.de ([127.0.0.1])
 by localhost (mail.mlh-server.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Am9FTZmWTRlZ for <alsa-devel@alsa-project.org>;
 Mon, 17 Mar 2014 19:40:02 +0100 (CET)
Received: from purefruit.fritz.box (dslb-092-076-230-060.pools.arcor-ip.net
 [92.76.230.60]) (Authenticated sender: mail@matthias-larisch.de)
 by mail.mlh-server.de (Postfix) with ESMTPSA id 3A7E4300137
 for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2014 19:40:02 +0100 (CET)
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

Hey there,

I notices mainly swh-plugins (like butterworth_1902) to crash on seek with
mplayer or mpd. This is due to their behaviour on relying on the activate call
after the control inputs are set.

This is not right by LADSPA API description but I see no point in NOT calling
activate as late as possible in alsa-lib.

Comments?

Regards,

Matthias

>From f7f5d920c845fc54ffef208f68f568b06e8fadd1 Mon Sep 17 00:00:00 2001
From: Matthias Larisch <mail@matthias-larisch.de>
Date: Mon, 17 Mar 2014 19:37:01 +0100
Subject: [PATCH] call ladspa activate as late as possible to work around wrong
 plugin behaviour

---
 src/pcm/pcm_ladspa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_ladspa.c b/src/pcm/pcm_ladspa.c
index 9ce5242..7d1e3df 100644
--- a/src/pcm/pcm_ladspa.c
+++ b/src/pcm/pcm_ladspa.c
@@ -645,8 +645,6 @@ static int snd_pcm_ladspa_allocate_instances(snd_pcm_t *pcm, snd_pcm_ladspa_t *l
 				return -EINVAL;
 			}
 			list_add_tail(&instance->list, &plugin->instances);
-			if (plugin->desc->activate)
-				plugin->desc->activate(instance->handle);
 			if (plugin->policy == SND_PCM_LADSPA_POLICY_DUPLICATE) {
 				err = snd_pcm_ladspa_connect_plugin_duplicate(plugin, &plugin->input, &plugin->output, instance, idx);
 				if (err < 0) {
@@ -664,6 +662,8 @@ static int snd_pcm_ladspa_allocate_instances(snd_pcm_t *pcm, snd_pcm_ladspa_t *l
 			assert(err >= 0);
 			err = snd_pcm_ladspa_connect_controls(plugin, &plugin->output, instance);
 			assert(err >= 0);
+			if (plugin->desc->activate)
+				plugin->desc->activate(instance->handle);
 		}
 		err = snd_pcm_ladspa_check_connect(plugin, &plugin->input, &instance->input, depth);
 		if (err < 0)
-- 
1.9.0
