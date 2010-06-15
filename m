From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC update for 2.6.35
Date: Tue, 15 Jun 2010 12:31:58 +0100
Message-ID: <20100615113158.GC14510@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6F8E4103898
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jun 2010 13:32:00 +0200 (CEST)
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

The following changes since commit e854df613fe934c94a0b39eccb4104e72ccbbded:

  Merge branch 'for-2.6.35' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6 into fix/asoc (2010-06-02 14:17:44 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

Sudhakar Rajashekhara (1):
      ASoC: DaVinci: Fix McASP hardware FIFO configuration

There is a fix for duplicate enables of the DMA, the changelog is
detailed.

 sound/soc/davinci/davinci-mcasp.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)
