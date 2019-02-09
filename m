From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] ASoC: codecs: jz4725b: Remove unnecessary
	const qualifier
Date: Fri, 8 Feb 2019 16:59:26 -0800
Message-ID: <CAKwvOdkrzOVoZxPcdGHa-dkKBwVBCqiYqDh9Sc+htT=7YOL2RA@mail.gmail.com>
References: <20190208045918.16799-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DBE02674C9
 for <alsa-devel@alsa-project.org>; Sat,  9 Feb 2019 01:59:16 +0100 (CET)
Received: by mail-pl1-f196.google.com with SMTP id u18so2479735plq.7
 for <alsa-devel@alsa-project.org>; Fri, 08 Feb 2019 16:59:16 -0800 (PST)
In-Reply-To: <20190208045918.16799-1-natechancellor@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Paul Cercueil <paul@crapouillou.net>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 7, 2019 at 9:00 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> sound/soc/codecs/jz4725b.c:177:14: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
> static const SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
>              ^
> include/sound/soc.h:356:2: note: expanded from macro 'SOC_VALUE_ENUM_SINGLE_DECL'
>         SOC_VALUE_ENUM_DOUBLE_DECL(name, xreg, xshift, xshift, xmask, xtexts, xvalues)
>         ^
> include/sound/soc.h:353:2: note: expanded from macro 'SOC_VALUE_ENUM_DOUBLE_DECL'
>         const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, \
>         ^
>
> As it points out, SOC_VALUE_ENUM_DOUBLE_DECL has the const attribute in
> its definition so remove it here.
>
> Fixes: e9d97b05a80f ("ASoC: codecs: Add jz4725b-codec driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/354
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the fix.  Looks like the struct instance declaration
already contains a const.  That's a curious (not bad, per se) pattern
that probably results in a few other instances of this warning, I'll
bet.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  sound/soc/codecs/jz4725b.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
> index e3dba92f30bd..5cc8c7ca24c6 100644
> --- a/sound/soc/codecs/jz4725b.c
> +++ b/sound/soc/codecs/jz4725b.c
> @@ -174,12 +174,12 @@ static const char * const jz4725b_codec_adc_src_texts[] = {
>         "Mic 1", "Mic 2", "Line In", "Mixer",
>  };
>  static const unsigned int jz4725b_codec_adc_src_values[] = { 0, 1, 2, 3, };
> -static const SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
> -                                       JZ4725B_CODEC_REG_CR3,
> -                                       REG_CR3_INSEL_OFFSET,
> -                                       REG_CR3_INSEL_MASK,
> -                                       jz4725b_codec_adc_src_texts,
> -                                       jz4725b_codec_adc_src_values);
> +static SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
> +                                 JZ4725B_CODEC_REG_CR3,
> +                                 REG_CR3_INSEL_OFFSET,
> +                                 REG_CR3_INSEL_MASK,
> +                                 jz4725b_codec_adc_src_texts,
> +                                 jz4725b_codec_adc_src_values);
>  static const struct snd_kcontrol_new jz4725b_codec_adc_src_ctrl =
>                         SOC_DAPM_ENUM("Route", jz4725b_codec_adc_src_enum);
>
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
