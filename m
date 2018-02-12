From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/uniphier 3/7] sound/soc/uniphier/aio-core.c:907:5:
 sparse: symbol 'aiodma_rb_get_rp' was not declared. Should it be static?
Date: Tue, 13 Feb 2018 01:53:10 +0800
Message-ID: <201802130150.A223WMAh%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: kbuild-all@01.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/uniphier
head:   db4cb3d04eba91db48da0032c44b83ed7185973c
commit: f37fe2f9987b0460f25a87b1380f8e97a5959121 [3/7] ASoC: uniphier: add support for UniPhier AIO common driver
reproduce:
        # apt-get install sparse
        git checkout f37fe2f9987b0460f25a87b1380f8e97a5959121
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/uniphier/aio-core.c:907:5: sparse: symbol 'aiodma_rb_get_rp' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
