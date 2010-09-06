From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix cut'n'paste comment in WM8994
Date: Mon, 06 Sep 2010 16:35:06 +0100
Message-ID: <1283787306.3078.43.camel@odin>
References: <1283786570-15247-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id F08BA245DE
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Sep 2010 17:35:08 +0200 (CEST)
Received: by wyb32 with SMTP id 32so4785718wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 06 Sep 2010 08:35:08 -0700 (PDT)
In-Reply-To: <1283786570-15247-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Mon, 2010-09-06 at 16:22 +0100, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8994.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index a3d9145..218bcd2 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -3810,7 +3810,7 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
>   *
>   * Enable microphone detection via IRQ on the WM8994.  If GPIOs are
>   * being used to bring out signals to the processor then only platform
> - * data configuration is needed for WM8903 and processor GPIOs should
> + * data configuration is needed for WM8994 and processor GPIOs should
>   * be configured using snd_soc_jack_add_gpios() instead.
>   *
>   * Configuration of detection levels is available via the micbias1_lvl

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
