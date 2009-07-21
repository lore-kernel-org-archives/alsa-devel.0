From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Add possibility to control the GPIO_STATUS shift
Date: Mon, 20 Jul 2009 22:45:36 -0700
Message-ID: <20090721054536.GA4671@dtor-d630.eng.vmware.com>
References: <200907171001.16889.marek.vasut@gmail.com> <200907171353.59356.marek.vasut@gmail.com> <20090717121159.GA20904@rakim.wolfsonmicro.main> <200907171645.21352.marek.vasut@gmail.com> <20090717145203.GA15061@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090717145203.GA15061@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, linux-input@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 17, 2009 at 03:52:03PM +0100, Mark Brown wrote:
> On Fri, Jul 17, 2009 at 04:45:21PM +0200, Marek Vasut wrote:
> 
> > From 1ea286d088993e05b5b374a08ee6f933242d3561 Mon Sep 17 00:00:00 2001
> > From: Marek Vasut <marek.vasut@gmail.com>
> > Date: Thu, 4 Jun 2009 21:56:59 +0200
> > Subject: [PATCH 2/2] Add possibility to control the GPIO_STATUS shift
> > 
> > This patch allows tweaking the behaviour of GPIO_STATUS register
> > shift quirk that's in wm97xx-core. The problem with GPIO_STATUS
> > register being shifted by one doesn't appear on all hardware it
> > seems and causes problems with accelerated touchscreen drivers on
> > Palm hardware. Therefore an accelerated touchscreen driver can select
> > if the shift is/isn't happening on the hardware.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 

Applied both patches to 'next', thank you Marek.

-- 
Dmitry
