From: "Maksim A. Boyko" <maksboyko@yandex.ru>
Subject: [PATCH] usb-audio: Fix invalid volume resolution for
 Logitech HD Webcam C525
Date: Sat, 10 Aug 2013 12:20:02 +0400
Message-ID: <5205F7B2.7030505@yandex.ru>
References: <alpine.LNX.2.02.1308091232400.26590@pcqnt1.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward9l.mail.yandex.net (forward9l.mail.yandex.net
 [84.201.143.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 26DD626158B
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2013 10:20:10 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.02.1308091232400.26590@pcqnt1.phys.spbu.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
Cc: maksim.a.boyko@gmail.com, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add the volume control quirk for avoiding the kernel warning
for the Logitech HD Webcam C525
as in the similar commit 36691e1be6ec551eef4a5225f126a281f8c051c2
for the Logitech HD Webcam C310.

Reported-by: Maksim Boyko <maksim.a.boyko@gmail.com>
Tested-by: Maksim Boyko <maksim.a.boyko@gmail.com>
Cc: <stable@vger.kernel.org> # 3.10.5+
Signed-off-by: Maksim Boyko <maksim.a.boyko@gmail.com>
--
  sound/usb/mixer.c |    1 +
  1 file changed, 1 insertion(+)

--- linux-3.10.5-orig/sound/usb/mixer.c	2013-08-04 12:51:49.000000000
+0400
+++ linux-3.10.5/sound/usb/mixer.c	2013-08-06 21:12:42.274197287
+0400
@@ -888,6 +888,7 @@ static void volume_control_quirks(struct
  	case USB_ID(0x046d, 0x081b): /* HD Webcam c310 */
  	case USB_ID(0x046d, 0x081d): /* HD Webcam c510 */
  	case USB_ID(0x046d, 0x0825): /* HD Webcam c270 */
+	case USB_ID(0x046d, 0x0826): /* HD Webcam c525 */
  	case USB_ID(0x046d, 0x0991):
  	/* Most audio usb devices lie about volume resolution.
  	 * Most Logitech webcams have res = 384.


--
WBR, Maksim

P.S. Please, use this patch due to it should have correct tab symbols.
