From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Fri, 9 Oct 2009 20:38:06 +0100
Message-ID: <20091009193806.GA5402@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 01C61103B09
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 21:38:08 +0200 (CEST)
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

The following changes since commit 907bc6c7fc7071b00083fc11e510e47dd93df45d:
  Mark Brown (1):
        Merge branch 'for-2.6.32' into for-2.6.33

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Mark Brown (5):
      ASoC: Remove absent SYNC and TDM DAI format options from i.MX SSI
      ASoC: WM8350 capture PGA mutes are inverted
      Merge branch 'upstream/wm8350' into for-2.6.32
      Merge branch 'for-2.6.32' into for-2.6.33
      ASoC: Minor fixups to tpa6130a2 driver

Nicolas Ferre (1):
      ASoC: at91sam9g20ek_2mmc board uses same audio connexion as at91sam9g20ek

Peter Ujfalusi (1):
      ASoC: TPA6130A2 amplifier driver

 include/sound/tpa6130a2-plat.h   |   30 +++
 sound/soc/atmel/sam9g20_wm8731.c |    2 +-
 sound/soc/codecs/Kconfig         |    4 +
 sound/soc/codecs/Makefile        |    2 +
 sound/soc/codecs/tpa6130a2.c     |  463 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tpa6130a2.h     |   62 +++++
 sound/soc/codecs/wm8350.c        |    4 +-
 sound/soc/imx/mxc-ssi.c          |    8 -
 8 files changed, 564 insertions(+), 11 deletions(-)
 create mode 100644 include/sound/tpa6130a2-plat.h
 create mode 100644 sound/soc/codecs/tpa6130a2.c
 create mode 100644 sound/soc/codecs/tpa6130a2.h
