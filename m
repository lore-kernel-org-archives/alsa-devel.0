From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3 2/2] ASOC: sunxi: Add support for the SPDIF block
Date: Wed, 3 Feb 2016 00:01:14 +0800
Message-ID: <201602022350.vGAUirEB%fengguang.wu@intel.com>
References: <1454424594-25208-3-git-send-email-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454424594-25208-3-git-send-email-codekipper@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, maxime.ripard@free-electrons.com, linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, be17068@iperbole.bo.it, Marcus Cooper <codekipper@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Marcus,

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.5-rc2 next-20160201]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/codekipper-gmail-com/Add-SPDIF-support-for-Allwinner-SoCs/20160202-225229
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/sunxi/sun4i-spdif.c:572:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
