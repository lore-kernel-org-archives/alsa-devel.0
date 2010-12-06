From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Mon, 6 Dec 2010 14:18:18 +0000
Message-ID: <20101206141817.GE1924@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CA2EB24381
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 15:18:21 +0100 (CET)
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

The following changes since commit af745bd724e304cc94a88a2fb43d53baffbd63a5:

  Merge branch 'for-2.6.37' of git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6 into fix/asoc (2010-12-02 17:31:18 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

More small localised fixes.

Axel Lin (1):
      ASoC: Hold client_mutex while calling snd_soc_instantiate_cards()

Uk Kim (2):
      ASoC: Fix off by one error in WM8994 EQ register bank size
      ASoC: Fix swap of left and right channels for WM8993/4 speaker boost gain

 include/linux/mfd/wm8994/pdata.h |    2 +-
 sound/soc/codecs/wm_hubs.c       |    2 +-
 sound/soc/soc-core.c             |    2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)
