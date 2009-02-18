From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Wed, 18 Feb 2009 12:55:10 +0000
Message-ID: <20090218125510.GA11978@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CEDE8103897
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:55:10 +0100 (CET)
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

The following changes since commit 59544d33ff3118f22a484d8be06cdf5cfc2fdca5:
  Mark Brown (1):
        ASoC: Remove version display from the WM8753 driver

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Mark Brown (2):
      ASoC: Include I2C headers for corgi and poodle
      ASoC: Implement SPI device unregistration for WM8731

 sound/soc/codecs/wm8731.c |    7 ++++++-
 sound/soc/pxa/corgi.c     |    1 +
 sound/soc/pxa/poodle.c    |    1 +
