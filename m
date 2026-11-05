Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E96E606A31B
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=ngQ7Qwsa;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eb2eKYnD
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65C34601E3;
	Thu,  5 Nov 2026 21:14:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65C34601E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793909666;
	bh=0z++K7EFByBu2htfgx671oiMl5Rb9T6wO61BPNWMO2I=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ngQ7Qwsa+OvQ0DV4tmzlQs1t3oHPlJ/QwCf3eE50hwn/XwMZqyzxvlzT0xHK+7XSn
	 mJ1lrS0aI/o409fVwLACOFL5EKpOdcUOaPtQUoEPCUi46vHWgK/DF1Cjm4oiYXByHB
	 yJHlZvmFWY/PZk7ojbMV3g8zy1kFybPz0WbyTmvE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76E9BF805F6; Thu,  5 Nov 2026 21:13:52 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7DEE3F805F2;
	Thu,  5 Nov 2026 21:13:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 36E23F804FF; Thu,  5 Nov 2026 21:13:46 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793909625;
	b=DSfcaz9B9CH7BOoiWg1c9R7NaRoYB+Jrdhyc5MY9uZWPzl0+3f5KXSQIHqTOEJMzlEz4
	 9MtUEUa4hicI5JMc4hmDrcLpX51j5z5JxlQGw32SL/z9LnhWPchCzM0YLMZtlxlgVnUCr
	 oVNVkxGLPpJHhDFvblCoQp0DJqi/YD7Ek60vpKGHS75hEVxS+jqBUmnI+XkXWwdZNOnBt
	 XyINoUyoTl3LZDD1ZxuRAtfEiJc75L8HhIqUoN5KOSY1HeveC8Ygd7q853CGbNSb1Ayj6
	 /JboeCDBk6a3QQ/8/B/ne3/a8+E+8e+DJkUbpNjiDB8v0Wuo0zs2BWb6WcKXyFIL0jw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793909625;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=0z++K7EFByBu2htfgx671oiMl5Rb9T6wO61BPNWMO2I=;
	b=GSgTLF+vre7ZneJ3kG1hUcsC3xxy5OjMO7bH8LtZ5vBADATudk9BvzcJBKHL5u21sf2d
	 3pBbsVUC17n/TaAXpYibbmSsQlydheTqFKH2xCn16ze0BLZ6Ic+jwBQlMBNWTf+vvWmO0
	 0/yXaoazdacnn9ApHgxEhDyxZPw35Qyy+OJnT+pNXSIx6wIEm9JH3jhXlUG1GXIKzXxUc
	 noBVs3gEiyCms9GBA5Aqg6rzHT9gsH6Px5BZEMBBZ9ZS2BrGEWwppQYB38iOmOkgsIy3x
	 CSL9sVfvFbockeIzXnc/X2dPrekcNtZtmlDJLjwKQKahZ8mNzxjgko5TBlz6JthLqGA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eb2eKYnD;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AC311F8016D
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2026 21:13:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC311F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eb2eKYnD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793909625; x=1825445625;
  h=date:from:to:cc:subject:message-id;
  bh=0z++K7EFByBu2htfgx671oiMl5Rb9T6wO61BPNWMO2I=;
  b=eb2eKYnD9hF+0lEsgw9+93XdR6uwz6rLO6yXmi5U7WyO74v4M/oAGcgw
   CMtmzMrrRtpiBRA6sy6v34tKUcR35IaQHoU7czzIHe8Cf51jMHNEDO/mc
   82rIQZzMMVbfzEwT3iSp6xWxClnGnRSnPUNiysdIpcRqwmw/2QwWVyK+g
   r0XbaL4TRR9D+9pgoWmRwgqvogzHTAuEfKPfcU1x204H4MxS4OOmniU/V
   OHZ/1VrLkabvzdIB8IPwrVeiHVcaSNphzzUHPuBUUqDA2/LtQjlvrW8eg
   HOtt+/T1I0KzAbVAgSxpPCEcOr+CM0ErqlE0uaw5mocmKiFxz5EOeN6jg
   g==;
X-CSE-ConnectionGUID: Tnv9PTVqQiqD7KkIp0cc0A==
X-CSE-MsgGUID: z9bY0lPzS3ut5kzBp87SCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2630892"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="2630892"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 12:13:40 -0800
X-CSE-ConnectionGUID: GJE1j10RTnuL+XXw+TnYUA==
X-CSE-MsgGUID: JU3/3YVVT8yhzUxPGkT/Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="7247541"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 05 Nov 2026 12:13:38 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xP3q1-000000009n1-2JnT;
	Thu, 05 Nov 2026 20:13:33 +0000
Date: Thu, 05 Nov 2026 21:13:28 +0100
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org
Subject: [tiwai-sound:test/sound-rust-v7.3 5/56] warning: reference
 as raw pointer
Message-ID: <202611052152.RyP1WBkt-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: QNP4T2VCWJSBFAUS6DZJM3U2IW25XSLY
X-Message-ID-Hash: QNP4T2VCWJSBFAUS6DZJM3U2IW25XSLY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QNP4T2VCWJSBFAUS6DZJM3U2IW25XSLY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git test/sound-rust-v7.3
head:   070444a8abf14da700680a5331d0a95cd11e578b
commit: 79a5b63f9f837d360951e298544c4f69e9051078 [5/56] rust: module: add support for string parameter type
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20261105/202611052152.RyP1WBkt-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611052152.RyP1WBkt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611052152.RyP1WBkt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: reference as raw pointer
   --> rust/kernel/module_param.rs:118:37
   |
   118 |         let arg_static = unsafe { &*(arg as *const BStr) };
   |                                     ^^^^^^^^^^^^^^^^^^^^ help: try: `core::ptr::from_ref::<BStr>(arg)`
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/rust-1.96.0/index.html#ref_as_ptr
   = note: requested on the command line with `-W clippy::ref-as-ptr`

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
