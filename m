From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/4] ASoC updates
Date: Wed, 12 Nov 2008 11:55:07 +0000
Message-ID: <20081112115507.GA22288@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7A9C9243B3
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 12:55:08 +0100 (CET)
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

The following changes since commit e18c94d20224f3df584531a48d944d8cccfda46d:
  Grazvydas Ignotas (1):
        ALSA: ASoC: TWL4030 codec - fix 256*Fs clock

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Christian Pellegrin (1):
      ASoC: s3c24xx 8 bit sound fix

Hugo Villeneuve (1):
      ASoC: Add Right-Justified mode and Codec clock master to davinci-i2s

Naresh Medisetty (1):
      ASoC: DaVinci: Audio: Fix swapping of channels at start of stereo playback

Troy Kisky (1):
      ASoC: TLV320AIC23B Support more sample rates

 sound/soc/codecs/tlv320aic23.c  |  222 +++++++++++++++++++++++++++++++--------
 sound/soc/davinci/davinci-i2s.c |   89 ++++++++++++++--
 sound/soc/s3c24xx/s3c24xx-i2s.c |    7 ++
 3 files changed, 263 insertions(+), 55 deletions(-)
