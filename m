From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Fri, 15 May 2009 09:23:36 +0100
Message-ID: <20090515082336.GB1451@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6555910395B
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 10:23:37 +0200 (CEST)
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

The following changes since commit 1ffafeb556d50de8039e14f1cbbe58e9e4549915:
  Mike Rapoport (1):
        pxa2xx-ac97: fix reset gpio mode setting

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

David Brownell (3):
      ASoC: davinci-pcm buildfixes
      ASoC: DaVinci I2S updates
      ASoC: DaVinci EVM board support buildfixes

 arch/arm/mach-davinci/include/mach/asp.h |   25 ++++++++++
 sound/soc/davinci/Kconfig                |    7 ++-
 sound/soc/davinci/davinci-evm.c          |   63 ++++++++++++++++++++++-----
 sound/soc/davinci/davinci-i2s.c          |   26 ++++++++++-
 sound/soc/davinci/davinci-pcm.c          |   71 +++++++++++++++++------------
 5 files changed, 146 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm/mach-davinci/include/mach/asp.h
