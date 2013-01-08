From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/adsp 4/4]
 sound/soc/codecs/wm_adsp.c:664:8: warning: assignment discards 'const'
 qualifier from pointer target type
Date: Wed, 09 Jan 2013 02:23:14 +0800
Message-ID: <50ec6412.AxfDprE3AWpg4QEx%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 337CA26167D
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 19:26:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/adsp
head:   25326bb263894a528288716901bd434372927844
commit: 25326bb263894a528288716901bd434372927844 [4/4] ASoC: wm_adsp: Implement support for algorithm-specific coefficient blocks
config: make ARCH=x86_64 allmodconfig

All warnings:

sound/soc/codecs/wm_adsp.c: In function 'wm_adsp_setup_algs':
sound/soc/codecs/wm_adsp.c:465:3: warning: format '%d' expects argument of type 'int', but argument 4 has type 'size_t' [-Wformat]
sound/soc/codecs/wm_adsp.c:480:3: warning: format '%zx' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat]
sound/soc/codecs/wm_adsp.c: In function 'wm_adsp_load_coeff':
sound/soc/codecs/wm_adsp.c:664:8: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]

vim +/const +664 sound/soc/codecs/wm_adsp.c

2159ad93 Mark Brown 2012-10-11  648  		case WMFW_NAME_TEXT:
2159ad93 Mark Brown 2012-10-11  649  		case WMFW_INFO_TEXT:
2159ad93 Mark Brown 2012-10-11  650  			break;
2159ad93 Mark Brown 2012-10-11  651  		case WMFW_ABSOLUTE:
2159ad93 Mark Brown 2012-10-11  652  			region_name = "register";
2159ad93 Mark Brown 2012-10-11  653  			reg = offset;
2159ad93 Mark Brown 2012-10-11  654  			break;
25326bb2 Mark Brown 2013-01-08  655  
25326bb2 Mark Brown 2013-01-08  656  		case WMFW_ADSP1_DM:
25326bb2 Mark Brown 2013-01-08  657  		case WMFW_ADSP1_ZM:
25326bb2 Mark Brown 2013-01-08  658  		case WMFW_ADSP2_XM:
25326bb2 Mark Brown 2013-01-08  659  		case WMFW_ADSP2_YM:
25326bb2 Mark Brown 2013-01-08  660  			adsp_dbg(dsp, "%s.%d: %d bytes in %x for %x\n",
25326bb2 Mark Brown 2013-01-08  661  				 file, blocks, le32_to_cpu(blk->len),
25326bb2 Mark Brown 2013-01-08  662  				 type, le32_to_cpu(blk->id));
25326bb2 Mark Brown 2013-01-08  663  
25326bb2 Mark Brown 2013-01-08 @664  			mem = wm_adsp_find_region(dsp, type);
25326bb2 Mark Brown 2013-01-08  665  			if (!mem) {
25326bb2 Mark Brown 2013-01-08  666  				adsp_err(dsp, "No base for region %x\n", type);
25326bb2 Mark Brown 2013-01-08  667  				break;
25326bb2 Mark Brown 2013-01-08  668  			}
25326bb2 Mark Brown 2013-01-08  669  
25326bb2 Mark Brown 2013-01-08  670  			reg = 0;
25326bb2 Mark Brown 2013-01-08  671  			list_for_each_entry(alg_region,
25326bb2 Mark Brown 2013-01-08  672  					    &dsp->alg_regions, list) {

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
