From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 7/9] ALSA: usb-audio: add UAC2 sepecific
	Feature Unit controls
Date: Mon, 31 May 2010 13:35:42 +0200
Message-ID: <1275305744-6590-7-git-send-email-daniel@caiaq.de>
References: <1275305744-6590-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 03F201038BB
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 13:36:11 +0200 (CEST)
In-Reply-To: <1275305744-6590-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, gregkh@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

The bits to enable them are always 0 for UAC1 devices, so no additional
checks are required.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/mixer.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 2442819..8be6bf2 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -686,16 +686,20 @@ struct usb_feature_control_info {
 };
 
 static struct usb_feature_control_info audio_feature_info[] = {
-	{ "Mute",		USB_MIXER_INV_BOOLEAN },
-	{ "Volume",		USB_MIXER_S16 },
+	{ "Mute",			USB_MIXER_INV_BOOLEAN },
+	{ "Volume",			USB_MIXER_S16 },
 	{ "Tone Control - Bass",	USB_MIXER_S8 },
 	{ "Tone Control - Mid",		USB_MIXER_S8 },
 	{ "Tone Control - Treble",	USB_MIXER_S8 },
 	{ "Graphic Equalizer",		USB_MIXER_S8 }, /* FIXME: not implemeted yet */
-	{ "Auto Gain Control",	USB_MIXER_BOOLEAN },
-	{ "Delay Control",	USB_MIXER_U16 },
-	{ "Bass Boost",		USB_MIXER_BOOLEAN },
-	{ "Loudness",		USB_MIXER_BOOLEAN },
+	{ "Auto Gain Control",		USB_MIXER_BOOLEAN },
+	{ "Delay Control",		USB_MIXER_U16 },
+	{ "Bass Boost",			USB_MIXER_BOOLEAN },
+	{ "Loudness",			USB_MIXER_BOOLEAN },
+	/* UAC2 specific */
+	{ "Input Gain Control",		USB_MIXER_U16 },
+	{ "Input Gain Pad Control",	USB_MIXER_BOOLEAN },
+	{ "Phase Inverter Control",	USB_MIXER_BOOLEAN },
 };
 
 
-- 
1.7.1
