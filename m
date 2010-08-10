From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.36
Date: Tue, 10 Aug 2010 15:52:31 +0100
Message-ID: <20100810145231.GJ6416@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C9DDE244BB
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 16:52:32 +0200 (CEST)
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

The following changes since commit bda7d2a862e6b788bca2d02d38a07966a9c92e48:

  ASoC: TWL4030: Capture route runtime DAPM ordering fix (2010-08-04 00:42:=
39 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2=
.6.36

Cliff Cai (1):
      ASoC: register cache should be 1 byte aligned for 1 byte long register

Eric B=E9nard (1):
      ASoC: Fix for changed Eureka Kconfig symbol names

Mark Brown (1):
      ASoC: Fix inverted mute controls for WM8580

Sonic Zhang (1):
      ASoC: add AD1980 obsolete information

A bunch of small, easy to parse, fixes here plus the documentation
updated on the obsoletion of the AD1980.

 sound/soc/blackfin/Kconfig        |    7 ++++++-
 sound/soc/blackfin/bf5xx-ad1980.c |   10 +++++++++-
 sound/soc/codecs/ad1980.c         |   10 +++++++++-
 sound/soc/codecs/ad1980.h         |    6 ++++++
 sound/soc/codecs/wm8580.c         |    6 +++---
 sound/soc/imx/Kconfig             |    4 +++-
 sound/soc/soc-cache.c             |    4 ++--
 7 files changed, 38 insertions(+), 9 deletions(-)
