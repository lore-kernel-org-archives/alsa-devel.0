From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Mon, 4 Jan 2010 22:35:17 +0000
Message-ID: <20100104223517.GA3865@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7B65D1037F7
	for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2010 23:35:22 +0100 (CET)
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit c5974b835a909ff15c3b7e6cf6789b5eb919f419:
  Linus Torvalds (1):
        Merge branch 'limits_cleanup' of git://decibel.fi.muni.cz/~xslaby/linux

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Takashi is on holiday for the first few weeks of the year so he said to
send direct pull requests in the interim.  The patch from Morimoto-san
is finishing off a cross-tree merge while the others are driver-specific
fixes.

Guennadi Liakhovetski (1):
      ASoC: fix params_rate() macro use in several codecs

Kuninori Morimoto (1):
      ASoC: fsi-ak4642: Remove ak4642_add_i2c_device

Manuel Lauss (1):
      ASoC: fixup oops in generic AC97 codec glue

Mark Brown (1):
      Merge commit 'v2.6.33-rc2' into for-2.6.33

 sound/soc/codecs/ac97.c   |    6 ++++++
 sound/soc/codecs/wm8510.c |   14 +++++++-------
 sound/soc/codecs/wm8940.c |   14 +++++++-------
 sound/soc/codecs/wm8974.c |   14 +++++++-------
 sound/soc/sh/fsi-ak4642.c |   30 ------------------------------
 5 files changed, 27 insertions(+), 51 deletions(-)
