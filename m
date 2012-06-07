From: Wang Xingchao <xingchao.wang@intel.com>
Subject: [PATCH V2] ALSA: hda - power setting error check
Date: Thu,  7 Jun 2012 18:21:30 +0800
Message-ID: <1339064490-6510-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 3991324133
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 12:26:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, fengguang.wu@intel.com
Cc: wangxingchao2011@gmail.com, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

codec may reject power state transition requests(reporting PS-ERROR set),
in that case we re-issue a power state setting and check error bit again.

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/pci/hda/hda_codec.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index d0ca370..a93c7ca 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3526,6 +3526,7 @@ static bool snd_hda_codec_get_supported_ps(struct hda_codec *codec, hda_nid_t fg
 static void hda_set_power_state(struct hda_codec *codec, hda_nid_t fg,
 				unsigned int power_state)
 {
+	int state, count = 0;
 	if (codec->patch_ops.set_power_state) {
 		codec->patch_ops.set_power_state(codec, fg, power_state);
 		return;
@@ -3537,9 +3538,19 @@ static void hda_set_power_state(struct hda_codec *codec, hda_nid_t fg,
 		bool epss = snd_hda_codec_get_supported_ps(codec, fg, AC_PWRST_EPSS);
 		msleep(epss? 10:100);
 	}
-	snd_hda_codec_read(codec, fg, 0, AC_VERB_SET_POWER_STATE,
-			    power_state);
-	snd_hda_codec_set_power_to_all(codec, fg, power_state, true);
+
+	/* repeat power states setting at most 10 times*/
+	while (count++ > 10) {
+		snd_hda_codec_read(codec, fg, 0, AC_VERB_SET_POWER_STATE,
+				    power_state);
+		snd_hda_codec_set_power_to_all(codec, fg, power_state, true);
+		state = snd_hda_codec_read(codec, fg, 0,
+					   AC_VERB_GET_POWER_STATE, 0);
+		if (!(state & AC_PWRST_ERROR))
+			break;
+	}
+	if (count > 10)
+		snd_printk(KERN_WARNING "Power states transition reject!\n");
 }
 
 /* modem wake on ring: transition from D2 to D0 in less than 2ms. For modems,
-- 
1.7.9.5
