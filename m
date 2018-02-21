From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RESEND PATCH v2 2/2] ASoC: topology: Add missing
 clock gating parameter when parsing hw_configs
Date: Wed, 21 Feb 2018 16:50:30 +0200
Message-ID: <CAHp75Vc451W4GvvVCv-70EO6Cgn99Y+HV9xb530nJ72aT79rLQ@mail.gmail.com>
References: <20180220174446.7784-1-k.marinushkin@gmail.com>
 <20180220174446.7784-3-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f176.google.com (mail-qk0-f176.google.com
 [209.85.220.176])
 by alsa0.perex.cz (Postfix) with ESMTP id E73392675DA
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 15:50:33 +0100 (CET)
Received: by mail-qk0-f176.google.com with SMTP id v124so2223175qkh.11
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 06:50:33 -0800 (PST)
In-Reply-To: <20180220174446.7784-3-k.marinushkin@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 20, 2018 at 7:44 PM, Kirill Marinushkin
<k.marinushkin@gmail.com> wrote:
> Clock gating parameter is a part of `dai_fmt`. It is supported by
> `alsa-lib` when creating a topology binary file, but ignored by kernel
> when loading this topology file.

> +               /* clock gating */
> +               if (hw_config->clock_gated == SND_SOC_TPLG_DAI_CLK_GATE_GATED)
> +                       link->dai_fmt |= SND_SOC_DAIFMT_GATED;

> +               else if (hw_config->clock_gated ==
> +                        SND_SOC_TPLG_DAI_CLK_GATE_CONT)

A nit, I would leave it on the same line, even if it ~2-3 characters
longer than 80.

> +                       link->dai_fmt |= SND_SOC_DAIFMT_CONT;
> +

-- 
With Best Regards,
Andy Shevchenko
