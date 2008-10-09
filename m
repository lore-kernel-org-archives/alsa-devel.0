From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [topic/asoc][DON'T PUSH][PATCH 0/3] ASoC: OMAP:
	McBSP DAI driver updates
Date: Thu, 9 Oct 2008 20:17:08 +0300
Message-ID: <bd7b27490810091017q38aef300rfd6150d1a17bc9f6@mail.gmail.com>
References: <1223557042-17279-1-git-send-email-jarkko.nikula@nokia.com>
	<20081009150228.GA16095@sirena.org.uk>
	<20081009151054.GB16095@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f17.google.com (mail-gx0-f17.google.com
	[209.85.217.17]) by alsa0.perex.cz (Postfix) with ESMTP id DD1CC24568
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 19:17:27 +0200 (CEST)
Received: by gxk10 with SMTP id 10so293457gxk.8
	for <alsa-devel@alsa-project.org>; Thu, 09 Oct 2008 10:17:09 -0700 (PDT)
In-Reply-To: <20081009151054.GB16095@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Steve Sakoman <sakoman@gmail.com>, alsa-devel@alsa-project.org, felipe.contreras@gmail.com, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 9, 2008 at 6:10 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> On Thu, Oct 09, 2008 at 04:02:29PM +0100, Mark Brown wrote:
>
> > These all look good.  How do you want to merge them?  They could either
> > go in with the McBSP changes they depend on or via ALSA.  If via ALSA
> > then if you like I'm happy to queue them up and submit them once their
> > dependencies are merged (I've got some other changes in a similar
> > situation myself).  Otherwise I guess you could resubmit them once the
> > McBSP changes are merged.
>
> Hrm.  Looking at the ARM list just now it seems both this and the things
> my other patches are waiting for are now in rmk's tree so I'm already
> tracking stuff in the same tree for submission - I guess that makes
> adding these to my queue the most simple approach?
>

Commenting from my another address. Yeah, I just saw Russell's mail that he
pulled in those McBSP patches so should be safe enough to track these
patches via your queue.

Actually devconf register definitions for 2430 and 34xx, what patch 1 is
using, are already in mainline and new McBSP DMA port and base address
definitions are covered by CONFIG_ARCH_OMAPxxxx so ASoC for osk5912 should
still compile.

---

I heard yesterday from Tony Lindgren that TWL4030 changes might be also
coming into mainline now. Then Steve would be able send his TWL4030 codec
driver and machine driver for Overo. Machine driver for Beagle exists as
well and question is should the same machine driver cover both boards since
now they are very similar? Current understanding is to keep them separated
since Overo will be extended in the future. Some discussion about it:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg04389.html


Jarkko
