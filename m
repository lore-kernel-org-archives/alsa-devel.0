From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH 4/4] ASoC: pxa-ssp: select PXA_SSP
Date: Tue,  3 Feb 2009 17:19:43 +0100
Message-ID: <1233677983-23710-5-git-send-email-philipp.zabel@gmail.com>
References: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id F0ACF10386C
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 17:19:56 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 13so971049fge.44
	for <alsa-devel@alsa-project.org>; Tue, 03 Feb 2009 08:19:56 -0800 (PST)
In-Reply-To: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
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
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

snd-soc-pxa-ssp depends on PXA_SSP being enabled.
Let SND_PXA_SOC_SSP select it, like SPI_PXA2XX does.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/pxa/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 5fb9513..8627bf6 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -23,6 +23,7 @@ config SND_PXA2XX_SOC_SSP
 
 config SND_PXA_SOC_SSP
 	tristate
+	select PXA_SSP
 
 config SND_PXA2XX_SOC_CORGI
 	tristate "SoC Audio support for Sharp Zaurus SL-C7x0"
-- 
1.5.6.5
