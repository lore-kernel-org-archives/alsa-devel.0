From: Mark Brown <broonie@sirena.org.uk>
Subject: ASoC updates for 2.6.30
Date: Tue, 17 Mar 2009 19:30:24 +0000
Message-ID: <20090317193022.GA6522@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 39064103896
	for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2009 20:30:31 +0100 (CET)
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

The following changes since commit 852fd9e50f62b4ea7afe26eee0710464de4801b8:
  Mark Brown (1):
        ASoC: Each PXA AC97 DAI needs a separate ops

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Atsushi Nemoto (1):
      ASoC: Only deregister AC97 dev if it's name was not "AC97"

Daniel Mack (1):
      ASoC: switch PXA SSP driver from network mode to PSP

Mark Brown (3):
      ASoC: Fix non-networked I2S mode for PXA SSP
      ASoC: Fix Zylonite for non-networked SSP mode
      Merge branch 'pxa-ssp' into for-2.6.30

 sound/soc/pxa/pxa-ssp.c  |   55 ++++++++++++++++++++++++++++++++++++----------
 sound/soc/pxa/zylonite.c |   55 +++++++++++++++++++++-------------------------
 sound/soc/soc-core.c     |    3 +-
 3 files changed, 70 insertions(+), 43 deletions(-)
