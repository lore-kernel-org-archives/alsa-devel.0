From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 7/7] ALSA: hda/tegra: add driver flag for
	runtime PM
Date: Mon, 21 Jan 2019 23:11:37 +0530
Message-ID: <1548092497-5459-8-git-send-email-spujar@nvidia.com>
References: <1548092497-5459-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 by alsa0.perex.cz (Postfix) with ESMTP id C21E026680F
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 18:42:21 +0100 (CET)
In-Reply-To: <1548092497-5459-1-git-send-email-spujar@nvidia.com>
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
azx_has_pm_runtime() can be called to check if above is enabled. The
flag is put under CONFIG_PM check.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 80c4042..80b7a3b 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -521,12 +521,16 @@ MODULE_DEVICE_TABLE(of, hda_tegra_match);
 
 static int hda_tegra_probe(struct platform_device *pdev)
 {
-	const unsigned int driver_flags = AZX_DCAPS_CORBRP_SELF_CLEAR;
+	unsigned int driver_flags = AZX_DCAPS_CORBRP_SELF_CLEAR;
 	struct snd_card *card;
 	struct azx *chip;
 	struct hda_tegra *hda;
 	int err;
 
+#ifdef CONFIG_PM
+	driver_flags |= AZX_DCAPS_PM_RUNTIME;
+#endif
+
 	hda = devm_kzalloc(&pdev->dev, sizeof(*hda), GFP_KERNEL);
 	if (!hda)
 		return -ENOMEM;
-- 
2.7.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
