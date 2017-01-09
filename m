From: denk <denk@post.com>
Subject: [PATCH] Add a quirk for Plantronics BT600
Date: Mon, 9 Jan 2017 17:10:46 +0100 (CET)
Message-ID: <926079054.23679773.1483978246978.JavaMail.zimbra@dkadioglu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.efm.de (hera.efm.de [195.190.148.227])
 by alsa0.perex.cz (Postfix) with ESMTP id A28F8266D40
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 17:10:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by hera.efm.de (Postfix) with ESMTP id DC03012C1F9D
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 17:10:47 +0100 (CET)
Received: from hera.efm.de ([127.0.0.1])
 by localhost (hera.efm.de [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id wQHDdSYCyRYQ for <alsa-devel@alsa-project.org>;
 Mon,  9 Jan 2017 17:10:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by hera.efm.de (Postfix) with ESMTP id BAEA612C1FFC
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 17:10:47 +0100 (CET)
Received: from hera.efm.de ([127.0.0.1])
 by localhost (hera.efm.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id F6FdqUztr2Gg for <alsa-devel@alsa-project.org>;
 Mon,  9 Jan 2017 17:10:47 +0100 (CET)
Received: from hera.efm.de (hera.efm.de [195.190.148.227])
 by hera.efm.de (Postfix) with ESMTP id 9E04C12C1F9D
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 17:10:47 +0100 (CET)
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

Plantronics BT600 does not support reading the sample rate which leads to many lines of "cannot get freq at ep 0x1" and "cannot get freq at ep 0x82". This patch adds the USB ID of the BT600 to quirks.c and avoids those error messages.


Signed-off-by: Dennis Kadioglu <denk@post.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c        
index b3fd238..9d747a9 100644 
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c        
@@ -1136,6 +1136,7 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
        case USB_ID(0x045E, 0x0772): /* MS Lifecam Studio */ 
        case USB_ID(0x045E, 0x0779): /* MS Lifecam HD-3000 */
        case USB_ID(0x047F, 0x0415): /* Plantronics BT-300 */
+       case USB_ID(0x047F, 0x02F7): /* Plantronics BT-600 */
        case USB_ID(0x047F, 0xAA05): /* Plantronics DA45 */  
        case USB_ID(0x04D8, 0xFEEA): /* Benchmark DAC1 Pre */    
        case USB_ID(0x0556, 0x0014): /* Phoenix Audio TMX320VC */
---
