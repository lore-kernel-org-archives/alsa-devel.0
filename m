From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.1
Date: Thu, 4 Aug 2011 05:11:25 +0100
Message-ID: <20110804041125.GA20357@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1ADD52435B
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 06:11:27 +0200 (CEST)
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

The following changes since commit 06132fdf63c7d9acc19f136623bf2201f49e73b5:

  ASoC: Fix txx9aclc.c build (2011-07-29 07:53:08 +0200)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-3.1

Mark Brown (1):
      ASoC: Disable wm_hubs periodic DC servo update

Wolfram Sang (1):
      ASoC: sgtl5000: fix cache handling

 sound/soc/codecs/sgtl5000.c |  128 ++++++++++++-------------------------------
 sound/soc/codecs/wm_hubs.c  |    3 +-
 2 files changed, 36 insertions(+), 95 deletions(-)
