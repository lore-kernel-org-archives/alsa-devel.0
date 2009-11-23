From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Mon, 23 Nov 2009 12:17:40 +0000
Message-ID: <20091123121740.GA26793@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 77D96103807
	for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2009 13:17:41 +0100 (CET)
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

The following changes since commit 41b51dd47ea7c406a8d49b97804e8acec9dadaed:
  Mark Brown (1):
        Merge branch 'for-2.6.32' into for-2.6.33

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2=
.6.33

Enric Balletb=F2 i Serra (1):
      ASoC: Add support for IGEP v2

Graeme Gregory (1):
      ASoC: ADS117x ADC driver

Mark Brown (2):
      ASoC: Update ads117x to current APIs
      Merge branch 'ads117x' of git://git.kernel.org/.../broonie/sound-2.6 =
into for-2.6.33

Troy Kisky (4):
      ASoC: DaVinci: i2s, reduce underruns by combining into 1 element
      ASoC: DaVinci: pcm, rename variables in prep for ping/pong
      ASoC: DaVinci: pcm, fix underrun by using sram
      ASoC: DaVinci: use edma_pause, edma_resume

 arch/arm/mach-davinci/include/mach/asp.h |    8 +
 sound/soc/codecs/Kconfig                 |    4 +
 sound/soc/codecs/Makefile                |    2 +
 sound/soc/codecs/ads117x.c               |  123 +++++++
 sound/soc/codecs/ads117x.h               |   13 +
 sound/soc/davinci/davinci-i2s.c          |   79 ++++-
 sound/soc/davinci/davinci-pcm.c          |  551 ++++++++++++++++++++++++++=
----
 sound/soc/davinci/davinci-pcm.h          |    1 +
 sound/soc/omap/Kconfig                   |    7 +
 sound/soc/omap/Makefile                  |    2 +
 sound/soc/omap/igep0020.c                |  148 ++++++++
 11 files changed, 859 insertions(+), 79 deletions(-)
 create mode 100644 sound/soc/codecs/ads117x.c
 create mode 100644 sound/soc/codecs/ads117x.h
 create mode 100644 sound/soc/omap/igep0020.c
