From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 01/14] dma: sun6i-dma: Add burst case of 4
Date: Tue, 4 Oct 2016 14:12:21 +0200
Message-ID: <20161004141221.55327f1b@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
        <3a2404510b5f8b16ae3bb193982d70f158700b2b.1475571575.git.mylene.josserand@free-electrons.com>
        <20161004124011.d7f5754a082d5f17d5185fc4@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161004124011.d7f5754a082d5f17d5185fc4-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hello,

On Tue, 4 Oct 2016 12:40:11 +0200, Jean-Francois Moine wrote:

> > Add the case of a burst of 4 which is handled by the SoC.
> > 
> > Signed-off-by: Mylène Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> >  drivers/dma/sun6i-dma.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> > index 8346199..0485204 100644
> > --- a/drivers/dma/sun6i-dma.c
> > +++ b/drivers/dma/sun6i-dma.c
> > @@ -240,6 +240,8 @@ static inline s8 convert_burst(u32 maxburst)
> >  	switch (maxburst) {
> >  	case 1:
> >  		return 0;
> > +	case 4:
> > +		return 1;
> >  	case 8:
> >  		return 2;
> >  	default:
> > -- 
> > 2.9.3  
> 
> This patch has already been rejected by Maxime in the threads
> 	http://www.spinics.net/lists/dmaengine/msg08610.html
> and
> 	http://www.spinics.net/lists/dmaengine/msg08719.html
> 
> I hope you will find the way he wants for this maxburst to be added.

I was about to reply to Mylene's e-mail, suggesting that she should add
a comment in the code (and maybe in the commit log) to explain why this
addition is needed, and also that even though the schematics say that
value "1" (max burst size of 4 bytes) is reserved, it is in fact
incorrect. The Allwinner BSP code is really using this value, and it's
the value that makes audio work, so we believe the datasheet is simply
incorrect.

We already discussed it with Maxime, so I believe he should agree this
time. But I would suggest to have such details explained in the commit
log and in a comment in the code.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
