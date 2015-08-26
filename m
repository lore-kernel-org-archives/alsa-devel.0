From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/rockchip 2/4]
 sound/soc/rockchip/rockchip_rt5645.c:214:3-8: No need to set .owner here.
 The core will do it.
Date: Wed, 26 Aug 2015 19:48:13 +0800
Message-ID: <201508261911.CXlWEwle%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E47CF2655B6
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 13:49:35 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: zhengxing <zhengxing@rock-chips.com>
Cc: Dylan Reid <dgreid@chromium.org>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/rockchip
head:   f8ce20005d1694584448cd544be5fb32416a277c
commit: 86059653ea7ca7b30ed25d6bec5807ba59a4f2e6 [2/4] ASoC: rockchip: Add machine driver for rt5645/rt5650 codec


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/rockchip/rockchip_rt5645.c:214:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
