From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Mon, 27 Apr 2009 21:10:47 +0100
Message-ID: <20090427201047.GA8650@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5B150103842
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 22:10:48 +0200 (CEST)
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

The following changes since commit a396e32ef0f3b98700abb9a6da3530c945e55908:
  Mark Brown (1):
        ASoC: s3c-i2s-v2 needs to declare a license for modular builds

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Jon Smirl (1):
      ASoC: Set the MPC5200 i2s driver to BROKEN status.

Mark Brown (1):
      ASoC: Fix logic in WM8350 master clocking check

 sound/soc/codecs/wm8350.c |    2 +-
 sound/soc/fsl/Kconfig     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
