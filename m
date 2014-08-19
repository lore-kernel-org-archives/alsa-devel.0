From: libin.yang@intel.com
Subject: [PATCH 1/2] ALSA: hda/hdmi - set depop_delay for
	haswell plus
Date: Tue, 19 Aug 2014 16:20:11 +0800
Message-ID: <1408436412-139667-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DEDB2655F0
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 10:23:06 +0200 (CEST)
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
Cc: Libin Yang <libin.yang@intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

Both Haswell and Broadwell need set depop_delay to 0. So apply this
setting to haswell plus.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/pci/hda/patch_hdmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 36badba..5e229f7 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2330,9 +2330,8 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		intel_haswell_fixup_enable_dp12(codec);
 	}
 
-	if (is_haswell(codec) || is_valleyview(codec)) {
+	if (is_haswell_plus(codec) || is_valleyview(codec))
 		codec->depop_delay = 0;
-	}
 
 	if (hdmi_parse_codec(codec) < 0) {
 		codec->spec = NULL;
-- 
1.9.1
