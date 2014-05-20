From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH] ALSA: hda/tegra - Fix MODULE_DEVICE_TABLE typo.
Date: Tue, 20 May 2014 11:26:12 -0700
Message-ID: <1400610372-12591-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f74.google.com (mail-oa0-f74.google.com
 [209.85.219.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 48347261B31
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 20:26:16 +0200 (CEST)
Received: by mail-oa0-f74.google.com with SMTP id m1so168744oag.5
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 11:26:14 -0700 (PDT)
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

I missed a rename during the review process.  Fix the
MODULE_DEVICE_TABLE to match the structure.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index e472bc8..086fd06 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -496,7 +496,7 @@ static const struct of_device_id hda_tegra_match[] = {
 	{ .compatible = "nvidia,tegra30-hda" },
 	{},
 };
-MODULE_DEVICE_TABLE(of, tegra_platform_hda_match);
+MODULE_DEVICE_TABLE(of, hda_tegra_match);
 
 static int hda_tegra_probe(struct platform_device *pdev)
 {
-- 
1.8.1.3.605.g02339dd
