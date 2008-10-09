From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [topic/asoc][DON'T PUSH][PATCH 0/3] ASoC: OMAP:
	McBSP DAI driver updates
Date: Thu, 9 Oct 2008 20:49:31 +0100
Message-ID: <20081009194930.GA28985@sirena.org.uk>
References: <1223557042-17279-1-git-send-email-jarkko.nikula@nokia.com>
	<20081009150228.GA16095@sirena.org.uk>
	<20081009151054.GB16095@sirena.org.uk>
	<bd7b27490810091017q38aef300rfd6150d1a17bc9f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CD2824575
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 21:49:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd7b27490810091017q38aef300rfd6150d1a17bc9f6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Steve Sakoman <sakoman@gmail.com>, alsa-devel@alsa-project.org, felipe.contreras@gmail.com, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 09, 2008 at 08:17:08PM +0300, Jarkko Nikula wrote:

> Actually devconf register definitions for 2430 and 34xx, what patch 1 is
> using, are already in mainline and new McBSP DMA port and base address
> definitions are covered by CONFIG_ARCH_OMAPxxxx so ASoC for osk5912 should
> still compile.

So they should be safe to push already, then?

> I heard yesterday from Tony Lindgren that TWL4030 changes might be also
> coming into mainline now. Then Steve would be able send his TWL4030 codec
> driver and machine driver for Overo. Machine driver for Beagle exists as

Yes, Samuel Ortiz said he'd merged David's patch for the core so the
codec driver should be good to go once Linus pulls the MFD tree.
Chances are that this will also be about the same time as the other
stuff I'm queuing if you want to go that way?

> well and question is should the same machine driver cover both boards since
> now they are very similar? Current understanding is to keep them separated
> since Overo will be extended in the future. Some discussion about it:

> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg04389.html

Given that Overo will be extended beyond what the Beagle board is
capable of it probably does make sense to separate the two drivers -
using the same one initially might confuse whoever comes along and does
the more detailed Overo board support.  The main argument for doing them
within the one driver would be if the Beagle and Overo boards were
generally understood by OMAP users as being subfitted versions of the
same family.

Really, whatever makes life easiest for you guys is fine.
