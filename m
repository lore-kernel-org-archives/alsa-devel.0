From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.31
Date: Tue, 19 May 2009 20:27:32 +0100
Message-ID: <20090519192731.GA9840@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 36E5810388B
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 21:27:40 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit f83fba8baab9e95fff0fe2be0e1e32a1650bdd7f:
  Mark Brown (1):
        ASoC: Add debug trace for bias level transitions

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

Atsushi Nemoto (1):
      ASoC: Add TXx9 AC link controller driver (v3)

Lopez Cruz, Misael (2):
      ASoC: TWL4030: Add control for selecting codec operation mode
      ASoC: SDP3430: Connect twl4030 voice DAI to McBSP3

Peter Ujfalusi (1):
      ASoC: TWL4030: Fix Analog capture path for AUXR

 sound/soc/Kconfig                 |    1 +
 sound/soc/Makefile                |    1 +
 sound/soc/codecs/twl4030.c        |   49 ++++-
 sound/soc/omap/sdp3430.c          |   87 +++++++-
 sound/soc/txx9/Kconfig            |   29 +++
 sound/soc/txx9/Makefile           |   11 +
 sound/soc/txx9/txx9aclc-ac97.c    |  255 ++++++++++++++++++++++
 sound/soc/txx9/txx9aclc-generic.c |   98 +++++++++
 sound/soc/txx9/txx9aclc.c         |  430 +++++++++++++++++++++++++++++++++++++
 sound/soc/txx9/txx9aclc.h         |   83 +++++++
 10 files changed, 1033 insertions(+), 11 deletions(-)
 create mode 100644 sound/soc/txx9/Kconfig
 create mode 100644 sound/soc/txx9/Makefile
 create mode 100644 sound/soc/txx9/txx9aclc-ac97.c
 create mode 100644 sound/soc/txx9/txx9aclc-generic.c
 create mode 100644 sound/soc/txx9/txx9aclc.c
 create mode 100644 sound/soc/txx9/txx9aclc.h
