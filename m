Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16405CD343F
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2026 19:51:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B4806020D;
	Fri, 15 May 2026 21:51:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B4806020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778874670;
	bh=k15qqqgCP9nWa36ZDnfAEeB9gW0FiZxgQpiUzUfjm8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=W4CuCXPjXEzHDPhxo5FPooR535b59nRiNv5RK8xCGLExi5OOh30sm+08c7w5ycqs+
	 LDVBur2TrOgIoqsO+SnbL5bCEE9HQYxf0h4c/7lIUvEtLBOXEg9FFDSURaetO6rcQB
	 18E8aEC8EshwzB47Zy0P9fCD7hv8QdKOMMA9uUUc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B2DBBF805E7; Fri, 15 May 2026 21:50:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 72A02F805E7;
	Fri, 15 May 2026 21:50:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 558BDF80557; Fri, 15 May 2026 21:50:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 756D1F800BD
	for <alsa-devel@alsa-project.org>; Fri, 15 May 2026 21:50:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 756D1F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hZgTGEx7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778874627; x=1810410627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k15qqqgCP9nWa36ZDnfAEeB9gW0FiZxgQpiUzUfjm8w=;
  b=hZgTGEx7JXIA2rASLNGyhkcmVShmUOgEFmaBErmM7tk5rkPhNKVzDUXi
   UcedWcxzbiEgR2pPLIuvs/WFrNlqcIq1TfECDS/jTrXoHRHa39cZWyAnV
   o/G31x+75x/+pUeoV5Rq7XIL0a3+Tn7lYJAoOI4nZzlmCEybV/tBfqpsV
   M9UzROD7kVi9fyUgtNTh/whI16dBaUCEYYhygLSPnXsCJxxf0Ng6eeK/a
   TKV/KuOS4516mnlHm5pdEH1AIwXRQOL1klPO1bXlJgmYe8B7WucvMTvF4
   9a8JDUQM2kaJmsnVML+Ne3M08wmwcr9HtjuF/nrdz5X0QKiH4G5DKnKUU
   g==;
X-CSE-ConnectionGUID: LLTrJjG/RsSXfVY0CoQ/BA==
X-CSE-MsgGUID: jPZJz3nlQdi1umu5mhDsog==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79800908"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000";
   d="scan'208";a="79800908"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2026 12:50:22 -0700
X-CSE-ConnectionGUID: CfccELJcRdeEPUtj/tnFVQ==
X-CSE-MsgGUID: qNQWcAw2QoiEi+M2ptL57g==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 15 May 2026 12:50:20 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNyXs-000000002dR-15c8;
	Fri, 15 May 2026 19:50:08 +0000
Date: Sat, 16 May 2026 03:49:16 +0800
From: kernel test robot <lkp@intel.com>
To: jack.yu@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org,
	lars@metafoo.de, flove@realtek.com, oder_chiou@realtek.com,
	shumingf@realtek.com, derek.fang@realtek.com,
	Jack Yu <jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: rt722-sdca: Add a control to support CAE firmware
 update
Message-ID: <202605160321.U3aaymLP-lkp@intel.com>
References: <20260515091643.3038701-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515091643.3038701-1-jack.yu@realtek.com>
Message-ID-Hash: 7LTBC64564B7YZ3VGJGKJOXBVUQOBZPB
X-Message-ID-Hash: 7LTBC64564B7YZ3VGJGKJOXBVUQOBZPB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7LTBC64564B7YZ3VGJGKJOXBVUQOBZPB/>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260516/202605160321.U3aaymLP-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260516/202605160321.U3aaymLP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605160321.U3aaymLP-lkp@intel.com/

All errors (new ones prefixed by >>):

   sound/soc/codecs/rt722-sdca.c: In function 'rt722_cae_update_put':
>> sound/soc/codecs/rt722-sdca.c:571:21: error: implicit declaration of function 'snd_soc_component_get_bias_level'; did you mean 'snd_soc_component_set_bias_level'? [-Wimplicit-function-declaration]
     571 |                 if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                     snd_soc_component_set_bias_level


vim +571 sound/soc/codecs/rt722-sdca.c

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
