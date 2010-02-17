From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Wed, 17 Feb 2010 16:29:07 +0000
Message-ID: <20100217162907.GC13324@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6D38E1038CE
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 17:29:09 +0100 (CET)
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

The following changes since commit 7833ae0edf50b0eb303e95b1bec5fbd63a1e2672:
  Peter Ujfalusi (1):
        ASoC: tlv320dac33: Correct the OSCSET calculation

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Mark Brown (1):
      ASoC: Make pmdown_time a long

Peter Ujfalusi (1):
      ASoC: TWL4030: Use codec defaults for Headset initial configuration

 include/sound/soc.h        |    2 +-
 sound/soc/codecs/twl4030.c |    4 ++--
 sound/soc/soc-core.c       |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
