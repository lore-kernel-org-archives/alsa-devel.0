Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3348606A9FA
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Nov 2026 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=u+vuO3TT;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XR3s1wb8
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30951601D2;
	Sat,  7 Nov 2026 16:19:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30951601D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794064783;
	bh=9mNlYNZ/xZ7bVe9/c/eZjr3BTb8RfVSjPGvI7lCaY1Y=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=u+vuO3TTg3ErMAjDVZLKI04i2YqBbaMcFz9UPOasRorVYLjInvnehcKpA2aD9+GXh
	 2bdgCzsskRYsJYECgMFXWfD6LDyoB6RpAnBiq3LFFRVvZEgPXWDOh6ouLtrx1/QQIp
	 rdiBqGdXeDvq9U6VxxPpy/o8W9D38HMJAQRusVdY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3470F805F7; Sat,  7 Nov 2026 16:19:10 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 66AEFF805FA;
	Sat,  7 Nov 2026 16:19:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B0C7F805A8; Sat,  7 Nov 2026 16:19:04 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794064740;
	b=NK3OsEfQ/XIQmMXv1iBIvgiTvMKMDApIMoteYWH83hJEzcG89m9zOWaT4X7d86XmSRcT
	 ZfTKkvYAmboylI5pbzVU44r2OSnSQAQPx4H9gkR2mIBbvXW6SN2xwegyVDyw2JF405FO3
	 qOciDdm1sx9zVU7jEPStcRhOwxZPG2r3nlWVbMdEe9NEPLg4TLk8QyuBK1/EqXa+UhQoW
	 f26a2C1zN+uTWxMr2xk5Jmwjg4JEsDUNNUjUrdOx1ZTSqcZ8RvIpcHaV8AeDwcNl93qS+
	 PquhsnqTu8BnyOrQtIC5liKNyxSJYI8vYLgIB4tV72E8X8y9Do4ecDaXyVts7ewHUtw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794064740;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=9mNlYNZ/xZ7bVe9/c/eZjr3BTb8RfVSjPGvI7lCaY1Y=;
	b=mFuT+VfXMVRE007rmw9AyaPkVDKRBTUPF6HTgEmoL/rFJdmcKLdOprWrpCBFW8eSvUzE
	 VZO3nJKBdES2MSpFlVyLcOd1LupLcxeJ70GfdnyrxoWkIwvRpOmuuZ1By6Ar5RGd/gce+
	 4hAQlRGMVLOeHbGe9JrecFj/55GClHIrVGdPKiORXw5xneBSY2oTd7Rpx875CtiHTQDnB
	 90mrTI8+F1kDKwlerv4adCoDeDG2z6SHio1cEC0l9kfWjoG2k2JzfjOOaOw4uM2JBxuCW
	 B9aR6/A3/hFMnBTlld2woJJYfTlygevKpoqsjN5Yd/+p8hvCeGFB88I6muopaa041RQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XR3s1wb8;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4772AF80212
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2026 16:18:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4772AF80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XR3s1wb8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794064739; x=1825600739;
  h=date:from:to:cc:subject:message-id;
  bh=9mNlYNZ/xZ7bVe9/c/eZjr3BTb8RfVSjPGvI7lCaY1Y=;
  b=XR3s1wb85kbTLz2CBFooYz0VXIQ7EK8EjmpdpF+T2nw1hPdONBre7H8Z
   MsySpaVGuDD3fx+/lweX+27W1Hblm8I3sKHnTMeKUljr0rg2D20YDYj0m
   KRLA4aHtXM29vA9NsFRVi6SusxE/z5q2EtfWrSMMv4czVMIxJ648OITuX
   qMuu7qbaKP3JUeA0GcWHJ2tAaqQ8CUHB7KKIAOmMq4uKRKLBHrVBtkgy8
   Sb1nC+F5VLAsalGlroaWU+VeDnnC8rqT8rfQGbhwIdkSXnwsHfh6k1ZOF
   ldpN7vf6aL0BcVmk1+6FTvJb4G8Kq5skXpclsaHcZY1KRYh1+X/AZMnnE
   A==;
X-CSE-ConnectionGUID: YwF333U2QLKVd282EGxINQ==
X-CSE-MsgGUID: EuD82nHORri05pZz7lOdJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2736220"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400";
   d="scan'208";a="2736220"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 07:18:53 -0800
X-CSE-ConnectionGUID: PRW7U6GIRpq/d6N37LxOWg==
X-CSE-MsgGUID: 5pfOZH8LRdGzPbUiDSvycQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400";
   d="scan'208";a="7509768"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Nov 2026 07:18:51 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPiBs-00000000r5a-3snk;
	Sat, 07 Nov 2026 15:18:48 +0000
Date: Sat, 07 Nov 2026 23:18:08 +0800
From: kernel test robot <lkp@intel.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [tiwai-sound:test/sound-rust-v7.3 7/56] error[E0425]: cannot
 find function `__pm_runtime_disable` in crate `bindings`
Message-ID: <202611072326.mCG6WGQe-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: TFSNHZVEXF56XHPFZITWACREO73UXW56
X-Message-ID-Hash: TFSNHZVEXF56XHPFZITWACREO73UXW56
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TFSNHZVEXF56XHPFZITWACREO73UXW56/>
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
config: x86_64-randconfig-1013-20261107 (https://download.01.org/0day-ci/archive/20261107/202611072326.mCG6WGQe-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261107/202611072326.mCG6WGQe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611072326.mCG6WGQe-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> error[E0425]: cannot find function `__pm_runtime_disable` in crate `bindings`
   --> rust/kernel/pm.rs:1003:23
   |
   1003 |             bindings::__pm_runtime_disable(self.ctx.inner.dev.as_raw(), true);
   |                       ^^^^^^^^^^^^^^^^^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `pm_runtime_barrier` in crate `bindings`
   --> rust/kernel/pm.rs:1004:23
   |
   1004 |             bindings::pm_runtime_barrier(self.ctx.inner.dev.as_raw());
   |                       ^^^^^^^^^^^^^^^^^^
   |
   ::: rust/bindings/bindings_helpers_generated.rs:1615:5
   |
   1615 |     pub fn pm_runtime_active(dev: *mut device) -> bool_;
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
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
