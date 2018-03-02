From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 2/2] ASoC: add tda7419 audio processor driver
Date: Sat, 3 Mar 2018 06:48:09 +0800
Message-ID: <201803030612.VHNIieNt%fengguang.wu@intel.com>
References: <20180227225128.17815-3-mporter@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180227225128.17815-3-mporter@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Porter <mporter@konsulko.com>
Cc: kbuild-all@01.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Matt,

I love your patch! Perhaps something to improve:

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.16-rc3 next-20180302]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matt-Porter/TDA7419-audio-processor-driver/20180303-042824
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/codecs/tda7419.c:151:9-10: WARNING: return of 0/1 in function 'tda7419_vol_is_stereo' with return type bool

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
