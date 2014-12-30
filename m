From: Andrew Jackson <andrew.jackson@arm.com>
Subject: [PATCH v5 4/6] ASoC: dwc: Register components with
	managed interface
Date: Tue, 30 Dec 2014 10:55:46 +0000
Message-ID: <6bd7d7cfd48fedccd8730ddbbae39f92dd0069c7.1419936132.git.Andrew.Jackson@arm.com>
References: <cover.1419936132.git.Andrew.Jackson@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.140])
 by alsa0.perex.cz (Postfix) with ESMTP id AB443260606
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 11:55:59 +0100 (CET)
In-Reply-To: <cover.1419936132.git.Andrew.Jackson@arm.com>
In-Reply-To: <cover.1419936132.git.Andrew.Jackson@arm.com>
References: <cover.1419936132.git.Andrew.Jackson@arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, pawel.moll@arm.com, Arnd Bergmann <arnd@arndb.de>, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, Andrew Jackson <Andrew.Jackson@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, robh+dt@kernel.org, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Andrew Jackson <Andrew.Jackson@arm.com>

Register SOC component using managed interface to
simplify error handling and future introduction of
device tree.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 sound/soc/dwc/designware_i2s.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index b3e7567..e1c0e2c 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -492,7 +492,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 		return ret;
 
 	dev_set_drvdata(&pdev->dev, dev);
-	ret = snd_soc_register_component(&pdev->dev, &dw_i2s_component,
+	ret = devm_snd_soc_register_component(&pdev->dev, &dw_i2s_component,
 					 dw_i2s_dai, 1);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "not able to register dai\n");
@@ -510,7 +510,6 @@ static int dw_i2s_remove(struct platform_device *pdev)
 {
 	struct dw_i2s_dev *dev = dev_get_drvdata(&pdev->dev);
 
-	snd_soc_unregister_component(&pdev->dev);
 	clk_disable_unprepare(dev->clk);
 
 	return 0;
-- 
1.7.1
