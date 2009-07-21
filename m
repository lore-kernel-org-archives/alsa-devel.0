From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: [PATCH] Mixer quirk for QuickCam E 3500
Date: Tue, 21 Jul 2009 23:10:42 +0200
Message-ID: <1248210642-5054-1-git-send-email-bug-track@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id EAEBB103813
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 23:10:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, clemens@ladisch.de
Cc: Alexey Fisher <bug-track@fisher-privat.net>
List-Id: alsa-devel@alsa-project.org

1. E3500 report cval->max more than it actually can handel, so if you
set 95% capture level it will be muted.
2. betwen cval->min and cval-max(real) is 2940 control units,
but real are only 7.
3. we found only 7 real control units, with cval->res = 384,
but alsa can't handel less than 10 controls, so make it more
and set cval->res = 192.

Signed-off-by: Alexey Fisher <bug-track@fisher-privat.net>
---
 sound/usb/usbmixer.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/usb/usbmixer.c b/sound/usb/usbmixer.c
index 4bd3a7a..72562ee 100644
--- a/sound/usb/usbmixer.c
+++ b/sound/usb/usbmixer.c
@@ -995,6 +995,13 @@ static void build_feature_ctl(struct mixer_build *state, unsigned char *desc,
 	/* is not very clear from datasheets */
 	/* I hope that the min value is -15360 for newer firmware --jk */
 	switch (state->chip->usb_id) {
+	case USB_ID(0x046d, 0x09a4):
+		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
+			snd_printk(KERN_INFO "using volume control quirk for the QuickCam E3500\n");
+			cval->min = 6080;
+			cval->max = 8768;
+			cval->res = 192;
+		}
 	case USB_ID(0x0471, 0x0101):
 	case USB_ID(0x0471, 0x0104):
 	case USB_ID(0x0471, 0x0105):
-- 
1.6.3.3
