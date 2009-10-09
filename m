From: <LoganLi@viatech.com.cn>
Subject: [PATCH 2/30] HDA VIA: Change get_codec_type argument
	to hda_codec type
Date: Fri, 9 Oct 2009 18:40:03 +0800
Message-ID: <5B2BE0DB92BC8F4694F815C2F34E0D5F123C2F@exchbj03.viatech.com.bj>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BD721037EA
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 12:40:00 +0200 (CEST)
Content-class: urn:content-classes:message
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: Change get_codec_type argument to hda_codec type

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 pci/hda/patch_via.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/pci/hda/patch_via.c
+++ b/pci/hda/patch_via.c
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
