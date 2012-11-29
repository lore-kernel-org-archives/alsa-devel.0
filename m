From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [asoc:topic/adsp 139/139]
 sound/soc/codecs/wm_adsp.c:556 wm_adsp2_event() warn: add some parenthesis
 here?
Date: Thu, 29 Nov 2012 10:33:37 +0300
Message-ID: <20121129073337.GZ6186@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FFAB26505A
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 08:33:45 +0100 (CET)
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: kbuild@01.org, Fengguang Wu <fengguang.wu@intel.com>, alsa-devel@alsa-project.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

FYI, there are new smatch warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/adsp
head:   973838a030d2a91fbd524c95281991510ed0a865
commit: 973838a030d2a91fbd524c95281991510ed0a865 [139/139] ASoC: wm_adsp: Enable DVFS for ADSP2

+ sound/soc/codecs/wm_adsp.c:556 wm_adsp2_event() warn: add some parenthesis here?

git remote update asoc
git checkout 973838a030d2a91fbd524c95281991510ed0a865
vim +556 sound/soc/codecs/wm_adsp.c

2159ad93 Mark Brown 2012-10-11  540  	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
2159ad93 Mark Brown 2012-10-11  541  	struct wm_adsp *dsp = &dsps[w->shift];
973838a0 Mark Brown 2012-11-28  542  	unsigned int val;
2159ad93 Mark Brown 2012-10-11  543  	int ret;
2159ad93 Mark Brown 2012-10-11  544  
2159ad93 Mark Brown 2012-10-11  545  	switch (event) {
2159ad93 Mark Brown 2012-10-11  546  	case SND_SOC_DAPM_POST_PMU:
973838a0 Mark Brown 2012-11-28  547  		if (dsp->dvfs) {
973838a0 Mark Brown 2012-11-28  548  			ret = regmap_read(dsp->regmap,
973838a0 Mark Brown 2012-11-28  549  					  dsp->base + ADSP2_CLOCKING, &val);
973838a0 Mark Brown 2012-11-28  550  			if (ret != 0) {
973838a0 Mark Brown 2012-11-28  551  				dev_err(dsp->dev,
973838a0 Mark Brown 2012-11-28  552  					"Failed to read clocking: %d\n", ret);
973838a0 Mark Brown 2012-11-28  553  				return ret;
973838a0 Mark Brown 2012-11-28  554  			}
973838a0 Mark Brown 2012-11-28  555  
973838a0 Mark Brown 2012-11-28 @556  			if (val & ADSP2_CLK_SEL_MASK >= 3) {

Precedence bug.  The intent was:
                                                        if (val & ADSP2_CLK_SEL_MASK) >= 3) {

973838a0 Mark Brown 2012-11-28  557  				ret = regulator_enable(dsp->dvfs);
973838a0 Mark Brown 2012-11-28  558  				if (ret != 0) {
973838a0 Mark Brown 2012-11-28  559  					dev_err(dsp->dev,
973838a0 Mark Brown 2012-11-28  560  						"Failed to enable supply: %d\n",
973838a0 Mark Brown 2012-11-28  561  						ret);
973838a0 Mark Brown 2012-11-28  562  					return ret;
973838a0 Mark Brown 2012-11-28  563  				}
973838a0 Mark Brown 2012-11-28  564  

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
