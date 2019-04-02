From: kbuild test robot <lkp@intel.com>
Subject: [asoc:for-5.2 98/99] sound/soc/codecs/tlv320aic31xx.c:1267:5:
 sparse: symbol 'aic31xx_set_jack' was not declared. Should it be static?
Date: Tue, 2 Apr 2019 19:46:16 +0800
Message-ID: <201904021912.ym8zWPD9%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: kbuild-all@01.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, Colin Ian King <colin.king@canonical.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2
head:   90f0202bf2e15e8933a550b7dfd439b500a76e1c
commit: ebf3326cd96989a498892a1b344faee3110f7877 [98/99] ASoC: tlv320aic31xx: Add headphone/headset detection
reproduce:
        # apt-get install sparse
        git checkout ebf3326cd96989a498892a1b344faee3110f7877
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

>> sound/soc/codecs/tlv320aic31xx.c:1267:5: sparse: symbol 'aic31xx_set_jack' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
