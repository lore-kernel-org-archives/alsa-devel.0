From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.35
Date: Mon, 22 Mar 2010 21:23:41 +0000
Message-ID: <20100322212340.GA17533@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AF2F2414A
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 22:23:44 +0100 (CET)
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

The following changes since commit fb91e0beb95e7e253a22fc87b39b5543073eae33:
  Stephen Rothwell (1):
        Add linux-next specific files for 20100322

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

Pull request against -next due to the merge up of v2.6.34-rc2 (log only,
diffstat got confused by the use of -next and tried to include the
entire contents of the branch not just the additions).

Daniel Mack (1):
      ASoC: pxa-pcm-lib: initialize DMA channel to -1

Mark Brown (8):
      Merge commit 'v2.6.34-rc2' into for-2.6.34
      ASoC: Remove BROKEN from i.MX audio after dependencies merged
      ASoC: Add a notifier for jack status changes
      ASoC: Allow force enabled pins to be disabled
      ASoC: Move WM8350 microphone detection bias managment out of driver
      ASoC: Allow disabling of WM835x jack detection
      ASoC: Allow WM8903 mic detect disable and don't force bias on
      Merge branch 'for-2.6.34' into for-2.6.35

Peter Ujfalusi (1):
      ASoC: TWL4030: PM fix for output amplifiers
