From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] sound: pci: azt3328.c:  Cleaning up function that are not used anywhere
Date: Wed,  3 Dec 2014 00:08:09 +0100
Message-ID: <1417561690-27471-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Benoit Taine <benoit.taine@lip6.fr>, Bjorn Helgaas <bhelgaas@google.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Remove function snd_azf3328_codec_outl() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 sound/pci/azt3328.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 5a69e26..82da7b9 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -379,15 +379,6 @@ snd_azf3328_codec_inw(const struct snd_azf3328_codec_data *codec, unsigned reg)
 }
 
 static inline void
-snd_azf3328_codec_outl(const struct snd_azf3328_codec_data *codec,
-		       unsigned reg,
-		       u32 value
-)
-{
-	outl(value, codec->io_base + reg);
-}
-
-static inline void
 snd_azf3328_codec_outl_multi(const struct snd_azf3328_codec_data *codec,
 			     unsigned reg, const void *buffer, int count
 )
-- 
1.7.10.4
