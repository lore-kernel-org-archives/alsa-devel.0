From: Wang Xingchao <xingchao.wang@intel.com>
Subject: [PATCH] ALSA: hda - Set channels count for HBR format
Date: Tue,  7 Aug 2012 15:20:22 +0800
Message-ID: <1344324022-17310-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 55DFB265D83
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 09:02:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

If it's HBR format, the channels count should be 8.

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/pci/hda/patch_hdmi.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index ad319d4..ae4e67e 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1153,8 +1153,11 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 	struct hdmi_spec *spec = codec->spec;
 	int pin_idx = hinfo_to_pin_index(spec, hinfo);
 	hda_nid_t pin_nid = spec->pins[pin_idx].pin_nid;
-
-	hdmi_set_channel_count(codec, cvt_nid, substream->runtime->channels);
+
+	if (is_hbr_format(format))
+		hdmi_set_channel_count(codec, cvt_nid, 8);
+	else
+		hdmi_set_channel_count(codec, cvt_nid, substream->runtime->channels);
 
 	hdmi_setup_audio_infoframe(codec, pin_idx, substream);
 
-- 
1.7.9.5
