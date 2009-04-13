From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Mon, 13 Apr 2009 15:07:37 +0100
Message-ID: <20090413140737.GA17456@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 965EB1037F7
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Apr 2009 16:07:38 +0200 (CEST)
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

The following changes since commit d6648da122870ff42bc720da25483bdb8bc868f8:
  Peter Ujfalusi (1):
        ASoC: TWL4030: Compillation error fix

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Eric's patch is a build fix for the magician after mainline merge.

Eric Miao (1):
      ASoC: magician: remove un-necessary #include of pxa-regs.h and hardware.h

Mark Brown (1):
      ASoC: Disable S3C64xx support in Kconfig

 sound/soc/pxa/magician.c  |    2 --
 sound/soc/s3c24xx/Kconfig |    6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)
