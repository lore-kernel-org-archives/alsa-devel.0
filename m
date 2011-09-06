From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: RE: [PATCH v2 1/2] ASoC: mxs-saif: add record function
Date: Tue, 6 Sep 2011 14:25:17 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F77222FC46@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1314015630-25022-1-git-send-email-b29396@freescale.com>
	<20110902145833.GI1901@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110902145833.GI1901@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Friday, September 02, 2011 10:59 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel@alsa-project.org; linux-arm-kernel@lists.infradead.org;
> broonie@opensource.wolfsonmicro.com; lrg@ti.com; s.hauer@pengutronix.de
> Subject: Re: [PATCH v2 1/2] ASoC: mxs-saif: add record function
> 
> On Mon, Aug 22, 2011 at 08:20:29PM +0800, Dong Aisheng wrote:
> > 1. add different clkmux mode handling for record.
> > SAIF can use two instances to implement full duplex (playback &
> > recording) and record saif may work on EXTMASTER mode that is using
> > other saif's BITCLK&LRCLK.
> > The clkmux mode is determined by saif's platform data and machine
> > specific clkmux setting is done in pdata->init().
> > 2. support playback and capture simutaneously however the sample rates
> > can not be different due to hw limitation.
> >
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> 
> First thanks to Aisheng for doing this and the discussions we had so
> far :) It is what we agreed one, yet there is one detail we had
> overlooked and we need to sort it out. After that, I think the patch can
> go in, because it works fine on my side.
> 
> >  /*
> > + * Since SAIF may work on EXTMASTER mode, IOW, it's working
> > +BITCLK&LRCLK
> > + * is provided by other SAIF, we provide a interface here to get its
> master.
> > + * Note that for DIRECT mode, it's master is itself.
> > + */
> > +static struct mxs_saif *mxs_saif_get_master(struct mxs_saif * saif) {
> > +	struct mxs_saif *master_saif;
> > +
> > +	/* get master saif according to different clkmux setting */
> > +	switch (saif->clkmux) {
> > +	case MXS_DIGCTL_SAIF_CLKMUX_DIRECT:
> > +		master_saif = saif;
> > +		break;
> > +	case MXS_DIGCTL_SAIF_CLKMUX_CROSSINPUT:
> > +		master_saif = saif->id ? mxs_saif[1] : mxs_saif[0];
> > +		break;
> > +	case MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0:
> > +		master_saif = mxs_saif[0];
> > +		break;
> > +	case MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR1:
> > +		master_saif = mxs_saif[1];
> > +		break;
> > +	default:
> > +		return NULL;
> > +	}
> > +
> > +	return master_saif;
> > +}
> 
> A get_master() function is probably the best we can do; yet we pull in
> some mach-specific details here, namely the MXS_DIGCTL_SAIF_CLKMUX_*
> macros. So, either
> 
> a) we keep going the way that mach-specific stuff has to live outside the
> generic driver. Then, we probably need some custom get_master()-callback
> (like we have an init()-callback already) which basically works like
> 
> 	master_id = pdata->get_saif_master(saif->id);

The driver is a little dependant on MXS if it wants to support EXTMST mode
Because the EXTMST function is not provided by himself, it's provided by
MXS DIGCTL.
I think what we're doing is try to minimum the dependency, right?

Anyway i'd agree with your method.
With that abstract, the saif does not need to know the clkmux anymore
(I think it's right thing because clkmux is provided by DIGCTL),
It only needs to know who is his master and the master id is provided by
mach-specific layer.
Thanks for the suggestion.
I will try to implement it.

> or b) we accept for now that this driver is heavily mxs specific and keep
> this code in the driver. Then, we could also get rid of the init()-
> callback, because it usually only calls mxs_saif_clkmux_select() which
> could also happen here.
> 
> According to Aisheng, saif-devices will not be used in later SoC, but we
> all probably know that things pop up unexpectedly, right? ;)
> 
> Comments,
> 
>    Wolfram
> 
> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
