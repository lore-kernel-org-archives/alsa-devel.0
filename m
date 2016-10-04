From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/14] dma: sun6i-dma: Add burst case of 4
Date: Tue, 4 Oct 2016 21:10:09 +0530
Message-ID: <20161004154009.GH2467@localhost>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <3a2404510b5f8b16ae3bb193982d70f158700b2b.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004124011.d7f5754a082d5f17d5185fc4@free.fr>
 <20161004141221.55327f1b@free-electrons.com>
 <20161004154651.3d0eb02badb6dc66758dd3aa@free.fr>
Reply-To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDLNNTP63EBBBVUWZ67QKGQEYD55NZQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20161004154651.3d0eb02badb6dc66758dd3aa-GANU6spQydw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 04, 2016 at 03:46:51PM +0200, Jean-Francois Moine wrote:
> On Tue, 4 Oct 2016 14:12:21 +0200
> Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>=20
> > > > Add the case of a burst of 4 which is handled by the SoC.
> > > >=20
> > > > Signed-off-by: Myl=C4=8Dne Josserand <mylene.josserand@free-electro=
ns.com>
> > > > ---
> > > >  drivers/dma/sun6i-dma.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> > > > index 8346199..0485204 100644
> > > > --- a/drivers/dma/sun6i-dma.c
> > > > +++ b/drivers/dma/sun6i-dma.c
> > > > @@ -240,6 +240,8 @@ static inline s8 convert_burst(u32 maxburst)
> > > >  	switch (maxburst) {
> > > >  	case 1:
> > > >  		return 0;
> > > > +	case 4:
> > > > +		return 1;
> > > >  	case 8:
> > > >  		return 2;
> > > >  	default:
> > > > --=20
> > > > 2.9.3 =20
> > >=20
> > > This patch has already been rejected by Maxime in the threads
> > > 	http://www.spinics.net/lists/dmaengine/msg08610.html
> > > and
> > > 	http://www.spinics.net/lists/dmaengine/msg08719.html
> > >=20
> > > I hope you will find the way he wants for this maxburst to be added.
> >=20
> > I was about to reply to Mylene's e-mail, suggesting that she should add
> > a comment in the code (and maybe in the commit log) to explain why this
> > addition is needed, and also that even though the schematics say that
> > value "1" (max burst size of 4 bytes) is reserved, it is in fact
> > incorrect. The Allwinner BSP code is really using this value, and it's
> > the value that makes audio work, so we believe the datasheet is simply
> > incorrect.
> >=20
> > We already discussed it with Maxime, so I believe he should agree this
> > time. But I would suggest to have such details explained in the commit
> > log and in a comment in the code.
>=20
> Strange. Looking at the datasheets of the A23, A31, A33, A83T and H3
> (these are the SoCs using the DMA sun6i), only the H3 can have 4 as the
> burst size (the doc is unclear for the A31).
>=20
> Well, I was submitting for the H3, Myl=C4=8Dne is submitting for the A33.
> So, what about the A23, A31 and A83T?

Since these are device properties, I feel we should move this to DT. That
way any new controller can have any variation based on the mood of hw
designer that day and we can hopefully cope with it :-)

But yes we would need to set the bursts supported in driver and allow above
for supported bursts only.

--=20
~Vinod

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
