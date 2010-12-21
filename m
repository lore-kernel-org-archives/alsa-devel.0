From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Remove some unused defines from
 WM8903
Date: Tue, 21 Dec 2010 10:19:50 +0000
Message-ID: <1292926790.3296.4.camel@odin>
References: <1292878546-28557-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B3D5010397B
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 11:19:53 +0100 (CET)
Received: by wwe15 with SMTP id 15so3681895wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 02:19:53 -0800 (PST)
In-Reply-To: <1292878546-28557-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Mon, 2010-12-20 at 20:55 +0000, Mark Brown wrote:
> These would have been used if we'd done manual clock divider setup,
> but we didn't.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8903.h |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8903.h b/sound/soc/codecs/wm8903.h
> index 7f9f6be..5f23d3c 100644
> --- a/sound/soc/codecs/wm8903.h
> +++ b/sound/soc/codecs/wm8903.h
> @@ -19,10 +19,6 @@ extern int wm8903_mic_detect(struct snd_soc_codec *codec,
>  			     struct snd_soc_jack *jack,
>  			     int det, int shrt);
>  
> -#define WM8903_MCLK_DIV_2 1
> -#define WM8903_CLK_SYS    2
> -#define WM8903_BCLK       3
> -#define WM8903_LRCLK      4
>  
>  /*
>   * Register values.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
