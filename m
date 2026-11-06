Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA3D606A326
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2026 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=DnUey1uX;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ccH4yu8m
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB7A7601EF;
	Fri,  6 Nov 2026 08:41:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB7A7601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793950917;
	bh=CFcVrs6bs1eLMBgvSSHi+fqAiGUDfxi78pedb6ylEIQ=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=DnUey1uXh4jUCGnhuxVgIzpLLlMrDpSR8VZD3C9CgKYoAmo7lp1/Jvdgg/IGpqun7
	 v4HGYSQB4Wdzs9NcpLE7GJ3vvRfFCI3kjGbDtXMPRoKEMZOJKl52do3bWtG84y4EkA
	 9PXlRPCIKaXSbf1n92YDaIcq3+jUVc5QFH4zYJX4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E3D6F805FF; Fri,  6 Nov 2026 08:41:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7DB61F80600;
	Fri,  6 Nov 2026 08:41:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 00195F80510; Fri,  6 Nov 2026 08:41:15 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793950871;
	b=LLcf5rdHLgMt0oQUUb2yPH20f4xh4LPa7CUd6W3rkhi8/fcM9seBF0cueZj1GYoZL7Ia
	 /5QfWSK41tqyAbNTIBJkYR1aR5x31HNUvbIjWfyh4jViyAa97C5E04RVPIHlsUicxBwor
	 kWSqAPwQtQkOsnlA5fq6QFQ0UipikUPXNR6mX4sWMJKBmqD9azRGeT5RCRLNBi8uSaxPV
	 pe5LeTz1tW+XAYUnkFlEnw5X7FkWTmmC/0LygXY2/X1nxQzjHoG7Wx0r4g8ghvtOLAu72
	 v/8889mLnxH4HVRPYw5TRW5hSkjzaNsvQmPZxO2XfhyARZQs5BP/sateDcSu2Z7cZcA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793950871;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=CFcVrs6bs1eLMBgvSSHi+fqAiGUDfxi78pedb6ylEIQ=;
	b=FW1TQwmWahJ32+MPqLzPboUMb/fNeEroKtOU2tyQIoZT1ctMHgVGoDm30clQ81Ioh5wJ
	 ZJcB7pHUkaa1j7ZxgBi93F2CPiykLE7Pru7wjhn1OzMD+dywdQ86VYtsGFGOSOO89D1Lv
	 SUL6Jr/1pgvrokLFoQLJLsilGHLMKlOBXi//ElLvRPC3OJDbNcAve1InQfBE31Sg+noxL
	 FrIREdMx+gotQBdh39+YN8uOO6/Z+l8j2ib94+64hA7fx3rXlL1gEsXr4TNmKtID+sxHG
	 gtCrM8MBMemWQq0f2XggtAN/kHhb76zbtReqzi7vhWJt63n0HIEMa9ioxuJ3rTtx5Pg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ccH4yu8m;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B0756F8024C
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 08:41:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0756F8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ccH4yu8m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793950871; x=1825486871;
  h=date:from:to:cc:subject:message-id;
  bh=CFcVrs6bs1eLMBgvSSHi+fqAiGUDfxi78pedb6ylEIQ=;
  b=ccH4yu8m9eEQ2VEHPX+J9RLZwv910m/Bya4OiOe8VlwIlnuvqbX3ZhUC
   OpkpXpTs3D4K+5AyPTta5OONfDt/Z8r9mFVb5WT67xtIDVN2pi9nUxdFV
   1K3CxCOvbSW/wCbh5JIysyp9mTdZJJ0yoCmTBpWPql1yA1vCm4LS11H/j
   ZabLdhfO1yuJfiDpioQto9bhGDa2CLeS0suCnhH7rsFthIKaC2z8T2lZA
   Zk4RAZMwE8Owpy7n8xMZh3zR6QIu8iwWt1CULFf0gJ77G37hxl8twvhhm
   wqbRXl+OLDB7VHgdYDynd86zKUOB94gP5iSC7vDigR1K68Ac9ir3IFTgi
   Q==;
X-CSE-ConnectionGUID: SJPRw/DTQRijlLCXZjUPiA==
X-CSE-MsgGUID: 2L6QKd3GT0SaCaxzdXq4NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2848372"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="2848372"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 23:41:07 -0800
X-CSE-ConnectionGUID: wXN/ebMZT8WRxP+4mWM8Vg==
X-CSE-MsgGUID: aaHK3UbOS36xFpeQixRaGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="7091720"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 05 Nov 2026 23:41:06 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPEZL-00000000A8V-1v6M;
	Fri, 06 Nov 2026 07:41:03 +0000
Date: Fri, 06 Nov 2026 08:40:58 +0100
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org
Subject: [tiwai-sound:test/sound-rust-v7.3 2/56] error[E0599]: the
 associated function or constant `new_zeroed_slice` exists for struct
 `rust_doctest_kernel_alloc_allocator_rs_0::kernel::alloc::Box<[u8],
 Kmalloc>`, but its trait bounds were not satisfied
Message-ID: <202611060812.fRcN8aWV-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: L3K2DMXPETAQBA3VMP2Q7UXRGNVFLEQQ
X-Message-ID-Hash: L3K2DMXPETAQBA3VMP2Q7UXRGNVFLEQQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/L3K2DMXPETAQBA3VMP2Q7UXRGNVFLEQQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git test/sound-rust-v7.3
head:   070444a8abf14da700680a5331d0a95cd11e578b
commit: 9985fb1d439627f74610170aeabe7b590f6b5145 [2/56] rust: alloc: add Box::new_zeroed_slice()
config: x86_64-randconfig-2302-20261105 (https://download.01.org/0day-ci/archive/20261106/202611060812.fRcN8aWV-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
sparse: v0.6.5-rc1-21-g84ec0658
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611060812.fRcN8aWV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611060812.fRcN8aWV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0599]: the associated function or constant `new_zeroed_slice` exists for struct `rust_doctest_kernel_alloc_allocator_rs_0::kernel::alloc::Box<[u8], Kmalloc>`, but its trait bounds were not satisfied
   --> rust/doctests_kernel_generated.rs:469:23
   |
   469 | let b = KBox::<[u8]>::new_zeroed_slice(10, GFP_KERNEL)?;
   |                       ^^^^^^^^^^^^^^^^ associated function or constant cannot be called due to unsatisfied trait bounds
   |
   note: if you're trying to build a new `rust_doctest_kernel_alloc_allocator_rs_0::kernel::alloc::Box<[u8], Kmalloc>`, consider using `rust_doctest_kernel_alloc_allocator_rs_0::kernel::alloc::Box::<T, A>::from_raw` which returns `rust_doctest_kernel_alloc_allocator_rs_0::kernel::alloc::Box<_, _>`
   --> rust/kernel/alloc/kbox.rs:177:5
   |
   177 |     pub const unsafe fn from_raw(raw: *mut T) -> Self {
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   = note: the following trait bounds were not satisfied:
   `[u8]: Sized`

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
