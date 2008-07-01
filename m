From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add some system information
	to	alsa-info.sh output
Date: Tue, 1 Jul 2008 10:34:52 +0100
Message-ID: <20080701093452.GA14666@rakim.wolfsonmicro.main>
References: <1214843497.11032.4.camel@temp-fallen>
	<20080630164210.GC21804@sirena.org.uk>
	<1214847360.11032.9.camel@temp-fallen>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 409832417D
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jul 2008 11:34:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1214847360.11032.9.camel@temp-fallen>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Travis Place <wishie@wishie.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 01, 2008 at 03:36:00AM +1000, Travis Place wrote:
> On Mon, 2008-06-30 at 17:42 +0100, Mark Brown wrote:

> > How about bios_vendor, bios_date and bios_version as well?

> How useful is the BIOS information going to be, in most cases ?

Well, ideally most of the time all this information will be useless
since everything will work fine :) .  I'd expect it to be useful
sometimes for handling things like broken information about setup for
HDA codecs.

> > For embedded devices the relevant information is often in /proc/cpuinfo
> > so it might be worth adding that too.

> Can i get an example output or 'cpuinfo' on an embedded device (if you
> have one available) so i can see what im looking for.

The particular output varies with platform and some platforms allow
machine drivers to add entirely custom fields - it's probably safest to
just include the entire file.
