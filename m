From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: s6000-i2s: Fix s6000_i2s_remove()
	return type
Date: Mon, 30 Jun 2014 10:01:37 +0200
Message-ID: <1404115299-24109-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-252.synserver.de (smtp-out-252.synserver.de
 [212.40.185.252])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FDC02617B6
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 10:02:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <daniel-gl@gmx.net>
List-Id: alsa-devel@alsa-project.org

The platform_driver remove callback return type is int not void.

Fixes the following warning:
	sound/soc/s6000/s6000-i2s.c:604:19: warning: incorrect type in initializer (different base types)
	sound/soc/s6000/s6000-i2s.c:604:19:    expected int ( *remove )( ... )
	sound/soc/s6000/s6000-i2s.c:604:19:    got void ( static [toplevel] *<noident>)( ... )

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/s6000/s6000-i2s.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/s6000/s6000-i2s.c b/sound/soc/s6000/s6000-i2s.c
index 7eba797..1c8d011 100644
--- a/sound/soc/s6000/s6000-i2s.c
+++ b/sound/soc/s6000/s6000-i2s.c
@@ -570,7 +570,7 @@ err_release_none:
 	return ret;
 }
 
-static void s6000_i2s_remove(struct platform_device *pdev)
+static int s6000_i2s_remove(struct platform_device *pdev)
 {
 	struct s6000_i2s_dev *dev = dev_get_drvdata(&pdev->dev);
 	struct resource *region;
@@ -597,6 +597,8 @@ static void s6000_i2s_remove(struct platform_device *pdev)
 	iounmap(mmio);
 	region = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	release_mem_region(region->start, resource_size(region));
+
+	return 0;
 }
 
 static struct platform_driver s6000_i2s_driver = {
-- 
1.8.0
