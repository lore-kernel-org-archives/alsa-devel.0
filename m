From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 0/5] ASOC: fix sparse warnings
Date: Tue, 27 Sep 2016 07:45:06 +0900
Message-ID: <1474929911-6005-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 89752266E0C
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 00:45:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset updates my previous one, and for Linux 4.8-rc8.
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-July/110466.html

This is to fix some sparse warnings in ALSA SoC part. Below items
are going to be fixed:
 * fix a condition statement with a logical operation
 * purge old way to initialize array
 * complement missing 'static' and 'const' qualifier for file local symbols

Takashi Sakamoto (5):
  ASOC: da7219: fix inappropriate condition statement
  ASOC: sst-bxt-rt298: fix obsoleted initializers for array
  ASOC: sst-bxt-da7219_max98357a: fix obsoleted initializers for array
  ASOC: rt5616: add static qualifier for file local symbols
  ASOC: tpa6130a2: add static qualifier for file local symbols

 sound/soc/codecs/da7219.c                     |  2 +-
 sound/soc/codecs/rt5616.c                     |  4 ++--
 sound/soc/codecs/tpa6130a2.c                  |  2 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 12 ++++++------
 sound/soc/intel/boards/bxt_rt298.c            | 14 +++++++-------
 5 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.7.4
