From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] V2,
	Convert bitfields in ASOC into full int width
Date: Wed, 23 Jul 2008 21:33:57 +0100
Message-ID: <20080723203357.GA16407@opensource.wolfsonmicro.com>
References: <20080723174302.14968.56684.stgit@terra>
	<20080723182937.GA25367@rakim.wolfsonmicro.main>
	<9e4733910807231206y541856d2n41f7841b27a63830@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D2C82481F
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 22:33:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807231206y541856d2n41f7841b27a63830@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 23, 2008 at 03:06:10PM -0400, Jon Smirl wrote:

> I did that making checkpatch happy. I don't have easily buildable test
> cases for powerpc so I'm doing this via inspection.  I'll see if I can
> mess with Kconfig and force all of the codecs to build.

Check the upstream branch of:

	git://opensource.wolfsonicro.com/linux-2.6-asoc

which contains a patch that does just that.

> So this one is ok with the \ added? Next round I need to clean
> everything up to make it 32 bit safe instead of only 16 bit. It will
> probably touch some of the same code and needs to apply on top of this
> patch.

Yes.  Like I say, I've applied it.
