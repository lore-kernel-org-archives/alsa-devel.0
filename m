From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v2 4/4] ALSA: usb-audio: Always create the interrupt pipe for the mixer
Date: Thu, 14 Jun 2018 15:05:58 +0100
Message-ID: <20180614140558.28277-5-jorge.sanjuan@codethink.co.uk>
References: <20180612143201.29988-1-jorge.sanjuan@codethink.co.uk>
 <20180614140558.28277-1-jorge.sanjuan@codethink.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180614140558.28277-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ruslan.bilovol@gmail.com
List-Id: alsa-devel@alsa-project.org

An UAC3 BADD device may also include an interrupt status pipe
to report changes on the HEADSET ADAPTER terminals. The creation
of the status pipe is dependent on the device reporting that it
has it.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/mixer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 03b8a2ac93c8..b1dcf6dfc27e 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -3338,10 +3338,12 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 		err = snd_usb_mixer_controls(mixer);
 		if (err < 0)
 			goto _error;
-		err = snd_usb_mixer_status_create(mixer);
-		if (err < 0)
-			goto _error;
 	}
+
+	err = snd_usb_mixer_status_create(mixer);
+	if (err < 0)
+		goto _error;
+
 	err = create_keep_iface_ctl(mixer);
 	if (err < 0)
 		goto _error;
-- 
2.11.0
