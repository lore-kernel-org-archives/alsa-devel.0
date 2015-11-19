From: han.lu@intel.com
Subject: [PATCH 2/2] ALSA: hda - apply SKL display power
	request/release patch to BXT
Date: Thu, 19 Nov 2015 23:25:13 +0800
Message-ID: <7a931eac5852ad6c303caeb4d0c9274e1133a09b.1447945222.git.han.lu@intel.com>
References: <cover.1447945222.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B5A6126616A
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 16:26:02 +0100 (CET)
In-Reply-To: <cover.1447945222.git.han.lu@intel.com>
In-Reply-To: <cover.1447945222.git.han.lu@intel.com>
References: <cover.1447945222.git.han.lu@intel.com>
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

For SKL, only the HDMI codec is in the display power well while the
HD-A controller isn't. So the codec flag 'link_power_control' is
set to request/release the display power via bus link_power ops.
For BXT, the power well design is the same as SKL, so the patch
should be applied to BXT too.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 309274b..aa68db6 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2375,7 +2375,8 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 	 * can cover the codec power request, and so need not set this flag.
 	 * For previous platforms, there is no such power well feature.
 	 */
-	if (is_valleyview_plus(codec) || is_skylake(codec))
+	if (is_valleyview_plus(codec) || is_skylake(codec) ||
+			is_broxton(codec))
 		codec->core.link_power_control = 1;
 
 	if (is_haswell_plus(codec) || is_valleyview_plus(codec)) {
-- 
2.5.0
