From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/intel 19/26]
 sound/soc/intel/skylake/skl-topology.c:480:24-30: ERROR: application of
 sizeof to pointer
Date: Tue, 2 Aug 2016 09:07:13 +0800
Message-ID: <201608020904.SqvBJ6e2%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B580266011
 for <alsa-devel@alsa-project.org>; Tue,  2 Aug 2016 03:08:06 +0200 (CEST)
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
To: Vinod Koul <vinod.koul@intel.com>
Cc: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/intel
head:   b1f89b197b3f7360239fc2120755252cead4e572
commit: 7c617ec3e8f6b614e63ea9c82ce2ea39e7daf579 [19/26] ASoC: Intel: Skylake: Move modules query to runtime


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/intel/skylake/skl-topology.c:480:24-30: ERROR: application of sizeof to pointer

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
