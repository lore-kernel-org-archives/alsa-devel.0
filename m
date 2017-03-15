From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] ASoC: wm8960: Use physical width for
	bclk
Date: Wed, 15 Mar 2017 09:19:01 +0000
Message-ID: <20170315091901.GF6986@localhost.localdomain>
References: <1489510622-30981-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BD6A266E13
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 10:17:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1489510622-30981-1-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org, shengjiu.wang@freescale.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, broonie@kernel.org, viorel.suman@nxp.com, mihai.serban@nxp.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 14, 2017 at 06:57:02PM +0200, Daniel Baluta wrote:
> bclk is derived from sysclk with the help of bclk_divs. Anyhow, for
> S20_3LE format there is no bclk_divs that could be used to derive
> an exact bclk.
> 
> We can fix this by using storage size instead the exact
> number of bits of the sample when computing bclk.
> 
> With this approach we can play S20_3LE encoded files at the cost of
> some unused BCLK cycles for S20_3LE and S24_LE.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/codecs/wm8960.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
> index e1429e3..18ca5fc 100644
> --- a/sound/soc/codecs/wm8960.c
> +++ b/sound/soc/codecs/wm8960.c
> @@ -722,7 +722,8 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
>  	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
>  	int i;
>  
> -	wm8960->bclk = snd_soc_params_to_bclk(params);
> +	wm8960->bclk = params_physical_width(params) *
> +		params_channels(params) * params_rate(params);
>  	if (params_channels(params) == 1)
>  		wm8960->bclk *= 2;

Would quite like to see Mark's thoughts on this. Feels a bit to
me (although I am not certain) like we are solving the problem in
the wrong place, isn't this really setting the desired BCLK and
then in wm8960_configure_clocking we should set the lowest BCLK
we can that is greater than or equal to the desired.

Thanks,
Charles
