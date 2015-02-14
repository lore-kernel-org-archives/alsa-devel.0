From: eliot@blennerhassett.gen.nz
Subject: [PATCH] ALSA: hda/tegra check correct return value
 from ioremap_resource
Date: Sat, 14 Feb 2015 15:32:24 +1300
Message-ID: <1423881144-5957-1-git-send-email-eliot@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 018B52604AE
 for <alsa-devel@alsa-project.org>; Sat, 14 Feb 2015 03:32:29 +0100 (CET)
Received: from mxin3-orange.clear.net.nz
 (lb2-srcnat.clear.net.nz [203.97.32.237])
 by smtp4.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0NJQ007FDPQ2V130@smtp4.clear.net.nz> for
 alsa-devel@alsa-project.org; Sat, 14 Feb 2015 15:32:27 +1300 (NZDT)
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
---
 sound/pci/hda/hda_tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 227990b..375e94f 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -329,8 +329,8 @@ static int hda_tegra_init_chip(struct azx *chip, struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	hda->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(chip->remap_addr))
-		return PTR_ERR(chip->remap_addr);
+	if (IS_ERR(hda->regs))
+		return PTR_ERR(hda->regs);
 
 	chip->remap_addr = hda->regs + HDA_BAR0;
 	chip->addr = res->start + HDA_BAR0;
-- 
1.9.1
