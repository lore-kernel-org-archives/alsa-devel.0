From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: ac97_codec: Use common error handling
 code in snd_ac97_mixer()
Date: Sat, 11 Nov 2017 22:40:35 +0100
Message-ID: <18b1926e-d801-4b9b-abab-8474113f556f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id ED966266B67
 for <alsa-devel@alsa-project.org>; Sat, 11 Nov 2017 22:40:42 +0100 (CET)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 11 Nov 2017 22:30:51 +0100

* Add jump targets so that a bit of exception handling can be better reused
  at the end of this function.

  This issue was detected by using the Coccinelle software.

* The script "checkpatch.pl" pointed information out like the following.

  ERROR: do not use assignment in if condition

  Thus fix three affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/ac97/ac97_codec.c | 50 +++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 1ef7cdf1d3e8..2289cdcf2d48 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2103,8 +2103,8 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 		ac97_err(ac97,
 			 "AC'97 %d access is not valid [0x%x], removing mixer.\n",
 			 ac97->num, ac97->id);
-		snd_ac97_free(ac97);
-		return -EIO;
+		err = -EIO;
+		goto free_ac;
 	}
 	pid = look_for_codec_id(snd_ac97_codec_ids, ac97->id);
 	if (pid)
@@ -2138,8 +2138,8 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 			ac97_err(ac97,
 				 "AC'97 %d access error (not audio or modem codec)\n",
 				 ac97->num);
-		snd_ac97_free(ac97);
-		return -EACCES;
+		err = -EACCES;
+		goto free_ac;
 	}
 
 	if (bus->ops->reset) // FIXME: always skipping?
@@ -2267,14 +2267,12 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 			}
 		}
 		sprintf(comp, "AC97a:%08x", ac97->id);
-		if ((err = snd_component_add(card, comp)) < 0) {
-			snd_ac97_free(ac97);
-			return err;
-		}
-		if (snd_ac97_mixer_build(ac97) < 0) {
-			snd_ac97_free(ac97);
-			return -ENOMEM;
-		}
+		err = snd_component_add(card, comp);
+		if (err < 0)
+			goto free_ac;
+
+		if (snd_ac97_mixer_build(ac97) < 0)
+			goto e_nomem;
 	}
 	if (ac97_is_modem(ac97)) {
 		char comp[16];
@@ -2287,24 +2285,28 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 			}
 		}
 		sprintf(comp, "AC97m:%08x", ac97->id);
-		if ((err = snd_component_add(card, comp)) < 0) {
-			snd_ac97_free(ac97);
-			return err;
-		}
-		if (snd_ac97_modem_build(card, ac97) < 0) {
-			snd_ac97_free(ac97);
-			return -ENOMEM;
-		}
+		err = snd_component_add(card, comp);
+		if (err < 0)
+			goto free_ac;
+
+		if (snd_ac97_modem_build(card, ac97) < 0)
+			goto e_nomem;
 	}
 	if (ac97_is_audio(ac97))
 		update_power_regs(ac97);
 	snd_ac97_proc_init(ac97);
-	if ((err = snd_device_new(card, SNDRV_DEV_CODEC, ac97, &ops)) < 0) {
-		snd_ac97_free(ac97);
-		return err;
-	}
+	err = snd_device_new(card, SNDRV_DEV_CODEC, ac97, &ops);
+	if (err < 0)
+		goto free_ac;
+
 	*rac97 = ac97;
 	return 0;
+
+e_nomem:
+	err = -ENOMEM;
+free_ac:
+	snd_ac97_free(ac97);
+	return err;
 }
 
 EXPORT_SYMBOL(snd_ac97_mixer);
-- 
2.15.0
