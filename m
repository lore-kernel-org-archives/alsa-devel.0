From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Mon, 6 Dec 2010 14:35:13 +0000
Message-ID: <20101206143513.GG1924@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0466B1038B7
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 15:35:14 +0100 (CET)
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

The following changes since commit 28216bf48bbe4314a7a02b7c9822dbb26aca530c:

  Merge branch 'for-2.6.37' into for-2.6.38 (2010-12-03 17:28:29 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

Axel Lin (1):
      ASoC: Hold client_mutex while calling snd_soc_instantiate_cards()

Dimitris Papastamos (1):
      ASoC: soc-cache: Add optional cache name member to snd_soc_cache_ops

Mark Brown (3):
      ASoC: Add post-CODEC bias level callback for machine driver
      ASoC: Add trace events for jack detection
      Merge branch 'for-2.6.37' into for-2.6.38

Seungwhan Youn (2):
      ASoC: SAMSUNG: Fix initial return value
      ASoC: SAMSUNG: Remove duplicated snd_card on smdk_spdif

Uk Kim (2):
      ASoC: Fix off by one error in WM8994 EQ register bank size
      ASoC: Fix swap of left and right channels for WM8993/4 speaker boost gain

 include/linux/mfd/wm8994/pdata.h |    2 +-
 include/sound/soc.h              |    3 ++
 include/trace/events/asoc.h      |   59 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm_hubs.c       |    2 +-
 sound/soc/samsung/smdk_spdif.c   |    4 +--
 sound/soc/soc-cache.c            |   18 ++++++++++-
 sound/soc/soc-core.c             |    6 ++--
 sound/soc/soc-dapm.c             |    4 ++
 sound/soc/soc-jack.c             |    7 ++++
 9 files changed, 95 insertions(+), 10 deletions(-)
