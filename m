From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: WM8804: Use a proper DAI name
Date: Sat, 02 Oct 2010 12:04:10 +0100
Message-ID: <1286017450.3125.4.camel@odin>
References: <1285920734-25573-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C33DB103862
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Oct 2010 13:04:12 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 42so3727492wyb.38
	for <alsa-devel@alsa-project.org>; Sat, 02 Oct 2010 04:04:12 -0700 (PDT)
In-Reply-To: <1285920734-25573-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-10-01 at 09:12 +0100, Dimitris Papastamos wrote:
> Make sure the DAI name does not include a '/' since we might have
> per DAI debugfs or sysfs entries in the future.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8804.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
> index ca7d9ee..40e5067 100644
> --- a/sound/soc/codecs/wm8804.c
> +++ b/sound/soc/codecs/wm8804.c
> @@ -669,7 +669,7 @@ static struct snd_soc_dai_ops wm8804_dai_ops = {
>  			SNDRV_PCM_FMTBIT_S24_LE)
>  
>  static struct snd_soc_dai_driver wm8804_dai = {
> -	.name = "wm8804-s/pdif",
> +	.name = "wm8804-spdif",
>  	.playback = {
>  		.stream_name = "Playback",
>  		.channels_min = 2,

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
