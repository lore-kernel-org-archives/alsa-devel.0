From: Sangbeom Kim <sbkim73@samsung.com>
Subject: RE: [alsa-devel] [PATCH 1/2] ARM: EXYNOS4: Add PCM audio support	for
 WM8994
Date: Tue, 26 Apr 2011 11:06:21 +0900
Message-ID: <007f01cc03b6$8e165060$aa42f120$@com>
References: <1303714472-2391-1-git-send-email-sbkim73@samsung.com>
 <1303714472-2391-3-git-send-email-sbkim73@samsung.com>
 <BANLkTik2uTae-V1MQ_Owj_jC=x14W4HgwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <BANLkTik2uTae-V1MQ_Owj_jC=x14W4HgwA@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Jassi Brar' <jassisinghbrar@gmail.com>
Cc: kgene.kim@samsung.com, alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi Jassi,

Thanks for your advisor.
Currently, Only Exynos4210 pcm block is different.
And There is no rule to design in Future AP.
I will discuss with ap design team and try to
change pcm block like a previous one for the future AP.
Because, I think that it is more desirable to include
SCLK divider in the pcm block like old Samsung APs.
So, In the exynos4 case, I want to handle it by quirk.
What do you think about my opinion?

SB Kim


On Tuesday, April 26, 2011 1:10 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> To: Sangbeom Kim
> Cc: kgene.kim@samsung.com; alsa-devel@alsa-project.org; linux-samsung-
> soc@vger.kernel.org; broonie@opensource.wolfsonmicro.com;
> lrg@slimlogic.co.uk
> Subject: Re: [alsa-devel] [PATCH 1/2] ARM: EXYNOS4: Add PCM audio support
> for WM8994
> 
> On Mon, Apr 25, 2011 at 12:24 PM, Sangbeom Kim <sbkim73@samsung.com> wrote:
> 
> > --- a/arch/arm/plat-samsung/include/plat/audio.h
> > +++ b/arch/arm/plat-samsung/include/plat/audio.h
> > @@ -36,6 +36,8 @@ struct samsung_i2s {
> >  */
> >  #define QUIRK_NO_MUXPSR                (1 << 2)
> >  #define QUIRK_NEED_RSTCLR      (1 << 3)
> > +/* If the PCM block has no internal prescalar or MUX */
> > +#define QUIRK_NO_DIV           (1 << 4)
> >        /* Quirks of the I2S controller */
> >        u32 quirks;
> 
> I think the I2S and PCM configuration don't share enough.
> So maybe a separate 'struct samsung_pcm' is warranted here.
> Also, if new SoC PCM blocks are going to _not_ have the divider
> may be it's a good idea to make that as 'norm' and having divider
> as a 'quirk' ?  That way, new code wouldn't have to bother adding
> the quirk every time.
> 
> -j
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
