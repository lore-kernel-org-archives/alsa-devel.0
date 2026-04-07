Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97118FB5188
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2026 03:50:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54A67601F3;
	Tue,  7 Apr 2026 05:50:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54A67601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775533819;
	bh=+5HZ7TMl4EDAq605473bjPsWC0R84LH6CxKoqbebHUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RwjKn/inroRRz26OqnT7mFUONV78K7857fAme1w190i2y+Eww0fBcXnHEf/xmFBHj
	 pSxyx//7tjlSsgDSc1AV1eQVi2dpfy0585SbugZSFl38Sv23Fgx1BlP+lK4yEdWLsW
	 jRt23IHHu1pWK59/+RKnn8W+sb4iiB+AbJEawpfE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 223E5F805F4; Tue,  7 Apr 2026 05:49:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A6498F805F3;
	Tue,  7 Apr 2026 05:49:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9CE6BF80548; Tue,  7 Apr 2026 05:49:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 02A6BF80154
	for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2026 05:49:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02A6BF80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=H5UFzMRK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775533769; x=1807069769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+5HZ7TMl4EDAq605473bjPsWC0R84LH6CxKoqbebHUY=;
  b=H5UFzMRK+tOkAueoPjPzr6UmtTf43jNjrT1l2AgDd+siv0pkMOtTCCUo
   pn+VpqP21iVSmh/hqSN1592IaBiIaJYjFYKnLbunMGOnJBD4XoccChWE7
   /2tOWdWWke/2deFECfYFnJ8Bh/XLJAN863fh2Cg7w4QWUhcyQkyeGmABK
   PrdTlidBfPugAsW8pDe8NIyvLEi5MSyfIXwKJN50OYx6CZk71TzkuKCBs
   a7Z/wjyfY/gMrDO4kS+OMlmvPC6n0Ln2ScMJ/PDV73RRR3PvgxPYeVjiC
   AMJ9EaMdjL/a2Hazyd6Qwd69myMFa8S8xf+Zm4HOpY2zZFLSndafcU5Jj
   Q==;
X-CSE-ConnectionGUID: iRW3GIKsTt26mPXHzYzmxg==
X-CSE-MsgGUID: 4FM1QyGQQqOR/KDIgg4wXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76385885"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000";
   d="scan'208";a="76385885"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 20:49:23 -0700
X-CSE-ConnectionGUID: 4YU8LARNSZWr6aZDrz6klA==
X-CSE-MsgGUID: KgbdcOD2TJa96Sgiur4ZhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000";
   d="scan'208";a="251191872"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 06 Apr 2026 20:49:20 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w9xRG-0000000001D-0Rux;
	Tue, 07 Apr 2026 03:49:18 +0000
Date: Tue, 7 Apr 2026 11:48:59 +0800
From: kernel test robot <lkp@intel.com>
To: jack.yu@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org,
	lars@metafoo.de, flove@realtek.com, oder_chiou@realtek.com,
	shumingf@realtek.com, derek.fang@realtek.com,
	Jack Yu <jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: rt1320-sdw: kcontrol for brown-out feature switch
Message-ID: <202604032240.PeKldNcG-lkp@intel.com>
References: <20260401093107.632673-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401093107.632673-1-jack.yu@realtek.com>
Message-ID-Hash: W3IGJYB4KVYMZRKVG5NBBSZUWUV5MD6G
X-Message-ID-Hash: W3IGJYB4KVYMZRKVG5NBBSZUWUV5MD6G
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W3IGJYB4KVYMZRKVG5NBBSZUWUV5MD6G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master v7.0-rc6 next-20260402]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jack-yu-realtek-com/ASoC-rt1320-sdw-kcontrol-for-brown-out-feature-switch/20260403-160437
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20260401093107.632673-1-jack.yu%40realtek.com
patch subject: [PATCH] ASoC: rt1320-sdw: kcontrol for brown-out feature switch
config: arc-randconfig-001-20260403 (https://download.01.org/0day-ci/archive/20260403/202604032240.PeKldNcG-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260403/202604032240.PeKldNcG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604032240.PeKldNcG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/soc/codecs/rt1320-sdw.c: In function 'rt1320_brown_out_put':
>> sound/soc/codecs/rt1320-sdw.c:2504:11: warning: unused variable 'tmp' [-Wunused-variable]
     int ret, tmp;
              ^~~
>> sound/soc/codecs/rt1320-sdw.c:2503:17: warning: unused variable 'dev' [-Wunused-variable]
     struct device *dev = &rt1320->sdw_slave->dev;
                    ^~~


vim +/tmp +2504 sound/soc/codecs/rt1320-sdw.c

  2497	
  2498	static int rt1320_brown_out_put(struct snd_kcontrol *kcontrol,
  2499					 struct snd_ctl_elem_value *ucontrol)
  2500	{
  2501		struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
  2502		struct rt1320_sdw_priv *rt1320 = snd_soc_component_get_drvdata(component);
> 2503		struct device *dev = &rt1320->sdw_slave->dev;
> 2504		int ret, tmp;
  2505	
  2506		ret = pm_runtime_resume(component->dev);
  2507		if (ret < 0 && ret != -EACCES)
  2508			return ret;
  2509	
  2510		rt1320->brown_out = ucontrol->value.integer.value[0];
  2511		regcache_cache_bypass(rt1320->regmap, true);
  2512	
  2513		if (rt1320->brown_out == 1)
  2514			regmap_write(rt1320->regmap, 0xdb03, 0x00);
  2515		else
  2516			regmap_write(rt1320->regmap, 0xdb03, 0xf0);
  2517	
  2518		regcache_cache_bypass(rt1320->regmap, false);
  2519	
  2520		return 0;
  2521	}
  2522	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
