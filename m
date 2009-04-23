From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Thu, 23 Apr 2009 19:48:29 +0100
Message-ID: <20090423184829.GA7807@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A9732438D
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 20:48:40 +0200 (CEST)
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

The following changes since commit a1992db55d80297544a65160ddb98afba45f7759:
  Takashi Iwai (1):
        ASoC: remove non-existing referece to CONFIG_SND_SOC_CODEC_WM8991

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Mark Brown (4):
      ASoC: Fix offset of freqmode in WM8580 PLL configuration
      ASoC: Fix WM8580 volume update handling for large register changes
      Merge commit 'takashi/fix/asoc' into for-2.6.30
      ASoC: s3c-i2s-v2 needs to declare a license for modular builds

 sound/soc/codecs/wm8580.c      |   16 ++++++++++------
 sound/soc/s3c24xx/s3c-i2s-v2.c |    3 ++-
 2 files changed, 12 insertions(+), 7 deletions(-)
