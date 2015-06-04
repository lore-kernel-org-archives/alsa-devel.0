From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/zx 2/4] sound/soc/zte/zx296702-i2s.c:358:27: sparse:
 symbol 'zx_i2s_dai' was not declared. Should it be static?
Date: Thu, 4 Jun 2015 21:00:50 +0800
Message-ID: <201506042120.M9liQXGN%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Nie <jun.nie@linaro.org>
Cc: kbuild-all@01.org, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/zx
head:   dc772a4cf76113d7269e4fb1c45e5d85c0cf458e
commit: e5d4cd87800ce12c356e7eb571e565e839ab3a90 [2/4] ASoC: zx: Add ZTE zx296702 I2S DAI driver
reproduce:
  # apt-get install sparse
  git checkout e5d4cd87800ce12c356e7eb571e565e839ab3a90
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/zte/zx296702-i2s.c:358:27: sparse: symbol 'zx_i2s_dai' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
