From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Fri, 18 Dec 2009 13:16:21 +0000
Message-ID: <20091218131621.GA30425@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 74DC21038DC
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 14:16:22 +0100 (CET)
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

The following changes since commit 1cf86f6f9b000e98c1b7f866f99633ae67464e2f:
  Kuninori Morimoto (1):
        ASoC: ak4642: Add default return value in ak4642_modinit

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Guennadi Liakhovetski (1):
      ASoC: wm8974: fix a wrong bit definition

Jon Smirl (1):
      ASoC: Fix disable of SPDIF on STAC9766 codec

 sound/soc/codecs/stac9766.c |   18 +-----------------
 sound/soc/codecs/wm8974.c   |    2 +-
 2 files changed, 2 insertions(+), 18 deletions(-)
