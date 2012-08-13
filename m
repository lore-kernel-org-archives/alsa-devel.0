From: Wang Xingchao <xingchao.wang@intel.com>
Subject: [PATCH 3/3] ALSA: hda - Disable DigEn bit before
	stream-id change
Date: Mon, 13 Aug 2012 14:11:11 +0800
Message-ID: <1344838271-3528-3-git-send-email-xingchao.wang@intel.com>
References: <1344838271-3528-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 53C79265CA7
 for <alsa-devel@alsa-project.org>; Mon, 13 Aug 2012 07:53:37 +0200 (CEST)
In-Reply-To: <1344838271-3528-1-git-send-email-xingchao.wang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

Follow the protection way in nvhdmi_8ch_7x_pcm_prepare().

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/pci/hda/patch_hdmi.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 641408d..aa414b9 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -831,6 +831,7 @@ static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 {
 	int pinctl;
 	int new_pinctl = 0;
+	struct hda_spdif_out *spdif = snd_hda_spdif_out_of_nid(codec, cvt_nid);
 
 	if (snd_hda_query_pin_caps(codec, pin_nid) & AC_PINCAP_HBR) {
 		pinctl = snd_hda_codec_read(codec, pin_nid, 0,
@@ -859,7 +860,21 @@ static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 		return -EINVAL;
 	}
 
+	/* turn off SPDIF once; otherwise the IEC958 bits won't be updated */
+	if (codec->spdif_status_reset && (spdif->ctls & AC_DIG1_ENABLE))
+		snd_hda_codec_write(codec,
+				cvt_nid,
+				0,
+				AC_VERB_SET_DIGI_CONVERT_1,
+				spdif->ctls & ~AC_DIG1_ENABLE & 0xff);
 	snd_hda_codec_setup_stream(codec, cvt_nid, stream_tag, 0, format);
+	/* turn on again (if needed) */
+	if (codec->spdif_status_reset && (spdif->ctls & AC_DIG1_ENABLE))
+		snd_hda_codec_write(codec,
+				cvt_nid,
+				0,
+				AC_VERB_SET_DIGI_CONVERT_1,
+				spdif->ctls & 0xff);
 	return 0;
 }
 
-- 
1.7.9.5
