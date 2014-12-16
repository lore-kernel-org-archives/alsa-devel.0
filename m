From: libin.yang@intel.com
Subject: [PATCH] ALSA: hda/hdmi - apply Haswell fix-ups to
	Skylake display codec
Date: Tue, 16 Dec 2014 13:17:34 +0800
Message-ID: <1418707054-22891-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id BFAA6260581
 for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2014 06:23:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: libin.yang@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

Skylake and Haswell have the same behavior on display audio. So this patch
applys Haswell fix-ups to Skylake.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/pci/hda/patch_hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 95129c2..5f13d2d 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -47,7 +47,9 @@ MODULE_PARM_DESC(static_hdmi_pcm, "Don't restrict PCM parameters per ELD info");
 
 #define is_haswell(codec)  ((codec)->vendor_id == 0x80862807)
 #define is_broadwell(codec)    ((codec)->vendor_id == 0x80862808)
-#define is_haswell_plus(codec) (is_haswell(codec) || is_broadwell(codec))
+#define is_skylake(codec) ((codec)->vendor_id == 0x80862809)
+#define is_haswell_plus(codec) (is_haswell(codec) || is_broadwell(codec) \
+					|| is_skylake(codec))
 
 #define is_valleyview(codec) ((codec)->vendor_id == 0x80862882)
 #define is_cherryview(codec) ((codec)->vendor_id == 0x80862883)
-- 
1.9.1
