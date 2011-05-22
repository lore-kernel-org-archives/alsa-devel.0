From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.40
Date: Sun, 22 May 2011 12:17:21 +0800
Message-ID: <20110522041719.GA11443@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 354CB2414E
	for <alsa-devel@alsa-project.org>;
	Sun, 22 May 2011 06:17:22 +0200 (CEST)
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

The following changes since commit 4a787a3ff3f419c23ab0a5cef677fa441356b818:

  Merge branch 'for-2.6.40' of git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6 into topic/asoc (2011-05-20 11:25:32 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.40

A few more small fixes.

Jarkko Nikula (1):
      ASoC: core: Don't set "(null)" as a driver name

Mark Brown (1):
      Merge branch 'topic/asoc' of git://git.kernel.org/.../tiwai/sound-2.6 into for-2.6.40

Stephen Warren (2):
      ASoC: spdif-dit: Add missing MODULE_*
      ASoC: Tegra: Fix compile when debugfs not enabled

 sound/soc/codecs/spdif_transciever.c |    8 ++++++--
 sound/soc/soc-core.c                 |    2 +-
 sound/soc/tegra/tegra_i2s.c          |    2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)
