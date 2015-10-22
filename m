From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: fix Rx synchrounous mode
Date: Thu, 22 Oct 2015 11:57:38 -0700
Message-ID: <20151022185737.GA4614@Asurada-CZ80>
References: <1445301743-24173-1-git-send-email-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id D11242605AE
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 20:57:44 +0200 (CEST)
Received: by pacfv9 with SMTP id fv9so98320175pac.3
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 11:57:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1445301743-24173-1-git-send-email-stefan@agner.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Agner <stefan@agner.ch>
Cc: alsa-devel@alsa-project.org, Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, timur@tabi.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 19, 2015 at 05:42:23PM -0700, Stefan Agner wrote:
> When using the Rx clock for both, transmitter and receiver, the
> transmitter needs to be set to synchronous with receiver.
> 
> This reverts 855675f6e6a6 ("ASoC: fsl_sai: Set SYNC bit of TCR2 to
> Asynchronous Mode"), which, judiging from the commit log, seems to
> mixed up between the two synchronous modes: The boolean

Actually my original patch I sent to the mail list was different:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-August/079639.html

It should be applied before the asynchronous patches however they
are somehow disordered. I guess that's why now the commit appears
in such confusing way. But anyway it's a bug I should have noticed
long time ago.

Thanks a lot

> sai->synchronous[TX] is indicating wheather the SAI should work in
> Rx synchronous mode (sync Tx with Rx), hence if the value is true,
> the SYNC field of TCR2 needs to be set to 0x1 ("Synchronous with
> receiver").
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
> Hi Nicolin,
> 
> I got this reported from a customer, he tried to use the device
> tree property "fsl,sai-synchronous-rx" according to the description
> but it failed. In a quick test, setting the SYNC field of TCR2 to
> 0x1 helped in his case. So I think this here is right. But given
> that you chaged the very same line can you review that again and
> give me a Ack/Nack?
> 
> --
> Stefan
> 
>  sound/soc/fsl/fsl_sai.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index a18fd92..1f0e552 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -454,7 +454,8 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
>  	 * Rx sync with Tx clocks: Clear SYNC for Tx, set it for Rx.
>  	 * Tx sync with Rx clocks: Clear SYNC for Rx, set it for Tx.
>  	 */
> -	regmap_update_bits(sai->regmap, FSL_SAI_TCR2, FSL_SAI_CR2_SYNC, 0);
> +	regmap_update_bits(sai->regmap, FSL_SAI_TCR2, FSL_SAI_CR2_SYNC,
> +		           sai->synchronous[TX] ? FSL_SAI_CR2_SYNC : 0);
>  	regmap_update_bits(sai->regmap, FSL_SAI_RCR2, FSL_SAI_CR2_SYNC,
>  			   sai->synchronous[RX] ? FSL_SAI_CR2_SYNC : 0);
>  
> -- 
> 2.6.1
> 
