From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2 3/3] ASoC: tas6424: Allow disabling auto diagnostics
 for faster power-on
Date: Sat, 28 Apr 2018 17:21:22 +0800
Message-ID: <201804281505.b24ElkrY%fengguang.wu@intel.com>
References: <1524837349-16350-4-git-send-email-jjhiblot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524837349-16350-4-git-send-email-jjhiblot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, dannenberg@ti.com, afd@ti.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jean-Jacques Hiblot <jjhiblot@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Jean-Jacques,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.17-rc2 next-20180426]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jean-Jacques-Hiblot/ASoc-TAS6424-Add-support-for-mute-standby-and-faster-power-on/20180428-113427
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/codecs/tas6424.c:61:1: sparse: symbol 'diags_enum' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
