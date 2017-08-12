From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ALSA: rme9652: Improve eight size determinations
Date: Sat, 12 Aug 2017 17:34:38 +0200
Message-ID: <ae12596b-becf-7af4-3959-5c2430b32eaf@users.sourceforge.net>
References: <a3223028-5b12-0efd-ffe0-aa7300334081@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a3223028-5b12-0efd-ffe0-aa7300334081@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Colin Ian King <colin.king@canonical.com>, Jaroslav Kysela <perex@perex.cz>, Julia Lawall <Julia.Lawall@lip6.fr>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 12 Aug 2017 16:50:06 +0200

Replace the specification of data structures by variable references
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/rme9652/hdspm.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index d448cf474c1b..8d339fb7c24b 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6221,7 +6221,7 @@ static int snd_hdspm_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
 		}
 		levels->status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
 
-		s = copy_to_user(argp, levels, sizeof(struct hdspm_peak_rms));
+		s = copy_to_user(argp, levels, sizeof(*levels));
 		if (0 != s) {
 			/* dev_err(hdspm->card->dev, "copy_to_user(.., .., %lu): %lu
 			 [Levels]\n", sizeof(struct hdspm_peak_rms), s);
@@ -6266,7 +6266,7 @@ static int snd_hdspm_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
 			ltc.input_format = no_video;
 		}
 
-		s = copy_to_user(argp, &ltc, sizeof(struct hdspm_ltc));
+		s = copy_to_user(argp, &ltc, sizeof(ltc));
 		if (0 != s) {
 			/*
 			  dev_err(hdspm->card->dev, "copy_to_user(.., .., %lu): %lu [LTC]\n", sizeof(struct hdspm_ltc), s); */
@@ -6357,7 +6357,7 @@ static int snd_hdspm_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
 		if (copy_from_user(&mixer, argp, sizeof(mixer)))
 			return -EFAULT;
 		if (copy_to_user((void __user *)mixer.mixer, hdspm->mixer,
-					sizeof(struct hdspm_mixer)))
+				 sizeof(*mixer.mixer)))
 			return -EFAULT;
 		break;
 
@@ -6636,8 +6636,8 @@ static int snd_hdspm_create(struct snd_card *card,
 	hdspm->irq = pci->irq;
 
 	dev_dbg(card->dev, "kmalloc Mixer memory of %zd Bytes\n",
-			sizeof(struct hdspm_mixer));
-	hdspm->mixer = kzalloc(sizeof(struct hdspm_mixer), GFP_KERNEL);
+		sizeof(*hdspm->mixer));
+	hdspm->mixer = kzalloc(sizeof(*hdspm->mixer), GFP_KERNEL);
 	if (!hdspm->mixer)
 		return -ENOMEM;
 
@@ -6774,8 +6774,7 @@ static int snd_hdspm_create(struct snd_card *card,
 		if (hdspm_read(hdspm, HDSPM_statusRegister2) &
 				HDSPM_s2_tco_detect) {
 			hdspm->midiPorts++;
-			hdspm->tco = kzalloc(sizeof(struct hdspm_tco),
-					GFP_KERNEL);
+			hdspm->tco = kzalloc(sizeof(*hdspm->tco), GFP_KERNEL);
 			if (NULL != hdspm->tco) {
 				hdspm_tco_write(hdspm);
 			}
@@ -6789,8 +6788,7 @@ static int snd_hdspm_create(struct snd_card *card,
 	case AES32:
 		if (hdspm_read(hdspm, HDSPM_statusRegister) & HDSPM_tco_detect) {
 			hdspm->midiPorts++;
-			hdspm->tco = kzalloc(sizeof(struct hdspm_tco),
-					GFP_KERNEL);
+			hdspm->tco = kzalloc(sizeof(*hdspm->tco), GFP_KERNEL);
 			if (NULL != hdspm->tco) {
 				hdspm_tco_write(hdspm);
 			}
@@ -6941,7 +6939,7 @@ static int snd_hdspm_probe(struct pci_dev *pci,
 	}
 
 	err = snd_card_new(&pci->dev, index[dev], id[dev],
-			   THIS_MODULE, sizeof(struct hdspm), &card);
+			   THIS_MODULE, sizeof(*hdspm), &card);
 	if (err < 0)
 		return err;
 
-- 
2.14.0
