From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] ASoC: dpcm: improve runtime update
	predictability
Date: Mon, 25 Jun 2018 21:39:29 +0800
Message-ID: <201806251940.hnjUV4rz%fengguang.wu@intel.com>
References: <20180625082923.25636-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C883426720C
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 15:40:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180625082923.25636-1-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Hi Jerome,

I love your patch! Perhaps something to improve:

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.18-rc2 next-20180625]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jerome-Brunet/ASoC-dpcm-improve-runtime-update-predictability/20180625-172002
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   sound/soc/soc-pcm.c:357:32: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:357:32: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:367:32: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:367:32: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:417:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:417:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:418:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:418:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:419:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:419:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:420:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:420:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:435:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:435:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:436:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:436:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:445:24: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:445:24: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:446:24: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:446:24: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:447:24: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:447:24: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:448:24: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:448:24: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1194:39: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1194:39: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1750:41: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1750:41: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1752:41: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1752:41: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1774:36: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1774:36: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1775:36: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1775:36: sparse: expression using sizeof(void)
>> sound/soc/soc-pcm.c:2600:5: sparse: symbol 'soc_dpcm_fe_runtime_update' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
