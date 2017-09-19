From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH] ALSA: hda - program ICT bits to support HBR
	audio
Date: Tue, 19 Sep 2017 20:30:01 +0530
Message-ID: <1505833201-22363-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BCC6266819
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 17:17:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Sriram Periyasamy <sriramx.periyasamy@intel.com>

On recent Intel platforms (Haswell, Broadwell, Skylake, ApolloLake,
KabyLake, ...), the IEC Coding Type (ICT) bitfield in the Digital
Converter Control #3 needs to be set explicitly for HDMI/DisplayPort
High Bit Rate (HBR) audio playback to work. This was not required in
earlier platforms when HBR was first introduced. The ICT bits are
defined in Section 7.3.3.9 of the HDaudio 1.0a specification.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=98797

Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 include/sound/hda_verbs.h  |  1 +
 sound/pci/hda/patch_hdmi.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/sound/hda_verbs.h b/include/sound/hda_verbs.h
index d0509db6d0ec..d2004d7feb2b 100644
--- a/include/sound/hda_verbs.h
+++ b/include/sound/hda_verbs.h
@@ -54,6 +54,7 @@ enum {
 #define AC_VERB_GET_EAPD_BTLENABLE		0x0f0c
 #define AC_VERB_GET_DIGI_CONVERT_1		0x0f0d
 #define AC_VERB_GET_DIGI_CONVERT_2		0x0f0e /* unused */
+#define AC_VERB_SET_DIGI_CONVERT_3		0x73e
 #define AC_VERB_GET_VOLUME_KNOB_CONTROL		0x0f0f
 /* f10-f1a: GPIO */
 #define AC_VERB_GET_GPIO_DATA			0x0f15
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 53f9311370de..2dcd99d2a757 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -906,6 +906,7 @@ static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 			      hda_nid_t pin_nid, u32 stream_tag, int format)
 {
 	struct hdmi_spec *spec = codec->spec;
+	unsigned int param;
 	int err;
 
 	err = spec->ops.pin_hbr_setup(codec, pin_nid, is_hbr_format(format));
@@ -915,6 +916,23 @@ static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 		return err;
 	}
 
+	/*
+	 * on recent platforms IEC Coding Type is required for HBR support,
+	 * read current Digital Converter settings and set ICT bitfield if
+	 * needed.
+	 */
+	param = snd_hda_codec_read(codec, cvt_nid, 0,
+				AC_VERB_GET_DIGI_CONVERT_1, 0);
+
+	param = (param >> 16) & ~(AC_DIG3_ICT);
+
+	/* on recent platforms ICT mode is required for HBR support */
+	if (is_hbr_format(format))
+		param |= 0x1;
+
+	snd_hda_codec_write(codec, cvt_nid, 0,
+				AC_VERB_SET_DIGI_CONVERT_3, param);
+
 	snd_hda_codec_setup_stream(codec, cvt_nid, stream_tag, 0, format);
 	return 0;
 }
-- 
1.9.1
