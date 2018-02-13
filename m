From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: Re: [PATCH v3 0/3] add UniPhier audio nodes
Date: Wed, 14 Feb 2018 01:06:49 +0900
Message-ID: <CAK7LNARaJB-ymtj3b0XQn0P7yo7se0CXgCCO6pb5oKEhCxf4CQ@mail.gmail.com>
References: <20180213130156.27827-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180213130156.27827-1-suzuki.katsuhiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Katsuhiro Suzuki <suzuki.katsuhiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Masami Hiramatsu <masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

2018-02-13 22:01 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>:
> This series adds device-tree nodes for Socionext audio system
> for UniPhier LD11/LD20 SoCs. This one enables I2S output for
> Line-In, Line-Out, S/PDIF output and compress audio output.
>
> Katsuhiro Suzuki (3):
>   arm64: dts: uniphier: add sound node for UniPhier
>   arm64: dts: uniphier: add speaker out for UniPhier LD11/LD20 boards
>   arm64: dts: uniphier: add compress audio out for UniPhier LD11/LD20


Series, applied to linux-uniphier.  Thanks!

Note, I locally fixed trivial things:
 - Use #include <...> instead of #include "..." to include dt-binding header
 - Fix DTC warnings (Character '_' not recommended in node)
 - Remove unused labels such as 'audio', 'evea'



>  .../boot/dts/socionext/uniphier-ld11-global.dts    | 62 ++++++++++++++
>  arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   | 92 +++++++++++++++++++++
>  .../boot/dts/socionext/uniphier-ld20-global.dts    | 62 ++++++++++++++
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 96 ++++++++++++++++++++++
>  4 files changed, 312 insertions(+)
>
> --
> 2.15.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
