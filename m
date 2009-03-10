From: Mark Brown <broonie@sirena.org.uk>
Subject: ASoC updates for 2.6.30
Date: Tue, 10 Mar 2009 19:55:52 +0000
Message-ID: <20090310195551.GA8255@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 59C1F1037FB
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 20:55:59 +0100 (CET)
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

The following changes since commit 0a4e1c9069b3cc2a9e5b57898ac9be94314e8efa:
  Takashi Iwai (1):
        Merge branch 'for-2.6.30' of git://git.kernel.org/.../broonie/sound-2.6 into topic/asoc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Ben Dooks (1):
      ASoC: Fix Samsung S3C2412_IISMOD_SDF_{MSB,LSB} definitions

Daniel Mack (1):
      ASoC: don't touch pxa-ssp registers when stream is running

Hugo Villeneuve (2):
      ALSA: ASoC: Davinci: Replaced DAI format RIGHT_J by DSP_B for SFFSDR
      ALSA: ASoC: Davinci: Updated sffsdr_hw_params() function to new format

Mark Brown (3):
      ASoC: Convert PXA AC97 driver to probe with the platform device
      Merge commit 'takashi/topic/asoc' into for-2.6.30
      ASoC: Fix up merge with the ARM tree

 arch/arm/mach-shark/include/mach/io.h             |    1 +
 arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h |    4 +-
 sound/soc/davinci/davinci-sffsdr.c                |   20 ++++++-----
 sound/soc/pxa/pxa-ssp.c                           |   11 ++++++
 sound/soc/pxa/pxa2xx-ac97.c                       |   38 ++++++++++++++++++--
 5 files changed, 59 insertions(+), 15 deletions(-)
