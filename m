From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/sunxi 2/2]
 sound/soc/sunxi/sun4i-codec.c:708:3-8: No need to set .owner here. The core
 will do it.
Date: Thu, 17 Sep 2015 04:55:55 +0800
Message-ID: <201509170447.vzyqPoy7%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DAB632616EF
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 22:57:20 +0200 (CEST)
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
To: Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/sunxi
head:   45fb6b6f2aa3f6b22b81078db0dba4b26c9d0bdb
commit: 45fb6b6f2aa3f6b22b81078db0dba4b26c9d0bdb [2/2] ASoC: sunxi: add support for the on-chip codec on early Allwinner SoCs


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/sunxi/sun4i-codec.c:708:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
