From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: Cirrus Logic CS42L52 Low power codec
Date: Mon, 18 Feb 2008 12:07:40 -0600
Message-ID: <1203358060.4063.29.camel@localhost.localdomain>
References: <1203344273.4063.6.camel@localhost.localdomain>
	<20080218143655.GE21314@rakim.wolfsonmicro.main>
	<1203345949.4063.8.camel@localhost.localdomain>
	<20080218152259.GA7939@rakim.wolfsonmicro.main>
	<1203352473.4063.22.camel@localhost.localdomain>
	<20080218175822.GA20259@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound1-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EA131038CA
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 19:10:38 +0100 (CET)
Received: from outbound1-dub.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound1-dub-R.bigfish.com (Postfix) with ESMTP id 9D25319D2845
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 18:10:31 +0000 (UTC)
Received: from mail11-dub-R.bigfish.com (unknown [10.5.252.3])
	by outbound1-dub.bigfish.com (Postfix) with ESMTP id 7A11116F004C
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 18:10:31 +0000 (UTC)
Received: from mail11-dub (localhost.localdomain [127.0.0.1])
	by mail11-dub-R.bigfish.com (Postfix) with ESMTP id BDCFB12605BA
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 18:09:17 +0000 (UTC)
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail11-dub.bigfish.com (Postfix) with ESMTP id 55589B38092
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 18:09:12 +0000 (UTC)
Received: from CLMSG-01.ad.cirrus.com ([198.61.95.37])
	by mail1.cirrus.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1II1iKm003063
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 12:01:44 -0600
In-Reply-To: <20080218175822.GA20259@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Makes sense.

So lets take a for-instance.
say I have 4 low power codecs and I want these codecs to be supported by
say NXP, SMDK24XX, FSL, and EP9X.  Then I would need to write the
machine code for each codec on each dev board?
Then allow the Kconfig to select what codecs I have for each machine.

correct?

In thinking ahead,  I can see how this will mean that in the future we
can have to option of several codecs per machine.  I guess that's the
deal with v2.   cool

so when I submit the CS42L52, I just need to .c and .h and a mod'ed
Kconfig for sound/soc/codecs.
fair enough

Thanks,

Brian



-----Original Message-----
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] Cirrus Logic CS42L52 Low power codec
Date: Mon, 18 Feb 2008 17:58:22 +0000

On Mon, Feb 18, 2008 at 10:34:33AM -0600, Brian Austin wrote:
[Reflowed to fit into 80 columns.]

> Since the codecs are not tied to the machine, the user must then add
> to the Kconfig of the ARCH to select which codec they want to use?

No - ASoC codec drivers shouldn't be directly visible in the kernel
configuration user interface.

> If the codec isn't tied to the machine, why can't we select from a
> list of supported codecs?  Just trying to get a better understanding
> of how this works.

The dependency is from machine to codec rather than from codec to
machine.  Using a codec in ASoC always requires explicit configuration
through a machine driver in order to specify how the codec is connected
to the rest of the system but the same codec driver can be used by many
machines.

Given that this is the embedded space and only a small proportion of the
machine drivers that get written ever get merged it's useful to have
codec drivers merged even if there are no currently merged machine
drivers which need them.  Having the codec driver merged makes it easier
for people to get the driver and if they do want to contribute their
machine driver then having the codec driver already there makes that
easier.

This pattern of merging codec drivers before machine support is fairly
common for reference platforms like you're talking about - often the
codec driver will be ready first.  For example, the recently merged
mpc8610_hpcd and DaVinci platforms both did this.
