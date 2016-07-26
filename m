From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5] ALSA: soc: fix sparse warnings
Date: Tue, 26 Jul 2016 22:41:52 +0900
Message-ID: <1469540517-32466-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id EA4C426813A
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2016 15:42:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is to fix some sparse warnings in ALSA SoC part. Below items
are going to be fixed:
 * fix a condition statement with a logical operation
 * purge old way to initialize array
 * missing 'static' qualifier for file local symbols

Although I got many warnings from Intel SST drivers due to confusions of
address spaces (__iomem and __kernel), I still left them as they are,
because they require more codes to fix. I hope Intel developers will
do additional work for them...


Takashi Sakamoto (5):
  ALSA: soc-da7219: fix inappropriate condition statement
  ALSA: soc-sst-bxt-rt298: fix obsoleted initializers for array
  ALSA: soc-sst-bxt-da7219_max98357a: fix obsoleted initializers for
    array
  ALSA: soc-rt5616: add static qualifier for file local symbols
  ALSA: soc-tpa6130a2: add static qualifier for file local symbols

 sound/soc/codecs/da7219.c                     |  2 +-
 sound/soc/codecs/rt5616.c                     |  4 ++--
 sound/soc/codecs/tpa6130a2.c                  |  2 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 12 ++++++------
 sound/soc/intel/boards/bxt_rt298.c            | 14 +++++++-------
 5 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.7.4
