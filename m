From: denk <denk@post.com>
Subject: [PATCH] Add a quirk for Plantronics DA45
Date: Fri, 19 Feb 2016 14:01:02 +0100 (CET)
Message-ID: <1839309538.65739518.1455886862918.JavaMail.zimbra@dkadioglu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from skylla.efm.de (skylla.efm.de [195.190.148.248])
 by alsa0.perex.cz (Postfix) with ESMTP id 84BC226695F
 for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2016 14:01:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by skylla.efm.de (Postfix) with ESMTP id 38DA27619B9
 for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2016 14:01:03 +0100 (CET)
Received: from skylla.efm.de ([127.0.0.1])
 by localhost (skylla.efm.de [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id JQUzn9czkbd5 for <alsa-devel@alsa-project.org>;
 Fri, 19 Feb 2016 14:01:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by skylla.efm.de (Postfix) with ESMTP id 199877619B7
 for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2016 14:01:03 +0100 (CET)
Received: from skylla.efm.de ([127.0.0.1])
 by localhost (skylla.efm.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id NTWsFp0pDsd3 for <alsa-devel@alsa-project.org>;
 Fri, 19 Feb 2016 14:01:03 +0100 (CET)
Received: from skylla.efm.de (skylla.efm.de [195.190.148.248])
 by skylla.efm.de (Postfix) with ESMTP id 043DD7618AC
 for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2016 14:01:03 +0100 (CET)
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
Signed-off-by: Dennis Kadioglu <denk@post.com>
