From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 2/3] ASoC: davinci-mcasp: Use
 'snd_pcm_format_t' type
Date: Mon, 7 May 2018 04:30:40 +0800
Message-ID: <201805070459.Vr54HE0b%fengguang.wu@intel.com>
References: <1525621665-11022-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id E5885267338
 for <alsa-devel@alsa-project.org>; Sun,  6 May 2018 22:31:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1525621665-11022-2-git-send-email-festevam@gmail.com>
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

   sound/soc/davinci/davinci-mcasp.c:1222:42: sparse: restricted snd_pcm_format_t degrades to integer
   sound/soc/davinci/davinci-mcasp.c:1222:47: sparse: restricted snd_pcm_format_t degrades to integer
>> sound/soc/davinci/davinci-mcasp.c:1223:40: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned int [unsigned] val @@    got restricted snd_pcm_format_unsigned int [unsigned] val @@
   sound/soc/davinci/davinci-mcasp.c:1223:40:    expected unsigned int [unsigned] val
   sound/soc/davinci/davinci-mcasp.c:1223:40:    got restricted snd_pcm_format_t [assigned] [usertype] i
   sound/soc/davinci/davinci-mcasp.c:1234:53: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned int [unsigned] val @@    got restricted snd_pcm_format_unsigned int [unsigned] val @@
   sound/soc/davinci/davinci-mcasp.c:1234:53:    expected unsigned int [unsigned] val
   sound/soc/davinci/davinci-mcasp.c:1234:53:    got restricted snd_pcm_format_t [assigned] [usertype] i
   sound/soc/davinci/davinci-mcasp.c:1222:71: sparse: restricted snd_pcm_format_t degrades to integer
   sound/soc/davinci/davinci-mcasp.c:1662:73: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __be32 const [usertype] *p @@    got icted __be32 const [usertype] *p @@
   sound/soc/davinci/davinci-mcasp.c:1662:73:    expected restricted __be32 const [usertype] *p
   sound/soc/davinci/davinci-mcasp.c:1662:73:    got unsigned int const [usertype] *

vim +1223 sound/soc/davinci/davinci-mcasp.c

a75a053f Jyri Sarha     2015-03-20  1208  
a75a053f Jyri Sarha     2015-03-20  1209  static int davinci_mcasp_hw_rule_format(struct snd_pcm_hw_params *params,
a75a053f Jyri Sarha     2015-03-20  1210  					struct snd_pcm_hw_rule *rule)
a75a053f Jyri Sarha     2015-03-20  1211  {
a75a053f Jyri Sarha     2015-03-20  1212  	struct davinci_mcasp_ruledata *rd = rule->private;
a75a053f Jyri Sarha     2015-03-20  1213  	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
a75a053f Jyri Sarha     2015-03-20  1214  	struct snd_mask nfmt;
a75a053f Jyri Sarha     2015-03-20  1215  	int rate = params_rate(params);
1f114f77 Jyri Sarha     2015-04-23  1216  	int slots = rd->mcasp->tdm_slots;
40601663 Fabio Estevam  2018-05-06  1217  	snd_pcm_format_t i;
40601663 Fabio Estevam  2018-05-06  1218  	int count = 0;
a75a053f Jyri Sarha     2015-03-20  1219  
a75a053f Jyri Sarha     2015-03-20  1220  	snd_mask_none(&nfmt);
a75a053f Jyri Sarha     2015-03-20  1221  
40601663 Fabio Estevam  2018-05-06 @1222  	for (i = SNDRV_PCM_FORMAT_FIRST; i <= SNDRV_PCM_FORMAT_LAST; i++) {
a75a053f Jyri Sarha     2015-03-20 @1223  		if (snd_mask_test(fmt, i)) {
dd55ff83 Jyri Sarha     2015-09-09  1224  			uint sbits = snd_pcm_format_width(i);
a75a053f Jyri Sarha     2015-03-20  1225  			int ppm;
a75a053f Jyri Sarha     2015-03-20  1226  
dd55ff83 Jyri Sarha     2015-09-09  1227  			if (rd->mcasp->slot_width)
dd55ff83 Jyri Sarha     2015-09-09  1228  				sbits = rd->mcasp->slot_width;
dd55ff83 Jyri Sarha     2015-09-09  1229  
3e9bee11 Peter Ujfalusi 2016-05-09  1230  			ppm = davinci_mcasp_calc_clk_div(rd->mcasp,
3e9bee11 Peter Ujfalusi 2016-05-09  1231  							 sbits * slots * rate,
3e9bee11 Peter Ujfalusi 2016-05-09  1232  							 false);
a75a053f Jyri Sarha     2015-03-20  1233  			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
a75a053f Jyri Sarha     2015-03-20  1234  				snd_mask_set(&nfmt, i);
a75a053f Jyri Sarha     2015-03-20  1235  				count++;
a75a053f Jyri Sarha     2015-03-20  1236  			}
a75a053f Jyri Sarha     2015-03-20  1237  		}
a75a053f Jyri Sarha     2015-03-20  1238  	}
a75a053f Jyri Sarha     2015-03-20  1239  	dev_dbg(rd->mcasp->dev,
1f114f77 Jyri Sarha     2015-04-23  1240  		"%d possible sample format for %d Hz and %d tdm slots\n",
1f114f77 Jyri Sarha     2015-04-23  1241  		count, rate, slots);
a75a053f Jyri Sarha     2015-03-20  1242  
a75a053f Jyri Sarha     2015-03-20  1243  	return snd_mask_refine(fmt, &nfmt);
a75a053f Jyri Sarha     2015-03-20  1244  }
a75a053f Jyri Sarha     2015-03-20  1245  

:::::: The code at line 1223 was first introduced by commit
:::::: a75a053f1eefbbbbae0f7d6bf1ed12ce012112b7 ASoC: davinci-mcasp: Set rule constraints if implicit BCLK divider is used

:::::: TO: Jyri Sarha <jsarha@ti.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
