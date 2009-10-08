From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 2/31] HDA patch_via.c: Change
	get_codec_type argument to hda_codec type
Date: Thu, 8 Oct 2009 13:40:40 +0800
Message-ID: <16685ee0910072240n3b971f8du78cdf9327e46a47d@mail.gmail.com>
References: <16685ee0910050724s125cf4agd90cdcf98b92e2fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 75C41103904
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:40:41 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1473837bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:40:40 -0700 (PDT)
In-Reply-To: <16685ee0910050724s125cf4agd90cdcf98b92e2fe@mail.gmail.com>
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

---
 sound/pci/hda/patch_via.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
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
