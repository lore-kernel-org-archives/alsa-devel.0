From: "Eric Miao" <ymiao3@marvell.com>
Subject: Re: [PATCH] Permit simultaneous compilation ofboth	PXA
	AC97 drivers
Date: Mon, 28 Jul 2008 18:23:05 -0700
Message-ID: <E913911567467945BBEB9277E27868B0FE152B@msiexch01.marvell.com>
References: <1217022714-2521-1-git-send-email-dbaryshkov@gmail.com>
	<20080725221517.GA5107@doriath.ww600.siemens.net>
	<20080726110626.GC3215@sirena.org.uk>
	<1217074954.7498.34.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dakia3.marvell.com (dakia3.marvell.com [65.219.4.28])
	by alsa0.perex.cz (Postfix) with ESMTP id CA772247C1
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 03:23:11 +0200 (CEST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>, Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, rmk@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Yep, I can do all the verfication on all pxa3xx variants and platforms :-)

> -----Original Message-----
> From: Liam Girdwood [mailto:lg@opensource.wolfsonmicro.com]
> Sent: Saturday, July 26, 2008 8:23 PM
> To: Dmitry Baryshkov
> Cc: Mark Brown; alsa-devel@alsa-project.org; Eric Miao; rmk@arm.linux.org.uk
> Subject: Re: [alsa-devel] [PATCH] Permit simultaneous compilation ofboth PXA
> AC97 drivers
> 
> On Sat, 2008-07-26 at 12:06 +0100, Mark Brown wrote:
> > On Sat, Jul 26, 2008 at 02:15:17AM +0400, Dmitry Baryshkov wrote:
> >
> > > I should have said, that these patches are largely untested. Please test
> > > before applying.
> >
> > Yeah, unfortunately it's kind of hard to get good test coverage due to
> > the number of variants :/ .  On the basis of the diffs these patches
> > look good, though the volume of code motion means that I'll do another
> > pass later.  I'll also test with the hardware I have and then push up to
> > Takashi (assuming I don't spot any issues) - it may be the middle of
> > next week before that happens.  Other test reports would be appreciated.
> >
> > This is certainly a very welcome cleanup - thanks a lot for doing it!
> 
> Agreed, thanks for the cleanup. :)
> 
> However this really *must* be tested on all pxa variants before
> upstreaming. The pxa family all have slightly different AC97 controller
> hardware (and quirks) and subsequently it may work fine on your board
> but break others :-/
> 
> We can certainly test on pxa270 and pxa320. Can someone else do the
> other variants.
> 
> Btw, the tests should also include AC97 slot 12 IO. i.e read and write
> codec register 0x54.
> 
> Thanks
> 
> Liam
