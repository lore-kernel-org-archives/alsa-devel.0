From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] ASoC: rt1011: Mark format integer literals as unsigned
Date: Thu, 6 Jun 2019 11:50:10 -0700
Message-ID: <CAKwvOdnswiifrvSrBcAnc4Br8nhxJRUAL0yNM6T6=4xScHXf5g@mail.gmail.com>
References: <20190606051227.90944-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190606051227.90944-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Shuming Fan <shumingf@realtek.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 5, 2019 at 10:13 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> sound/soc/codecs/rt1011.c:1291:12: warning: integer literal is too large
> to be represented in type 'long', interpreting as 'unsigned long' per
> C89; this literal will have type 'long long' in C99 onwards
> [-Wc99-compat]
>                 format = 2147483648; /* 2^24 * 128 */

This number's bitpattern is a leading one followed by 31 zeros.
`format` is declared as `unsigned int`, and literals in C are signed
unless suffixed, so this patch LGTM.  Maybe a macro declaring such a
bitpattern would improve readability over the existing magic constant
and comment?
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>                          ^
> sound/soc/codecs/rt1011.c:2123:13: warning: integer literal is too large
> to be represented in type 'long', interpreting as 'unsigned long' per
> C89; this literal will have type 'long long' in C99 onwards
> [-Wc99-compat]
>                         format = 2147483648; /* 2^24 * 128 */
>                                  ^
> 2 warnings generated.
>
> Mark the integer literals as unsigned explicitly so that if the kernel
> does ever bump the C standard it uses, the behavior is consitent.

s/consitent/consistent/

:set spell

:P
-- 
Thanks,
~Nick Desaulniers
