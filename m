From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/gtm601 2/3] sound/soc/codecs/gtm601.c:36:27: sparse:
 symbol 'gtm601_dai' was not declared. Should it be static?
Date: Mon, 22 Jun 2015 23:48:25 +0800
Message-ID: <201506222333.SOsGGlVC%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: kbuild-all@01.org, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/gtm601
head:   ac6e7c29ac12e1e285b0740bb671039ef436cf91
commit: 600a2b098a87843d44ab2f54fde9eda421946b38 [2/3] ASoC: Add gtm601 codec driver
reproduce:
  # apt-get install sparse
  git checkout 600a2b098a87843d44ab2f54fde9eda421946b38
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/codecs/gtm601.c:36:27: sparse: symbol 'gtm601_dai' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
