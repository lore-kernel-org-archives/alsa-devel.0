From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Enabling HDMI HBR mode on Intel HDA
Date: Fri, 30 Jul 2010 15:48:41 +0300
Message-ID: <201007301548.41516.anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_posUMd5zNHRNvtO"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
	[83.102.40.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DC8281039EF
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 14:48:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sirokuusama.dnainternet.net (Postfix) with ESMTP id 67BE07F24C
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 15:48:43 +0300 (EEST)
Received: from sirokuusama.dnainternet.net ([83.102.40.133])
	by localhost (sirokuusama.dnainternet.net [127.0.0.1]) (amavisd-new,
	port 10041)
	with ESMTP id MM3pWagHUc9m for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 15:48:43 +0300 (EEST)
Received: from kirsikkapuu.dnainternet.net (kirsikkapuu.dnainternet.net
	[83.102.40.214])
	by sirokuusama.dnainternet.net (Postfix) with ESMTP id 3EDC47F245
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 15:48:43 +0300 (EEST)
Received: from mail.onse.fi (unknown [109.204.162.131])
	by kirsikkapuu.dnainternet.net (Postfix) with ESMTP id 34C6B2BAEA
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 15:48:42 +0300 (EEST)
Received: from sigma.onse.fi (sigma [10.0.0.8])
	by mail.onse.fi (Postfix) with ESMTP id CB94610DE4BF
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 15:48:41 +0300 (EEST)
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
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_posUMd5zNHRNvtO
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all!

We have been trying to get truehd/mlp/mat passthrough to work, with no luck so 
far. As HDMI standard requires a separate transmission mode (i.e. HBR Audio 
Stream Packets instead of Audio Sample Packets) for high-bitrate (over 
6.144Mbps) compressed formats, a driver change is needed, AFAIU.

Attached is a hack we have been using with hda_intel driver (the patch is for 
generic code; we have been using nvidia 8x codec if that matters).

Could anyone familiar with Intel HDA confirm whether the hack looks correct, 
or if something more is required? (0x05 is the hardcoded pin nid).

It would help to know for sure that the problem is in our iso61937/mat 
encapsulation and not in the temporary driver hack.

Thanks,
-- 
Anssi Hannula

--Boundary-00=_posUMd5zNHRNvtO
Content-Type: text/x-patch;
  charset="us-ascii";
  name="alsa-hbr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="alsa-hbr.patch"

diff --git a/pci/hda/hda_codec.h b/pci/hda/hda_codec.h
index a115c0c..43602f7 100644
--- a/pci/hda/hda_codec.h
+++ b/pci/hda/hda_codec.h
@@ -364,6 +364,9 @@ enum {
 #define AC_DIG2_CC			(0x7f<<0)
 
 /* Pin widget control - 8bit */
+#define AC_PINCTL_EPT			(0x3<<0)
+#define AC_PINCTL_EPT_NATIVE		0
+#define AC_PINCTL_EPT_HBR		3
 #define AC_PINCTL_VREFEN		(0x7<<0)
 #define AC_PINCTL_VREF_HIZ		0	/* Hi-Z */
 #define AC_PINCTL_VREF_50		1	/* 50% */
diff --git a/pci/hda/patch_hdmi.c b/pci/hda/patch_hdmi.c
index 86067ee..a4dffd3 100644
--- a/pci/hda/patch_hdmi.c
+++ b/pci/hda/patch_hdmi.c
@@ -163,7 +163,8 @@ static int hdmi_channel_mapping[0x32][8] = {
 	/* surround51 */
 	[0x0b] = { 0x00, 0x11, 0x24, 0x35, 0x43, 0x52, 0xf6, 0xf7 },
 	/* 7.1 */
-	[0x13] = { 0x00, 0x11, 0x26, 0x37, 0x43, 0x52, 0x64, 0x75 },
+//	[0x13] = { 0x00, 0x11, 0x26, 0x37, 0x43, 0x52, 0x64, 0x75 },
+	[0x13] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77 },
 };
 
 /*
@@ -688,20 +689,35 @@ static void hdmi_unsol_event(struct hda_codec *codec, unsigned int res)
 static void hdmi_setup_stream(struct hda_codec *codec, hda_nid_t nid,
 			      u32 stream_tag, int format)
 {
+	int pinctl = 0;
 	int tag;
 	int fmt;
+	int new_pinctl = 0;
 
+	pinctl = snd_hda_codec_read(codec, 0x05, 0, AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
 	tag = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONV, 0) >> 4;
 	fmt = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_STREAM_FORMAT, 0);
 
-	snd_printdd("hdmi_setup_stream: "
-		    "NID=0x%x, %sstream=0x%x, %sformat=0x%x\n",
+	if (snd_hda_param_read(codec, 0x05, AC_PAR_PIN_CAP) & AC_PINCAP_HBR)
+		new_pinctl = (pinctl & ~AC_PINCTL_EPT) | AC_PINCTL_EPT_HBR;
+	else
+		new_pinctl = (pinctl & ~AC_PINCTL_EPT) | AC_PINCTL_EPT_NATIVE;
+
+	snd_printk("hdmi_setup_stream: "
+		    "%spinctl=0x%x, NID=0x%x, %sstream=0x%x, %sformat=0x%x\n",
+		    pinctl == new_pinctl ? "" : "new-",
+		    new_pinctl,
 		    nid,
 		    tag == stream_tag ? "" : "new-",
 		    stream_tag,
 		    fmt == format ? "" : "new-",
 		    format);
 
+	if (pinctl != new_pinctl)
+		snd_hda_codec_write(codec, 0x05, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL,
+				    new_pinctl);
+
 	if (tag != stream_tag)
 		snd_hda_codec_write(codec, nid, 0,
 				    AC_VERB_SET_CHANNEL_STREAMID,

--Boundary-00=_posUMd5zNHRNvtO
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_posUMd5zNHRNvtO--
