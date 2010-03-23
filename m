From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.35
Date: Tue, 23 Mar 2010 15:52:09 +0000
Message-ID: <20100323155208.GA25603@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 682BA103946
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2010 16:52:10 +0100 (CET)
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

The following changes since commit 74511020dde10252f8b8e648690d99dba721de14:
  Mark Brown (1):
        Merge branch 'for-2.6.34' into for-2.6.35

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

Kuninori Morimoto (3):
      ASoC: ak4642: Add pll select support
      ASoC: ak4642: Add set_fmt function for snd_soc_dai_ops
      ASoC: ak4642: Add enhanced sampling rate

Mark Brown (1):
      ASoC: Implement WM8994 DAI tristate support

 sound/soc/codecs/ak4642.c |  175 ++++++++++++++++++++++++++++++++++++---------
 sound/soc/codecs/wm8994.c |   38 ++++++++++
 sound/soc/sh/fsi-ak4642.c |   14 ++++
 3 files changed, 192 insertions(+), 35 deletions(-)
