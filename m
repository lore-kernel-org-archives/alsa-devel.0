From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/ak4458 1/2]
 sound/soc/codecs/ak4458.c:577:28: sparse: symbol 'ak4458_regmap' was not
 declared. Should it be static?
Date: Fri, 16 Feb 2018 21:55:27 +0800
Message-ID: <201802162144.qKMmP0uq%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A7601266FC9
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 14:55:50 +0100 (CET)
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
To: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Cc: alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>, Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, Mihai Serban <mihai.serban@nxp.com>
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/ak4458
head:   17e2304f0ad31d3f9bba4285b7024bf3c3626600
commit: 08660086eff9e9e69246a65ee48aba5c3901bf5e [1/2] ASoC: ak4458: Add support for AK4458 DAC driver
reproduce:
        # apt-get install sparse
        git checkout 08660086eff9e9e69246a65ee48aba5c3901bf5e
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/codecs/ak4458.c:577:28: sparse: symbol 'ak4458_regmap' was not declared. Should it be
>> sound/soc/codecs/ak4458.c:587:25: sparse: symbol 'ak4458_pm' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
