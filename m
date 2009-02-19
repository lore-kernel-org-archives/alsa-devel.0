From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Thu, 19 Feb 2009 19:01:41 +0000
Message-ID: <20090219190140.GA9707@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 355E8244BA
	for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2009 20:01:53 +0100 (CET)
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

The following changes since commit 93b760b7072ca6972c15c798e97af3f830d8bbba:
  Mark Brown (1):
        ASoC: Implement SPI device unregistration for WM8731

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Mark Brown (3):
      ASoC: Check for errors when writing WM8731 reset register
      ASoC: Add device init/exit annotations to new-style Wolfson CODEC drivers
      ASoC: Disable WM8731 line bypass by default

Peter Ujfalusi (1):
      ASoC: TWL4030: Add digital loopback support

 sound/soc/codecs/twl4030.c |   56 +++++++++++++++++++++++++++++++++++++++----
 sound/soc/codecs/wm8350.c  |    2 +-
 sound/soc/codecs/wm8731.c  |   19 +++++++++++----
 sound/soc/codecs/wm8900.c  |    8 +++---
 sound/soc/codecs/wm8903.c  |    8 +++---
 5 files changed, 73 insertions(+), 20 deletions(-)
