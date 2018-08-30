From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] ASoC: Add driver for PROTO Audio CODEC (with a
 WM8731)
Date: Thu, 30 Aug 2018 18:12:59 +0800
Message-ID: <201808301856.vMNJerSs%fengguang.wu@intel.com>
References: <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: kbuild-all@01.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org, alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, florian.meier@koalo.de, cristian.birsan@microchip.com
List-Id: alsa-devel@alsa-project.org

Hi Codrin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on at91/at91-next]
[also build test WARNING on v4.19-rc1 next-20180830]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Codrin-Ciubotariu/ASoC-Add-driver-for-PROTO-Audio-CODEC-with-a-WM8731/20180830-060610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git at91-next


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/atmel/mikroe-proto.c:178:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
