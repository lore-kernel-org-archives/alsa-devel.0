From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:fix/topology 5/7]
 sound/soc/soc-topology.c:596:14: sparse: incorrect type in assignment
 (different base types)
Date: Fri, 7 Aug 2015 04:02:13 +0800
Message-ID: <201508070411.ljtMxHXo%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 36F8C2605CB
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2015 22:02:50 +0200 (CEST)
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
To: Mengdong Lin <mengdong.lin@intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git fix/topology
head:   c7bcf8777a539e64dafc7417c00047aee6eb8909
commit: 28a87eebcad40101b1b273cbd4f2a02c104f9367 [5/7] ASoC: topology: Update TLV support so we can support more TLV types
reproduce:
  # apt-get install sparse
  git checkout 28a87eebcad40101b1b273cbd4f2a02c104f9367
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   sound/soc/soc-topology.c:1696:45: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:190:28: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:191:39: sparse: incorrect type in return expression (different base types)
   sound/soc/soc-topology.c:191:39:    expected int
   sound/soc/soc-topology.c:191:39:    got restricted __le32 [usertype] reg
   sound/soc/soc-topology.c:203:28: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:204:39: sparse: incorrect type in return expression (different base types)
   sound/soc/soc-topology.c:204:39:    expected int
   sound/soc/soc-topology.c:204:39:    got restricted __le32 [usertype] shift
   sound/soc/soc-topology.c:228:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:228:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:228:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:228:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:228:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:228:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:228:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:228:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:248:20: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:248:20: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:248:20: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:248:20: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:248:20: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:248:20: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:248:20: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:519:42: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:521:42: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:523:42: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:534:61: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:536:61: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:538:62: sparse: restricted __le32 degrades to integer
>> sound/soc/soc-topology.c:596:14: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:596:14:    expected unsigned int [unsigned] <noident>
   sound/soc/soc-topology.c:596:14:    got restricted __le32 [usertype] min
   sound/soc/soc-topology.c:597:22: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:609:17: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:612:15: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:616:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:667:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:677:27: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:677:27:    expected unsigned int [unsigned] [addressable] [assigned] access
   sound/soc/soc-topology.c:677:27:    got restricted __le32 [usertype] access
   sound/soc/soc-topology.c:679:26: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:679:26:    expected int [signed] max
   sound/soc/soc-topology.c:679:26:    got restricted __le32 [usertype] max
   sound/soc/soc-topology.c:748:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:758:27: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:758:27:    expected unsigned int [unsigned] [addressable] [assigned] access
   sound/soc/soc-topology.c:758:27:    got restricted __le32 [usertype] access
   sound/soc/soc-topology.c:770:25: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:770:25:    expected int [signed] max
   sound/soc/soc-topology.c:770:25:    got restricted __le32 [usertype] max
   sound/soc/soc-topology.c:771:25: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:771:25:    expected int [signed] min
   sound/soc/soc-topology.c:771:25:    got restricted __le32 [usertype] min
   sound/soc/soc-topology.c:772:28: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:772:28:    expected unsigned int [unsigned] invert:1
   sound/soc/soc-topology.c:772:28:    got restricted __le32 [usertype] invert
   sound/soc/soc-topology.c:773:34: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:773:34:    expected int [signed] platform_max
   sound/soc/soc-topology.c:773:34:    got restricted __le32 [usertype] platform_max
   sound/soc/soc-topology.c:824:44: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:828:27: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:855:15: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:859:27: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:863:9: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:887:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:905:27: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:905:27:    expected unsigned int [unsigned] [addressable] [assigned] access
   sound/soc/soc-topology.c:905:27:    got restricted __le32 [usertype] access
   sound/soc/soc-topology.c:913:27: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:913:27:    expected unsigned int [unsigned] items
   sound/soc/soc-topology.c:913:27:    got restricted __le32 [usertype] items
   sound/soc/soc-topology.c:914:26: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:914:26:    expected unsigned int [unsigned] mask
   sound/soc/soc-topology.c:914:26:    got restricted __le32 [usertype] mask
   sound/soc/soc-topology.c:920:36: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:920:36: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:920:36: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:920:36: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:920:36: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:994:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:994:45: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1001:28: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1013:60: sparse: incorrect type in argument 3 (different base types)
   sound/soc/soc-topology.c:1013:60:    expected unsigned long [unsigned] [usertype] size
   sound/soc/soc-topology.c:1013:60:    got restricted __le32 [usertype] payload_size
   sound/soc/soc-topology.c:1020:59: sparse: incorrect type in argument 3 (different base types)
   sound/soc/soc-topology.c:1020:59:    expected unsigned long [unsigned] [usertype] size
   sound/soc/soc-topology.c:1020:59:    got restricted __le32 [usertype] payload_size
   sound/soc/soc-topology.c:1023:60: sparse: incorrect type in argument 3 (different base types)
   sound/soc/soc-topology.c:1023:60:    expected unsigned long [unsigned] [usertype] size
   sound/soc/soc-topology.c:1023:60:    got restricted __le32 [usertype] payload_size
   sound/soc/soc-topology.c:1005:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1005:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1005:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1005:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1005:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1005:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1005:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1005:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1005:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1005:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1005:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1005:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1005:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1040:24: sparse: incorrect type in initializer (different base types)
   sound/soc/soc-topology.c:1040:24:    expected int [signed] count
   sound/soc/soc-topology.c:1040:24:    got restricted __le32 [usertype] count
   sound/soc/soc-topology.c:1043:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1043:45: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1049:27: sparse: incorrect type in argument 4 (different base types)
   sound/soc/soc-topology.c:1049:27:    expected unsigned long [unsigned] [usertype] bytes
   sound/soc/soc-topology.c:1049:27:    got restricted __le32 [usertype] payload_size
   sound/soc/soc-topology.c:1107:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1120:30: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1120:30:    expected unsigned int [unsigned] access
   sound/soc/soc-topology.c:1120:30:    got restricted __le32 [usertype] access
   sound/soc/soc-topology.c:1132:25: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1132:25:    expected int [signed] max
   sound/soc/soc-topology.c:1132:25:    got restricted __le32 [usertype] max
   sound/soc/soc-topology.c:1133:25: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1133:25:    expected int [signed] min
   sound/soc/soc-topology.c:1133:25:    got restricted __le32 [usertype] min
   sound/soc/soc-topology.c:1134:28: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1134:28:    expected unsigned int [unsigned] invert:1
   sound/soc/soc-topology.c:1134:28:    got restricted __le32 [usertype] invert
   sound/soc/soc-topology.c:1135:34: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1135:34:    expected int [signed] platform_max
   sound/soc/soc-topology.c:1135:34:    got restricted __le32 [usertype] platform_max
   sound/soc/soc-topology.c:1179:25: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1200:20: sparse: incorrect type in assignment (different base types)

vim +596 sound/soc/soc-topology.c

   580		return 0;
   581	}
   582	
   583	
   584	static int soc_tplg_create_tlv_db_scale(struct soc_tplg *tplg,
   585		struct snd_kcontrol_new *kc, struct snd_soc_tplg_tlv_dbscale *scale)
   586	{
   587		unsigned int item_len = 2 * sizeof(unsigned int);
   588		unsigned int *p;
   589	
   590		p = kzalloc(item_len + 2 * sizeof(unsigned int), GFP_KERNEL);
   591		if (!p)
   592			return -ENOMEM;
   593	
   594		p[0] = SNDRV_CTL_TLVT_DB_SCALE;
   595		p[1] = item_len;
 > 596		p[2] = scale->min;
   597		p[3] = (scale->step & TLV_DB_SCALE_MASK)
   598				| (scale->mute ? TLV_DB_SCALE_MUTE : 0);
   599	
   600		kc->tlv.p = (void *)p;
   601		return 0;
   602	}
   603	
   604	static int soc_tplg_create_tlv(struct soc_tplg *tplg,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
