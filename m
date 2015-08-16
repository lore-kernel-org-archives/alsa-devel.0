From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 2/2] ALSA: usb-audio: Add sample rate inquiry
	quirk for AudioQuest DragonFly
Date: Sun, 16 Aug 2015 15:50:13 +0300
Message-ID: <1439729413-30804-2-git-send-email-anssi.hannula@iki.fi>
References: <1439729413-30804-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail.tpnet.fi (webmail.tpnet.fi [62.106.63.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 674F62604B0
 for <alsa-devel@alsa-project.org>; Sun, 16 Aug 2015 14:50:22 +0200 (CEST)
In-Reply-To: <1439729413-30804-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Avoid getting sample rate on AudioQuest DragonFly as it is unsupported
and causes noisy "cannot get freq at ep 0x1" messages when playback
starts.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
Cc: <stable@vger.kernel.org>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 754e689596a2..078ff58f1ba0 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1121,6 +1121,7 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
 	case USB_ID(0x045E, 0x0779): /* MS Lifecam HD-3000 */
 	case USB_ID(0x04D8, 0xFEEA): /* Benchmark DAC1 Pre */
 	case USB_ID(0x074D, 0x3553): /* Outlaw RR2150 (Micronas UAC3553B) */
+	case USB_ID(0x21B4, 0x0081): /* AudioQuest DragonFly */
 		return true;
 	}
 	return false;
-- 
2.3.8
