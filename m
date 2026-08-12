Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523E1C5CFDB
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:23:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1992B60207;
	Thu, 13 Aug 2026 01:23:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1992B60207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786576999;
	bh=HrOweiJQuCeaQJsPlDUtj+c6qRKO32NL8UiWXaciyCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=n6Y8oY1tzm1Q4CWBLLmm94HC3ZWQQvpxYMly1DSWvmfiIoJ90lCNjIVB6vYRwU/Sx
	 0YUEe4p5ZP40KBLE96/5pwIn6qKje6ViKtRU7+q29vkeT/qLvgQXLkl9Un8+bzAyO8
	 JnqEvvkP0XfAxX1+7minEpOsoDxNXD/xQxJ8NXxY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ED4CDF805FE; Thu, 13 Aug 2026 01:22:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 76492F805FA;
	Thu, 13 Aug 2026 01:22:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ADA72F80553; Thu, 13 Aug 2026 01:22:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786576952;
	b=bAXW61K8IwOMO/793mRjfC77X9bP3j8s4pMCzM79SZ5Bxkt4RDvNWL8T2XfIh/Bpd+iC
	 47Ox7vImI2I1Kd+UHiSkzWGYd/GYO4+oEERAhVvPszIlwVKLxdcMOvmST04ITyUENHUMn
	 XurE/GIMOqTM1HcIuu0igW+4gFfdXFqgXk1+GCRXWYFLnujE9BJlMULUlmkhypCqeFczD
	 RTxYucxWGxiXDI1o3omVzj4+FrGWC0tpGBxDf94fRR2pW6bzBCwRb1R4p56jutS/qrFKF
	 QMkzH3OtP51Y1tgHkm2X2GSZN0/vXjaVAeDB9pfsWouSO+h7rIAx92wI7MtIDhw3mhQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786576952;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=HrOweiJQuCeaQJsPlDUtj+c6qRKO32NL8UiWXaciyCw=;
	b=g81JSaCzemAabt+LGQNoOqPlEhkeJNSuPTMHOlLKk5ALGdn7SpFsp7v3uvmrm77MOpE0
	 9KmR4Z1GpwVMZLaVoFLMHND3WkXCells1e0cEdhrNyO9AtPS4dqC7PuYqUfBrLAN6CU1W
	 b6PdutucXdj4vBxJCaPXmroDumd9GHzZVUTEgZLdF91S1Y8P+D7hwi7KPX1r0hlK457yA
	 3Qjj7EBBaPo0VYdDvgYbeMKCq0KbxkThcKT8GVmYsmR7JEwABvFsAHVvrHe3dZwXBIGrR
	 ybBlZ4CfEAHxg8USZ+syUNlpq/s7E7hvE6eUkrbaEClLa/Iurh2rNp9JstBXxBXe7BA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=a2Tkodbo;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F345AF800D2
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2026 01:22:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F345AF800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=a2Tkodbo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786576952; x=1818112952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HrOweiJQuCeaQJsPlDUtj+c6qRKO32NL8UiWXaciyCw=;
  b=a2TkodboU0FRJlHux1VcmzhxF2f4A0BYTtr659Im+jHUdwmJTLRWFJMT
   aZ4pcbNroQyTd4xOFr/lut1BNa7srr3XQSE7OHZrqhRrtszuuc629Ttkb
   1VfNnXs3PKLSM5MaKFEH80YCW3hJpvhmWOdzFJ5NOHlcd8H7M+9j1yIBf
   yVkTW7MZ1sq/guW2Bxq67UNMGB5AHhGRVR7hgz4XOhTv6IXQvczkXp0Mi
   /kxRRtvRdNqv2Xns6TLDTVlC15MxeyzPFY6twhVfrF9G8mdKpFeLN0wU1
   Jw3JVGV5m/vibPew10zt95aP31x0O3jCx65FzgRbXV+PWZLWs+RYuN83U
   A==;
X-CSE-ConnectionGUID: ZaFDMZx5Quq5rVWd/r1yrA==
X-CSE-MsgGUID: Pm61iSwCQaWWwTk43b/mog==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97809956"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000";
   d="scan'208";a="97809956"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 16:22:26 -0700
X-CSE-ConnectionGUID: Fyxh9ubzTkKxFfsWQc+85A==
X-CSE-MsgGUID: zFmBj/mKRRKxelWqDwd5Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000";
   d="scan'208";a="267282898"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 12 Aug 2026 16:22:25 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuIH8-00000000S34-2Fg5;
	Wed, 12 Aug 2026 23:22:22 +0000
Date: Thu, 13 Aug 2026 07:21:57 +0800
From: kernel test robot <lkp@intel.com>
To: dengxiang <os_dengxiang82@126.com>, tiwai@suse.com,
	bo.liu@senarytech.com
Cc: oe-kbuild-all@lists.linux.dev, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	dengxiang <os_dengxiang82@126.com>
Subject: Re: [PATCH] ALSA: hda/conexant: Fix microphone mute after power-on
 reboot
Message-ID: <202608130757.AUMlBDHD-lkp@intel.com>
References: <20260701065533.72517-1-os_dengxiang82@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701065533.72517-1-os_dengxiang82@126.com>
Message-ID-Hash: UH5O6QFUJR6UO3BVXJ64MCGKEYSNFYOW
X-Message-ID-Hash: UH5O6QFUJR6UO3BVXJ64MCGKEYSNFYOW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UH5O6QFUJR6UO3BVXJ64MCGKEYSNFYOW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi dengxiang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus linus/master v7.2-rc7 next-20260811]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/dengxiang/ALSA-hda-conexant-Fix-microphone-mute-after-power-on-reboot/20260813-035114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20260701065533.72517-1-os_dengxiang82%40126.com
patch subject: [PATCH] ALSA: hda/conexant: Fix microphone mute after power-on reboot
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260813/202608130757.AUMlBDHD-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260813/202608130757.AUMlBDHD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608130757.AUMlBDHD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/hda/codecs/conexant.c: In function 'cxt_fixed_mic_boost':
>> sound/hda/codecs/conexant.c:1198:31: warning: unused variable 'spec' [-Wunused-variable]
    1198 |         struct conexant_spec *spec = codec->spec;
         |                               ^~~~


vim +/spec +1198 sound/hda/codecs/conexant.c

  1195	
  1196	static void cxt_fixed_mic_boost(struct hda_codec *codec, hda_nid_t node_id)
  1197	{
> 1198		struct conexant_spec *spec = codec->spec;
  1199		unsigned int value = 0;
  1200	
  1201		value = snd_hda_codec_read(codec, node_id, 0, AC_VERB_GET_AMP_GAIN_MUTE, 0);
  1202		snd_hda_codec_amp_stereo(codec, node_id, HDA_INPUT, 0, HDA_AMP_VOLMASK, value);
  1203	}
  1204	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
