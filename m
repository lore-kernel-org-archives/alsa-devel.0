Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B200ACD343F
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2026 20:45:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FB9E60228;
	Fri, 15 May 2026 22:45:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FB9E60228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778877938;
	bh=c9D75mDsRZE8URzUvIVTHDuWnWp7qVpNXvYhqCLOzqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bGO3+R4PyG1gNUWHCESPUKbZY9CTF00UiPI3B5ibMqfDrrW+K80FGHPyJtG2IyACZ
	 ju3GcVjj+QNZLo66FWcUuIRP91/7HmRZg9j9+nO2ou8NXX5L2e/KHP/81eaVXgl5cz
	 OczcOin+FDCwsUw65x3ZJfNWUXG5V3kWXg2zOSSs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 884DAF805F0; Fri, 15 May 2026 22:45:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B7B8FF805E5;
	Fri, 15 May 2026 22:45:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D99D7F80557; Fri, 15 May 2026 22:44:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DAB49F800BD
	for <alsa-devel@alsa-project.org>; Fri, 15 May 2026 22:44:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DAB49F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LC/T2XlP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778877891; x=1810413891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c9D75mDsRZE8URzUvIVTHDuWnWp7qVpNXvYhqCLOzqo=;
  b=LC/T2XlP64hXvYWL7Axjya8s6V1CYY1WsqyYAbtv/DhO3BsZ7zYlEHvt
   aglwk2w8B7bhEIUII7MTokICF3DAm0e8AefdmWxZekElVNiAiLM9tmL1w
   ZsZxwHxDGoLxU1zGySLzURJJIoh6aMlmRh1WX6V0M7Dsqs27lf9dcZgfO
   w6PNk7RVMp13zcKc1SrOPUZ0BPMaSZ16YfbYfsboGcwBpWBTao1c8pksl
   xAAw2W3ZBayPrEGy5XnvA4216pS3UBcmMtayjg1Hk7hYYDiuk+XH9xwB3
   FEDc18rf+39A0ChSCMhipDOid8WnS+LviGsa93NgHb8ntvE6oQgUEtxZA
   w==;
X-CSE-ConnectionGUID: 6+YTQfW8T2uXM4AcVdzYQA==
X-CSE-MsgGUID: UUC2C5kSQoqLIZIEKz7qjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79960373"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000";
   d="scan'208";a="79960373"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2026 13:44:46 -0700
X-CSE-ConnectionGUID: IrIUv9jJSKG9KDhlIHnSLQ==
X-CSE-MsgGUID: GbIFp31ITZmZfOGwdVUhwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000";
   d="scan'208";a="240619779"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 15 May 2026 13:44:18 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNzOI-000000002iX-3W3r;
	Fri, 15 May 2026 20:44:14 +0000
Date: Sat, 16 May 2026 04:43:51 +0800
From: kernel test robot <lkp@intel.com>
To: jack.yu@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
	oder_chiou@realtek.com, shumingf@realtek.com,
	derek.fang@realtek.com, Jack Yu <jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: rt722-sdca: Add a control to support CAE firmware
 update
Message-ID: <202605160417.WSjswKEf-lkp@intel.com>
References: <20260515091643.3038701-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515091643.3038701-1-jack.yu@realtek.com>
Message-ID-Hash: 5CSQBX2SIKOHQZYKSZN4TDU2EO37NVTW
X-Message-ID-Hash: 5CSQBX2SIKOHQZYKSZN4TDU2EO37NVTW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5CSQBX2SIKOHQZYKSZN4TDU2EO37NVTW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jack-yu-realtek-com/ASoC-rt722-sdca-Add-a-control-to-support-CAE-firmware-update/20260515-191729
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20260515091643.3038701-1-jack.yu%40realtek.com
patch subject: [PATCH] ASoC: rt722-sdca: Add a control to support CAE firmware update
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260516/202605160417.WSjswKEf-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260516/202605160417.WSjswKEf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605160417.WSjswKEf-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sound/soc/codecs/rt722-sdca.c:571:7: error: call to undeclared function 'snd_soc_component_get_bias_level'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     571 |                 if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
         |                     ^
   sound/soc/codecs/rt722-sdca.c:571:7: note: did you mean 'snd_soc_component_set_bias_level'?
   include/sound/soc-component.h:326:5: note: 'snd_soc_component_set_bias_level' declared here
     326 | int snd_soc_component_set_bias_level(struct snd_soc_component *component,
         |     ^
   1 error generated.


vim +/snd_soc_component_get_bias_level +571 sound/soc/codecs/rt722-sdca.c

   555	
   556	static int rt722_cae_update_put(struct snd_kcontrol *kcontrol,
   557					 struct snd_ctl_elem_value *ucontrol)
   558	{
   559		struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
   560		struct rt722_sdca_priv *rt722 = snd_soc_component_get_drvdata(component);
   561		int ret, changed = 0;
   562	
   563		if (!rt722->hw_init)
   564			return 0;
   565	
   566		ret = pm_runtime_resume_and_get(component->dev);
   567		if (ret < 0 && ret != -EACCES)
   568			return ret;
   569	
   570		if (ucontrol->value.integer.value[0]) {
 > 571			if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
   572				ret = rt722_cae_load(rt722);
   573				if (ret)
   574					dev_err(component->dev, "CAE load failed: %d\n", ret);
   575				else
   576					changed = 1;
   577			}
   578		} else {
   579			if (rt722->cae_update_done) {
   580				rt722->cae_update_done = 0;
   581				changed = 1;
   582			}
   583		}
   584	
   585		pm_runtime_mark_last_busy(component->dev);
   586		pm_runtime_put_autosuspend(component->dev);
   587	
   588		return changed;
   589	}
   590	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
