From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 3/3] t5325: add audio support
Date: Wed, 13 Oct 2010 19:43:14 +0100
Message-ID: <20101013184314.GA17574@rakim.wolfsonmicro.main>
References: <20101012094453.660938870@rtp-net.org>
	<20101012100039.492443712@rtp-net.org>
	<20101012171845.GI30933@rakim.wolfsonmicro.main>
	<87wrpmvunr.fsf@lechat.rtp-net.org>
	<20101013180607.GA15001@sirena.org.uk>
	<87ocayvtkn.fsf@lechat.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E37B6103A1C
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 20:43:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87ocayvtkn.fsf@lechat.rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Saeed Bishara <saeed@marvell.com>, Martin Michlmayr <tbm@cyrius.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 13, 2010 at 08:25:12PM +0200, Arnaud Patard wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> > Oh, actually the problem is that you've not prefixed the ASoC patches
> > with ASoC: so they look like they're supposed to be arch/arm patches
> > (2/3 being the main offender).

> Oh, I see. This patch is modify arch/arm/mach-kirkwood/t5325-setup.c and
> is adding only audio stuff and needs a header coming from previous
> patches. That's why I've put it in the patch serie. imho doing like this
> should make life easier for everyone.

> Will add and "ASoC:" in the patch subject.

This one is for arch/arm so doesn't want that - the patch before is for
ASoC and does.
