From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Thu, 16 Apr 2009 14:01:40 +0100
Message-ID: <20090416130139.GA7035@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 622BC24378
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 15:01:41 +0200 (CEST)
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

The following changes since commit 9dd175f7d2db1826c891855d3d150da3a5792e94:
  Takashi Iwai (1):
        Merge branch 'topic/hda' into for-linus

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Ben Dooks (4):
      ASoC: Fix jive_wm8750.c build problems
      ASoC: s3c-i2s-v2.c fix for s3c_i2sv2_iis_calc_rate
      ASoC: Fix s3c-i2s-v2.c snd_soc_dai changes
      ASoC: Fix include build error in s3c2412-i2s.c

Daniel Mack (1):
      ASoC: pxa-ssp: allow setting of dai format 0

Jarkko Nikula (2):
      ASoC: OMAP: Fix DSP_B format in OMAP McBSP DAI driver
      ASoC: OMAP: Fix FS polarity in OSK5912 machine driver

 sound/soc/omap/omap-mcbsp.c     |    7 +++++--
 sound/soc/omap/osk5912.c        |    4 ++--
 sound/soc/pxa/pxa-ssp.c         |    1 +
 sound/soc/s3c24xx/jive_wm8750.c |   12 ++++++------
 sound/soc/s3c24xx/s3c-i2s-v2.c  |   18 ++++++++++--------
 sound/soc/s3c24xx/s3c2412-i2s.c |    2 +-
 6 files changed, 25 insertions(+), 19 deletions(-)
