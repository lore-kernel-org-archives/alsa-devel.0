From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Thu, 7 Oct 2010 14:17:56 -0700
Message-ID: <20101007211755.GB11935@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B0D091039DA
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 23:17:43 +0200 (CEST)
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

The following changes since commit ad5e4655f9a920b1cc13972e0389eaf9e0ba10b3:

  ASoC: remove duplicated include for nuc900 (2010-10-05 19:26:00 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

Mark Brown (6):
      ASoC: Add Dimitris Papastamos to Wolfson maintainers
      ASoC: Update links for Wolfson MAINTAINERS entry
      ASoC: Staticise AD1980 DAI
      ASoC: Use delayed work for debounce of GPIO based jacks
      ASoC: Staticise CS4270 DAI
      Merge branch 'for-2.6.36' into for-2.6.37

 MAINTAINERS               |    4 +++-
 include/sound/soc.h       |    2 +-
 sound/soc/codecs/ad1980.c |    2 +-
 sound/soc/codecs/cs4270.c |    2 +-
 sound/soc/soc-jack.c      |   11 +++++------
 5 files changed, 11 insertions(+), 10 deletions(-)
