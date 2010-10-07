From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Staticise CS4270 DAI
Date: Thu, 07 Oct 2010 19:13:14 +0100
Message-ID: <1286475194.3149.17.camel@odin>
References: <1286407557-30413-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6674B103868
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 20:13:21 +0200 (CEST)
Received: by wyb35 with SMTP id 35so258038wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 07 Oct 2010 11:13:21 -0700 (PDT)
In-Reply-To: <1286407557-30413-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-10-06 at 16:25 -0700, Mark Brown wrote:
> It's not needed with multi-component.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/cs4270.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
> index 5fd8e0d..6d4bdc6 100644
> --- a/sound/soc/codecs/cs4270.c
> +++ b/sound/soc/codecs/cs4270.c
> @@ -518,7 +518,7 @@ static struct snd_soc_dai_ops cs4270_dai_ops = {
>  	.digital_mute	= cs4270_dai_mute,
>  };
>  
> -struct snd_soc_dai_driver cs4270_dai = {
> +static struct snd_soc_dai_driver cs4270_dai = {
>  	.name = "cs4270-hifi",
>  	.playback = {
>  		.stream_name = "Playback",

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
