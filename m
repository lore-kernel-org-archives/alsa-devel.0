From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Mon, 2 Nov 2009 18:26:37 +0000
Message-ID: <20091102182637.GA13693@rakim.wolfsonmicro.main>
References: <4AE59E01.9000802@mocean-labs.com>
	<20091026130931.GA18781@sirena.org.uk>
	<s5h4ophyu6d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <s5h4ophyu6d.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit 98078bf90495729e59edbec088d00b9d98f4cc0f:
  Mark Brown (1):
        Merge branch 'for-2.6.32' into for-2.6.33

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Eero Nurkkala (2):
      ASoC: remove io_mutex
      ASoC: refactor snd_soc_update_bits()

Manuel Lauss (1):
      ASoC: au1x: convert to platform drivers.

Neil Jones (1):
      ASoC: Add support for the WM8727 DAC.

Peter Ujfalusi (1):
      ASoC: TWL4030: Make sure, that the codec is powered on startup

 sound/soc/au1x/dbdma2.c    |  117 ++++++++++++++++++++++-----
 sound/soc/au1x/psc-ac97.c  |  194 +++++++++++++++++++++++++++-----------------
 sound/soc/au1x/psc-i2s.c   |  189 +++++++++++++++++++++++++++----------------
 sound/soc/au1x/psc.h       |    7 ++-
 sound/soc/codecs/Kconfig   |    4 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/twl4030.c |    1 +
 sound/soc/codecs/wm8727.c  |  143 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8727.h  |   21 +++++
 sound/soc/soc-core.c       |   41 +++++++---
 10 files changed, 545 insertions(+), 174 deletions(-)
 create mode 100644 sound/soc/codecs/wm8727.c
 create mode 100644 sound/soc/codecs/wm8727.h
