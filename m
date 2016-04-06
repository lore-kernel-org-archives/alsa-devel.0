From: denk <denk@post.com>
Subject: [PATCH] Add a quirk for Plantronics BT300
Date: Wed, 6 Apr 2016 08:37:17 +0200 (CEST)
Message-ID: <640357602.7415605.1459924637134.JavaMail.zimbra@dkadioglu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from skylla.efm.de (skylla.efm.de [195.190.148.248])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A66026506E
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 08:37:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by skylla.efm.de (Postfix) with ESMTP id BB65B761794
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 08:37:17 +0200 (CEST)
Received: from skylla.efm.de ([127.0.0.1])
 by localhost (skylla.efm.de [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id HRHNFd5JBO4N for <alsa-devel@alsa-project.org>;
 Wed,  6 Apr 2016 08:37:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by skylla.efm.de (Postfix) with ESMTP id 9D5EC7618A0
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 08:37:17 +0200 (CEST)
Received: from skylla.efm.de ([127.0.0.1])
 by localhost (skylla.efm.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id I0mu8taBZqih for <alsa-devel@alsa-project.org>;
 Wed,  6 Apr 2016 08:37:17 +0200 (CEST)
Received: from skylla.efm.de (skylla.efm.de [195.190.148.248])
 by skylla.efm.de (Postfix) with ESMTP id 89B67761794
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 08:37:17 +0200 (CEST)
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

Plantronics BT300 does not support reading the sample rate which leads to many lines of "cannot get freq at ep 0x1". This patch adds the USB ID of the BT300 to quirks.c and avoids those error messages.


Signed-off-by: Dennis Kadioglu <denk@post.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 6178bb5..a97c949 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1134,6 +1134,7 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
        case USB_ID(0x045E, 0x076F): /* MS Lifecam HD-6000 */
        case USB_ID(0x045E, 0x0772): /* MS Lifecam Studio */
        case USB_ID(0x045E, 0x0779): /* MS Lifecam HD-3000 */
+       case USB_ID(0x047F, 0x0415): /* Plantronics BT-300 */
        case USB_ID(0x047F, 0xAA05): /* Plantronics DA45 */
        case USB_ID(0x04D8, 0xFEEA): /* Benchmark DAC1 Pre */
        case USB_ID(0x074D, 0x3553): /* Outlaw RR2150 (Micronas UAC3553B) */
---
