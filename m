From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Add quirk for MS LifeCam
	Studio
Date: Tue, 19 May 2015 11:00:45 +0200
Message-ID: <1432026045-2927-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 95FF2260695
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 11:00:46 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6408AAC5D
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 09:00:46 +0000 (UTC)
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

Microsoft LifeCam Studio (045e:0772) needs a similar quirk for
suppressing the wrong sample rate inquiry.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=98481
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 7c5a70139278..46facfc9aec1 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1117,6 +1117,7 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
 	switch (chip->usb_id) {
 	case USB_ID(0x045E, 0x075D): /* MS Lifecam Cinema  */
 	case USB_ID(0x045E, 0x076D): /* MS Lifecam HD-5000 */
+	case USB_ID(0x045E, 0x0772): /* MS Lifecam Studio */
 	case USB_ID(0x04D8, 0xFEEA): /* Benchmark DAC1 Pre */
 		return true;
 	}
-- 
2.4.1
