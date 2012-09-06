From: Wang Xingchao <xingchao.wang@intel.com>
Subject: [PATCH 3/3] ALSA: HDMI - Setup channel mapping for
	non_pcm audio
Date: Thu,  6 Sep 2012 10:02:38 +0800
Message-ID: <1346896958-21080-4-git-send-email-xingchao.wang@intel.com>
References: <1346896958-21080-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C096F2652C5
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 04:16:03 +0200 (CEST)
In-Reply-To: <1346896958-21080-1-git-send-email-xingchao.wang@intel.com>
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
Cc: tiwai@suse.de, anssi.hannula@iki.fi, alanwww1@xbmc.org, fengguang.wu@intel.com, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

For HBR stream test, use straight channel mapping way.
when switched back to "speaker-test -c8", even the audio
infoframe is up-to-date, there should be correct channel mapping setup.

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/pci/hda/patch_hdmi.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index a87f8b2..bcb0939 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -780,6 +780,11 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec, int pin_idx,
 		hdmi_fill_audio_infoframe(codec, pin_nid,
 					    ai.bytes, sizeof(ai));
 		hdmi_start_infoframe_trans(codec, pin_nid);
+	} else {
+		/* For non-pcm audio switch, setup new channel mapping
+		 * accordingly */
+		if (per_cvt->non_pcm != non_pcm)
+			hdmi_setup_channel_mapping(codec, pin_nid, cvt_nid, non_pcm, ca);
 	}
 
 	per_cvt->non_pcm = non_pcm;
-- 
1.7.9.5
