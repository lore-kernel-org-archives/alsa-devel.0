From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [alsa-devel] ASoC: sun4i-i2s: Restricting the MCLK
Date: Thu, 4 Aug 2016 10:45:28 +0800
Message-ID: <CAGb2v66Xjv4A8SWoxT5-=8OELxcCJp+_4PCQd5BM8Hk7YS+85w@mail.gmail.com>
References: <1470150313.4786.48.camel@physik.uni-kl.de>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCMILY6JWQBBBYOYRK6QKGQEIS4DSKA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1470150313.4786.48.camel-PRwTpj6vllL6m1q2wEL4bg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: niederp-PRwTpj6vllL6m1q2wEL4bg@public.gmane.org
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Aug 2, 2016 at 11:05 PM, Thomas Niederpr=C3=BCm
<niederp-PRwTpj6vllL6m1q2wEL4bg@public.gmane.org> wrote:
> I am using the new sun4i-i2s driver in linux-next to run a sta326 codec
> via the pin header on a cubietruck (this involves some soldering as
> described in [1]). The codec can only be configured as slave and needs
> a master clock for its internal PLL. It is therefore great that, unlike
> many other SOCs, the a20 provides a MCLK that can be used to sync the
> codec. However, in my case there is a restriction imposed on the MCLK
> by the codec. As stated in the datasheet [2], the master clock should
> be at maximum 12.288 MHz/11.2896 MHz or otherwise the codec will not
> work (confirmed by experiment!).
>
> Since the mod clock of the a20's dai block is running at twice this
> frequency, I need to assure that the MLCK divider is at least 2.
> Actually it is rather straight forward to achieve this by changing the
> breaking condition in the divider calculation, as shown by the
> following one-line patch:
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 687a8f8..8920844 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -206,7 +206,7 @@ static int sun4i_i2s_set_clk_rate(struct sun4i_i2s
> *i2s,
>                                                   clk_rate,
>                                                   rate);
>
> -               if ((bclk_div >=3D 0) && (mclk_div >=3D 0))
> +               if ((bclk_div >=3D 0) && (mclk_div >=3D 1))
>                         break;
>         }
>
> Of course, this is just a hack to fix my use case and I am wondering
> what would be the best way to handle my corner case more generally? I
> see one option in introducing a DT property mlck_mindiv, or similar,
> that defaults to 1 and can be overwritten at the board level. I'm
> willing to prepare a proper patch to tackle this problem but right now
> I'm wondering if there a major objections to this approach or whether
> there is any better solution to the problem.

I think the proper way would be to have sun4i-i2s support the .set_sysclk
callback in .dai_ops. simple-card calls snd_soc_dai_set_sysclk if you
have the "mclk-fs" property set in the DT.

Regards
ChenYu

>
> Best regards,
>
> Thomas
>
> [1] https://hifiduino.wordpress.com/2014/03/07/cubieboard-for-audio/
> [2] www.st.com/resource/en/datasheet/sta326.pdf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
