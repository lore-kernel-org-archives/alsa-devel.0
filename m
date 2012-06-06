From: Wang Xingchao <xingchao.wang@intel.com>
Subject: [PATCH 1/2] ALSA: hda - check supported power states
Date: Wed,  6 Jun 2012 22:02:48 +0800
Message-ID: <1338991369-31656-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 5917C24393
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2012 16:07:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: wangxingchao2011@gmail.com, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

Add function to check whether power states supported by specific
codec node.

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/pci/hda/hda_codec.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 41ca803..b89c8ec 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3505,6 +3505,22 @@ void snd_hda_codec_set_power_to_all(struct hda_codec *codec, hda_nid_t fg,
 EXPORT_SYMBOL_HDA(snd_hda_codec_set_power_to_all);
 
 /*
+ *  supported power states check
+ */
+static bool snd_hda_codec_get_supported_ps(struct hda_codec *codec, hda_nid_t fg,
+				unsigned int power_state)
+{
+	int sup = snd_hda_param_read(codec, fg, AC_PAR_POWER_STATE);
+
+	if (sup < 0)
+		return false;
+	if (sup & power_state)
+		return true;
+	else
+		return false;
+}
+
+/*
  * set power state of the codec
  */
 static void hda_set_power_state(struct hda_codec *codec, hda_nid_t fg,
-- 
1.7.9.5
