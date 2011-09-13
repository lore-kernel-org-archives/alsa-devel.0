From: Geoffrey Wossum <geoffrey@pager.net>
Subject: Re: [PATCH] ASoC: playpaq_wm8510: Return proper error
	if clk_get fails
Date: Tue, 13 Sep 2011 11:16:22 -0500
Message-ID: <201109131116.23577.geoffrey@pager.net>
References: <1315534538.3275.1.camel@phoenix>
	<CABS+qY1W5D7_-ourY=kaF2-FADM8EqBRYR2QZa1odpzDiCya9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.pager.net (unknown [64.129.32.194])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F8DD103A3A
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 18:16:39 +0200 (CEST)
In-Reply-To: <CABS+qY1W5D7_-ourY=kaF2-FADM8EqBRYR2QZa1odpzDiCya9g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Girdwood, Liam" <lrg@ti.com>
Cc: Axel Lin <axel.lin@gmail.com>, Geoffrey Wossum <gwossum@acm.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Friday, September 09, 2011 11:38:44 AM Girdwood, Liam wrote:


On 9 September 2011 03:15, Axel Lin 
<axel.lin@gmail.com<mailto:axel.lin@gmail.com>> wrote:
Return proper error instead of 0 if clk_get fails.

Signed-off-by: Axel Lin <axel.lin@gmail.com<mailto:axel.lin@gmail.com>>
---
 sound/soc/atmel/playpaq_wm8510.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/soc/atmel/playpaq_wm8510.c 
b/sound/soc/atmel/playpaq_wm8510.c
index 1aac2f4..2909bfa 100644
--- a/sound/soc/atmel/playpaq_wm8510.c
+++ b/sound/soc/atmel/playpaq_wm8510.c
@@ -383,14 +383,17 @@ static int __init playpaq_asoc_init(void)
       _gclk0 = clk_get(NULL, "gclk0");
       if (IS_ERR(_gclk0)) {
               _gclk0 = NULL;
+               ret = PTR_ERR(_gclk0);
               goto err_gclk0;
       }
       _pll0 = clk_get(NULL, "pll0");
       if (IS_ERR(_pll0)) {
               _pll0 = NULL;
+               ret = PTR_ERR(_pll0);
               goto err_pll0;
       }
-       if (clk_set_parent(_gclk0, _pll0)) {
+       ret = clk_set_parent(_gclk0, _pll0);
+       if (ret) {
               pr_warning("snd-soc-playpaq: "
                          "Failed to set PLL0 as parent for DAC clock\n");
               goto err_set_clk;
--
1.7.4.1




Acked-by: Liam Girdwood <lrg@ti.com<mailto:lrg@ti.com>>
Acked-by: Geoffrey Wossum <gwossum@acm.org>
