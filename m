From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] ASoC: Add max98926 codec driver
Date: Wed, 2 Dec 2015 03:23:33 +0800
Message-ID: <201512020319.lxuzp62p%fengguang.wu@intel.com>
References: <1448994679-7387-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E561261ADA
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 20:24:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1448994679-7387-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, kbuild-all@01.org, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi anish,

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.4-rc3 next-20151127]

url:    https://github.com/0day-ci/linux/commits/anish-kumar/ASoC-Add-max98926-codec-driver/20151202-023631
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/codecs/max98926.c:587:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
