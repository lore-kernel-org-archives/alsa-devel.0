From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: [PATCH] snd_usb_audio: add Logitech HD Webcam c510 to
	quirk-384
Date: Wed,  9 Nov 2011 11:39:24 +0100
Message-ID: <1320835164-3540-1-git-send-email-bug-track@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 2CA5D1039C9
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 11:39:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Alexey Fisher <bug-track@fisher-privat.net>
List-Id: alsa-devel@alsa-project.org

Logitech HD Webcam c510 provide wrong mixer resolution.
Add it to "res = 384" quirk.

Signed-off-by: Alexey Fisher <bug-track@fisher-privat.net>
---
 sound/usb/mixer.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index c5444e0..ab23869 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -799,6 +799,7 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 
 	case USB_ID(0x046d, 0x0808):
 	case USB_ID(0x046d, 0x0809):
+	case USB_ID(0x046d, 0x081d): /* HD Webcam c510 */
 	case USB_ID(0x046d, 0x0991):
 	/* Most audio usb devices lie about volume resolution.
 	 * Most Logitech webcams have res = 384.
-- 
1.7.5.4
