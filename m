From: Dennis Kadioglu <denk@post.com>
Subject: [PATCH] Add a quirk for Plantronics DA45
Date: Tue, 1 Mar 2016 14:23:29 +0100 (CET)
Message-ID: <327228764.27997811.1456838609096.JavaMail.zimbra@dkadioglu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from skylla.efm.de (skylla.efm.de [195.190.148.248])
 by alsa0.perex.cz (Postfix) with ESMTP id C2C0626600E
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 14:23:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by skylla.efm.de (Postfix) with ESMTP id A99067618F0
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 14:23:29 +0100 (CET)
Received: from skylla.efm.de ([127.0.0.1])
 by localhost (skylla.efm.de [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id BAcyRl_BzELV for <alsa-devel@alsa-project.org>;
 Tue,  1 Mar 2016 14:23:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by skylla.efm.de (Postfix) with ESMTP id 8DA1576200A
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 14:23:29 +0100 (CET)
Received: from skylla.efm.de ([127.0.0.1])
 by localhost (skylla.efm.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id UPEmY_cSyMIP for <alsa-devel@alsa-project.org>;
 Tue,  1 Mar 2016 14:23:29 +0100 (CET)
Received: from skylla.efm.de (skylla.efm.de [195.190.148.248])
 by skylla.efm.de (Postfix) with ESMTP id 79D8F7618F0
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 14:23:29 +0100 (CET)
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

Plantronics DA45 does not support reading the sample rate which leads to many lines of "cannot get freq at ep 0x4" and "cannot get freq at ep 0x84". This patch adds the USB ID of the DA45 to quirks.c and avoids those error messages.


Signed-off-by: Dennis Kadioglu <denk@post.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 2585c17..5b03296 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1123,6 +1123,7 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
        case USB_ID(0x045E, 0x076F): /* MS Lifecam HD-6000 */
        case USB_ID(0x045E, 0x0772): /* MS Lifecam Studio */
        case USB_ID(0x045E, 0x0779): /* MS Lifecam HD-3000 */
+       case USB_ID(0x047F, 0xAA05): /* Plantronics DA45 */
        case USB_ID(0x04D8, 0xFEEA): /* Benchmark DAC1 Pre */
        case USB_ID(0x074D, 0x3553): /* Outlaw RR2150 (Micronas UAC3553B) */
        case USB_ID(0x21B4, 0x0081): /* AudioQuest DragonFly */
---
