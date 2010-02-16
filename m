From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Tue, 16 Feb 2010 19:20:02 +0000
Message-ID: <20100216192001.GA3260@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C4D8E244D1
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 20:20:03 +0100 (CET)
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

The following changes since commit 3a66d3877eaa4ab9818000a15c07326adaa9ca79:
  Mark Brown (1):
        ASoC: Add WM2000 driver

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Mark Brown (2):
      ASoC: Make pmdown_time a per-card setting
      ASoC: Make pmdown_time runtime configurable

Peter Ujfalusi (2):
      ASoC: tlv320dac33: Clearing FIFOFLUSH flag before playback
      ASoC: tlv320dac33: Correct the OSCSET calculation

 include/sound/soc.h            |    2 ++
 sound/soc/codecs/tlv320dac33.c |    5 ++++-
 sound/soc/soc-core.c           |   31 ++++++++++++++++++++++++++++++-
 3 files changed, 36 insertions(+), 2 deletions(-)
