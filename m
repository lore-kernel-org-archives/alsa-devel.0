From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 2/3] ARM: mx28evk: add platform data for
	saif
Date: Thu, 10 Nov 2011 11:26:08 +0100
Message-ID: <20111110102608.GY16886@pengutronix.de>
References: <1320907333-12696-1-git-send-email-b29396@freescale.com>
	<1320907333-12696-3-git-send-email-b29396@freescale.com>
	<20111110083852.GU16886@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F7722CB9F2@039-SN1MPN1-002.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4B02F243D9
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 11:26:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7722CB9F2@039-SN1MPN1-002.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng-B29396 <B29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Guo Shawn-R65073 <r65073@freescale.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 10, 2011 at 09:23:18AM +0000, Dong Aisheng-B29396 wrote:
> > > +
> > > +static const struct mxs_saif_platform_data
> > > +			mx28evk_mxs_saif_pdata __initconst = {
> > > +	.init = mx28evk_mxs_saif_pinit,
> > > +	.get_master_id = mxs_get_saif_clk_master_id,
> > 
> > This looks *very* suspicious. .init sets the mux register
> > and .get_master_id reads the very same information back. Why not simply
> > put a bool is_master into platform data?
> 
> Originally it's used to avoid introduce a global variable to save clkmux
> Since we can directly read it from register.
> 
> If put a bool is_master into pdata, we are assuming there are only two saif
> Instances. As I was suggested by Wolfram before that how about if there are
> more than two saifs in the future SoCs?

I don't understand. A is_master variable in platform_data does not make
any assumption about the number of interfaces in the system.

> So the original saif driver design is following this rule that it only needs
> to know its master id.

If that's the design then put the master id into platform_data. This
information is purely static and the board knows it. No need to put a
function in platform_data. Something like this:

	struct saif_pdata {
		bool master_mode; /* if true use master mode */
		int master_id; /* id of the master if in slave mode */
	};

> If we decide to change here, I may also have a lot to change in saif driver.

Some lines in the probe code, not more.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
