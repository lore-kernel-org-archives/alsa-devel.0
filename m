From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 4/4] ALSA: usb-audio: fix UAC2 control
	value queries
Date: Fri, 11 Jun 2010 15:51:21 +0200
Message-ID: <20100611135121.GB17833@buzzloop.caiaq.de>
References: <1276263191-8652-1-git-send-email-daniel@caiaq.de>
	<1276263191-8652-5-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 6223E1039BC
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jun 2010 15:51:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1276263191-8652-5-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, alexlee188@gmail.com, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 11, 2010 at 03:33:11PM +0200, Daniel Mack wrote:
> UAC2 controls can be queried in 1-byte, 2-byte or 4-byte request blocks.
> The size is actually determined by the number of bytes requested, and as
> everything is little-endian, we can always go for the 4-byte variant.
> 
> Also, the MIN, MAX and RES value computations were using a wrong offset.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Reported-by: Alex Lee <alexlee188@gmail.com>

Damn, I forgot to pick the right commit message for this patch. Below is
a new version. Sorry.

Daniel

>From 9a8be646c65df2960bda3588cbd2cea4834c7750 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Fri, 11 Jun 2010 13:49:56 +0200
Subject: [PATCH] ALSA: usb-audio: fix UAC2 control value queries

For RANGE requests, we should only query as much bytes as we're in face
interested in.

For CUR requests, we shouldn't confuse the firmware with an overlong
request but just ask for 2 bytes.

This might need fixing in the future as it's not entirely clear when to
dispatch 1-byte, 2-byte and 4-byte request blocks. For now, we assume
everything is coded in 16bit - this works for all firmware
implementations I've seen.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Reported-by: Alex Lee <alexlee188@gmail.com>
---
 sound/usb/mixer.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index a060d00..6939d0f 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -297,20 +297,27 @@ static int get_ctl_value_v1(struct usb_mixer_elem_info *cval, int request, int v
 
 static int get_ctl_value_v2(struct usb_mixer_elem_info *cval, int request, int validx, int *value_ret)
 {
-	unsigned char buf[14]; /* enough space for one range of 4 bytes */
+	unsigned char buf[2 + 3*sizeof(__u16)]; /* enough space for one range */
 	unsigned char *val;
-	int ret;
+	int ret, size;
 	__u8 bRequest;
 
-	bRequest = (request == UAC_GET_CUR) ?
-		UAC2_CS_CUR : UAC2_CS_RANGE;
+	if (request == UAC_GET_CUR) {
+		bRequest = UAC2_CS_CUR;
+		size = sizeof(__u16);
+	} else {
+		bRequest = UAC2_CS_RANGE;
+		size = sizeof(buf);
+	}
+
+	memset(buf, 0, sizeof(buf));
 
 	ret = snd_usb_ctl_msg(cval->mixer->chip->dev,
 			      usb_rcvctrlpipe(cval->mixer->chip->dev, 0),
 			      bRequest,
 			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 			      validx, cval->mixer->ctrlif | (cval->id << 8),
-			      buf, sizeof(buf), 1000);
+			      buf, size, 1000);
 
 	if (ret < 0) {
 		snd_printk(KERN_ERR "cannot get ctl value: req = %#x, wValue = %#x, wIndex = %#x, type = %d\n",
@@ -318,6 +325,8 @@ static int get_ctl_value_v2(struct usb_mixer_elem_info *cval, int request, int v
 		return ret;
 	}
 
+	/* FIXME: how should we handle multiple triplets here? */
+
 	switch (request) {
 	case UAC_GET_CUR:
 		val = buf;
-- 
1.7.1
