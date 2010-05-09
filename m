From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/5] Enabling ASoC paths over suspend
Date: Sun, 9 May 2010 13:07:41 +0100
Message-ID: <20100509120741.GA16918@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EF42D24591
	for <alsa-devel@alsa-project.org>;
	Sun,  9 May 2010 14:07:43 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
Cc: Laim Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following patch series implements support for keeping some paths in
the audio codec enabled while the system is suspended.  This is
primarily intended for mobile phones, where the GSM modem is normally
capable of supporting a voice call with no intervention from the CPU so
power can be saved by suspending the Linux system.  This is done by
allowing DAPM nodes to be marked as ignoring suspend.  Any audio paths
between two widgets set up like this at suspend time will be kept active
and the CODEC device will not be suspended.

The existing testing is very light (especially for digital paths), the
intention is to do more of that get this merged into Takashi's tree
early next week.

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git suspend-enable

Mark Brown (5):
      ASoC: Remove unneeded suspend bias managment from CODEC drivers
      ASoC: Remove unused DAPM suspend flag
      ASoC: Refactor DAPM suspend handling
      ASoC: Support leaving paths enabled over system suspend
      ASoC: Allow active paths from the GSM modem while the GTA02 is suspended

 include/sound/soc-dapm.h                 |    3 +-
 sound/soc/codecs/ak4535.c                |    1 -
 sound/soc/codecs/cq93vc.c                |    2 +-
 sound/soc/codecs/ssm2602.c               |    1 -
 sound/soc/codecs/stac9766.c              |    3 -
 sound/soc/codecs/tlv320aic23.c           |    1 -
 sound/soc/codecs/tlv320aic3x.c           |    2 +-
 sound/soc/codecs/tlv320dac33.c           |    3 -
 sound/soc/codecs/twl4030.c               |    1 -
 sound/soc/codecs/twl6040.c               |    1 -
 sound/soc/codecs/uda1380.c               |    1 -
 sound/soc/codecs/wm8350.c                |    3 -
 sound/soc/codecs/wm8510.c                |    2 +-
 sound/soc/codecs/wm8711.c                |    2 +-
 sound/soc/codecs/wm8728.c                |    2 +-
 sound/soc/codecs/wm8731.c                |    1 -
 sound/soc/codecs/wm8903.c                |    1 -
 sound/soc/codecs/wm8940.c                |    1 -
 sound/soc/codecs/wm8960.c                |    2 +-
 sound/soc/codecs/wm8974.c                |    2 +-
 sound/soc/codecs/wm9712.c                |    3 -
 sound/soc/codecs/wm9713.c                |    3 -
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c |    8 +++
 sound/soc/soc-core.c                     |   35 ++++++++++-
 sound/soc/soc-dapm.c                     |   92 +++++++++++++++++++-----------
 25 files changed, 107 insertions(+), 69 deletions(-)
