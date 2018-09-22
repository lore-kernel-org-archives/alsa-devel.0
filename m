From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ALSA: usb-audio: ensure that cluster header
	size is enough
Date: Sat, 22 Sep 2018 16:38:32 +0300
Message-ID: <20180922133831.GA6792@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 53F742673F4
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2018 15:38:47 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: alsa-devel@alsa-project.org, Michael Drake <michael.drake@codethink.co.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

I think we need a check to make sure that "hc_header.wLength" is large
enough for a struct struct uac3_cluster_header_descriptor.

Fixes: 9a2fe9b801f5 ("ALSA: usb: initial USB Audio Device Class 3.0 support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 67cf849aa16b..f7179ce39a19 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -968,6 +968,12 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 	 * and request Cluster Descriptor
 	 */
 	wLength = le16_to_cpu(hc_header.wLength);
+	if (wLength < sizeof(*cluster)) {
+		dev_err(&dev->dev,
+			"%u:%d : cluster header size too small %d\n",
+			iface_no, altno, wLength);
+		return ERR_PTR(-EIO);
+	}
 	cluster = kzalloc(wLength, GFP_KERNEL);
 	if (!cluster)
 		return ERR_PTR(-ENOMEM);
