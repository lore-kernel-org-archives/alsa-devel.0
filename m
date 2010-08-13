From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/7] ASoC: Fix inverted WM8580 capture mute
	control
Date: Fri, 13 Aug 2010 20:35:06 +0100
Message-ID: <1281728107-25386-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20100813193305.GB3778@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5081910390A
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 21:35:13 +0200 (CEST)
In-Reply-To: <20100813193305.GB3778@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8580.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 6262124..357f7d5 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -262,7 +262,7 @@ SOC_SINGLE("DAC1 Switch", WM8580_DAC_CONTROL5, 0, 1, 0),
 SOC_SINGLE("DAC2 Switch", WM8580_DAC_CONTROL5, 1, 1, 0),
 SOC_SINGLE("DAC3 Switch", WM8580_DAC_CONTROL5, 2, 1, 0),
 
-SOC_DOUBLE("Capture Switch", WM8580_ADC_CONTROL1, 0, 1, 1, 0),
+SOC_DOUBLE("Capture Switch", WM8580_ADC_CONTROL1, 0, 1, 1, 1),
 SOC_SINGLE("Capture High-Pass Filter Switch", WM8580_ADC_CONTROL1, 4, 1, 0),
 };
 
-- 
1.7.1
