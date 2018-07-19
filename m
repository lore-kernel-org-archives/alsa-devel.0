From: kbuild test robot <fengguang.wu@intel.com>
Subject: [RFC PATCH] ALSA: usb-audio: snd_usb_add_audio_stream_v3() can be
 static
Date: Fri, 20 Jul 2018 01:48:10 +0800
Message-ID: <20180719174810.GA74610@lkp-hsx03>
References: <20180719112215.4219-3-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180719112215.4219-3-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc: kbuild-all@01.org, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Fixes: 69abc040c878 ("ALSA: usb-audio: AudioStreaming Power Domain parsing")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 stream.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 031878a..c0567fa1 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -559,10 +559,10 @@ int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 	return __snd_usb_add_audio_stream(chip, stream, fp, NULL);
 }
 
-int snd_usb_add_audio_stream_v3(struct snd_usb_audio *chip,
-				int stream,
-				struct audioformat *fp,
-				struct snd_usb_power_domain *pd)
+static int snd_usb_add_audio_stream_v3(struct snd_usb_audio *chip,
+				       int stream,
+				       struct audioformat *fp,
+				       struct snd_usb_power_domain *pd)
 {
 	return __snd_usb_add_audio_stream(chip, stream, fp, pd);
 }
