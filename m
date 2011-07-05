From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.0
Date: Mon, 4 Jul 2011 23:14:07 -0700
Message-ID: <20110705061407.GB1625@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82565245CA
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jul 2011 08:14:11 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 63bc9750167ac765827470aa5aed1e79aeaaad9e:

  Merge branch 'for-3.0' of git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6 into fix/asoc (2011-07-05 07:33:06 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-3.0

Mark Brown (2):
      ASoC: Fix Blackfin I2S _pointer() implementation return in bounds values
      ASoC: Ensure we delay long enough for WM8994 FLL to lock when starting

Stephen Warren (1):
      ASoC: Tegra: I2S: Ensure clock is enabled when writing regs

 sound/soc/blackfin/bf5xx-i2s-pcm.c |   13 +++++++++++--
 sound/soc/codecs/wm8994.c          |    2 ++
 sound/soc/tegra/tegra_i2s.c        |    6 ++++++
 3 files changed, 19 insertions(+), 2 deletions(-)
