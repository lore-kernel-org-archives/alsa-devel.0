From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amade@asmblr.net>
Subject: [PATCH] ALSA: usb-audio: fix CM6206 register definitions
Date: Tue,  8 Jan 2019 21:03:11 +0100
Message-ID: <20190108200311.4969-1-amade@asmblr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, Takashi Iwai <tiwai@suse.com>
Cc: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amade@asmblr.net>
List-Id: alsa-devel@alsa-project.org

fix typo after a recent commit causing headphones to have no sound

Fixes: ad43d528a7ac (ALSA: usb-audio: Define registers for CM6206)
Signed-off-by: Amadeusz Sławiński <amade@asmblr.net>
---
 sound/usb/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 96340f23f86d..ebbadb3a7094 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -768,7 +768,7 @@ static int snd_usb_cm6206_boot_quirk(struct usb_device *dev)
 		 * REG1: PLL binary search enable, soft mute enable.
 		 */
 		CM6206_REG1_PLLBIN_EN |
-		CM6206_REG1_SOFT_MUTE_EN |
+		CM6206_REG1_SOFT_MUTE_EN,
 		/*
 		 * REG2: enable output drivers,
 		 * select front channels to the headphone output,
-- 
2.20.1
