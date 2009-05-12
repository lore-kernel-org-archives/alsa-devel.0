From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/4] pxa2xx-i2s: Handle SACR1_DRPL
	and	SACR1_DREC separately
Date: Tue, 12 May 2009 09:58:39 +0100
Message-ID: <20090512085838.GB29889@sirena.org.uk>
References: <4A03748B.1010302@gmail.com> <20090508104229.GD5654@sirena.org.uk>
	<20090511190504.GF20283@sirena.org.uk> <4A087FCF.2080304@gmail.com>
	<20090511210729.GA4404@sirena.org.uk> <4A08A001.4050003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9785B103830
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 10:58:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A08A001.4050003@gmail.com>
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

On Tue, May 12, 2009 at 12:00:33AM +0200, Karl Beldan wrote:

> Then it is perfectly normal since reset enables both REC and RPL, 2/4 needs 1/4.
> The current tree disables the clocks anytime one function is disabled.

That doesn't seem to tie up - I can see the initialisation changing the
behaviour on first run but it seems surprising that this should happen
on subsequent runs too.  Alternatively, is your initialisation patch
safe to apply by itself?

> I resent 1/4 and will make it 1/5 with the whole serie once everything is Clear.

As previously discussed you need to rework the patch to not do the reset
on initial probe not when the module is loaded, you need to address this
rather than reposting.

I'll try to find time to re-review the series but I'm going to need to
sit down with the datasheet and check this in much more detail.
