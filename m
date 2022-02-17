Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2ACC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Feb 2022 19:49:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FF211811;
	Thu, 17 Feb 2022 20:48:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FF211811
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645127349;
	bh=aaxSkQVousgo9mD1lX3qPH2hJ2uGtvOppUNnRDzJDOM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gXtvpqGstObfV5qBc8cmZvdHJbj9FpTm0ruyiAzPp0LCexDJFUceYm6aqQ/ZJ1U8r
	 L9TknnKg/b1RQinLqwdV4ZiH3wJ23UOZLzVIl7V2tqniqze+yvcQBzX3eL6NGVN86y
	 lcsx2R4QxViiORbMwDf1mBZE3/vbQy/A+MfV0A2Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB1EFF8023B;
	Thu, 17 Feb 2022 20:48:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3829AF80118; Thu, 17 Feb 2022 20:48:18 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 113ECF80118
 for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2022 20:48:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 113ECF80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Wb8M3QP1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645127293; x=1676663293;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aaxSkQVousgo9mD1lX3qPH2hJ2uGtvOppUNnRDzJDOM=;
 b=Wb8M3QP1TRa//l3YsH19GLnxKL14ldWAZuPdzGkdnS2SdaNSMC2bn/uZ
 LjIq1yLgnVucigLHYY9fJn8I6ao+zRpAUu7eBM3X6/SP991f6tPzvcvIP
 W2WMyR+MNxRSA9IQpudJpzMo+OfKM6msY7dAGkMFLgq3xR+d0khtSjswG
 A1l9Kqkdu4oHUK/wJYyJeRzlApR7uQUbhTgHXpc7OvrJNgf2kmvNLZqz9
 XPFJomxbR+Sk17sVWqkZiglwos/TSXc2kCeCyp8ML8h13ueHqrru3cgbv
 nyLBNqVefGl8URp1DZvFPcDI1DPZhPGMGDQ/Fvk7MiPe8FelhlXg7uYcw A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="311703315"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; d="scan'208";a="311703315"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2022 11:48:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; d="scan'208";a="503216448"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 17 Feb 2022 11:48:01 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nKmkz-0000XK-9r; Thu, 17 Feb 2022 19:48:01 +0000
Date: Fri, 18 Feb 2022 03:47:15 +0800
From: kernel test robot <lkp@intel.com>
To: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>, agross@kernel.org,
 bjorn.andersson@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
 robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@codeaurora.org,
 perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
 rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, swboyd@chromium.org, judyhsiao@chromium.org
Subject: Re: [PATCH] ASoC: codecs: Add power domains support in digital macro
 codecs
Message-ID: <202202180220.7Z94ouak-lkp@intel.com>
References: <1645108786-25990-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645108786-25990-1-git-send-email-quic_srivasam@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Venkata Prasad Potturu <quic_potturu@quicinc.com>, kbuild-all@lists.01.org,
 Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Srinivasa,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on next-20220217]
[cannot apply to v5.17-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Srinivasa-Rao-Mandadapu/ASoC-codecs-Add-power-domains-support-in-digital-macro-codecs/20220217-224032
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: csky-buildonly-randconfig-r001-20220217 (https://download.01.org/0day-ci/archive/20220218/202202180220.7Z94ouak-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/a1e8b5e6a2baa8ce5b2373bfbdfce5a771132448
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Srinivasa-Rao-Mandadapu/ASoC-codecs-Add-power-domains-support-in-digital-macro-codecs/20220217-224032
        git checkout a1e8b5e6a2baa8ce5b2373bfbdfce5a771132448
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "lpass_macro_pds_exit" [sound/soc/codecs/snd-soc-lpass-rx-macro.ko] undefined!
>> ERROR: modpost: "lpass_macro_pds_init" [sound/soc/codecs/snd-soc-lpass-rx-macro.ko] undefined!
>> ERROR: modpost: "lpass_macro_pds_exit" [sound/soc/codecs/snd-soc-lpass-va-macro.ko] undefined!
>> ERROR: modpost: "lpass_macro_pds_init" [sound/soc/codecs/snd-soc-lpass-va-macro.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
