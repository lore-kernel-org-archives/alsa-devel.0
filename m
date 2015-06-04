From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/zx 2/8]
 sound/soc/zte/zx296702-i2s.c:428:3-8: No need to set .owner here. The core
 will do it.
Date: Fri, 5 Jun 2015 01:11:26 +0800
Message-ID: <201506050116.40gO5c34%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F22A26061E
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 19:12:22 +0200 (CEST)
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
To: Jun Nie <jun.nie@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/zx
head:   69ccc50231eca9a57dc06a5514103c0f17ef402e
commit: e5d4cd87800ce12c356e7eb571e565e839ab3a90 [2/8] ASoC: zx: Add ZTE zx296702 I2S DAI driver


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/zte/zx296702-i2s.c:428:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
