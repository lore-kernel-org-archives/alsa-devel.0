From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/adsp 3/4]
 sound/soc/codecs/wm_adsp.c:464:3: warning: format '%d' expects argument of
 type 'int', but argument 4 has type 'size_t'
Date: Wed, 09 Jan 2013 02:21:07 +0800
Message-ID: <50ec6393.+AiDak6TVO8OHHW0%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 63EAF26167D
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 19:24:09 +0100 (CET)
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
commit: 7265971f1bda27fdf97a19db3608ae15e2cdc7d2 [3/4] ASoC: wm_asdp: Validate sanity of algorithm count
config: make ARCH=x86_64 allmodconfig

All warnings:

sound/soc/codecs/wm_adsp.c: In function 'wm_adsp_setup_algs':
sound/soc/codecs/wm_adsp.c:464:3: warning: format '%d' expects argument of type 'int', but argument 4 has type 'size_t' [-Wformat]
sound/soc/codecs/wm_adsp.c:479:3: warning: format '%zx' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat]

vim +464 sound/soc/codecs/wm_adsp.c

aab034fe Mark Brown 2012-10-26  448  
aab034fe Mark Brown 2012-10-26  449  		pos = sizeof(adsp2_id) / 2;
aab034fe Mark Brown 2012-10-26  450  		term = pos + ((sizeof(*adsp2_alg) * algs) / 2);
aab034fe Mark Brown 2012-10-26  451  		break;
aab034fe Mark Brown 2012-10-26  452  
aab034fe Mark Brown 2012-10-26  453  	default:
aab034fe Mark Brown 2012-10-26  454  		BUG_ON(NULL == "Unknown DSP type");
aab034fe Mark Brown 2012-10-26  455  		return -EINVAL;
aab034fe Mark Brown 2012-10-26  456  	}
aab034fe Mark Brown 2012-10-26  457  
aab034fe Mark Brown 2012-10-26  458  	if (algs == 0) {
aab034fe Mark Brown 2012-10-26  459  		adsp_err(dsp, "No algorithms\n");
aab034fe Mark Brown 2012-10-26  460  		return -EINVAL;
aab034fe Mark Brown 2012-10-26  461  	}
aab034fe Mark Brown 2012-10-26  462  
7265971f Mark Brown 2012-12-19  463  	if (algs > 1024) {
7265971f Mark Brown 2012-12-19 @464  		adsp_err(dsp, "Algorithm count %d excessive\n", algs);
7265971f Mark Brown 2012-12-19  465  		print_hex_dump_bytes(dev_name(dsp->dev), DUMP_PREFIX_OFFSET,
7265971f Mark Brown 2012-12-19  466  				     buf, buf_size);
7265971f Mark Brown 2012-12-19  467  		return -EINVAL;
7265971f Mark Brown 2012-12-19  468  	}
7265971f Mark Brown 2012-12-19  469  
aab034fe Mark Brown 2012-10-26  470  	/* Read the terminator first to validate the length */
aab034fe Mark Brown 2012-10-26  471  	ret = regmap_raw_read(regmap, mem->base + term, &val, sizeof(val));
aab034fe Mark Brown 2012-10-26  472  	if (ret != 0) {

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
