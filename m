From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/3] ASoC: pcm_native: Use
 'snd_pcm_format_t' type
Date: Mon, 7 May 2018 04:05:22 +0800
Message-ID: <201805070206.1JTd9zGM%fengguang.wu@intel.com>
References: <1525621665-11022-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 22A7E267338
 for <alsa-devel@alsa-project.org>; Sun,  6 May 2018 22:05:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1525621665-11022-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, broonie@kernel.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

I love your patch! Perhaps something to improve:

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.17-rc3 next-20180504]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Fabio-Estevam/ASoC-pcm_native-Use-snd_pcm_format_t-type/20180506-235347
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   sound/core/pcm_native.c:561:51: sparse: incorrect type in assignment (different base types) @@    expected restricted snd_pcm_state_t [usertype] state @@    got t [usertype] state @@
   sound/core/pcm_native.c:561:51:    expected restricted snd_pcm_state_t [usertype] state
   sound/core/pcm_native.c:561:51:    got int [signed] state
   sound/core/pcm_native.c:726:38: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:726:38:    expected int [signed] state
   sound/core/pcm_native.c:726:38:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:738:38: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:738:38:    expected int [signed] state
   sound/core/pcm_native.c:738:38:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:787:38: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:787:38:    expected int [signed] state
   sound/core/pcm_native.c:787:38:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1197:32: sparse: incorrect type in assignment (different base types) @@    expected restricted snd_pcm_state_t [usertype] state @@    got t [usertype] state @@
   sound/core/pcm_native.c:1197:32:    expected restricted snd_pcm_state_t [usertype] state
   sound/core/pcm_native.c:1197:32:    got int [signed] state
   sound/core/pcm_native.c:1221:31: sparse: incorrect type in argument 3 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:1221:31:    expected int [signed] state
   sound/core/pcm_native.c:1221:31:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1228:40: sparse: incorrect type in argument 3 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:1228:40:    expected int [signed] state
   sound/core/pcm_native.c:1228:40:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1254:28: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1256:40: sparse: incorrect type in assignment (different base types) @@    expected restricted snd_pcm_state_t [usertype] state @@    got t [usertype] state @@
   sound/core/pcm_native.c:1256:40:    expected restricted snd_pcm_state_t [usertype] state
   sound/core/pcm_native.c:1256:40:    got int [signed] state
   sound/core/pcm_native.c:1280:64: sparse: incorrect type in argument 3 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:1280:64:    expected int [signed] state
   sound/core/pcm_native.c:1280:64:    got restricted snd_pcm_state_t [usertype] state
   sound/core/pcm_native.c:1296:38: sparse: incorrect type in argument 3 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:1296:38:    expected int [signed] state
   sound/core/pcm_native.c:1296:38:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1655:38: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:1655:38:    expected int [signed] state
   sound/core/pcm_native.c:1655:38:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1721:61: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:1721:61:    expected int [signed] state
   sound/core/pcm_native.c:1721:61:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1722:63: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:1722:63:    expected int [signed] state
   sound/core/pcm_native.c:1722:63:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1739:76: sparse: incorrect type in initializer (different base types) @@    expected int [signed] new_state @@    got restricted snint [signed] new_state @@
   sound/core/pcm_native.c:1739:76:    expected int [signed] new_state
   sound/core/pcm_native.c:1739:76:    got restricted snd_pcm_state_t
   sound/core/pcm_native.c:1842:40: sparse: expression using sizeof(void)
   sound/core/pcm_native.c:1842:40: sparse: expression using sizeof(void)
   sound/core/pcm_native.c:2060:42: sparse: restricted snd_pcm_format_t degrades to integer
   sound/core/pcm_native.c:2060:47: sparse: restricted snd_pcm_format_t degrades to integer
>> sound/core/pcm_native.c:2062:43: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned int [unsigned] val @@    got restricted snd_pcm_format_unsigned int [unsigned] val @@
   sound/core/pcm_native.c:2062:43:    expected unsigned int [unsigned] val
   sound/core/pcm_native.c:2062:43:    got restricted snd_pcm_format_t [assigned] [usertype] k
   sound/core/pcm_native.c:2068:44: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned int [unsigned] val @@    got restricted snd_pcm_format_unsigned int [unsigned] val @@
   sound/core/pcm_native.c:2068:44:    expected unsigned int [unsigned] val
   sound/core/pcm_native.c:2068:44:    got restricted snd_pcm_format_t [assigned] [usertype] k
   sound/core/pcm_native.c:2060:70: sparse: restricted snd_pcm_format_t degrades to integer
   sound/core/pcm_native.c:2082:42: sparse: restricted snd_pcm_format_t degrades to integer
   sound/core/pcm_native.c:2082:47: sparse: restricted snd_pcm_format_t degrades to integer
   sound/core/pcm_native.c:2084:87: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned int [unsigned] val @@    got restricted snd_pcm_format_unsigned int [unsigned] val @@
   sound/core/pcm_native.c:2084:87:    expected unsigned int [unsigned] val
   sound/core/pcm_native.c:2084:87:    got restricted snd_pcm_format_t [assigned] [usertype] k
   sound/core/pcm_native.c:2082:70: sparse: restricted snd_pcm_format_t degrades to integer
   sound/core/pcm_native.c:2266:30: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2268:30: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2271:38: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2273:38: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2275:38: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2285:86: sparse: restricted snd_pcm_subformat_t degrades to integer
   include/sound/pcm.h:1092:47: sparse: cast removes address space of expression
   include/sound/pcm.h:1099:47: sparse: cast removes address space of expression
   include/sound/pcm.h:1099:47: sparse: cast removes address space of expression
   include/sound/pcm.h:1092:47: sparse: cast removes address space of expression
   sound/core/pcm_compat.c:232:13: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [explicitly-signed] __pu_val @@    got restricted snd_pcm_statsigned int [signed] [explicitly-signed] __pu_val @@
   sound/core/pcm_compat.c:232:13:    expected signed int [signed] [explicitly-signed] __pu_val
   sound/core/pcm_compat.c:232:13:    got restricted snd_pcm_state_t [addressable] [assigned] [usertype] state
   sound/core/pcm_compat.c:241:13: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [explicitly-signed] __pu_val @@    got restricted snd_pcm_statsigned int [signed] [explicitly-signed] __pu_val @@
   sound/core/pcm_compat.c:241:13:    expected signed int [signed] [explicitly-signed] __pu_val
   sound/core/pcm_compat.c:241:13:    got restricted snd_pcm_state_t [addressable] [assigned] [usertype] suspended_state
   sound/core/pcm_compat.c:296:13: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [explicitly-signed] __pu_val @@    got restricted snd_pcm_statsigned int [signed] [explicitly-signed] __pu_val @@
   sound/core/pcm_compat.c:296:13:    expected signed int [signed] [explicitly-signed] __pu_val
   sound/core/pcm_compat.c:296:13:    got restricted snd_pcm_state_t [addressable] [assigned] [usertype] state
   sound/core/pcm_compat.c:305:13: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [explicitly-signed] __pu_val @@    got restricted snd_pcm_statsigned int [signed] [explicitly-signed] __pu_val @@
   sound/core/pcm_compat.c:305:13:    expected signed int [signed] [explicitly-signed] __pu_val
   sound/core/pcm_compat.c:305:13:    got restricted snd_pcm_state_t [addressable] [assigned] [usertype] suspended_state
   include/sound/pcm.h:1092:47: sparse: cast removes address space of expression
   include/sound/pcm.h:1099:47: sparse: cast removes address space of expression
   sound/core/pcm_compat.c:529:13: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [explicitly-signed] __pu_val @@    got restrictesigned int [signed] [explicitly-signed] __pu_val @@
   sound/core/pcm_compat.c:529:13:    expected signed int [signed] [explicitly-signed] __pu_val
   sound/core/pcm_compat.c:529:13:    got restricted snd_pcm_state_t [assigned] [usertype] state
   sound/core/pcm_compat.c:532:13: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [explicitly-signed] __pu_val @@    got restrictesigned int [signed] [explicitly-signed] __pu_val @@
   sound/core/pcm_compat.c:532:13:    expected signed int [signed] [explicitly-signed] __pu_val
   sound/core/pcm_compat.c:532:13:    got restricted snd_pcm_state_t [assigned] [usertype] suspended_state
   sound/core/pcm_compat.c:618:13: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [explicitly-signed] __pu_val @@    got restrictesigned int [signed] [explicitly-signed] __pu_val @@
   sound/core/pcm_compat.c:618:13:    expected signed int [signed] [explicitly-signed] __pu_val
   sound/core/pcm_compat.c:618:13:    got restricted snd_pcm_state_t [assigned] [usertype] state
   sound/core/pcm_compat.c:621:13: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [explicitly-signed] __pu_val @@    got restrictesigned int [signed] [explicitly-signed] __pu_val @@
   sound/core/pcm_compat.c:621:13:    expected signed int [signed] [explicitly-signed] __pu_val
   sound/core/pcm_compat.c:621:13:    got restricted snd_pcm_state_t [assigned] [usertype] suspended_state
   sound/core/pcm_native.c:112:9: sparse: context imbalance in 'snd_pcm_stream_lock' - different lock contexts for basic block
   sound/core/pcm_native.c:134:28: sparse: context imbalance in 'snd_pcm_stream_unlock' - unexpected unlock
   sound/core/pcm_native.c:1068:52: sparse: context imbalance in 'snd_pcm_action_group' - unexpected unlock

vim +2062 sound/core/pcm_native.c

^1da177e Linus Torvalds   2005-04-16  2050  
877211f5 Takashi Iwai     2005-11-17  2051  static int snd_pcm_hw_rule_format(struct snd_pcm_hw_params *params,
877211f5 Takashi Iwai     2005-11-17  2052  				  struct snd_pcm_hw_rule *rule)
^1da177e Linus Torvalds   2005-04-16  2053  {
9f3c49af Fabio Estevam    2018-05-06  2054  	snd_pcm_format_t k;
b55f9fdc Takashi Sakamoto 2017-05-17  2055  	const struct snd_interval *i =
b55f9fdc Takashi Sakamoto 2017-05-17  2056  				hw_param_interval_c(params, rule->deps[0]);
877211f5 Takashi Iwai     2005-11-17  2057  	struct snd_mask m;
877211f5 Takashi Iwai     2005-11-17  2058  	struct snd_mask *mask = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
^1da177e Linus Torvalds   2005-04-16  2059  	snd_mask_any(&m);
9f3c49af Fabio Estevam    2018-05-06  2060  	for (k = SNDRV_PCM_FORMAT_FIRST; k <= SNDRV_PCM_FORMAT_LAST; ++k) {
^1da177e Linus Torvalds   2005-04-16  2061  		int bits;
^1da177e Linus Torvalds   2005-04-16 @2062  		if (! snd_mask_test(mask, k))
^1da177e Linus Torvalds   2005-04-16  2063  			continue;
^1da177e Linus Torvalds   2005-04-16  2064  		bits = snd_pcm_format_physical_width(k);
^1da177e Linus Torvalds   2005-04-16  2065  		if (bits <= 0)
^1da177e Linus Torvalds   2005-04-16  2066  			continue; /* ignore invalid formats */
^1da177e Linus Torvalds   2005-04-16  2067  		if ((unsigned)bits < i->min || (unsigned)bits > i->max)
^1da177e Linus Torvalds   2005-04-16  2068  			snd_mask_reset(&m, k);
^1da177e Linus Torvalds   2005-04-16  2069  	}
^1da177e Linus Torvalds   2005-04-16  2070  	return snd_mask_refine(mask, &m);
^1da177e Linus Torvalds   2005-04-16  2071  }
^1da177e Linus Torvalds   2005-04-16  2072  

:::::: The code at line 2062 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
