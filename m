From: Liam Girdwood <lrg@ti.com>
Subject: Re: FW: [PATCH v3] ASoC: Add support for TI LM49453
 Audio codec
Date: Wed, 08 Feb 2012 13:27:30 +0000
Message-ID: <1328707650.3955.17.camel@odin>
References: <290463D19D2E064191F1F96ECA480A89434AC4A96E@EXMAIL02.scwf.nsc.com>
	<4F323BF5.4010309@ti.com> <1328692723.3955.4.camel@odin>
	<1328693854.21099.5.camel@vkoul-udesk3> <1328694877.3955.9.camel@odin>
	<1328697415.21099.8.camel@vkoul-udesk3> <1328698650.3955.13.camel@odin>
	<20120208112059.GB3120@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
	[74.125.149.140])
	by alsa0.perex.cz (Postfix) with ESMTP id A6FAB2440E
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 14:27:34 +0100 (CET)
Received: by mail-ww0-f45.google.com with SMTP id dt12so490646wgb.14
	for <alsa-devel@alsa-project.org>; Wed, 08 Feb 2012 05:27:32 -0800 (PST)
In-Reply-To: <20120208112059.GB3120@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, M R Swami Reddy <MR.Swami.Reddy@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-08 at 11:20 +0000, Mark Brown wrote:
> On Wed, Feb 08, 2012 at 10:57:30AM +0000, Liam Girdwood wrote:
> > On Wed, 2012-02-08 at 16:06 +0530, Vinod Koul wrote:
> 
> > > We want to dynamical turn off this clock when not is use and turn on
> > > only when codec is using. So I was thinking of turning this ON in
> > > codecs .set_bias_level callback, but how to propagate this into machine
> > > driver?
> 
> > It's usually done in the machine driver hw_params() since at this point
> > we know the rate, format etc that can have a bearing on the clock
> > configuration. You could switch it OFF in machine hw_free().
> 
> For modern devices set_bias_level() is often a better choice if you're
> only going to do one of that or hw_params(), especially on the shutdown
> paths - devices these days typically need the clocks for a lot more
> stuff.  hw_params() by itself obviously has issues for analogue only
> paths too.

> I'd generally expect to see new machine drivers doing this stuff in
> set_bias_level() and possibly also having additional startup code in
> hw_params() depending on how flexible the clocking is.

The scope of set_bias_level() is now starting to increase to more than
just the card bias power. It may be worthwhile at some point to rename
it to cover all possibilities.

Liam
