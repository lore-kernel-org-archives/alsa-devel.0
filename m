From: Nicolas Huaman <nicolas@herochao.de>
Subject: [PATCH] ALSA: usb-audio: update quirk for B&W PX to
	remove microphone
Date: Thu,  4 Oct 2018 16:42:05 +0200
Message-ID: <20181004144205.18153-1-nicolas@herochao.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.huaman.de (mail.huaman.de [88.99.34.23])
 by alsa0.perex.cz (Postfix) with ESMTP id CB3F0267736
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 16:42:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Nicolas Huaman <nicolas@herochao.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

A quirk in snd-usb-audio was added to automate setting sample rate to
4800k and remove the previously exposed nonfunctional microphone for 
the Bowers & Wilkins PX:
commit 240a8af929c7c57dcde28682725b29cf8474e8e5
https://lore.kernel.org/patchwork/patch/919689/

However the headphones where updated shortly after that to remove the
unintentional microphone functionality. I guess because of this the
headphones now crash when connecting them via USB while the quirk is
active. Dmesg:

snd-usb-audio: probe of 2-3:1.0 failed with error -22
usb 2-3: 2:1: cannot get min/max values for control 2 (id 2)

This patch removes the microfone and allows the headphones to connect 
and work out of the box. It is based on the current mainline kernel 
 and successfully applied an tested on my machine (4.18.10.arch1-1).

Signed-off-by: Nicolas Huaman <nicolas@herochao.de>
---
 sound/usb/quirks-table.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 08aa78007020..849953e5775c 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3346,19 +3346,14 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
-			/* Capture */
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE,
-			},
 			/* Playback */
 			{
-				.ifnum = 2,
+				.ifnum = 1,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
 				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 2,
-					.iface = 2,
+					.iface = 1,
 					.altsetting = 1,
 					.altset_idx = 1,
 					.attributes = UAC_EP_CS_ATTR_FILL_MAX |
-- 
2.19.0
