From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: Add DSP DAI format support to the
	OMAP McBSP driver
Date: Fri,  3 Oct 2008 09:54:57 +0100
Message-ID: <1223024097-8335-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081003085338.GA8173@rakim.wolfsonmicro.main>
	<1223024097-8335-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223024097-8335-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 95938246B2
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Oct 2008 10:54:58 +0200 (CEST)
In-Reply-To: <1223024097-8335-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Arun KS <arunks@mistralsolutions.com>
List-Id: alsa-devel@alsa-project.org

From: Arun KS <arunks@mistralsolutions.com>

Enables DSP DAI format for McBSP in OMAP platform driver

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/omap-mcbsp.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 35310e1..fb920e1 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -245,6 +245,11 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		regs->rcr2	|= RDATDLY(1);
 		regs->xcr2	|= XDATDLY(1);
 		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		/* 0-bit data delay */
+		regs->rcr2      |= RDATDLY(0);
+		regs->xcr2      |= XDATDLY(0);
+		break;
 	default:
 		/* Unsupported data format */
 		return -EINVAL;
-- 
1.5.6.5
