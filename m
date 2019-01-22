From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 6/6] ALSA: hda/tegra: add driver flag for
	runtime PM
Date: Tue, 22 Jan 2019 13:03:21 +0530
Message-ID: <1548142401-22841-7-git-send-email-spujar@nvidia.com>
References: <1548142401-22841-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 549942674CB
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 08:33:56 +0100 (CET)
In-Reply-To: <1548142401-22841-1-git-send-email-spujar@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Sameer Pujar <spujar@nvidia.com>
List-Id: alsa-devel@alsa-project.org

AZX_DCAPS_PM_RUNTIME flag is added to indicate support for runtime PM.
azx_has_pm_runtime() is used to check if above is enabled and thus
forbid runtime PM calls if needed.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index a7fd4c6..c8d18dc 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -520,7 +520,8 @@ MODULE_DEVICE_TABLE(of, hda_tegra_match);
 
 static int hda_tegra_probe(struct platform_device *pdev)
 {
-	const unsigned int driver_flags = AZX_DCAPS_CORBRP_SELF_CLEAR;
+	const unsigned int driver_flags = AZX_DCAPS_CORBRP_SELF_CLEAR |
+					  AZX_DCAPS_PM_RUNTIME;
 	struct snd_card *card;
 	struct azx *chip;
 	struct hda_tegra *hda;
-- 
2.7.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
