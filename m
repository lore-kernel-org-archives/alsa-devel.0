From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.36
Date: Fri, 13 Aug 2010 15:49:35 +0100
Message-ID: <20100813144934.GA11661@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C9C024154
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 16:49:36 +0200 (CEST)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 2e2211a387e70c62e1249822a94f4a33933ecd62:

  ASoC: add AD1980 obsolete information (2010-08-10 15:43:45 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.36

A couple of focused patches for the WM8994, plus the MAINTAINERS
additions.  They're not 100% ASoC but mostly so by volume of code
covered so hopefully not a problem for you to take via your tree - let
me know if it's an issue and I'll drop them.

Mark Brown (4):
      ASoC: Optimise DSP performance for WM8994
      ASoC: Only tweak WM8994 chip configuration on devices up to rev D
      MAINTAINERS: Make Wolfson entry also cover CODEC drivers
      MAINTAINERS: Add Ian Lartey as comaintaner for Wolfson devices

 MAINTAINERS               |    7 ++++---
 sound/soc/codecs/wm8994.c |   23 +++++++++++++++--------
 2 files changed, 19 insertions(+), 11 deletions(-)
