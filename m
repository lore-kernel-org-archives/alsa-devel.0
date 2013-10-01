From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 4/4] ALSA: hda - hdmi: Disable ramp-up/down for
	non-PCM on AMD codecs
Date: Tue,  1 Oct 2013 23:30:56 +0300
Message-ID: <1380659456-3746-5-git-send-email-anssi.hannula@iki.fi>
References: <1380659456-3746-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id BB8BC264F09
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2013 22:31:28 +0200 (CEST)
In-Reply-To: <1380659456-3746-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Olivier Langlois <olivier@trillion01.com>, alsa-devel@alsa-project.org, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Peter=20Fr=C3=BChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

Recent AMD HDMI codecs (revision ID 3 and later, 0x100300 as reported by
procfs codec#0) have a configurable ramp-up/down functionality.

The documentation ( http://www.x.org/docs/AMD/AMD_HDA_verbs_v2.pdf )
specifies that 180 (meaning 180/256 =~ 0.7) is recommended for PCM and 0
for non-PCM.

Apply the recommended values according to provided S/PDIF AES0 settings.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 sound/pci/hda/patch_hdmi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index c0cd4ca..22f30fe 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2673,6 +2673,10 @@ static int patch_nvhdmi_8ch_7x(struct hda_codec *codec)
 #define ATI_VERB_GET_MULTICHANNEL_7	0xf88
 #define ATI_VERB_GET_MULTICHANNEL_MODE	0xf89
 
+/* AMD specific HDA cvt verbs */
+#define ATI_VERB_SET_RAMP_RATE		0x770
+#define ATI_VERB_GET_RAMP_RATE		0xf70
+
 #define ATI_OUT_ENABLE 0x1
 
 #define ATI_HBR_CAPABLE 0x01
@@ -2824,6 +2828,7 @@ static int atihdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 					unsigned int format,
 					struct snd_pcm_substream *substream)
 {
+	hda_nid_t cvt_nid = hinfo->nid;
 	struct hdmi_spec *spec = codec->spec;
 	int pin_idx = hinfo_to_pin_index(spec, hinfo);
 	struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
@@ -2853,6 +2858,15 @@ static int atihdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 		return -EINVAL;
 	}
 
+	if (is_amdhdmi_rev3(codec)) {
+		int ramp_rate = 180; /* default as per spec */
+		/* disable ramp-up/down for non-pcm as per spec */
+		if (format & AC_FMT_TYPE_NON_PCM)
+			ramp_rate = 0;
+
+		snd_hda_codec_write(codec, cvt_nid, 0, ATI_VERB_SET_RAMP_RATE, ramp_rate);
+	}
+
 	return generic_hdmi_playback_pcm_prepare(hinfo, codec, stream_tag, format, substream);
 }
 
-- 
1.8.1.5
