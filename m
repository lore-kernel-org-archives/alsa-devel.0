From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC update for 2.6.31
Date: Mon, 8 Jun 2009 10:54:58 +0100
Message-ID: <20090608095458.GA3112@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2F5D7103815
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 11:55:00 +0200 (CEST)
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

The following changes since commit e3509ff0fb9df53e45cd68488e3b463a80455db7:
  Daniel Mack (1):
        ASoC: fix NULL pointer dereference in soc_suspend()

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

Mark Brown (1):
      ASoC: Apostrophe patrol

Troy Kisky (1):
      ASoC: codec tlv320aic23 fix bogus divide by 0 message

 sound/soc/codecs/tlv320aic23.c |   10 +++++-----
 sound/soc/soc-dapm.c           |   10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)
