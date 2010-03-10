From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: da7210: Add
 11025/22050/44100/88200 rate support
Date: Wed, 10 Mar 2010 10:06:20 +0000
Message-ID: <20100310100619.GA24422@rakim.wolfsonmicro.main>
References: <ufx4amigj.wl%morimoto.kuninori@renesas.com>
	<20100309133803.GB1940@rakim.wolfsonmicro.main>
	<uy6i0hp27.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 511C910385A
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 11:06:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <uy6i0hp27.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 10, 2010 at 11:45:52AM +0900, Kuninori Morimoto wrote:

> This chip doesn't support asymmetric sample rates.
> Is there a method of prohibiting it on ALSA ?
> Or should I add any lock ?

Set symmetric_rates in the DAI.

> > > +	/* As suggested by Dialog */
> > > +	da7210_write(codec, DA7210_A_HID_UNLOCK,	0x8B);
> > > +	da7210_write(codec, DA7210_A_TEST_UNLOCK,	0xB4);
> > > +	da7210_write(codec, DA7210_A_PLL1,		0x01);
> > > +	da7210_write(codec, DA7210_A_CP_MODE,		0x7C);

> > I suspect you want to disable the HID and test keys when you're done
> > fiddling with the configuration here...

> Ohh sorry.
> This XXX_UNLOCK doesn't mean "disable"..
> In default, we can not change value on some register
> because it is locked.
> So, this driver unlock it here.

> Should I add some comment ?

No, what I'm saying is that since the registers are supposed to be
locked in normal operation you should reset the lock registers so that
unintended register writes don't occur in normal operation.  The locks
will cover more than you're updating here.
