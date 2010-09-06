From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Staticise WM9712 DAI list
Date: Mon, 06 Sep 2010 19:08:59 +0100
Message-ID: <1283796539.3078.45.camel@odin>
References: <1283795799-1811-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 3B402243F6
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Sep 2010 20:09:01 +0200 (CEST)
Received: by wyb32 with SMTP id 32so4931525wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 06 Sep 2010 11:09:01 -0700 (PDT)
In-Reply-To: <1283795799-1811-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Mon, 2010-09-06 at 18:56 +0100, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm9712.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
> index f8f37ae..cebeb93 100644
> --- a/sound/soc/codecs/wm9712.c
> +++ b/sound/soc/codecs/wm9712.c
> @@ -524,7 +524,7 @@ static struct snd_soc_dai_ops wm9712_dai_ops_aux = {
>  	.prepare	= ac97_aux_prepare,
>  };
>  
> -struct snd_soc_dai_driver wm9712_dai[] = {
> +static struct snd_soc_dai_driver wm9712_dai[] = {
>  {
>  	.name = "wm9712-hifi",
>  	.ac97_control = 1,

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
