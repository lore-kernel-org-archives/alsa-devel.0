From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/cs42l42 4/5]
 sound/soc/codecs/cs42l42.c:1972:3-8: No need to set .owner here. The core
 will do it.
Date: Thu, 10 Nov 2016 00:58:40 +0800
Message-ID: <201611100033.SRMoP0oO%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C1A352670BE
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 17:58:49 +0100 (CET)
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
To: James Schulman <james.schulman@cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/cs42l42
head:   da16c55793539a8c83c81240984915ce6d0140fe
commit: 2c394ca79604b404fe60218670ab301ecb758b34 [4/5] ASoC: Add support for CS42L42 codec


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/codecs/cs42l42.c:1972:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
