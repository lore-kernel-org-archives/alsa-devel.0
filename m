From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Cirrus Logic CS42L52 Low power codec
Date: Mon, 18 Feb 2008 19:05:29 +0000
Message-ID: <20080218190529.GB20259@rakim.wolfsonmicro.main>
References: <1203344273.4063.6.camel@localhost.localdomain>
	<20080218143655.GE21314@rakim.wolfsonmicro.main>
	<1203345949.4063.8.camel@localhost.localdomain>
	<20080218152259.GA7939@rakim.wolfsonmicro.main>
	<1203352473.4063.22.camel@localhost.localdomain>
	<20080218175822.GA20259@rakim.wolfsonmicro.main>
	<1203358060.4063.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B3AC244C5
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 20:05:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1203358060.4063.29.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 18, 2008 at 12:07:40PM -0600, Brian Austin wrote:
> say I have 4 low power codecs and I want these codecs to be supported by
> say NXP, SMDK24XX, FSL, and EP9X.  Then I would need to write the
> machine code for each codec on each dev board?
> Then allow the Kconfig to select what codecs I have for each machine.

> correct?

Yes.

> In thinking ahead,  I can see how this will mean that in the future we
> can have to option of several codecs per machine.  I guess that's the
> deal with v2.   cool

The main thing with v2 from the point of view of codec discovery is that
it removes the requirement that v1 has that the codec driver be loaded
initialised the machine driver.  That creates problems if your system is
able to discover the control interface for the codec through some other
means like the PowerPC device trees.

You can have multiple runtime codec options per machine with v1, it just
has to be implemented in the machine driver and you end up having to
compile in all the codec drivers you might need all the time.

> so when I submit the CS42L52, I just need to .c and .h and a mod'ed
> Kconfig for sound/soc/codecs.
> fair enough

Yes, exactly.
