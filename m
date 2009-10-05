From: Li Bo <liboat@gmail.com>
Subject: [PATCH 2/31] HDA patch_via.c: Change get_codec_type
	argument to hda_codec type
Date: Mon, 5 Oct 2009 22:24:40 +0800
Message-ID: <16685ee0910050724s125cf4agd90cdcf98b92e2fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 68E59243D1
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 16:24:43 +0200 (CEST)
Received: by fxm8 with SMTP id 8so2789765fxm.45
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 07:24:41 -0700 (PDT)
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
Cc: tiwai@suse.de, LoganLi@viatech.com.cn, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Change get_codec_type argument to hda_codec type

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-10-04 23:01:14.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-10-04 23:05:10.000000000 +0800
@@ -88,8 +88,9 @@
 	CODEC_TYPES,
 };

-static enum VIA_HDA_CODEC get_codec_type(u32 vendor_id)
+static enum VIA_HDA_CODEC get_codec_type(struct hda_codec *codec)
 {
+	u32 vendor_id = codec->vendor_id;
 	u16 ven_id = vendor_id >> 16;
 	u16 dev_id = vendor_id & 0xffff;
 	enum VIA_HDA_CODEC codec_type;
@@ -141,7 +142,7 @@
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	hda_nid_t nid = get_amp_nid(kcontrol);

-	if (get_codec_type(codec->vendor_id) == VT1708S
+	if (get_codec_type(codec) == VT1708S
 	    && (nid == 0x1a || nid == 0x1e)) {
 		if (size < 4 * sizeof(unsigned int))
 			return -ENOMEM;
@@ -163,7 +164,7 @@
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	hda_nid_t nid = get_amp_nid(kcontrol);

-	if (get_codec_type(codec->vendor_id) == VT1708S
+	if (get_codec_type(codec) == VT1708S
 	    && (nid == 0x1a || nid == 0x1e)) {
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 		uinfo->count = 2;
