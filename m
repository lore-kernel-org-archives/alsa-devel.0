Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590E606A326
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2026 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=YKUaA2F+;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WfiMOPW/
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4AD3A601E2;
	Fri,  6 Nov 2026 22:08:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4AD3A601E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793999316;
	bh=mNWXcQyMHSHmYjjF+ErQ3qO51LSnxf+/Umo4VPw+vMw=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=YKUaA2F+owMciuKWvt0yTP1C2GDIQsP2Rdtdszm+s1uMV2rNs6AjJ62AQ6UG6PTBw
	 j52HVS+KlChYe8kOHaEmYiDMnkYLsrERLdOIDlYoHIyfBxDZbJn3+/M9U8TJV9kjiA
	 FQgNp8SjVtBBNsf6NCR+oupIMqAZS1SxqIZpoZEw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0500F805FA; Fri,  6 Nov 2026 22:08:01 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 34EC6F80600;
	Fri,  6 Nov 2026 22:08:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AE5AFF80510; Fri,  6 Nov 2026 22:07:54 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793999270;
	b=OF6yKDIHEcJQQjFuB2aatVvoQxiNZwYyAnIKdKd6lVNIDkd2Zz1PYbBauB/2u4ItYdse
	 +0fod7FSPe3BN5d4Bl8ea9dvzrBFSYjS0yPuKOKjwqduedV/CTt0gu6gUR+u6UU7lbLZI
	 e3dyEH8Zmq2GSn8byZrca894yjR3I/WEckmFpmssln4NnHarmfDDf6RV/8J8z8A/G7ZWJ
	 I2Am4cWZgFMjgnod2IQ6IolqDajOONVojyCJA4v/ezs00p0HLy8aO33cWwz5O2TKxoxdk
	 d1gcO/NMlZhvdB+PcY0Av9eh2iwteVphG4TOVOo37NXCtMpavs/5SgRYae8q2Zs+25w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793999270;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=mNWXcQyMHSHmYjjF+ErQ3qO51LSnxf+/Umo4VPw+vMw=;
	b=l5V7XrWaWZexYA7eK+Cxvx+RABPA8sspsCQeMRNip4WoFUnv5ygoddXTrSRqlsRLr5fj
	 nBfm82SO5ctSBYB7NfnfUUke85Iz+ud5fnbR8Rreu1WukUvmBa93NcpL1nnLaUjEuz30v
	 gVWk9yCsckK/ZYZvZYdbbRHmeiu6eWqLinQHuba7opHs6gRivwyGzFNWkMIoDeh7wS2Gz
	 7drcMxfE2Tsp9125BopBd1jWmTpQqyjLCsrJCuZnHDMlzMdcql7DYDWWhGMSseFLFmshK
	 vGXo2+5171tyBQnkmcmFim/dy2aAapNWONl2TfVMc7CYMTVnb8QlxQ8BDsIOzJSLAkw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="WfiMOPW/";
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AC02DF8024C
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 22:07:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC02DF8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=WfiMOPW/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793999271; x=1825535271;
  h=date:from:to:cc:subject:message-id;
  bh=mNWXcQyMHSHmYjjF+ErQ3qO51LSnxf+/Umo4VPw+vMw=;
  b=WfiMOPW/4F8MRCRS1rn/WnzrZaV5yy2WkazpHR0XXIfI8PSIebmkymca
   cr2bnCcSDUnIbyzstslVmLqD0ENtHrVRV6tRuq9EitINZITWiLrIBIbCy
   WyS0RAh9AjslFRipvg3Sor71ldzwheszXGvQNM6rmScKY7RcpXDdpKr/K
   ZpHNPBH0CBFfl/EpaKaXtqTbO+/8tz2HPV+tCjNxoPPQcw2mgp0swQML1
   vompbz0HMpYqEaRsB7WJJnr8dUt0LJr5oxkYWv+OgLrdkhkHZKY2I6O0T
   hKZbuYQa7vHabKE1hJX4ZYb5NQic56oqhBce9g1jRNiyOCjjd/5RFdX2z
   g==;
X-CSE-ConnectionGUID: X/u2ZwvTRYGwe7mfnEBcEA==
X-CSE-MsgGUID: 6S1Ana8YRhWTIwdObt9sJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2719720"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400";
   d="scan'208";a="2719720"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 13:07:45 -0800
X-CSE-ConnectionGUID: rK9lnQn2Sr+Jb19rR5bmmw==
X-CSE-MsgGUID: rk7JVfquQmuss6a8ocNDpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400";
   d="scan'208";a="7355638"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
  by fmviesa004.fm.intel.com with ESMTP; 06 Nov 2026 13:07:43 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPR9x-00000000AMj-0CNf;
	Fri, 06 Nov 2026 21:07:41 +0000
Date: Fri, 06 Nov 2026 22:06:54 +0100
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org
Subject: [tiwai-sound:test/sound-rust-v7.3 42/56] warning: `as`
 casting between raw pointers without changing their constness
Message-ID: <202611062249.snPBEWys-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: GCUZDACGMFLOJVRUWS6Y7VCFYLHF42P4
X-Message-ID-Hash: GCUZDACGMFLOJVRUWS6Y7VCFYLHF42P4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GCUZDACGMFLOJVRUWS6Y7VCFYLHF42P4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git test/sound-rust-v7.3
head:   070444a8abf14da700680a5331d0a95cd11e578b
commit: b172ad8bf456b4d29c21afeebf24dba090c8a62e [42/56] rust: usb: Add safe mutable isochronous methods to Urb and UrbData
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20261106/202611062249.snPBEWys-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611062249.snPBEWys-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611062249.snPBEWys-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: `as` casting between raw pointers without changing their constness
   --> rust/kernel/usb.rs:883:21
   |
   883 |                     urb.transfer_buffer as *mut u8,
   |                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: try `pointer::cast`, a safer alternative: `urb.transfer_buffer.cast::<u8>()`
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/rust-1.96.0/index.html#ptr_as_ptr
   = note: requested on the command line with `-W clippy::ptr-as-ptr`
--
>> warning: `as` casting between raw pointers without changing their constness
   --> rust/kernel/usb.rs:913:21
   |
   913 |                     urb.transfer_buffer as *mut u8,
   |                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: try `pointer::cast`, a safer alternative: `urb.transfer_buffer.cast::<u8>()`
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/rust-1.96.0/index.html#ptr_as_ptr
--
>> warning: `as` casting between raw pointers without changing their constness
   --> rust/kernel/usb.rs:982:24
   |
   982 |         unsafe { &mut *(self.urb.as_ptr() as *mut Urb<T>) }
   |                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: try `pointer::cast`, a safer alternative: `self.urb.as_ptr().cast::<Urb<T>>()`
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/rust-1.96.0/index.html#ptr_as_ptr

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
