Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FA3C4332F
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Nov 2023 20:47:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4497B829;
	Sun,  5 Nov 2023 21:46:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4497B829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699217236;
	bh=DFEnBoAZfjHsPxHG7Pn6/C8BILMOVrXxGrVVO4Ir0M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gRWY0oldh52JEEJiulH2otjYWvoByUNUGLYgqO5v8sSVEanNha6+qVaZuN1i4NH6r
	 DQ0Bxz7Q3lsmryDILQUOcVbdS4dMvqJg8Av24LwlavVz8CHewgF2K+Y9o91Zx+uxKx
	 kwtylmorskK7uc08rbRywKMMQXCIkW/mZ8x+I8AY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A6285F80558; Sun,  5 Nov 2023 21:46:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5622BF8016D;
	Sun,  5 Nov 2023 21:46:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3EEB3F8016D; Sun,  5 Nov 2023 21:45:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 458C1F80100
	for <alsa-devel@alsa-project.org>; Sun,  5 Nov 2023 21:45:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 458C1F80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OHdwYwwV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699217105; x=1730753105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DFEnBoAZfjHsPxHG7Pn6/C8BILMOVrXxGrVVO4Ir0M0=;
  b=OHdwYwwVxKWirF88uhOktHHCxKMrYWboSd34niJTt6zwuIUugJF0E0aV
   ldl5XiiDJ+jofvIWuHxnpyxKv51W0liaQi8v5LAIkiIoFbjOB8zN77mMk
   NVlVFRD/zfEMzJQo8mGwlb0I12r76jqPzZFXNip3mhvS16N6hyglhQSwD
   DrxUY7bJ04AMJclzMd5dDKjWC8zf1PobAkYE91Ov9l2lrOj8yP+dBbcq1
   wd1RI7iqY5m8+0i9BgogoDHgWSESCBWDRfZdO7WDg9A1Siex38f1AAunt
   0sO2g6YYDyu2lZ8FX+cqWV8cf6ebVqagyTelwVRH0mNFur4AQDlipIh3K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="388991516"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200";
   d="scan'208";a="388991516"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2023 12:45:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="762133802"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200";
   d="scan'208";a="762133802"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 Nov 2023 12:44:58 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qzjzL-0005mC-32;
	Sun, 05 Nov 2023 20:44:55 +0000
Date: Mon, 6 Nov 2023 04:44:17 +0800
From: kernel test robot <lkp@intel.com>
To: Ivan Orlov <ivan.orlov0322@gmail.com>, perex@perex.cz, tiwai@suse.com,
	corbet@lwn.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 2/2] ALSA: Add new driver for Marian M2 sound card
Message-ID: <202311060403.591giMV8-lkp@intel.com>
References: <20230918181044.7257-2-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918181044.7257-2-ivan.orlov0322@gmail.com>
Message-ID-Hash: SML4JE4B3UVFR6FTPIEIWXJPIVBFHPIG
X-Message-ID-Hash: SML4JE4B3UVFR6FTPIEIWXJPIVBFHPIG
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SML4JE4B3UVFR6FTPIEIWXJPIVBFHPIG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Ivan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus linus/master v6.6 next-20231103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Orlov/ALSA-Add-new-driver-for-Marian-M2-sound-card/20230919-021236
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20230918181044.7257-2-ivan.orlov0322%40gmail.com
patch subject: [PATCH v2 2/2] ALSA: Add new driver for Marian M2 sound card
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20231106/202311060403.591giMV8-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060403.591giMV8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311060403.591giMV8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/pci/marianm2.c:466:6: warning: variable 'buffer_frames' set but not used [-Wunused-but-set-variable]
           int buffer_frames;
               ^
>> sound/pci/marianm2.c:472:11: warning: variable 'speedmode' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           else if (params_rate(params) < RATE_FAST)
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/pci/marianm2.c:475:6: note: uninitialized use occurs here
           if (speedmode > marian->desc->speedmode_max) {
               ^~~~~~~~~
   sound/pci/marianm2.c:472:7: note: remove the 'if' if its condition is always true
           else if (params_rate(params) < RATE_FAST)
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/pci/marianm2.c:465:24: note: initialize the variable 'speedmode' to silence this warning
           unsigned int speedmode;
                                 ^
                                  = 0
   2 warnings generated.


vim +472 sound/pci/marianm2.c

   460	
   461	static int snd_marian_hw_params(struct snd_pcm_substream *substream,
   462					struct snd_pcm_hw_params *params)
   463	{
   464		struct marian_card *marian = snd_pcm_substream_chip(substream);
   465		unsigned int speedmode;
 > 466		int buffer_frames;
   467	
   468		buffer_frames = SUBSTREAM_BUF_SIZE / M2_FRAME_SIZE;
   469	
   470		if (params_rate(params) < RATE_SLOW)
   471			speedmode = SPEEDMODE_SLOW;
 > 472		else if (params_rate(params) < RATE_FAST)
   473			speedmode = SPEEDMODE_FAST;
   474	
   475		if (speedmode > marian->desc->speedmode_max) {
   476			dev_err(marian->card->dev,
   477				"Requested rate (%u Hz) higher than card's maximum\n",
   478				params_rate(params));
   479			_snd_pcm_hw_param_setempty(params, SNDRV_PCM_HW_PARAM_RATE);
   480			return -EBUSY;
   481		}
   482	
   483		spin_lock(&marian->reglock);
   484		if (marian->desc->set_speedmode)
   485			marian->desc->set_speedmode(marian, speedmode);
   486		else
   487			marian_generic_set_speedmode(marian, speedmode);
   488	
   489		marian->detune = 0;
   490	
   491		marian_generic_set_dco(marian, params_rate(params), 0);
   492		spin_unlock(&marian->reglock);
   493	
   494		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
   495			snd_pcm_set_runtime_buffer(substream, &marian->playback_buf);
   496		else
   497			snd_pcm_set_runtime_buffer(substream, &marian->capture_buf);
   498	
   499		// apply optional card specific hw constraints
   500		if (marian->desc->hw_constraints_func)
   501			marian->desc->hw_constraints_func(marian, substream, params);
   502	
   503		return 0;
   504	}
   505	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
