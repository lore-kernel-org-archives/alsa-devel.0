From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Davinci: DM365: Enable DaVinci Voice
 Codec support for DM365 EVM
Date: Mon, 11 Jan 2010 15:34:58 +0000
Message-ID: <20100111153458.GA2661@rakim.wolfsonmicro.main>
References: <1262902641-14821-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20100108113121.GB10128@sirena.org.uk>
	<4B476D3B.3050200@ridgerun.com>
	<20100108193720.GA3088@sirena.org.uk>
	<4B4B3F97.8060508@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E664110380B
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 16:34:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B4B3F97.8060508@ridgerun.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 11, 2010 at 09:11:19AM -0600, Miguel Aguilar wrote:
> Mark Brown wrote:

> >>Can you check the part of this patch related to registering both
> >>codecs AIC3x and the voice codec?

> >Like I say that all looks fine to me but I can't really check if the
> >DaVinci code is idiomatic.

> Is there any way to tell alsamixer to use the controls of one
> subdevice or the other?

Not from the arch/arm stuff, but that's a machine driver issue anyway.
If you really only want to use a single device then just don't hook up
the other device in the machine driver and it'll never appear.
