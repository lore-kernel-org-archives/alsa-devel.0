From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/max98925 1/1] sound/soc/codecs/max98925.c:189:1: sparse:
 symbol 'max98925_spk_tlv' was not declared. Should it be static?
Date: Thu, 12 Mar 2015 03:05:44 +0800
Message-ID: <201503120256.08LBzgQA%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Anish Kumar <yesanishhere@gmail.com>
Cc: kbuild-all@01.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/max98925
head:   31bdf73603f61a22c1643d1d887cf36eaa3a6834
commit: 31bdf73603f61a22c1643d1d887cf36eaa3a6834 [1/1] ASoC: Add max98925 codec driver
reproduce:
  # apt-get install sparse
  git checkout 31bdf73603f61a22c1643d1d887cf36eaa3a6834
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/codecs/max98925.c:189:1: sparse: symbol 'max98925_spk_tlv' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
