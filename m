From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: i.MX SDMA support
Date: Wed, 11 Aug 2010 14:43:52 +0100
Message-ID: <1281534232.3080.112.camel@odin>
References: <20100809091157.GC20065@pengutronix.de>
	<1281350823.3035.54.camel@odin> <20100809121956.GA27749@pengutronix.de>
	<64008892-3D75-4309-A623-CCE9B335F77F@opensource.wolfsonmicro.com>
	<20100810131527.GK27749@pengutronix.de> <1281449263.3059.53.camel@odin>
	<20100811084213.GN27749@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A6B5103872
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 15:43:57 +0200 (CEST)
Received: by eye27 with SMTP id 27so39420eye.38
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2010 06:43:57 -0700 (PDT)
In-Reply-To: <20100811084213.GN27749@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-08-11 at 10:42 +0200, Sascha Hauer wrote:
> On Tue, Aug 10, 2010 at 03:07:43PM +0100, Liam Girdwood wrote:
> > On Tue, 2010-08-10 at 15:15 +0200, Sascha Hauer wrote:
> > 
> > > I just looked at the i.MX part in the multi-component update and this
> > > is currently far from being in a working state, so there's still some
> > > work to do before thinking about possible conflicts...
> > 
> > Ok, I don't think it's that far off. Everything builds for i.MX and all
> > components should register. The part I can't test is the component
> > probe() and playback/capture.
> > 
> > Have you seen an oops ?
> 
> Many of them, yes ;)
> 
> The following patch puts i.MX (nearly) back into business.
> 
> Sascha
> 

Both applied. I'll do the string change for SSI shortly.

Thanks

Liam
