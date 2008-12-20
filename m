From: Mark Brown <broonie@sirena.org.uk>
Subject: ASoC updates
Date: Sat, 20 Dec 2008 13:51:32 +0000
Message-ID: <20081220135131.GA12554@sirena.org.uk>
References: <4edcd8463d981e4babef82167aa58131539c367f.1229601269.git.stanley.miao@windriver.com>
	<20081219163501.0e235884.jarkko.nikula@nokia.com>
	<s5h4p10w7nm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 45363244B2
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2008 14:51:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h4p10w7nm.wl%tiwai@suse.de>
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

The following changes since commit 70043058a6968917c00c8d4cff5bfc0e095831ec:
  Takashi Iwai (1):
        Merge branch 'fix/asoc' into topic/asoc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6 for-tiwai

Troy Kisky (8):
      ALSA: ASoC: DaVinci: davinvi-evm, make requests explicit
      ALSA: ASoC: DaVinci: davinci-i2s add comments to explain polarity
      ALSA: ASoC: DaVinci: davinci-i2s clean up
      ALSA: ASoC: DaVinci: davinci-i2s clean up
      ALSA: ASoC: DaVinci: document I2S limitations
      ALSA: ASoC: tlv320aic3x add dsp_a
      ALSA: ASoC: DaVinci: i2s, evm, pass same value to codec and cpu_dai
      ALSA: ASoc: DaVinci: davinci-evm use dsp_b mode

 sound/soc/codecs/tlv320aic3x.c  |    4 +
 sound/soc/codecs/tlv320aic3x.h  |    2 +
 sound/soc/davinci/davinci-evm.c |    8 +-
 sound/soc/davinci/davinci-i2s.c |  158 ++++++++++++++++++++++++--------------
 4 files changed, 110 insertions(+), 62 deletions(-)
