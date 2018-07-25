From: Jeff Crukley <jcrukley@gmail.com>
Subject: [PATCH] Added support for Encore mDSD USB DAC
Date: Wed, 25 Jul 2018 15:05:01 -0400
Message-ID: <1532545501-26129-1-git-send-email-jcrukley@gmail.com>
References: <s5hh8knw4r2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
 [209.85.214.66])
 by alsa0.perex.cz (Postfix) with ESMTP id B88A026774A
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:05:21 +0200 (CEST)
Received: by mail-it0-f66.google.com with SMTP id p4-v6so10261724itf.2
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 12:05:21 -0700 (PDT)
In-Reply-To: <s5hh8knw4r2.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz
Cc: JCruk <jcrukley@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: JCruk <jcrukley@gmail.com>

This patch adds native DSD playback support for the Encore mDSD USB DAC by
specifying the vendor and product ID's

Signed-off-by: Jeff Crukley <jcrukley@gmail.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 02b6cc0..6fbafce 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1373,6 +1373,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
 
+	case USB_ID(0x16d0, 0x09dd): /* Encore mDSD */
 	case USB_ID(0x0d8c, 0x0316): /* Hegel HD12 DSD */
 	case USB_ID(0x16b0, 0x06b2): /* NuPrime DAC-10 */
 	case USB_ID(0x16d0, 0x0733): /* Furutech ADL Stratos */
-- 
2.7.4
