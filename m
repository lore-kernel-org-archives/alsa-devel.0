From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/simple 1/1] sound/soc/soc-core.c:3306:47:
 sparse: incorrect type in argument 1 (different base types)
Date: Thu, 17 Sep 2015 05:03:59 +0800
Message-ID: <201509170552.H0qeDD9q%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 417DA261A8C
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 23:04:42 +0200 (CEST)
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
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/simple
head:   6131084a0bc966107021d8c89489f9cd1663b902
commit: 6131084a0bc966107021d8c89489f9cd1663b902 [1/1] ASoC: simple-card: Add tdm slot mask support to simple-card
reproduce:
  # apt-get install sparse
  git checkout 6131084a0bc966107021d8c89489f9cd1663b902
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/soc-core.c:3306:47: sparse: incorrect type in argument 1 (different base types)
   sound/soc/soc-core.c:3306:47:    expected restricted __be32 const [usertype] *p
   sound/soc/soc-core.c:3306:47:    got unsigned int const [usertype] *

vim +3306 sound/soc/soc-core.c

  3290		return 0;
  3291	}
  3292	EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_simple_widgets);
  3293	
  3294	static int snd_soc_of_get_slot_mask(struct device_node *np,
  3295					    const char *prop_name,
  3296					    unsigned int *mask)
  3297	{
  3298		u32 val;
  3299		const u32 *of_slot_mask = of_get_property(np, prop_name, &val);
  3300		int i;
  3301	
  3302		if (!of_slot_mask)
  3303			return 0;
  3304		val /= sizeof(u32);
  3305		for (i = 0; i < val; i++)
> 3306			if (be32_to_cpup(&of_slot_mask[i]))
  3307				*mask |= (1 << i);
  3308	
  3309		return val;
  3310	}
  3311	
  3312	int snd_soc_of_parse_tdm_slot(struct device_node *np,
  3313				      unsigned int *tx_mask,
  3314				      unsigned int *rx_mask,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
