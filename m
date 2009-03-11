From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH 3/3][RFC] ASoC: pxa-ssp: Don't use
	SSCR0_SerClkDiv and SSCR0_SCR
Date: Wed, 11 Mar 2009 19:17:00 +0100
Message-ID: <1236795420-12175-3-git-send-email-philipp.zabel@gmail.com>
References: <1236795420-12175-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f174.google.com (mail-bw0-f174.google.com
	[209.85.218.174])
	by alsa0.perex.cz (Postfix) with ESMTP id A60601038A6
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 19:17:14 +0100 (CET)
Received: by bwz22 with SMTP id 22so119614bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 11:17:13 -0700 (PDT)
In-Reply-To: <1236795420-12175-1-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

As soon as CONFIG_PXA25x is enabled, those macros only handle the PXA25x_SSP
case, which is wrong most of the time (and always wrong on >=PXA27x).

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

Conflicts:

	sound/soc/pxa/pxa-ssp.c
---
 sound/soc/pxa/pxa-ssp.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index bc9d306..2a2c322 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -287,10 +287,17 @@ static void ssp_set_scr(struct ssp_priv *priv, u32 div)
 {
 	struct ssp_dev *dev = &priv->dev;
 	struct ssp_device *ssp = dev->ssp;
-	u32 sscr0 = ssp_read_reg(dev->ssp, SSCR0) & ~SSCR0_SCR;
+	u32 sscr0 = ssp_read_reg(dev->ssp, SSCR0);
 
 	priv->scr_div = div;
-	ssp_write_reg(ssp, SSCR0, (sscr0 | SSCR0_SerClkDiv(div)));
+	if (ssp->type == PXA25x_SSP) {
+		sscr0 &= ~0x0000ff00;        /* SSCR0_SCR */
+		sscr0 |= ((div - 2)/2) << 8; /* SSCR0_SerClkDiv(div) */
+	} else {
+		sscr0 &= ~0x000fff00;        /* SSCR0_SCR */
+		sscr0 |= (div - 1) << 8;     /* SSCR0_SerClkDiv(div) */
+	}
+	ssp_write_reg(ssp, SSCR0, sscr0);
 }
 
 /*
-- 
1.6.2
