From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 4/7] ASoC: Fix Zylonite voice
	interface	stereo configurations
Date: Wed, 25 Feb 2009 17:06:17 +0100
Message-ID: <20090225160617.GH11203@buzzloop.caiaq.de>
References: <20090225104701.GA20221@rakim.wolfsonmicro.main>
	<1235558902-20314-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id F04282413F
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 17:06:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1235558902-20314-4-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Wed, Feb 25, 2009 at 10:48:19AM +0000, Mark Brown wrote:
> We always run in the first timeslot of one.

I'm currently fiddling around with these bits in order to find a
suitable configuration where the codec is master, so this is
interesting. As the whole frame in I2S is 64 bits long and one FIFO
entry has 32 bits of audio data - how can you only deal with one
timeslot and still playback stereo?


> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/pxa/zylonite.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
> index ec2fb76..0140a25 100644
> --- a/sound/soc/pxa/zylonite.c
> +++ b/sound/soc/pxa/zylonite.c
> @@ -127,9 +127,8 @@ static int zylonite_voice_hw_params(struct snd_pcm_substream *substream,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = snd_soc_dai_set_tdm_slot(cpu_dai,
> -				       params_channels(params),
> -				       params_channels(params));
> +	/* We're not really in network mode but the emulation wants this. */
> +	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 1, 1);

As you set SND_SOC_DAIFMT_I2S, the MOD bit in SSCR0 is set which means
you are actually running in network mode, right?

This register really appears mazy to me - sorry if these are obvious
things I missed.

Daniel
