From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] ALSA/ASoC: fix after merging ASoC PR for
	v4.12-rc1
Date: Tue,  2 May 2017 22:32:59 +0900
Message-ID: <20170502133303.19622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 47EDB266B85
 for <alsa-devel@alsa-project.org>; Tue,  2 May 2017 15:33:08 +0200 (CEST)
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

This patchset is for current 'for-linus' remote branch[1], after merging
PR from ALSA SoC part for v4.12-rc1[2].

The first two patch includes bug fixes introduced at former kernel
releases, the rest is to suppress sparse.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?h=for-linus&id=a5c3b32a1146e44f6b38fdfdfffc27842953420c
[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2017-May/120308.html

Takashi Sakamoto (4):
  ASoC: codecs: da7213: fix invalid usage of bitwise operation in loop
    condition
  ASoC: codecs: msm8916: fix invalid cast to bool type
  ASoC: hisilicon: localize functions without external linkage
  ASoC: intel: atom: localize variable without external linkage

 sound/soc/codecs/da7213.c             | 14 +++++---------
 sound/soc/codecs/msm8916-wcd-analog.c |  6 +++---
 sound/soc/hisilicon/hi6210-i2s.c      | 11 ++++++-----
 sound/soc/intel/atom/sst/sst.c        |  2 +-
 4 files changed, 15 insertions(+), 18 deletions(-)

-- 
2.9.3
