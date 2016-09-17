From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH -next] ASoC: rt5663: fix sparse warnings
Date: Sat, 17 Sep 2016 10:45:18 +0800
Message-ID: <201609171011.E9z8MBt2%fengguang.wu@intel.com>
References: <1474076049-9416-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474076049-9416-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: kbuild-all@01.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Wei Yongjun <weiyongjun1@huawei.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Wei,

[auto build test WARNING on next-20160916]

url:    https://github.com/0day-ci/linux/commits/Wei-Yongjun/ASoC-rt5663-fix-sparse-warnings/20160917-094530


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/codecs/rt5663.c:3203:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
