From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/2] ASoC: Restore DAI ID specification for
 WM8994
Date: Wed, 13 Oct 2010 10:30:32 +0100
Message-ID: <1286962232.3282.27.camel@odin>
References: <1286895476-23198-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1286895476-23198-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D042243BB
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 11:30:35 +0200 (CEST)
Received: by wwd20 with SMTP id 20so137234wwd.2
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2010 02:30:35 -0700 (PDT)
In-Reply-To: <1286895476-23198-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-10-12 at 15:57 +0100, Mark Brown wrote:
> WM8994 relies on the DAIs having IDs that match the AIF numbers.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8994.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index cb9338e..9ccda44 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -3850,6 +3850,7 @@ static struct snd_soc_dai_ops wm8994_aif3_dai_ops = {
>  static struct snd_soc_dai_driver wm8994_dai[] = {
>  	{
>  		.name = "wm8994-aif1",
> +		.id = 1,
>  		.playback = {
>  			.stream_name = "AIF1 Playback",
>  			.channels_min = 2,
> @@ -3868,6 +3869,7 @@ static struct snd_soc_dai_driver wm8994_dai[] = {
>  	},
>  	{
>  		.name = "wm8994-aif2",
> +		.id = 2,
>  		.playback = {
>  			.stream_name = "AIF2 Playback",
>  			.channels_min = 2,
> @@ -3886,6 +3888,7 @@ static struct snd_soc_dai_driver wm8994_dai[] = {
>  	},
>  	{
>  		.name = "wm8994-aif3",
> +		.id = 3,
>  		.playback = {
>  			.stream_name = "AIF3 Playback",
>  			.channels_min = 2,

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
