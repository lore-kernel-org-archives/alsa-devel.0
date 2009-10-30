From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Fri, 30 Oct 2009 10:47:20 +0000
Message-ID: <20091030104720.GB5345@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4E17244DD
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 11:47:21 +0100 (CET)
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

Welcome back!  There's a couple of small updates below, one is just
enhanced help text and the other fixes support for basic AC97 devices.

The following changes since commit 8e8b2d676f3f7c1246b108793fb5690e6c6fcd26:
  Eero Nurkkala (1):
        ASoC: Serialize access to dapm_power_widgets()

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Barry Song (1):
      ASoC: Fix possible codec_dai->ops NULL pointer problems

Janusz Krzysztofik (1):
      ASoC: Amstrad Delta: add info about the line discipline requirement to Kconfig help text

 sound/soc/omap/Kconfig |   13 ++++++++++++-
 sound/soc/soc-core.c   |   11 ++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)
