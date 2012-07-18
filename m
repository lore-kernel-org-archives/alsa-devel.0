From: Roberto Nibali <rnibali@gmail.com>
Subject: Re: [PATCH] ASoC imx-audmux: add
 MX31_AUDMUX_PORT7_SSI_PINS_7 define
Date: Wed, 18 Jul 2012 20:28:09 +0200
Message-ID: <CAONxwYNBXeCPYeOfer7TugVhr2VFgtqWZHEw8L0e8G0XR26h1w@mail.gmail.com>
References: <1342616477-24778-1-git-send-email-torbenh@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
 [209.85.213.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 441CA260312
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2012 20:28:29 +0200 (CEST)
Received: by yenr13 with SMTP id r13so1844044yen.38
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2012 11:28:30 -0700 (PDT)
In-Reply-To: <1342616477-24778-1-git-send-email-torbenh@linutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Torben Hohn <torbenh@linutronix.de>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Richard Zhao <richard.zhao@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Wed, Jul 18, 2012 at 3:01 PM, Torben Hohn <torbenh@linutronix.de> wrote:
> The MX31 Audmux also has 7 Ports.
> This patch adds the missing define, and makes the debugfs code iterate
> over that port too.
>
> Signed-off-by: Torben Hohn <torbenh@linutronix.de>
> ---
>  sound/soc/fsl/imx-audmux.c |    2 +-
>  sound/soc/fsl/imx-audmux.h |    1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
> index 0803274..e7c800e 100644
> --- a/sound/soc/fsl/imx-audmux.c
> +++ b/sound/soc/fsl/imx-audmux.c
> @@ -156,7 +156,7 @@ static void __init audmux_debugfs_init(void)
>                 return;
>         }
>
> -       for (i = 0; i < MX31_AUDMUX_PORT6_SSI_PINS_6 + 1; i++) {
> +       for (i = 0; i < MX31_AUDMUX_PORT7_SSI_PINS_7 + 1; i++) {
>                 snprintf(buf, sizeof(buf), "ssi%d", i);
>                 if (!debugfs_create_file(buf, 0444, audmux_debugfs_root,
>                                          (void *)i, &audmux_debugfs_fops))
> diff --git a/sound/soc/fsl/imx-audmux.h b/sound/soc/fsl/imx-audmux.h
> index 04ebbab..b8ff44b 100644
> --- a/sound/soc/fsl/imx-audmux.h
> +++ b/sound/soc/fsl/imx-audmux.h
> @@ -14,6 +14,7 @@
>  #define MX31_AUDMUX_PORT4_SSI_PINS_4   3
>  #define MX31_AUDMUX_PORT5_SSI_PINS_5   4
>  #define MX31_AUDMUX_PORT6_SSI_PINS_6   5
> +#define MX31_AUDMUX_PORT7_SSI_PINS_7   6

There was a similar fix for the kernel part about three months ago.
Also, the i.MX25 has 7 SSI ports, so this patch is good and safe.

Cheers
Roberto
