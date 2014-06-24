From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] sound: oss: mpu401.c:  Cleaning up missing break in a case
Date: Tue, 24 Jun 2014 12:49:35 +0200
Message-ID: <1403606975-12827-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Added a missed break in a case statement

This was found using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 sound/oss/mpu401.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/oss/mpu401.c b/sound/oss/mpu401.c
index 25e4609..400896b 100644
--- a/sound/oss/mpu401.c
+++ b/sound/oss/mpu401.c
@@ -316,6 +316,7 @@ static int mpu_input_scanner(struct mpu_config *devc, unsigned char midic)
 				case 0xf6:
 					/* printk( "tune_request\n"); */
 					devc->m_state = ST_INIT;
+					break;
 
 					/*
 					 *    Real time messages
-- 
1.7.10.4
