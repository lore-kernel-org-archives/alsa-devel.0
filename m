From: Chris J Arges <chris.j.arges@canonical.com>
Subject: [PATCH] ALSA: usb-audio: Fix Scarlett 6i6 initialization typo
Date: Wed, 17 Dec 2014 16:09:35 -0600
Message-ID: <1418854194-13837-1-git-send-email-chris.j.arges@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@vger.kernel.org
Cc: Chris J Arges <chris.j.arges@canonical.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The num_controls field was incorrectly set to 0 causing 6i6 to not be
initialized. Set this to 9.

Reported-and-tested-by: Mark Roberts <sunifiram@gmail.com>
Signed-off-by: Chris J Arges <chris.j.arges@canonical.com>
---
 sound/usb/mixer_scarlett.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_scarlett.c b/sound/usb/mixer_scarlett.c
index 9109652..7438e7c 100644
--- a/sound/usb/mixer_scarlett.c
+++ b/sound/usb/mixer_scarlett.c
@@ -655,7 +655,7 @@ static struct scarlett_device_info s6i6_info = {
 		.names = NULL
 	},
 
-	.num_controls = 0,
+	.num_controls = 9,
 	.controls = {
 		{ .num = 0, .type = SCARLETT_OUTPUTS, .name = "Monitor" },
 		{ .num = 1, .type = SCARLETT_OUTPUTS, .name = "Headphone" },
-- 
1.9.1
