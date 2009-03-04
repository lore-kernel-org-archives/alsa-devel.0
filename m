From: Joonyoung Shim <dofmind@gmail.com>
Subject: [PATCH] ASoC: Fix long name of control for dapm_switch
Date: Wed, 4 Mar 2009 10:47:09 +0900
Message-ID: <4e1455be0903031747s65097766saea220037d1335ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.249])
	by alsa0.perex.cz (Postfix) with ESMTP id B3E7724430
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 02:47:10 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id c5so2736208rvf.32
	for <alsa-devel@alsa-project.org>; Tue, 03 Mar 2009 17:47:09 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The length of long control name doesn't include the length of widget
name at present when widget->id is snd_soc_dapm_switch, so the long
control name of dapm_switch is shortened.
To avoid this problem, the long control name only for dapm_mixer_named_ctl
must have simply the kcontrol name.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 sound/soc/soc-dapm.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4b8dbbf..7a1fed1 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -331,26 +331,23 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
                         * for dapm_mixer_named_ctl this is simply the
                         * kcontrol name.
                         */
-                       name_len = strlen(w->kcontrols[i].name) + 1;
-                       if (w->id == snd_soc_dapm_mixer)
-                               name_len += 1 + strlen(w->name);
+                       if (w->id == snd_soc_dapm_mixer_named_ctl)
+                               name_len = strlen(w->kcontrols[i].name) + 1;
+                       else
+                               name_len = 2 + strlen(w->name)
+                                       + strlen(w->kcontrols[i].name);

                        path->long_name = kmalloc(name_len, GFP_KERNEL);

                        if (path->long_name == NULL)
                                return -ENOMEM;

-                       switch (w->id) {
-                       case snd_soc_dapm_mixer:
-                       default:
-                               snprintf(path->long_name, name_len, "%s %s",
-                                        w->name, w->kcontrols[i].name);
-                       break;
-                       case snd_soc_dapm_mixer_named_ctl:
+                       if (w->id == snd_soc_dapm_mixer_named_ctl)
                                snprintf(path->long_name, name_len, "%s",
                                         w->kcontrols[i].name);
-                       break;
-                       }
+                       else
+                               snprintf(path->long_name, name_len, "%s %s",
+                                        w->name, w->kcontrols[i].name);

                        path->long_name[name_len - 1] = '\0';

-- 
1.5.6.3


-- 
- Joonyoung Shim
