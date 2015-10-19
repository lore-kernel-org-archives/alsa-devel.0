From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/3] mfd: arizona: Support Cirrus Logic CS47L24 and WM1831
Date: Mon, 19 Oct 2015 21:53:27 +0800
Message-ID: <201510192134.3BJpW7bK%fengguang.wu@intel.com>
References: <1445257885-16989-2-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445257885-16989-2-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: kbuild-all@01.org, lee.jones@linaro.org, linus.walleij@linaro.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Richard,

[auto build test WARNING on next-20151016 -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Richard-Fitzgerald/Add-support-for-Cirrus-Logic-CS47L24-and-WM1831-codecs/20151019-203503
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/mfd/cs47l24-tables.c:33:38: sparse: incorrect type in argument 2 (different base types)
   drivers/mfd/cs47l24-tables.c:33:38:    expected struct reg_sequence const *regs
   drivers/mfd/cs47l24-tables.c:33:38:    got struct reg_default static const [toplevel] *<noident>
   drivers/mfd/cs47l24-tables.c: In function 'cs47l24_patch':
   drivers/mfd/cs47l24-tables.c:33:10: warning: passing argument 2 of 'regmap_register_patch' from incompatible pointer type [-Wincompatible-pointer-types]
             cs47l24_reva_patch,
             ^
   In file included from include/linux/mfd/arizona/core.h:17:0,
                    from drivers/mfd/cs47l24-tables.c:15:
   include/linux/regmap.h:726:5: note: expected 'const struct reg_sequence *' but argument is of type 'const struct reg_default *'
    int regmap_register_patch(struct regmap *map, const struct reg_sequence *regs,
        ^

vim +33 drivers/mfd/cs47l24-tables.c

    17	#include <linux/device.h>
    18	
    19	#include "arizona.h"
    20	
    21	#define CS47L24_NUM_ISR 5
    22	
    23	static const struct reg_default cs47l24_reva_patch[] = {
    24		{ 0x80,  0x3 },
    25		{ 0x27C, 0x0010 },
    26		{ 0x221, 0x0070 },
    27		{ 0x80,  0x0 },
    28	};
    29	
    30	int cs47l24_patch(struct arizona *arizona)
    31	{
    32		return regmap_register_patch(arizona->regmap,
  > 33					     cs47l24_reva_patch,
    34					     ARRAY_SIZE(cs47l24_reva_patch));
    35	}
    36	EXPORT_SYMBOL_GPL(cs47l24_patch);
    37	
    38	static const struct regmap_irq cs47l24_irqs[ARIZONA_NUM_IRQ] = {
    39		[ARIZONA_IRQ_GP2] = { .reg_offset = 0, .mask = ARIZONA_GP2_EINT1 },
    40		[ARIZONA_IRQ_GP1] = { .reg_offset = 0, .mask = ARIZONA_GP1_EINT1 },
    41	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
