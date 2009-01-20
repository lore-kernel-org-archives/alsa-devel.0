From: Mark Brown <broonie@sirena.org.uk>
Subject: ASoC updates for 2.6.30
Date: Tue, 20 Jan 2009 21:00:19 +0000
Message-ID: <20090120210018.GB7686@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CB0141037E3
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 22:00:26 +0100 (CET)
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

The following changes since commit b2a19d02396c92294abcddee5bd9bd49cc4e4d1c:
  Mark Brown (1):
        ASoC: Staticise PCM operations tables

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Ian Molton (1):
      ASoC: Fix WM9705 capture switch name

Mark Brown (1):
      Merge branch 'for-2.6.29' into for-2.6.30

Timur Tabi (2):
      ASoC: fix registration of the SoC card in the Freescale MPC8610 drivers
      ASoC: Allow Freescale MPC8610 audio drivers to be compiled as modules

 sound/soc/codecs/wm9705.c    |    4 ++--
 sound/soc/fsl/Kconfig        |   16 ++++++++--------
 sound/soc/fsl/Makefile       |    7 +++++--
 sound/soc/fsl/mpc8610_hpcd.c |   18 ++++++------------
 4 files changed, 21 insertions(+), 24 deletions(-)
