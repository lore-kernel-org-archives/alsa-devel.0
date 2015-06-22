From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/gtm601 2/3]
 sound/soc/codecs/gtm601.c:86:4-9: No need to set .owner here. The core will
 do it.
Date: Mon, 22 Jun 2015 23:36:03 +0800
Message-ID: <201506222357.qkZddKc2%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FE5A265141
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 17:36:19 +0200 (CEST)
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
To: Marek Belisko <marek@goldelico.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/gtm601
head:   ac6e7c29ac12e1e285b0740bb671039ef436cf91
commit: 600a2b098a87843d44ab2f54fde9eda421946b38 [2/3] ASoC: Add gtm601 codec driver


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/codecs/gtm601.c:86:4-9: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
