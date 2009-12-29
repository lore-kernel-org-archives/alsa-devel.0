From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Tue, 29 Dec 2009 12:35:55 +0000
Message-ID: <20091229123555.GC5784@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03122243B9
	for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2009 13:35:59 +0100 (CET)
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

The following changes since commit 6b7b284958d47b77d06745b36bc7f36dab769d9b:
  Linus Torvalds (1):
        Linux 2.6.33-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

The change in the branch is much bigger than the diffstat shows due to
the merge up of Linus' tree (which now builds for ARM).

Guennadi Liakhovetski (1):
      ASoC: fix params_rate() macro use in several codecs

Kuninori Morimoto (1):
      ASoC: fsi-ak4642: Remove ak4642_add_i2c_device

Mark Brown (1):
      Merge commit 'v2.6.33-rc2' into for-2.6.33

 sound/soc/codecs/wm8510.c |   14 +++++++-------
 sound/soc/codecs/wm8940.c |   14 +++++++-------
 sound/soc/codecs/wm8974.c |   14 +++++++-------
 sound/soc/sh/fsi-ak4642.c |   30 ------------------------------
 4 files changed, 21 insertions(+), 51 deletions(-)
