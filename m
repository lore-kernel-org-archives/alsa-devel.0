From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.36
Date: Tue, 6 Jul 2010 09:21:37 +0900
Message-ID: <20100706002136.GC1923@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 197B624346
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Jul 2010 02:21:59 +0200 (CEST)
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

The following changes since commit ce93a3702832121d517ad348817929f22fcce47c:

  ASoC: Add SmartQ sound driver (2010-07-04 18:04:12 +0900)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.36

Mark Brown (4):
      ASoC: Fix sorting of Makefile and Kconfig
      ASoC: Remove current WM8960 deemphasis control
      ASoC: Automatically manage DAC deemphasis rate for WM8960
      ASoC: Automatically manage ALC coefficients for WM8960

 sound/soc/Kconfig         |    2 +-
 sound/soc/Makefile        |    2 +-
 sound/soc/codecs/wm8960.c |   99 +++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 93 insertions(+), 10 deletions(-)
