From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH v2 7/7] ALSA: USB-audio: Remove mixer entry
	from Zoom R16/24 quirk
Date: Mon, 19 Oct 2015 08:52:55 +0200
Message-ID: <1445237575-396-8-git-send-email-ricardw@axis.com>
References: <1444906657-16791-1-git-send-email-ricardw@axis.com>
 <1445237575-396-1-git-send-email-ricardw@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 1977B26571B
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 08:53:05 +0200 (CEST)
In-Reply-To: <1445237575-396-1-git-send-email-ricardw@axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Ricard Wanderlof <ricardw@axis.com>, Ricard Wanderlof <ricard2005@butoba.net>
List-Id: alsa-devel@alsa-project.org

The device has no mixer (and identifies itself as such), so just skip
the mixer definition.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
---
 sound/usb/quirks-table.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 4a8ca637..722b77b 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3182,8 +3182,6 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 {
 	/*
 	 * ZOOM R16/24 in audio interface mode.
-	 * Mixer descriptors are garbage, further quirks will be needed
-	 * to make any of it functional, thus disabled for now.
 	 * Playback requires an extra four byte LE length indicator
 	 * at the start of each isochronous packet. This quirk is
 	 * enabled in create_standard_audio_quirk().
@@ -3194,11 +3192,6 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 		.type = QUIRK_COMPOSITE,
 		.data = (const struct snd_usb_audio_quirk[]) {
 			{
-				/* Mixer */
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE,
-			},
-			{
 				/* Playback  */
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
-- 
2.1.4
