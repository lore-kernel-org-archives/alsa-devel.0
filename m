From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/7] DAPM power sequencing changes
Date: Mon, 8 Jun 2009 15:27:40 +0100
Message-ID: <20090608142734.GA6137@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D356F24451
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 16:27:41 +0200 (CEST)
Received: from rakim.wolfsonmicro.main (lumison.wolfsonmicro.com
	[87.246.78.27])
	by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id 38996110024
	for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2009 15:27:41 +0100 (BST)
Received: from broonie by rakim.wolfsonmicro.main with local (Exim 4.69)
	(envelope-from <broonie@rakim.wolfsonmicro.main>) id 1MDfp6-0001fO-Nb
	for alsa-devel@alsa-project.org; Mon, 08 Jun 2009 15:27:40 +0100
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I've implemented what I hope are some improvements to the DAPM power
sequence application.  Currently when it is implementing power changes
DAPM will do one register write per widget.  Normally this leads to
multiple writes to the same register since power control tends to be
clustered in a few registers, slowing things down.  This can get
noticable on slow or heavily contended buses, especially around resume.
The overall effect of these changes is that DAPM will try to minimise
the number of register writes it does when implementing power sequences.

As with any substantial change in the power sequencing there is a risk
that there may have been some performance regressions on some systems -
my biggest concern is that some thing were being helped by the delays
introduced by the repeated register writes and may require special
handling to fix.  My hope is that this won't happen if anything it should
fix some problems by ensuring that both left and right channels of
stereo paths get powered up together but without wide testing that's
hard to guarantee.  Any testing that you can do on your systems would be
greatly appreciated.

Obviously this is quite an invasive change so I don't intend to submit
to ALSA until after the 2.6.31 merge window has closed.  The patches can
be found here for the time being:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git dapm

Mark Brown (7):
      ASoC: Sort DAPM power sequences while building lists
      ASoC: Factor out DAPM sequence execution
      ASoC: Coalesce register writes for DAPM sequences
      ASoC: Sort specialised mixers and muxes together
      ASoC: Coalesce power updates for DAPM widgets with events
      ASoC: Coalesce power updates for PGAs
      ASoC: Make DAPM power sequence lists local variables

 include/sound/soc.h  |    2 -
 sound/soc/soc-dapm.c |  302 +++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 227 insertions(+), 77 deletions(-)
