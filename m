From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Fri, 13 Feb 2009 14:08:43 +0000
Message-ID: <20090213140843.GB13249@rakim.wolfsonmicro.main>
References: <20090213135750.GA13249@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 42E65103936
	for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2009 15:08:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090213135750.GA13249@rakim.wolfsonmicro.main>
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

The following changes since commit 9e30d7718bb7402c7bdee631ad2aae2658c324f0:
  Takashi Iwai (1):
        ASoC: Fix forgotten replacements of socdev->codec

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Mark Brown (2):
      ASoC: Only register AC97 bus if it's not done already
      Merge branch 'for-2.6.29' into for-2.6.30

Timur Tabi (1):
      ASoC: add additional controls to the CS4270 codec driver

 sound/soc/codecs/Kconfig  |    6 ---
 sound/soc/codecs/cs4270.c |   93 +++++++++++++++++++-------------------------
 sound/soc/soc-core.c      |    5 ++-
 3 files changed, 44 insertions(+), 60 deletions(-)
