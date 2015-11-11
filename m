From: han.lu@intel.com
Subject: [PATCH 1/1] ALSA: hda/hdmi - apply Skylake fix-ups to
	Broxton display codec
Date: Wed, 11 Nov 2015 16:54:27 +0800
Message-ID: <1447232067-8303-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C696C2605B1
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 09:55:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, libin.yang@linux.intel.com, mengdong.lin@linux.intel.com, han.lu@linux.intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Broxton and Skylake have the same behavior on display audio. So this patch
applys Skylake fix-ups to Broxton.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index f503a88..309274b 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -50,8 +50,9 @@ MODULE_PARM_DESC(static_hdmi_pcm, "Don't restrict PCM parameters per ELD info");
 #define is_haswell(codec)  ((codec)->core.vendor_id == 0x80862807)
 #define is_broadwell(codec)    ((codec)->core.vendor_id == 0x80862808)
 #define is_skylake(codec) ((codec)->core.vendor_id == 0x80862809)
+#define is_broxton(codec) ((codec)->core.vendor_id == 0x8086280a)
 #define is_haswell_plus(codec) (is_haswell(codec) || is_broadwell(codec) \
-					|| is_skylake(codec))
+				|| is_skylake(codec) || is_broxton(codec))
 
 #define is_valleyview(codec) ((codec)->core.vendor_id == 0x80862882)
 #define is_cherryview(codec) ((codec)->core.vendor_id == 0x80862883)
-- 
2.5.0
