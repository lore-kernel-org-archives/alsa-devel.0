From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:for-next 462/535]
 sound/soc/codecs/da7219.c:1777:22: sparse: symbol 'da7219_dai_clks_ops' was
 not declared. Should it be static?
Date: Tue, 13 Mar 2018 16:14:00 +0800
Message-ID: <201803131627.neUkQAuZ%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C2D126718B
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 09:14:07 +0100 (CET)
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
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
head:   27f6213507962a2c754d7dff7c25515e09e31752
commit: fc8f7ea2d6c074baaad202c9187962bfa493ef13 [462/535] ASoC: da7219: Add common clock usage for providing DAI clks
reproduce:
        # apt-get install sparse
        git checkout fc8f7ea2d6c074baaad202c9187962bfa493ef13
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   sound/soc/codecs/da7219.c:440:44: sparse: cast to restricted __le16
   sound/soc/codecs/da7219.c:461:13: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [usertype] val @@    got  short [unsigned] [usertype] val @@
   sound/soc/codecs/da7219.c:461:13:    expected unsigned short [unsigned] [usertype] val
   sound/soc/codecs/da7219.c:461:13:    got restricted __le16 [usertype] <noident>
   sound/soc/codecs/da7219.c:817:57: sparse: dubious: x & !y
   sound/soc/codecs/da7219.c:1427:16: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [usertype] offset @@    got  short [unsigned] [usertype] offset @@
   sound/soc/codecs/da7219.c:1427:16:    expected unsigned short [unsigned] [usertype] offset
   sound/soc/codecs/da7219.c:1427:16:    got restricted __le16 [usertype] <noident>
>> sound/soc/codecs/da7219.c:1777:22: sparse: symbol 'da7219_dai_clks_ops' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
