From: Kulikov Vasiliy <segooon@gmail.com>
Subject: [PATCH 08/10] oss: midi_synth: check get_user() return value
Date: Wed, 28 Jul 2010 20:41:17 +0400
Message-ID: <1280335277-23435-1-git-send-email-segooon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Roel Kluin <roel.kluin@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

get_user() may fail, if so return -EFAULT.

Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 sound/oss/midi_synth.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/oss/midi_synth.c b/sound/oss/midi_synth.c
index 3bc7104..3c09374 100644
--- a/sound/oss/midi_synth.c
+++ b/sound/oss/midi_synth.c
@@ -523,7 +523,9 @@ midi_synth_load_patch(int dev, int format, const char __user *addr,
 	{
 		unsigned char   data;
 
-		get_user(*(unsigned char *) &data, (unsigned char __user *) &((addr)[hdr_size + i]));
+		if (get_user(data,
+		    (unsigned char __user *)(addr + hdr_size + i)))
+			return -EFAULT;
 
 		eox_seen = (i > 0 && data & 0x80);	/* End of sysex */
 
-- 
1.7.0.4
