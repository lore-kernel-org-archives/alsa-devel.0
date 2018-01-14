From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v2 03/16] ASoC: fsl_ssi: Maintain a mask of
	active streams
Date: Sun, 14 Jan 2018 23:34:01 +0100
Message-ID: <1488354c-99b0-fa64-a88c-0fa065df4b7d@maciej.szmigiero.name>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
 <1515652995-15996-4-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id D6DFA266CFE
 for <alsa-devel@alsa-project.org>; Sun, 14 Jan 2018 23:34:10 +0100 (CET)
In-Reply-To: <1515652995-15996-4-git-send-email-nicoleotsuka@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, caleb@crome.org, timur@tabi.org, broonie@kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 11.01.2018 07:43, Nicolin Chen wrote:
> Checking TE and RE bits in SCR register doesn't work for AC97 mode
> which enables SSIEN, TE and RE in the fsl_ssi_setup_ac97() that's
> called during probe().
> 
> So when running into the trigger(), it will always get the result
> of both TE and RE being enabled already, even if actually there is
> no active stream.
> 
> This patch fixes this issue by adding a variable to log the active
> streams manually.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Tested-by: Caleb Crome <caleb@crome.org>
> ---
>  sound/soc/fsl/fsl_ssi.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 491b660..aa14a5d 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -201,6 +201,7 @@ struct fsl_ssi_soc_data {
>   * @cpu_dai_drv: CPU DAI driver for this device
>   *
>   * @dai_fmt: DAI configuration this device is currently used with
> + * @streams: Mask of current active streams: BIT(TX) and BIT(RX)
>   * @i2s_net: I2S and Network mode configurations of SCR register
>   * @use_dma: DMA is used or FIQ with stream filter
>   * @use_dual_fifo: DMA with support for dual FIFO mode
> @@ -245,6 +246,7 @@ struct fsl_ssi {
>  	struct snd_soc_dai_driver cpu_dai_drv;
>  
>  	unsigned int dai_fmt;
> +	u8 streams;
>  	u8 i2s_net;
>  	bool use_dma;
>  	bool use_dual_fifo;
> @@ -440,15 +442,14 @@ static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
>  static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
>  			   struct fsl_ssi_regvals *vals)
>  {
> +	bool dir = (&ssi->regvals[TX] == vals) ? TX : RX;
Using a bool variable for a bit index (and array index in other parts
of code) looks just wrong.

Even a simple int would look better IMHO here (and in patch 5 that
rewrites this line a bit).

Maciej
