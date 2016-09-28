From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 0/3] ASoC: max9867/rt5616/wm8960: remove
	usage of obsoleted TLV-related macro
Date: Wed, 28 Sep 2016 09:29:18 +0900
Message-ID: <1475022561-5968-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 3B5322606F8
 for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2016 02:29:27 +0200 (CEST)
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

This patchset update my previous one:
[alsa-devel] [PATCH] ASOC: max9867/rt5616/wm8960: remove usage of obsoleted TLV-related macro

Changes v2:
 - Split to several patches for each modules

Takashi Sakamoto (3):
  ASoC: max9867: remove usage of obsoleted TLV-related macro
  ASoC: rt5616: remove usage of obsoleted TLV-related macro
  ASoC: wm8960: remove usage of obsoleted TLV-related macro

 sound/soc/codecs/max9867.c | 5 ++---
 sound/soc/codecs/rt5616.c  | 5 ++---
 sound/soc/codecs/wm8960.c  | 5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.7.4
