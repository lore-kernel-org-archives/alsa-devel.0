From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: ASoc: pxa/raumfeld: adopt new
 snd_soc_dai_set_pll() API
Date: Mon, 30 Nov 2009 14:06:37 +0100
Message-ID: <20091130130637.GH14091@buzzloop.caiaq.de>
References: <1259575964-32251-1-git-send-email-daniel@caiaq.de>
	<20091130125543.GE10968@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id AE87C103879
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 14:06:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091130125543.GE10968@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 30, 2009 at 12:55:43PM +0000, Mark Brown wrote:
> On Mon, Nov 30, 2009 at 11:12:44AM +0100, Daniel Mack wrote:
> > This is needed for recent changes in the for-2.6.33 branch.
> 
> Which changes?

snd_soc_dai_set_pll() takes an additional argument now.

> 
> > -	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, clk);
> > +	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, clk, clk);
> >  	if (ret < 0)
> >  		return ret;
> 
> This looks wrong - why would you configure a PLL to produce the same
> frequency as is being input?  I suspect you're trying to update for the
> addition of the additional source argument to set_pll()...

Ah, right. The pxa-ssp code doesn't pay attention to either argument,
hence I didn't notice. Thanks!

Daniel


>From fdc23d80fa7a3b2aa76e05ee9fbd85dea0f647d8 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Mon, 30 Nov 2009 11:08:17 +0100
Subject: [PATCH] ALSA: ASoc: pxa/raumfeld: adopt new snd_soc_dai_set_pll() API

ALSA's for-2.6.33 branch has a new source argument to
snd_soc_dai_set_pll().

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/raumfeld.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index 5d7bb8c..e713181 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -116,7 +116,7 @@ static int raumfeld_cs4270_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 
 	/* setup the CPU DAI */
-	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, clk);
+	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, 0, clk);
 	if (ret < 0)
 		return ret;
 
@@ -205,7 +205,7 @@ static int raumfeld_ak4104_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 
 	/* setup the CPU DAI */
-	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, clk);
+	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, 0, clk);
 	if (ret < 0)
 		return ret;
 
-- 
1.6.5.2
