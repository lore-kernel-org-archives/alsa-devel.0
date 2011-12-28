From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC update for 3.2
Date: Wed, 28 Dec 2011 11:44:09 +0000
Message-ID: <20111228114408.GH24405@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 36924244D4
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 12:44:11 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 497d496598f411cb7f0690725a0e8b9029cebdb9:

  ASoC: Fix hx4700 error handling to free gpios if snd_soc_register_card fails (2011-12-12 12:58:42 +0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.2

Joachim Eastwood (1):
      ASoC: wm8776: add missing break in sample size switch

 sound/soc/codecs/wm8776.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
