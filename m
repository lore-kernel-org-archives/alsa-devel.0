Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECD4C27C4F
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Jun 2024 02:56:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B89EDE;
	Wed, 19 Jun 2024 04:55:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B89EDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718765765;
	bh=ruiJuo0TcIPww1MKnKhDXKjJpEPkKk7FFb1iT/KeR1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jrlj860Hrnwb1NTYqCA0P9aUZhVmogsaMG+J8EqIUWrw7S1meYTRkYC0713QP2B2J
	 PVHgVc9U4RZkoe9uv27woEpztRVwsNS+aQ+4wbFzKLImNaoX7GcpEjaJkqo3DVHbpj
	 h02sucT7IHfAem6UPVIusE56G/+oVnkrt6qlmY7g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 77B0DF805B6; Wed, 19 Jun 2024 04:55:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F2A82F805B5;
	Wed, 19 Jun 2024 04:55:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54C20F8023A; Wed, 19 Jun 2024 04:54:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AF169F800ED
	for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2024 04:54:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF169F800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=TEBRAsEy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718765688; x=1750301688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ruiJuo0TcIPww1MKnKhDXKjJpEPkKk7FFb1iT/KeR1I=;
  b=TEBRAsEyJ5nC/iLFnoOn06EwqBraeEejW72Z2HPhIOomRFnUf4xm6m5V
   xKaTl9gS5YmWCsfQ0wfuS2/fjWrCCdtii3r0FJptAEmgD5bpOJrU3IlGx
   GRWN6XaoLVnE1SaSpGCn6zPVG7S8EtoclAdWOqDQLudSG/wvL2tzq3Ie4
   mt/xtRP8+Jxj49oIndP6oCE32mwTCP5WeeKNUKHftVzPmoCwa08wFYWTD
   Zt+02YfxsZvHITVNKNLQMDlIZXy/tDAT8DksZKSJJrHkH6TefWuCIe5dP
   t9vy84gH/uqw1XpRVfEvwDnm5UU6oC8qpu6+9W6eR23m6umM3NNkij45Q
   w==;
X-CSE-ConnectionGUID: JGajuzvESQuE2XboaikzXg==
X-CSE-MsgGUID: tc+qyVNXRTCFUarl6GyyeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="27098710"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000";
   d="scan'208";a="27098710"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2024 19:54:41 -0700
X-CSE-ConnectionGUID: REFS4McYQWKbyGSnAE9OGA==
X-CSE-MsgGUID: ve6VOm3WTSi6RXgIBjiO6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000";
   d="scan'208";a="41860800"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2024 19:54:38 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJlT1-0006Cw-34;
	Wed, 19 Jun 2024 02:54:35 +0000
Date: Wed, 19 Jun 2024 10:53:55 +0800
From: kernel test robot <lkp@intel.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Manikantan R <quic_manrav@quicinc.com>
Subject: Re: [PATCH 2/2] ASoC: codecs:lpass-wsa-macro: Fix logic of enabling
 vi channels
Message-ID: <202406191005.yMuWtspN-lkp@intel.com>
References: <20240618-lpass-wsa-vi-v1-2-416a6f162c81@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-lpass-wsa-vi-v1-2-416a6f162c81@linaro.org>
Message-ID-Hash: AG5BQMLUG6MXJAQIORQ56RAZW3VOAQAN
X-Message-ID-Hash: AG5BQMLUG6MXJAQIORQ56RAZW3VOAQAN
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AG5BQMLUG6MXJAQIORQ56RAZW3VOAQAN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Srinivas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0]

url:    https://github.com/intel-lab-lkp/linux/commits/Srinivas-Kandagatla/ASoC-codecs-lpass-wsa-macro-Fix-vi-feedback-rate/20240618-221030
base:   1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
patch link:    https://lore.kernel.org/r/20240618-lpass-wsa-vi-v1-2-416a6f162c81%40linaro.org
patch subject: [PATCH 2/2] ASoC: codecs:lpass-wsa-macro: Fix logic of enabling vi channels
config: i386-buildonly-randconfig-002-20240619 (https://download.01.org/0day-ci/archive/20240619/202406191005.yMuWtspN-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240619/202406191005.yMuWtspN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406191005.yMuWtspN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/soc/codecs/lpass-wsa-macro.c:999:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     999 |         default:
         |         ^
   sound/soc/codecs/lpass-wsa-macro.c:999:2: note: insert 'break;' to avoid fall-through
     999 |         default:
         |         ^
         |         break; 
>> sound/soc/codecs/lpass-wsa-macro.c:1238:6: warning: variable 'tx_reg0' set but not used [-Wunused-but-set-variable]
    1238 |         u32 tx_reg0, tx_reg1;
         |             ^
>> sound/soc/codecs/lpass-wsa-macro.c:1238:15: warning: variable 'tx_reg1' set but not used [-Wunused-but-set-variable]
    1238 |         u32 tx_reg0, tx_reg1;
         |                      ^
   3 warnings generated.


vim +/tx_reg0 +1238 sound/soc/codecs/lpass-wsa-macro.c

0c27e978419e7e Srinivas Kandagatla 2024-06-18  1231  
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1232  static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1233  					struct snd_kcontrol *kcontrol,
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1234  					int event)
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1235  {
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1236  	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1237  	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05 @1238  	u32 tx_reg0, tx_reg1;
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1239  	u32 rate_val;
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1240  
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1241  	switch (wsa->pcm_rate_vi) {
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1242  	case 8000:
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1243  		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1244  		break;
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1245  	case 16000:
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1246  		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_16K;
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1247  		break;
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1248  	case 24000:
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1249  		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_24K;
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1250  		break;
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1251  	case 32000:
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1252  		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_32K;
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1253  		break;
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1254  	case 48000:
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1255  		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_48K;
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1256  		break;
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1257  	default:
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1258  		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1259  		break;
2881dae5fbb091 Srinivas Kandagatla 2024-06-18  1260  	}
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1261  
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1262  	if (test_bit(WSA_MACRO_TX0, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1263  		tx_reg0 = CDC_WSA_TX0_SPKR_PROT_PATH_CTL;
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1264  		tx_reg1 = CDC_WSA_TX1_SPKR_PROT_PATH_CTL;
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1265  	} else if (test_bit(WSA_MACRO_TX1, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1266  		tx_reg0 = CDC_WSA_TX2_SPKR_PROT_PATH_CTL;
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1267  		tx_reg1 = CDC_WSA_TX3_SPKR_PROT_PATH_CTL;
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1268  	}
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1269  
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1270  	switch (event) {
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1271  	case SND_SOC_DAPM_POST_PMU:
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1272  			/* Enable V&I sensing */
0c27e978419e7e Srinivas Kandagatla 2024-06-18  1273  		wsa_macro_enable_disable_vi_feedback(component, true, rate_val);
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1274  		break;
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1275  	case SND_SOC_DAPM_POST_PMD:
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1276  		/* Disable V&I sensing */
0c27e978419e7e Srinivas Kandagatla 2024-06-18  1277  		wsa_macro_enable_disable_vi_feedback(component, false, rate_val);
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1278  		break;
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1279  	}
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1280  
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1281  	return 0;
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1282  }
2c4066e5d428d4 Srinivas Kandagatla 2020-11-05  1283  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
