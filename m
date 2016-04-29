From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Quirk for yet another Phoenix
	Audio devices (v2)
Date: Fri, 29 Apr 2016 13:43:06 +0200
Message-ID: <1461930186-28036-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 49179266858
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2016 13:43:07 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BD3DBAC15
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2016 11:43:06 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Phoenix Audio MT202pcs (1de7:0114) and MT202exe (1de7:0013) need the
same workaround as TMX320 for avoiding the firmware bug.  It fixes the
frequent error about the sample rate inquiries and the slow device
probe as consequence.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=117321
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 0adfd9537cf7..7b6dca2d7488 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1138,7 +1138,9 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
 	case USB_ID(0x047F, 0xAA05): /* Plantronics DA45 */
 	case USB_ID(0x04D8, 0xFEEA): /* Benchmark DAC1 Pre */
 	case USB_ID(0x074D, 0x3553): /* Outlaw RR2150 (Micronas UAC3553B) */
+	case USB_ID(0x1de7, 0x0013): /* Phoenix Audio MT202exe */
 	case USB_ID(0x1de7, 0x0014): /* Phoenix Audio TMX320 */
+	case USB_ID(0x1de7, 0x0114): /* Phoenix Audio MT202pcs */
 	case USB_ID(0x21B4, 0x0081): /* AudioQuest DragonFly */
 		return true;
 	}
-- 
2.8.1
