From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/adsp 1/4]
 sound/soc/codecs/wm_adsp.c:446:3: warning: format '%zx' expects argument of
 type 'size_t', but argument 4 has type 'unsigned int'
Date: Wed, 09 Jan 2013 02:18:51 +0800
Message-ID: <50ec630b.SBxzov8c2DbRhl+c%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id C28CF261654
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 19:21:54 +0100 (CET)
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
commit: aab034fe60460c0e352a64e94f2323edc12ff296 [1/4] ASoC: wm_adsp: Add support for parsing algorithms
config: make ARCH=x86_64 allmodconfig

All warnings:

sound/soc/codecs/wm_adsp.c: In function 'wm_adsp_setup_algs':
sound/soc/codecs/wm_adsp.c:446:3: warning: format '%zx' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat]

vim +446 sound/soc/codecs/wm_adsp.c

aab034fe Mark Brown 2012-10-26  430  	}
aab034fe Mark Brown 2012-10-26  431  
aab034fe Mark Brown 2012-10-26  432  	if (algs == 0) {
aab034fe Mark Brown 2012-10-26  433  		adsp_err(dsp, "No algorithms\n");
aab034fe Mark Brown 2012-10-26  434  		return -EINVAL;
aab034fe Mark Brown 2012-10-26  435  	}
aab034fe Mark Brown 2012-10-26  436  
aab034fe Mark Brown 2012-10-26  437  	/* Read the terminator first to validate the length */
aab034fe Mark Brown 2012-10-26  438  	ret = regmap_raw_read(regmap, mem->base + term, &val, sizeof(val));
aab034fe Mark Brown 2012-10-26  439  	if (ret != 0) {
aab034fe Mark Brown 2012-10-26  440  		adsp_err(dsp, "Failed to read algorithm list end: %d\n",
aab034fe Mark Brown 2012-10-26  441  			ret);
aab034fe Mark Brown 2012-10-26  442  		return ret;
aab034fe Mark Brown 2012-10-26  443  	}
aab034fe Mark Brown 2012-10-26  444  
aab034fe Mark Brown 2012-10-26  445  	if (be32_to_cpu(val) != 0xbedead)
aab034fe Mark Brown 2012-10-26 @446  		adsp_warn(dsp, "Algorithm list end %zx 0x%x != 0xbeadead\n",
aab034fe Mark Brown 2012-10-26  447  			  term, be32_to_cpu(val));
aab034fe Mark Brown 2012-10-26  448  
aab034fe Mark Brown 2012-10-26  449  	alg = kzalloc((term - pos) * 2, GFP_KERNEL);
aab034fe Mark Brown 2012-10-26  450  	if (!alg)
aab034fe Mark Brown 2012-10-26  451  		return -ENOMEM;
aab034fe Mark Brown 2012-10-26  452  
aab034fe Mark Brown 2012-10-26  453  	ret = regmap_raw_read(regmap, mem->base + pos, alg, (term - pos) * 2);
aab034fe Mark Brown 2012-10-26  454  	if (ret != 0) {

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
