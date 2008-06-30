From: Travis Place <wishie@wishie.net>
Subject: Re: [PATCH] Add some system information
	to	alsa-info.sh output
Date: Tue, 01 Jul 2008 03:36:00 +1000
Message-ID: <1214847360.11032.9.camel@temp-fallen>
References: <1214843497.11032.4.camel@temp-fallen>
	<20080630164210.GC21804@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-99-053.dial.usertools.net
	[202.137.99.53]) by alsa0.perex.cz (Postfix) with ESMTP id 130D424700
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Jun 2008 19:35:55 +0200 (CEST)
In-Reply-To: <20080630164210.GC21804@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I think i was a bit quick/excited about getting this info in
there..Tested on my 2 machines here (both running 2.6.24 though) without
issues.. Will have to look into it further (after taking your advice)
and rework this patch.

On Mon, 2008-06-30 at 17:42 +0100, Mark Brown wrote:
> On Tue, Jul 01, 2008 at 02:31:37AM +1000, Travis Place wrote:
> 
> > +if [ -d $SYSFS ]
> > +then
> > +BOARD_VENDOR=`cat /sys/devices/virtual/dmi/id/board_vendor`
> > +PRODUCT_VERSION=`cat /sys/devices/virtual/dmi/id/product_version`
> > +PRODUCT_NAME=`cat /sys/devices/virtual/dmi/id/product_name`
> 
> This produces visible errors if the information isn't present (which
> would be reasonable enough).  It might be better to check for errors and
> include something about being unable to read DMI information in the
> report - that'd be a bit less scary.
> 
> Also, on my system the DMI information is under /sys/class/dmi rather
> than /sys/devices/virtual (this is with 2.6.25).

This will certainly be a pain, if the info keep moving around.. unless
we do some quick 'search' for the 'dmi' dir.
> 
> > +fi
> 
> How about bios_vendor, bios_date and bios_version as well?
> 
How useful is the BIOS information going to be, in most cases ?

> For embedded devices the relevant information is often in /proc/cpuinfo
> so it might be worth adding that too.

Can i get an example output or 'cpuinfo' on an embedded device (if you
have one available) so i can see what im looking for.

Thanks,
Travis Place
