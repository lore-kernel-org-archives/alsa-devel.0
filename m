From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: imx: Open code dma channel request
Date: Sat, 19 Oct 2013 22:27:51 +0200
Message-ID: <5262EB47.7000302@metafoo.de>
References: <1382212933-15641-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 9693C26260F
 for <alsa-devel@alsa-project.org>; Sat, 19 Oct 2013 22:27:07 +0200 (CEST)
In-Reply-To: <1382212933-15641-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 10/19/2013 10:02 PM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
>
> Currently the imx DMA code is one of the few users relying on the fact
> that the compat code uses the dma_data as the filter data for non-DT
> channel requests. Since the rest of the core expects this to be a struct
> snd_dmaengine_dai_data this isn't terribly helpful this will be changed to
> use the already existing filter data so avoid breaking imx by open
> coding the current behaviour.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>

Since the driver is already using the generic struct adding this to the other 
patch makes more sense to me:

--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -25,12 +25,10 @@

  static bool filter(struct dma_chan *chan, void *param)
  {
-	struct snd_dmaengine_dai_dma_data *dma_data = param;
-
  	if (!imx_dma_is_general_purpose(chan))
  		return false;

-	chan->private = dma_data->filter_data;
+	chan->private = param;

  	return true;
  }
