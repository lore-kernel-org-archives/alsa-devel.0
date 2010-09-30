From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WM8985: Register notifier for
	the	regulator being disabled
Date: Thu, 30 Sep 2010 17:40:37 +0100
Message-ID: <20100930164037.GA9431@sirena.org.uk>
References: <1285756717-27149-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<20100929174322.GA31934@opensource.wolfsonmicro.com>
	<1285840292.4722.17.camel@dplaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2CED610394A
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 18:40:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1285840292.4722.17.camel@dplaptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 30, 2010 at 10:51:32AM +0100, Dimitris Papastamos wrote:
> On Wed, 2010-09-29 at 10:43 -0700, Mark Brown wrote:

> > It's better to restructure the code so that the compiler is able to
> > follow the control flow and see that there's no uninitialised access -
> > this sort of change will just shut up legitimate warnings as well.  Some
> > of the other CODEC drivers (wm8400 is one) have had similar changes
> > which seem to do the trick.

> My version of GCC (4.5.1) does not seem to have a problem figuring out
> the flow of execution.  It is just that some of the people who use this
> code and have an older version of GCC get these warnings.  I agree this
> is not the way to fix it as it silences legitimate warnings.  However I
> can't really test any changes I make in an attempt to fixing this due
> to not having an older version of gcc.

Yes, there's some particular version of GCC that has trouble with this.
Whatever the WM8400 did to avoid the issue should work when applied to
this driver, it's a very common pattern in the Wolfson drivers.
