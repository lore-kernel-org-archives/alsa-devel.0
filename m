From: Kulikov Vasiliy <segooon@gmail.com>
Subject: [PATCH 8/8] sound: asihpi: fix sign bug
Date: Thu, 15 Jul 2010 22:48:19 +0400
Message-ID: <1279219700-12892-1-git-send-email-segooon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Eliot Blennerhassett <eblennerhassett@audioscience.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

bytes_per_sec is unsigned, so if snd_pcm_format_width() return error we
would not see it.

Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 sound/pci/asihpi/asihpi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 91218f7..c80b0b8 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -460,6 +460,7 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_card_asihpi *card = snd_pcm_substream_chip(substream);
 	int err;
 	u16 format;
+	int width;
 	unsigned int bytes_per_sec;
 
 	print_hwparams(params);
@@ -512,9 +513,10 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 				dpcm->hpi_buffer_attached);
 	}
 	bytes_per_sec = params_rate(params) * params_channels(params);
-	bytes_per_sec *= snd_pcm_format_width(params_format(params));
+	width = snd_pcm_format_width(params_format(params));
+	bytes_per_sec *= width;
 	bytes_per_sec /= 8;
-	if (bytes_per_sec <= 0)
+	if (width < 0 || bytes_per_sec == 0)
 		return -EINVAL;
 
 	dpcm->bytes_per_sec = bytes_per_sec;
-- 
1.7.0.4
