From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/4] pxa2xx-i2s: Handle SACR1_DRPL
	and	SACR1_DREC separately
Date: Tue, 12 May 2009 11:32:43 +0100
Message-ID: <20090512103243.GH29889@sirena.org.uk>
References: <4A03748B.1010302@gmail.com> <20090508104229.GD5654@sirena.org.uk>
	<20090511190504.GF20283@sirena.org.uk> <4A087FCF.2080304@gmail.com>
	<20090511210729.GA4404@sirena.org.uk> <4A08A001.4050003@gmail.com>
	<20090512085838.GB29889@sirena.org.uk> <4A094867.2010600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D1D63103838
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 12:32:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A094867.2010600@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karl Beldan <karl.beldan@gmail.com>
Cc: Eric Miao <eric.miao@marvell.com>, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

On Tue, May 12, 2009 at 11:59:03AM +0200, Karl Beldan wrote:
> Mark Brown wrote:

> > That doesn't seem to tie up - I can see the initialisation changing the
> > behaviour on first run but it seems surprising that this should happen
> > on subsequent runs too.  Alternatively, is your initialisation patch
> > safe to apply by itself?

> Well 2/4 stops the clocks only if both REC and RPL are disabled.
> Without 1/4 you end up with REC enabled at startup.
> In a scenario where you have never used REC you end up RPLing with REC always on.
> REC being on at shutdown(),clocks won't stop.

Yet they are being stopped by something...

> > As previously discussed you need to rework the patch to not do the reset
> > on initial probe not when the module is loaded, you need to address this
> > rather than reposting.

> The patch in question is moving the reset in probe rather than module init - with comment updated.
> What is wrong ?

A repost is where you send exactly the same thing again.  When you say
you're reposting something it means you've not made any changes; if you
say that's what you're doing and your code has problems that need to be
fixed it's fairly obvious that all the previous comments are going to
continue to apply.

> > I'll try to find time to re-review the series but I'm going to need to
> > sit down with the datasheet and check this in much more detail.

> For 1/4 and 2/4 there should not be great need, Really.

There's been enough stuff with the series that I've got a few alarm
bells ringing, if only with obscure relationships between the patches.
