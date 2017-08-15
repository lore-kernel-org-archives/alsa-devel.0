From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Apply sample rate quirk to
	Sennheiser headset
Date: Tue, 15 Aug 2017 09:09:10 +0200
Message-ID: <20170815070910.18687-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 667A126683B
 for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2017 09:09:13 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A7C3CAE93
 for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2017 07:09:13 +0000 (UTC)
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

A Senheisser headset requires the typical sample-rate quirk for
avoiding spurious errors from inquiring the current sample rate like:
 usb 1-1: 2:1: cannot get freq at ep 0x4
 usb 1-1: 3:1: cannot get freq at ep 0x83

The USB ID 1395:740a has to be added to the entries in
snd_usb_get_sample_rate_quirk().

Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1052580
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index d7b0b0a3a2db..f3e9e30172f3 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1142,6 +1142,7 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
 	case USB_ID(0x0556, 0x0014): /* Phoenix Audio TMX320VC */
 	case USB_ID(0x05A3, 0x9420): /* ELP HD USB Camera */
 	case USB_ID(0x074D, 0x3553): /* Outlaw RR2150 (Micronas UAC3553B) */
+	case USB_ID(0x1395, 0x740a): /* Sennheiser DECT */
 	case USB_ID(0x1901, 0x0191): /* GE B850V3 CP2114 audio interface */
 	case USB_ID(0x1de7, 0x0013): /* Phoenix Audio MT202exe */
 	case USB_ID(0x1de7, 0x0014): /* Phoenix Audio TMX320 */
-- 
2.13.3
