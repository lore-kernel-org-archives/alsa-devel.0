From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Tue, 28 Jul 2009 22:43:41 +0100
Message-ID: <20090728214341.GE4505@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C8629247A2
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jul 2009 23:43:47 +0200 (CEST)
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

The following changes since commit 4ce2f2fe61002ab35c9333d52c95b5ff9e949f50:
  Marek Vasut (1):
        ASoC: Switch palm27x-asoc to jack detection api

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Barry Song (2):
      ASoC: blackfin I2S(TDM mode) CPU DAI driver
      ASoC: board driver to connect bf5xx with ad1938

Janusz Krzysztofik (1):
      ASoC: CX20442: fix issues pointed out by subsystem maintainer

 sound/soc/blackfin/Kconfig         |   23 +++-
 sound/soc/blackfin/Makefile        |    6 +
 sound/soc/blackfin/bf5xx-ad1938.c  |  142 +++++++++++++++
 sound/soc/blackfin/bf5xx-tdm-pcm.c |  330 ++++++++++++++++++++++++++++++++++
 sound/soc/blackfin/bf5xx-tdm-pcm.h |   21 +++
 sound/soc/blackfin/bf5xx-tdm.c     |  343 ++++++++++++++++++++++++++++++++++++
 sound/soc/blackfin/bf5xx-tdm.h     |   14 ++
 sound/soc/codecs/cx20442.c         |   17 +-
 8 files changed, 888 insertions(+), 8 deletions(-)
 create mode 100644 sound/soc/blackfin/bf5xx-ad1938.c
 create mode 100644 sound/soc/blackfin/bf5xx-tdm-pcm.c
 create mode 100644 sound/soc/blackfin/bf5xx-tdm-pcm.h
 create mode 100644 sound/soc/blackfin/bf5xx-tdm.c
 create mode 100644 sound/soc/blackfin/bf5xx-tdm.h
