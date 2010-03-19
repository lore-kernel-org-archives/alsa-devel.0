From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Fri, 19 Mar 2010 14:31:17 +0000
Message-ID: <20100319143117.GG23306@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 49373103896
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 15:31:21 +0100 (CET)
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

The following changes since commit 83f40d31ca3fba3627a289e262b9423e21e1f01a:
  Takashi Iwai (1):
        Merge branch 'fix/asoc' into for-next

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Mark Brown (1):
      ASoC: Bail out of wm_hubs DC servo if calibration fails

Peter Ujfalusi (2):
      ASoC: tlv320dac33: Fix DSP modes
      ASoC: tlv320dac33: Internal clocking changes

 sound/soc/codecs/tlv320dac33.c |   10 +++-------
 sound/soc/codecs/wm_hubs.c     |    2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)
