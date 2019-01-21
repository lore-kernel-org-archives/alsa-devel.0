From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 3/7] ALSA: hda/tegra: add runtime PM callbacks
Date: Mon, 21 Jan 2019 23:11:33 +0530
Message-ID: <1548092497-5459-4-git-send-email-spujar@nvidia.com>
References: <1548092497-5459-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9692F26745A
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 18:42:05 +0100 (CET)
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

This patch adds skeleton of runtime suspend and resume callbacks.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 28e1656..1189f97 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -265,8 +265,23 @@ static int hda_tegra_resume(struct device *dev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
+#ifdef CONFIG_PM
+static int hda_tegra_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int hda_tegra_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+#endif /* CONFIG_PM */
+
 static const struct dev_pm_ops hda_tegra_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(hda_tegra_suspend, hda_tegra_resume)
+	SET_RUNTIME_PM_OPS(hda_tegra_runtime_suspend,
+			   hda_tegra_runtime_resume,
+			   NULL)
 };
 
 static int hda_tegra_dev_disconnect(struct snd_device *device)
-- 
2.7.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
