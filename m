Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C708606A328
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=ry1iN/Po;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mgy2cu+c
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F270601D3;
	Thu,  5 Nov 2026 22:26:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F270601D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793913999;
	bh=goTlMdDDwVSzYjrrufrV1Ronxk1B09FoPYelTQTASN4=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ry1iN/PoHck6YK8hbZMa4JhfwGoUjvCAb6jsCNN1ky+tfShw3nTef/t9pyNG9n8dG
	 H4PoCnzsL/FcLO+sfiIdzHrtxrutXLw2Ic9ODdHD9fzx2jYG/ASNBRf5EDWSuzhBCJ
	 ISsSIeHF/47zGit7qdjbsqy1WjVjZwxVflDujUpY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2DE85F80603; Thu,  5 Nov 2026 22:26:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 79324F80600;
	Thu,  5 Nov 2026 22:26:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 916A9F804FF; Thu,  5 Nov 2026 22:25:59 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793913958;
	b=g+62UZ6AAzrIBG/eCBx7buoVnZXnH5YVpJHxSaAvHOvEvnkkmzV9+DRCT8Zj7zCP4uhi
	 Kr+LY5hnGd4wJRhRbppeZvfLNFyCPzX4PwFLuyp09fgA6ZHxMLCDuaMaQ9ac0gjfJ1rin
	 7uhiKW33nhC6vP5c0ka1ozkmEgKVcxUwmqcRv6ZotT168Yt1e5HHGIzjMU9PIjPVfHElW
	 MIiIfo+zlLzsX9vOPVUXXfvg7HH5oN69b+lQuY+qfshkmPLKVq0aS+WnL0dtb0DMh4QRq
	 ZV0dWgAEf8x9XyV0YNRo3xYaYxv+EdWPa/fTpKP6dvVtP/WC96Z54qY4OYNZqyguPJw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793913958;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=goTlMdDDwVSzYjrrufrV1Ronxk1B09FoPYelTQTASN4=;
	b=F5U9JzGVkw/v/JX2Z58B9HDKMSr4CsBL64r8hmUAjaiPy0O1oV68Lm1mixY7wb0gkJ1N
	 hkwwMhinSJ4fSQ0Egk1LYwIBh86AKsy/qEYKesv2aAQ3P7ZZ/BxwKwG85fYRHVmIp/5Pn
	 Fk8k1WRwUqN0lrKDpab18U8toLUV5RiLQAA4fAq+lsD1YUuLEy8NklcBWqPbxjGoruEmv
	 bAlyy/Vh9KjNPQvlxajSu3mtZsXAuToKcbcwSo4b5G6y306c2KRqcTp6H6HCBlyQ2pbvW
	 YilI7wr26BXhrISjB6sA2LTQeoRt5ADT2b4kATCEXeF2Dk3KpYo1zoBEw7LXY2GSRrg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mgy2cu+c;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 277D8F8016D
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2026 22:25:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 277D8F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mgy2cu+c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793913959; x=1825449959;
  h=date:from:to:cc:subject:message-id;
  bh=goTlMdDDwVSzYjrrufrV1Ronxk1B09FoPYelTQTASN4=;
  b=mgy2cu+cdHafcUlUQlkiqvOUnTIWcLWAeeeRtQ3BFAmU4blKSanB8AE4
   pRVYnvaqUDlAiQK8ORTrKMu63V55rTDFDaL+bFJB7JMga5XaMxJHKY4Fq
   48FiuTIS49vAzhQOpLLN59wx/ssflDx2ZEsnDZVu1GtdYA+t4Q895gtmx
   pDCZcdvo0Xzgcuhr42MH6js1HWSylLO7dke8fQIYo0iCIFWUgqgbVwShl
   6Zqp98bi5eDySFAk5J8zgGYvaMpENeUm/ANis57TgynvNww5rk5Su/835
   yRaotKLp6ACZDNxw6YkqyVnyAMOxRrm/liPdD+HUuN1RL9Zr/1X1yC39k
   A==;
X-CSE-ConnectionGUID: meREFtiuS3GlKALxQ+gD5g==
X-CSE-MsgGUID: 00CdJuceRp+iixD9mhgHgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2606846"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="2606846"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 13:25:53 -0800
X-CSE-ConnectionGUID: iMA8ocPQQKiimm152XJFjA==
X-CSE-MsgGUID: N5YXU8IkRTqbpsHIZViTDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="7022205"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 05 Nov 2026 13:25:51 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xP4xw-000000009o9-0KEx;
	Thu, 05 Nov 2026 21:25:48 +0000
Date: Thu, 05 Nov 2026 22:25:47 +0100
From: kernel test robot <lkp@intel.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [tiwai-sound:test/sound-rust-v7.3 7/56] error[E0425]: cannot
 find function `pm_runtime_barrier` in crate `bindings`
Message-ID: <202611052257.izHDrnRN-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: W5SZWDXSJCCX24TEE3XEM5BAQCZEYGBO
X-Message-ID-Hash: W5SZWDXSJCCX24TEE3XEM5BAQCZEYGBO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W5SZWDXSJCCX24TEE3XEM5BAQCZEYGBO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git test/sound-rust-v7.3
head:   070444a8abf14da700680a5331d0a95cd11e578b
commit: d5dd8d4a1fbe95ad79dc47b8b6606b6fcece0c82 [7/56] rust: add runtime PM support
config: s390-randconfig-2000-20261105 (https://download.01.org/0day-ci/archive/20261105/202611052257.izHDrnRN-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 0fa861dbbf46e5a75f621406fd91cb015d8754bf)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611052257.izHDrnRN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611052257.izHDrnRN-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> error[E0425]: cannot find function `pm_runtime_barrier` in crate `bindings`
   --> rust/kernel/pm.rs:1004:23
   |
   1004 |             bindings::pm_runtime_barrier(self.ctx.inner.dev.as_raw());
   |                       ^^^^^^^^^^^^^^^^^^
   |
   ::: rust/bindings/bindings_helpers_generated.rs:1555:5
   |
   1555 |     pub fn pm_runtime_active(dev: *mut device) -> bool_;
   |     ---------------------------------------------------- similarly named function `pm_runtime_active` defined here
   |
   help: a function with a similar name exists
   |
   1004 -             bindings::pm_runtime_barrier(self.ctx.inner.dev.as_raw());
   1004 +             bindings::pm_runtime_active(self.ctx.inner.dev.as_raw());
   |
--
>> warning: unused variable: `dev`
   --> rust/kernel/pm.rs:380:15
   |
   380 |     fn active(dev: &device::Device<device::Bound>) -> bool {
   |               ^^^ help: if this is intentional, prefix it with an underscore: `_dev`
   |
   = note: `#[warn(unused_variables)]` (part of `#[warn(unused)]`) on by default
--
>> warning: unused variable: `dev`
   --> rust/kernel/pm.rs:385:18
   |
   385 |     fn suspended(dev: &device::Device<device::Bound>) -> bool {
   |                  ^^^ help: if this is intentional, prefix it with an underscore: `_dev`
--
>> warning: unused variable: `dev`
   --> rust/kernel/pm.rs:408:22
   |
   408 |     fn get_if_active(dev: &device::Device<device::Bound>) -> Result {
   |                      ^^^ help: if this is intentional, prefix it with an underscore: `_dev`
--
>> warning: unused variable: `dev`
   --> rust/kernel/pm.rs:416:24
   |
   416 |     fn runtime_disable(dev: &device::Device<device::Bound>) {}
   |                        ^^^ help: if this is intentional, prefix it with an underscore: `_dev`
--
>> error[E0425]: cannot find function `__pm_runtime_disable` in crate `bindings`
   --> rust/kernel/pm.rs:1003:23
   |
   1003 |             bindings::__pm_runtime_disable(self.ctx.inner.dev.as_raw(), true);
   |                       ^^^^^^^^^^^^^^^^^^^^ not found in `bindings`

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
