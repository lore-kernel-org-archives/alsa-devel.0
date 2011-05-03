From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.39
Date: Tue, 3 May 2011 11:24:44 +0100
Message-ID: <20110503102444.GB1762@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 55CD22447E
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 12:24:47 +0200 (CEST)
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

The following changes since commit b3c27b51db9112d03864fdef44fa611dd69c1425:

  ASoC: add a module alias to the FSI driver (2011-04-18 17:14:28 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.39

All fixes in individual drivers, the bitfield definitions patch is a
style thing only but was used by the subsequent two patches.

Ben Gardiner (4):
      ASoC: davinci-mcasp: correct tdm_slots limit
      davinci-mcasp: use bitfield definitions for PDIR
      davinci-mcasp: fix _CBM_CFS hw_params
      davinci-mcasp: fix _CBM_CFS pin directions

Mark Brown (2):
      ASoC: Fix CODEC name in Goni
      ASoC: Fix CODEC DAI names for Goni

 sound/soc/davinci/davinci-mcasp.c |   19 ++++++++++++-------
 sound/soc/samsung/goni_wm8994.c   |    8 ++++----
 2 files changed, 16 insertions(+), 11 deletions(-)
