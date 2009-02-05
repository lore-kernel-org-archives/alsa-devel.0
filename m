From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Thu, 5 Feb 2009 14:19:43 +0000
Message-ID: <20090205141943.GA31519@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E259D2433F
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2009 15:20:00 +0100 (CET)
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

The following changes since commit 395707212a53999427bd160abd6541bffe062033:
  Takashi Iwai (1):
        Merge branch 'fix/asoc' into topic/asoc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Philipp Zabel (2):
      ASoC: uda1380: split set_dai_fmt into _both, _playback and _capture variants
      ASoC: pxa-ssp: fix SSP port request

Vasily Khoruzhick (1):
      ASoC: Don't unconditionally use the PLL in UDA1380

 sound/soc/codecs/uda1380.c |   72 ++++++++++++++++++++++++++++++++++++++-----
 sound/soc/pxa/pxa-ssp.c    |   12 ++++---
 2 files changed, 70 insertions(+), 14 deletions(-)
