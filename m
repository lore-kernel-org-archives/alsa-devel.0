From: Julia Lawall <julia.lawall@lip6.fr>
Subject: [asoc:for-5.1 100/129]
 sound/soc/codecs/wcd9335.c:2168:5-8: Unneeded variable: "ret". Return "0"
 on line 2182 (fwd)
Date: Mon, 4 Feb 2019 23:18:33 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1902042317300.2614@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F17626745C
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 23:18:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

It's a small thing, but just returning 0 would be a little bit more clear
than setting ret to 0 and then returning that.

julia

---------- Forwarded message ----------
Date: Tue, 5 Feb 2019 05:57:05 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [asoc:for-5.1 100/129] sound/soc/codecs/wcd9335.c:2168:5-8: Unneeded
    variable: "ret". Return "0" on line 2182

CC: kbuild-all@01.org
CC: alsa-devel@alsa-project.org
TO: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC: Mark Brown <broonie@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.1
head:   0f747bb273790f49be4660521d86d7cebd1bbe1e
commit: 354461486f66e4311d9412c53205d773aac85b78 [100/129] ASoC: wcd9335: add playback dapm widgets
:::::: branch date: 6 hours ago
:::::: commit date: 7 days ago

>> sound/soc/codecs/wcd9335.c:2168:5-8: Unneeded variable: "ret". Return "0" on line 2182
   sound/soc/codecs/wcd9335.c:2498:5-8: Unneeded variable: "ret". Return "0" on line 2528
   sound/soc/codecs/wcd9335.c:2302:5-8: Unneeded variable: "ret". Return "0" on line 2341
   sound/soc/codecs/wcd9335.c:2453:5-8: Unneeded variable: "ret". Return "0" on line 2491
   sound/soc/codecs/wcd9335.c:1583:5-8: Unneeded variable: "ret". Return "0" on line 1595

# https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=354461486f66e4311d9412c53205d773aac85b78
git remote add asoc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git remote update asoc
git checkout 354461486f66e4311d9412c53205d773aac85b78
vim +2168 sound/soc/codecs/wcd9335.c

35446148 Srinivas Kandagatla 2019-01-28  2162
35446148 Srinivas Kandagatla 2019-01-28  2163  static int wcd9335_codec_ear_dac_event(struct snd_soc_dapm_widget *w,
35446148 Srinivas Kandagatla 2019-01-28  2164  				       struct snd_kcontrol *kc, int event)
35446148 Srinivas Kandagatla 2019-01-28  2165  {
35446148 Srinivas Kandagatla 2019-01-28  2166  	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
35446148 Srinivas Kandagatla 2019-01-28  2167  	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
35446148 Srinivas Kandagatla 2019-01-28 @2168  	int ret = 0;
35446148 Srinivas Kandagatla 2019-01-28  2169
35446148 Srinivas Kandagatla 2019-01-28  2170  	switch (event) {
35446148 Srinivas Kandagatla 2019-01-28  2171  	case SND_SOC_DAPM_PRE_PMU:
35446148 Srinivas Kandagatla 2019-01-28  2172  		wcd_clsh_ctrl_set_state(wcd->clsh_ctrl, WCD_CLSH_EVENT_PRE_DAC,
35446148 Srinivas Kandagatla 2019-01-28  2173  					WCD_CLSH_STATE_EAR, CLS_H_NORMAL);
35446148 Srinivas Kandagatla 2019-01-28  2174
35446148 Srinivas Kandagatla 2019-01-28  2175  		break;
35446148 Srinivas Kandagatla 2019-01-28  2176  	case SND_SOC_DAPM_POST_PMD:
35446148 Srinivas Kandagatla 2019-01-28  2177  		wcd_clsh_ctrl_set_state(wcd->clsh_ctrl, WCD_CLSH_EVENT_POST_PA,
35446148 Srinivas Kandagatla 2019-01-28  2178  					WCD_CLSH_STATE_EAR, CLS_H_NORMAL);
35446148 Srinivas Kandagatla 2019-01-28  2179  		break;
35446148 Srinivas Kandagatla 2019-01-28  2180  	};
35446148 Srinivas Kandagatla 2019-01-28  2181
35446148 Srinivas Kandagatla 2019-01-28 @2182  	return ret;
35446148 Srinivas Kandagatla 2019-01-28  2183  }
35446148 Srinivas Kandagatla 2019-01-28  2184

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
