From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/6] ASoC: ad1980: fix names of a
	few	kcontrols
Date: Fri, 27 Aug 2010 19:11:09 +0100
Message-ID: <20100827181109.GB30429@sirena.org.uk>
References: <1282655384-13357-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1282655384-13357-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E7B8110381E
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 20:11:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282655384-13357-2-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
Cc: Marcus Weigelt <marcus.weigelt@fwd-online.de>, alsa-devel@alsa-project.org, Sonic Zhang <sonic.zhang@analog.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 24, 2010 at 03:09:40PM +0200, Uwe Kleine-K??nig wrote:
> From: Marcus Weigelt <marcus.weigelt@fwd-online.de>
> 
> The names used before keep alsamixer from showing the appropriate
> controls for the AD1980.  Mic and phone volume controls were shown in
> alsamixers' capture tab where they don??t belong to.  Phone playback

It's not massively obvious that microphone and phone aren't inputs and
therefore don't sensibly appear in the capture tab?

> volume did not appear in playback tab and the microphone playback could
> never be unmuted.  Further it was not possible to select phone as
> capture source.  Changing the names fixes these problems.

This doesn't sound real - misnamed controls might cause UI problems but
you'd have to try *really* hard to make the control name completely
prevent the setting of the control.

What is the actual problem that is is being fixed here?

> Signed-off-by: Marcus Weigelt <marcus.weigelt@fwd-online.de>
> Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>

Please remember to CC maintaintainers on patches.

> ---
>  sound/soc/codecs/ad1980.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
> index 35c0580..c1550b8 100644
> --- a/sound/soc/codecs/ad1980.c
> +++ b/sound/soc/codecs/ad1980.c
> @@ -82,11 +82,11 @@ SOC_SINGLE("PCM Capture Switch", AC97_REC_GAIN, 15, 1, 1),
>  SOC_SINGLE("Mono Playback Volume", AC97_MASTER_MONO, 0, 31, 1),
>  SOC_SINGLE("Mono Playback Switch", AC97_MASTER_MONO, 15, 1, 1),
>  
> -SOC_SINGLE("Phone Capture Volume", AC97_PHONE, 0, 31, 1),
> -SOC_SINGLE("Phone Capture Switch", AC97_PHONE, 15, 1, 1),
> +SOC_SINGLE("Phone Playback Volume", AC97_PHONE, 0, 31, 1),
> +SOC_SINGLE("Phone Playback Switch", AC97_PHONE, 15, 1, 1),
>  
> -SOC_SINGLE("Mic Volume", AC97_MIC, 0, 31, 1),
> -SOC_SINGLE("Mic Switch", AC97_MIC, 15, 1, 1),
> +SOC_SINGLE("Mic Playback Volume", AC97_MIC, 0, 31, 1),
> +SOC_SINGLE("Mic Playback Switch", AC97_MIC, 15, 1, 1),
>  
>  SOC_SINGLE("Stereo Mic Switch", AC97_AD_MISC, 6, 1, 0),
>  SOC_DOUBLE("Line HP Swap Switch", AC97_AD_MISC, 10, 5, 1, 0),
> -- 
> 1.7.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
