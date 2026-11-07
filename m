Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85270606A32C
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Nov 2026 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=OvLSbAse;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OAIQTIU/
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 416C2601EB;
	Sat,  7 Nov 2026 10:52:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 416C2601EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794045138;
	bh=ep4uHUzZwNSf8xIZ0csL6LCecUe/UPzRGkeyq+qfd2M=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=OvLSbAse9HEQAulvY1mpY1Ck77Duz/MrW6/2x0uxq1YbcY+qd052doF5hswjKRFGa
	 KMduxzrLHzJc3v/Wa6tTkg6CtD+jKs2TVlQ1/pvX2yR+fWPMbYCN46QQXH8MX3NZS2
	 UTVFFNXkRG3JNBkFkWWD6Rx2CnFvxojM807v+0iE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40B1FF805F9; Sat,  7 Nov 2026 10:51:42 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CC5FF805E5;
	Sat,  7 Nov 2026 10:51:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D62EDF805A8; Sat,  7 Nov 2026 10:51:34 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794045090;
	b=c1s68IGE+Xbz/aNQ+tlEu3lwAQ1tWNdUMKrS8GA7NX/kBULLBiRBQBTYQTKicKcd72W3
	 pVlfj4SKerc2XPdLpttV7nKNJq96MT3sJzGT9bXdr4deENZ2DIwNIhtlEvI2UIwbyIz6d
	 qv7GB2r6ZM8cQwc+H12HIpM1Eyu4HmZJsI+yW6VRQCYV/vp/OK2UryUXAH2X4TkmINplN
	 ajLYUCKNTz8mRUX4aArngWWhcTXL9ABccoagE34qu7JayAwlnA76LJU/gqXH70KCxsccc
	 vymjOFepn9Ipoz024Il563wH0NoWLfxIAvVrO65tLp70pfB2wGjK1s/TKgWyXxTfIhw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794045090;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=ep4uHUzZwNSf8xIZ0csL6LCecUe/UPzRGkeyq+qfd2M=;
	b=cIIdG1PhCdRjBOfk+nnfQD39LDUKw285/ChElrA024R8M7k+Lx2u+sVxgUKDu7/w4fj4
	 KfRMtbITQL6WjYf6Crf+7HDg94wXuqpKQ6MkWdRi4IJPPSu7CzaZ+cdsS3r69mgUZBV+/
	 xWpT4JWeDdkirLsQnImDEURb18ZLpJ2ZtJK7pLpV/zoA0lVYbcK6qn4+789N2Hoyn6b5Z
	 aY2guAnJ29PInWIn9Tm8ol/z9sD4EghAJ76Ozk049QkT0cUFU9XW2Z42czLOLlhGNxFik
	 E7jXnBnM/eg1WJ4N6UnpJWoNvUhiHtLEK9WS1aDIgUe/AO/CALOW+NA/4rU+8hHsShg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="OAIQTIU/";
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BDFCAF80538
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2026 10:51:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BDFCAF80538
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OAIQTIU/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794045090; x=1825581090;
  h=date:from:to:cc:subject:message-id;
  bh=ep4uHUzZwNSf8xIZ0csL6LCecUe/UPzRGkeyq+qfd2M=;
  b=OAIQTIU/PDXySefUKfimttlcmiw3uB1JnsY7Aa8GvWNNqSrmi0SmdmKT
   yfk1Iejxh6oxCJ592Ht9l0GlS4EO0tDtEkkbOiVq2kNwAkWnIsSGjCezT
   DrEJN+/QQhX6kXQgh4TpO1chUIRPhhGVbedcaAtqaZTsifm7LS0UxvxMm
   3k+hF44r7nEtYAgp7JLoiFURo71VyEfS28LE5fe2pPWsHV2Uy1IJsJA4L
   kNePikVppEcAp0SwEfTOwXI/V/DT9nHMpbJWYFn9QA4F5OotZLXQLSz+h
   iGxp0S8Y5Wfjx+yXg7tjq/hMe6361MpfImUZRlM+0smnz2cEUf8zl1KBe
   A==;
X-CSE-ConnectionGUID: FjEvo4f4S2aOt1yh5BTisg==
X-CSE-MsgGUID: Gh7getdAQyKDXge5qq/HPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2884415"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400";
   d="scan'208";a="2884415"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 01:51:25 -0800
X-CSE-ConnectionGUID: t95IFQAmTHOG8XXh5O5wgA==
X-CSE-MsgGUID: BrKsLq5vQSyyrTR/CB660A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400";
   d="scan'208";a="7337394"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 Nov 2026 01:51:23 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPd4y-00000000qfZ-4AE4;
	Sat, 07 Nov 2026 09:51:20 +0000
Date: Sat, 07 Nov 2026 17:50:48 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 alsa-devel@alsa-project.org
Subject: [tiwai-sound:test/sound-rust-v7.3 2/56] error[E0599]: the
 associated function or constant `new_zeroed_slice` exists for struct
 `rust_doctest_kernel_alloc_allocator_rs_0::kernel::alloc::Box<[u8],
 Kmalloc>`, but its trait bounds were not satisfied
Message-ID: <202611071750.G3OBAifp-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: HEPYY2COB77YLKXTDLR7CQKEY7FM4KWC
X-Message-ID-Hash: HEPYY2COB77YLKXTDLR7CQKEY7FM4KWC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HEPYY2COB77YLKXTDLR7CQKEY7FM4KWC/>
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
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20261107/202611071750.G3OBAifp-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261107/202611071750.G3OBAifp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611071750.G3OBAifp-lkp@intel.com/

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
