From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: azt3328: some indenting cleanups
Date: Wed, 25 Feb 2015 16:32:45 +0300
Message-ID: <20150225133245.GR19745@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Benoit Taine <benoit.taine@lip6.fr>, Bjorn Helgaas <bhelgaas@google.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

A few minor tweaks to make things line up correctly.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index a40a2b4..33b2a0a 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -1385,8 +1385,8 @@ snd_azf3328_ctrl_codec_activity(struct snd_azf3328 *chip,
 					.running)
 			     &&  (!chip->codecs[peer_codecs[codec_type].other2]
 					.running));
-		 }
-		 if (call_function)
+		}
+		if (call_function)
 			snd_azf3328_ctrl_enable_codecs(chip, enable);
 
 		/* ...and adjust clock, too
@@ -2126,7 +2126,8 @@ static struct snd_pcm_ops snd_azf3328_i2s_out_ops = {
 static int
 snd_azf3328_pcm(struct snd_azf3328 *chip)
 {
-enum { AZF_PCMDEV_STD, AZF_PCMDEV_I2S_OUT, NUM_AZF_PCMDEVS }; /* pcm devices */
+	/* pcm devices */
+	enum { AZF_PCMDEV_STD, AZF_PCMDEV_I2S_OUT, NUM_AZF_PCMDEVS };
 
 	struct snd_pcm *pcm;
 	int err;
