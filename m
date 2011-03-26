From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Device-drivers-devel] [PATCH] ASoC: ad74111: new
	codec driver
Date: Sat, 26 Mar 2011 18:09:42 +0000
Message-ID: <20110326180942.GA13129@opensource.wolfsonmicro.com>
References: <1301128426-2817-1-git-send-email-vapier@gentoo.org>
	<20110326122108.GD28537@opensource.wolfsonmicro.com>
	<AANLkTinAs+3g1KHDyxBTDze8MnFZn3X7b5vuQSM+yLsN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E7AAF103896
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 19:09:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTinAs+3g1KHDyxBTDze8MnFZn3X7b5vuQSM+yLsN@mail.gmail.com>
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

On Sat, Mar 26, 2011 at 01:52:48PM -0400, Mike Frysinger wrote:
> On Sat, Mar 26, 2011 at 08:21, Mark Brown wrote:

> > A few of your patches have this sort of additional change in them.
> > While the cleanup is good it would be better to split it into a separate
> > patch. =A0Seeing the unrelated change slows down review and it'll also
> > create extra merge issues when applying or cherry picking the driver
> > back to older kernels.

> in general i agree, but for moving literally one line i dont generally
> worry about it

It's a one line patch that totally changes the shape of the diff for
that hunk.  As I said above this slows down review, it's jarring as one
has to stop and reverse engineer from the change if was intentional and
if it is sensible.  It could be some unrelated cleanup, it could be (and
frequently is) context that got included in the diff by mistake.

> > Again, drop the -codec unless this is part of a MFD.

> when i looked at the history of things, it seemed like it's the ASoC
> maintainers sticking "-codec" on stuff.  so should i go through
> existing drivers and revert that back ?

Yes, they were included by mistake as a result of automated changes in
the multi-component merges.
