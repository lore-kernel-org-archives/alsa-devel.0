From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/6] ASoC: mxs: add __devinit for mxs_saif_probe
Date: Thu, 10 May 2012 16:42:08 +0800
Message-ID: <1336639333-11561-2-git-send-email-shawn.guo@linaro.org>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B97E410B9E6
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 10:42:40 +0200 (CEST)
Received: by dajt11 with SMTP id t11so1905635daj.38
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2012 01:42:39 -0700 (PDT)
In-Reply-To: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org, Dong Aisheng <dong.aisheng@linaro.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/mxs/mxs-saif.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 7fd224b..40d0775 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -621,7 +621,7 @@ static irqreturn_t mxs_saif_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int mxs_saif_probe(struct platform_device *pdev)
+static int __devinit mxs_saif_probe(struct platform_device *pdev)
 {
 	struct resource *iores, *dmares;
 	struct mxs_saif *saif;
-- 
1.7.5.4
