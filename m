From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake - Add Skylake RT286
 I2S machine driver
Date: Fri, 9 Oct 2015 22:08:34 +0800
Message-ID: <201510092204.E2j1aR9a%fengguang.wu@intel.com>
References: <1444392297-17313-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EE4D2606E9
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 16:10:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1444392297-17313-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Omair M Abdullah <omair.m.abdullah@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, kbuild-all@01.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Omair,

[auto build test WARNING on next-20151009 -- if it's inappropriate base, please ignore]

reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/intel/skylake/skl-sst-cldma.c:48:24: sparse: incorrect type in assignment (different base types)
   sound/soc/intel/skylake/skl-sst-cldma.c:48:24:    expected unsigned int [unsigned] [usertype] <noident>
   sound/soc/intel/skylake/skl-sst-cldma.c:48:24:    got restricted __le32 [usertype] <noident>
   sound/soc/intel/skylake/skl-sst-cldma.c:49:24: sparse: incorrect type in assignment (different base types)
   sound/soc/intel/skylake/skl-sst-cldma.c:49:24:    expected unsigned int [unsigned] [usertype] <noident>
   sound/soc/intel/skylake/skl-sst-cldma.c:49:24:    got restricted __le32 [usertype] <noident>
   sound/soc/intel/skylake/skl-sst-cldma.c:51:24: sparse: incorrect type in assignment (different base types)
   sound/soc/intel/skylake/skl-sst-cldma.c:51:24:    expected unsigned int [unsigned] [usertype] <noident>
   sound/soc/intel/skylake/skl-sst-cldma.c:51:24:    got restricted __le32 [usertype] <noident>
>> sound/soc/intel/skylake/skl-sst-cldma.c:54:24: sparse: incorrect type in assignment (different base types)
   sound/soc/intel/skylake/skl-sst-cldma.c:54:24:    expected unsigned int [unsigned] [usertype] <noident>
   sound/soc/intel/skylake/skl-sst-cldma.c:54:24:    got restricted __le32

vim +48 sound/soc/intel/skylake/skl-sst-cldma.c

914426c8 Vinod Koul 2015-07-10  42  
914426c8 Vinod Koul 2015-07-10  43  	ctx->cl_dev.frags = 0;
914426c8 Vinod Koul 2015-07-10  44  	while (size > 0) {
914426c8 Vinod Koul 2015-07-10  45  		phys_addr_t addr = virt_to_phys(dmab_data->area +
914426c8 Vinod Koul 2015-07-10  46  				(ctx->cl_dev.frags * ctx->cl_dev.bufsize));
914426c8 Vinod Koul 2015-07-10  47  
914426c8 Vinod Koul 2015-07-10 @48  		bdl[0] = cpu_to_le32(lower_32_bits(addr));
914426c8 Vinod Koul 2015-07-10  49  		bdl[1] = cpu_to_le32(upper_32_bits(addr));
914426c8 Vinod Koul 2015-07-10  50  
914426c8 Vinod Koul 2015-07-10  51  		bdl[2] = cpu_to_le32(ctx->cl_dev.bufsize);
914426c8 Vinod Koul 2015-07-10  52  
914426c8 Vinod Koul 2015-07-10  53  		size -= ctx->cl_dev.bufsize;
914426c8 Vinod Koul 2015-07-10 @54  		bdl[3] = (size || !with_ioc) ? 0 : cpu_to_le32(0x01);
914426c8 Vinod Koul 2015-07-10  55  
914426c8 Vinod Koul 2015-07-10  56  		bdl += 4;
914426c8 Vinod Koul 2015-07-10  57  		ctx->cl_dev.frags++;

:::::: The code at line 48 was first introduced by commit
:::::: 914426c8657c1e934b015ffa32e7bfd0cb34f47f ASoC: Intel: Skylake: add code loader DMA operations

:::::: TO: Vinod Koul <vinod.koul@intel.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
