From: Tony Das <tdas444@gmail.com>
Subject: [PATCH] ALSA: usb-audio: Add SMSL D1 to quirks for
	native DSD support
Date: Wed, 28 Nov 2018 20:16:37 +0000
Message-ID: <CAKb=P8ugru=qaO6S29xBjdi0kXkrFmbDxVYk07cUnL=t35GG4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 by alsa0.perex.cz (Postfix) with ESMTP id B78862679A7
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 21:16:50 +0100 (CET)
Received: by mail-oi1-f194.google.com with SMTP id w13so23719027oiw.9
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 12:16:50 -0800 (PST)
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

This patch adds quirk VID/PID IDs for the SMSL D1 in order to enable
Native DSD support.

Signed-off-by: Tony Das <tdas444@gmail.com>
---
Author: Tony Das <tdas444@gmail.com>
Date: Tue Nov 27 22:13:30 2018 +0000

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 3d0f09108c98..aeac6bb7e111 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1515,6 +1515,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct
snd_usb_audio *chip,
   case USB_ID(0x27f7, 0x3002): /* W4S DAC-2v2SE */
   case USB_ID(0x29a2, 0x0086): /* Mutec MC3+ USB */
   case USB_ID(0x6b42, 0x0042): /* MSB Technology */
+   case USB_ID(0x152a, 0x85de): /* SMSL D1 DAC */
       if (fp->altsetting == 3)
           return SNDRV_PCM_FMTBIT_DSD_U32_BE;
       break;
