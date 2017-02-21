From: kbuild test robot <lkp@intel.com>
Subject: Re: [alsa_devel] [PATCH v3 2/2] ASoC: Add driver
 support fro Conexant CX2092X DSP
Date: Wed, 22 Feb 2017 01:44:01 +0800
Message-ID: <201702220127.8Yf496qG%fengguang.wu@intel.com>
References: <4a4e60530c00c33f554b8157c2afa0a57362c0bc.1487684248.git.simon.ho@conexant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 14478266DA9
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 18:44:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4a4e60530c00c33f554b8157c2afa0a57362c0bc.1487684248.git.simon.ho@conexant.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: simon.ho.cnxt@gmail.com
Cc: alsa-devel@alsa-project.org, Simon Ho <simon.ho@conexant.com>, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

Hi Simon,

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.10 next-20170220]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/simon-ho-cnxt-gmail-com/ASoC-add-driver-support-for-Conexant-CX2092X-DSP/20170221-235253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/codecs/cx2092x-i2c.c:43:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
