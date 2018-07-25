From: JCruk <jcrukley@gmail.com>
Subject: [PATCH] Added support for Encore mDSD and Topping DX7s
	XMOS USB DACs
Date: Wed, 25 Jul 2018 12:19:53 -0400
Message-ID: <1532535593-32167-1-git-send-email-jcrukley@gmail.com>
References: <s5hbmav1emu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f67.google.com (mail-it0-f67.google.com
 [209.85.214.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FE7C2675D4
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 18:20:08 +0200 (CEST)
Received: by mail-it0-f67.google.com with SMTP id 72-v6so9495849itw.3
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 09:20:08 -0700 (PDT)
In-Reply-To: <s5hbmav1emu.wl-tiwai@suse.de>
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

Signed-off-by: JCruk <jcrukley@gmail.com>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 02b6cc0..7683d33 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1373,6 +1373,8 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
 
+	case USB_ID(0x152a, 0x8750): /* Topping DX7s */
+	case USB_ID(0x16d0, 0x09dd): /* Encore mDSD */
 	case USB_ID(0x0d8c, 0x0316): /* Hegel HD12 DSD */
 	case USB_ID(0x16b0, 0x06b2): /* NuPrime DAC-10 */
 	case USB_ID(0x16d0, 0x0733): /* Furutech ADL Stratos */
-- 
2.7.4
