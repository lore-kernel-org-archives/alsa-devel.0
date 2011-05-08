From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/6] ASoC: SSM2602: Fix default register
 cache
Date: Sun, 08 May 2011 21:53:33 +0100
Message-ID: <1304888013.3246.34.camel@odin>
References: <20110508135613.GA15968@opensource.wolfsonmicro.com>
	<1304871886-18509-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 186311037FF
	for <alsa-devel@alsa-project.org>;
	Sun,  8 May 2011 22:53:38 +0200 (CEST)
Received: by wyg36 with SMTP id 36so3931094wyg.38
	for <alsa-devel@alsa-project.org>; Sun, 08 May 2011 13:53:37 -0700 (PDT)
In-Reply-To: <1304871886-18509-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Frysinger <vapier@gentoo.org>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2011-05-08 at 09:24 -0700, Lars-Peter Clausen wrote:
> Some of the values in the default register cache did not represent the codecs
> state after reset. This patch fixes it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/codecs/ssm2602.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
> index 30229cf..a09d66c 100644
> --- a/sound/soc/codecs/ssm2602.c
> +++ b/sound/soc/codecs/ssm2602.c
> @@ -60,8 +60,8 @@ struct ssm2602_priv {
>   * There is no point in caching the reset register
>   */
>  static const u16 ssm2602_reg[SSM2602_CACHEREGNUM] = {
> -	0x0017, 0x0017, 0x0079, 0x0079,
> -	0x0000, 0x0000, 0x0000, 0x000a,
> +	0x0097, 0x0097, 0x0079, 0x0079,
> +	0x000a, 0x0008, 0x009f, 0x000a,
>  	0x0000, 0x0000
>  };
>  

All 

Acked-by: Liam Girdwood <lrg@ti.com>
