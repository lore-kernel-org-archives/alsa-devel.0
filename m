From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] sound: oss: mpu401.c:  Cleaning up variable is set more than once
Date: Wed, 25 Jun 2014 14:18:24 +0200
Message-ID: <1403698704-22364-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Julia Lawall <Julia.Lawall@lip6.fr>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

A struct member variable is set to the same value more than once

This was found using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 sound/oss/mpu401.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/oss/mpu401.c b/sound/oss/mpu401.c
index 3bbc3ec..31d7f72 100644
--- a/sound/oss/mpu401.c
+++ b/sound/oss/mpu401.c
@@ -972,7 +972,6 @@ int attach_mpu401(struct address_info *hw_config, struct module *owner)
 	devc->m_busy = 0;
 	devc->m_state = ST_INIT;
 	devc->shared_irq = hw_config->always_detect;
-	devc->irq = hw_config->irq;
 	spin_lock_init(&devc->lock);
 
 	if (devc->irq < 0)
-- 
1.7.10.4
