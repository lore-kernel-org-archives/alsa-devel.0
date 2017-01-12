From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/rt5659 25/26]
 sound/soc/codecs/rt5659.c:4236:3-8: No need to set .owner here. The core
 will do it.
Date: Fri, 13 Jan 2017 02:04:06 +0800
Message-ID: <201701130203.Mo7fnvyJ%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 21158266569
 for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2017 19:04:33 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/rt5659
head:   eae39b5f4269260d5d8b35133ba0f4c5e2895b71
commit: 0230f088adcf537a60df9d80dce5b71059946dfe [25/26] ASoC: rt5659: declare rt5659_i2c_driver static


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/codecs/rt5659.c:4236:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
