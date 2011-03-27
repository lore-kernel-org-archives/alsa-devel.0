From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Device-drivers-devel] [PATCH] ASoC: ad74111: new
	codec driver
Date: Sun, 27 Mar 2011 14:43:43 +0100
Message-ID: <20110327134343.GA6292@opensource.wolfsonmicro.com>
References: <1301128426-2817-1-git-send-email-vapier@gentoo.org>
	<20110326122108.GD28537@opensource.wolfsonmicro.com>
	<AANLkTinAs+3g1KHDyxBTDze8MnFZn3X7b5vuQSM+yLsN@mail.gmail.com>
	<20110326180942.GA13129@opensource.wolfsonmicro.com>
	<AANLkTi=QNDFP6uCG75vkQLL7_AN2Nm_b1Pqb+vyj4qU4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3B468103875
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Mar 2011 15:43:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=QNDFP6uCG75vkQLL7_AN2Nm_b1Pqb+vyj4qU4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: Scott Jiang <scott.jiang@analog.com>, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 27, 2011 at 12:10:08AM -0400, Mike Frysinger wrote:
> On Sat, Mar 26, 2011 at 14:09, Mark Brown wrote:

> > It's a one line patch that totally changes the shape of the diff for
> > that hunk. =A0As I said above this slows down review, it's jarring as o=
ne
> > has to stop and reverse engineer from the change if was intentional and
> > if it is sensible. =A0It could be some unrelated cleanup, it could be (=
and
> > frequently is) context that got included in the diff by mistake.

> i still disagree, but considering you have the luxury of not accepting
> our patches, i guess it doesnt matter too much huh

It's not a luxury, believe me.  Most of the issues you guys are having
here seem to be process issues as much as anything else, there's a
couple of things you could do which would really help make the whole
thing run more smoothly:

 - Submit against current -next.  It looks like you're mostly submitting
   once a release or so, usually shortly after the release, with code
   based off either the release that just went out or the release before
   that.  This means that you're going to be at least one kernel
   revision out of date on current APIs and best practices and sometimes
   means you're submitting code that won't even compile.  ASoC moves
   pretty quickly so you really do need to check with current code.

 - Follow up promptly on reviews - I'm rarely seeing updates to patches
   that involve any domain specific changes, and where there is followup
   it's often at the next release.  This interacts badly with the
   submission against old code issues as that means you're likely to
   require some fairly straightforward API updates but waiting to
   resubmit means that you'll often end up requiring further updates
   next time around.

For example, the SSM2604 driver you're submitting now was originally
sent last August and you sent patches for ADAV801/3, ADAU1361, ADAU1381
and ADAU1761 at the end of last year which mostly just needed fairly
straightforward updates for old kernel issues but which haven't been
resubmitted since.  None of these devices look like they should be hard
to get support integrated into mainline but the above issues are making
that harder work than it needs to be.
