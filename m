From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [PATCH 1/1] ASoC: core: cache index fix
Date: Tue, 2 Aug 2011 10:55:25 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721F43AA@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1312198690-13237-1-git-send-email-b29396@freescale.com>
	<20110801115150.GB16629@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F410B@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110802083850.GB9553@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F427D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hy5zcnlu8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	by alsa0.perex.cz (Postfix) with ESMTP id B08271037E3
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Aug 2011 12:55:30 +0200 (CEST)
In-Reply-To: <s5hy5zcnlu8.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, August 02, 2011 6:34 PM
> To: Dong Aisheng-B29396
> Cc: Mark Brown; alsa-devel@alsa-project.org; s.hauer@pengutronix.de;
> lrg@ti.com; linux-arm-kernel@lists.infradead.org; w.sang@pengutronix.de
> Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
> 
> At Tue, 2 Aug 2011 09:41:22 +0000,
> Dong Aisheng-B29396 wrote:
> >
> > > -----Original Message-----
> > > From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> > > Sent: Tuesday, August 02, 2011 4:39 PM
> > > To: Dong Aisheng-B29396
> > > Cc: alsa-devel@alsa-project.org;
> > > linux-arm-kernel@lists.infradead.org;
> > > lrg@ti.com; s.hauer@pengutronix.de; w.sang@pengutronix.de
> > > Subject: Re: [PATCH 1/1] ASoC: core: cache index fix
> > >
> > > On Tue, Aug 02, 2011 at 08:03:23AM +0000, Dong Aisheng-B29396 wrote:
> > >
> > >
> > > > > ...hw_read() shouldn't need to know about this stuff
> > > > Here the reg_cache_size is the maximum cache index in the register
> > > cache array.
> > > > Therefore, the original code using reg to compare with
> > > > reg_cache_size is not correct when the reg_cache_step is not 1.
> > > > e.g. the reg to read is 0x30 and reg_cache_size maybe only 0x16.
> > > > So we use idx to check if it exceeds the cache size.
> > >
> > > I see what you're doing, but like I say this is just legacy code
> > > that shouldn't be peering at the cache size any more and layering
> > > additional stuff in is just going to make the situation worse.
> > >
> > > > BTW, do you mean the soc_io layer does not need to know the
> > > > details of idx&reg Conversion?
> > >
> > > Yes.
> > >
> > > > Do I need to implement a help function like reg_is_cachable(reg)
> > > > to be
> > > used here?
> > >
> > > No, I think we should hide these decisions completely within the
> > > cache code.
> >
> > Yes, but the issue is that hw_read will check if reg is in cache array
> > And checking like " if (reg >= codec->driver->reg_cache_size ||" is
> > wrong when the step is not 1 that will cause registers with their
> > index are greater than cache index will not be able to fetch data from
> cache.
> 
> reg_cache_size is supposed to be the real size of the cache table.
> This isn't influenced by reg_cache_step value.  So, the behavior in soc-
> io.c (and other ASoC core) is correct.
But the reg is related to step.
So reg and reg_cache_size are un-match when step > 1, right?
 
> That is, the codec drivers setting ARRAY_SIZE() to reg_cache_size with
> reg_cache_step > 1 are buggy and should be fixed.
