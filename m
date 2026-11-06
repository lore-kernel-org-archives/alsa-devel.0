Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09987606A326
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=JkbXF/yX;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eSoEenbn
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04664601E3;
	Fri,  6 Nov 2026 20:42:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04664601E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793994151;
	bh=8NYsY5LS5YysIdqHvLuvm6y10d+JDyLcOS7i2UyNj6s=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=JkbXF/yXdi6be13FZtS6syy+BxxCgoZRtV0CM8HA8UOu86SIvHPbLTDHZ1gau7/pi
	 S92jpqEUWLu/h8v+ZEqyBQoFoExFQn9ATdXT0K1RroTAnVLCOSdbt5NOmKn4S9Oc/d
	 ztfgZ/KQu8Swe0vY5B/ygR/NvGJAE3Xg9U3cy8Eg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 36561F80600; Fri,  6 Nov 2026 20:41:53 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 62073F805FF;
	Fri,  6 Nov 2026 20:41:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E669EF80510; Fri,  6 Nov 2026 20:41:48 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793994104;
	b=dS2QeWCucD8gMiowHzHpqSIXBHLZsCnFrxEqL5sbsz55EkHv1hSSIxOdLWLanXAD3OkD
	 tkwOdXx7is6PZrGv5eygbzoLlGrmKrqrtUiJNgqtAqVRDf8PQVCgPJj0RvqEX/L8UAndt
	 VMtaRkr3SMfTXgqA3QpeBc3ftqCutn5pkhBv/RXy+MrwXzaE1HeJ5BItlCMwGOyicITZQ
	 D+xbgmY5gLhYY8N9nguuVkmx3fMio5Y78rT7ZUuEXht1waFUvm84hAhtKPQ/agTjd6eMS
	 hnxCNkRBZNEoKMQYsNj34epCY511wOuWZGa+soCwK2I+M3eaa/vehtrGktmrBdfPcVA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793994104;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=8NYsY5LS5YysIdqHvLuvm6y10d+JDyLcOS7i2UyNj6s=;
	b=ik1MGiGGcfbBUOLlr0OKHjEFMUgiSssW7HN2XSoBNKRbcoUE1ls3CHuOV4VjYD1LLo/i
	 +RYt0wSHuqPrFGib6m+F3Sx7fc1PYuj/EfwAW0Bu4W1we3VAZFart3vi1IdE49pJsQJub
	 5Gjp3vrUSNbbD0QSuG/sfik/+l6Qx6Xe9yMEKlztLPAEfeqO27wF78QkeeULILZoN8R92
	 FIJZXlZlI+UnoCEg916PUEX3iYE65wpdwdA6GxN92XHN3InFGrqdK/irLpUGr3DBzqv4r
	 t9WfeZOhyTpTdpnuZfBzFVTlc4gkUDu2DtJcR74h8FOpIsZ5G4QOSnYqndch7pzI3BQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eSoEenbn;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 518EBF80124
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 20:41:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 518EBF80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eSoEenbn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793994105; x=1825530105;
  h=date:from:to:cc:subject:message-id;
  bh=8NYsY5LS5YysIdqHvLuvm6y10d+JDyLcOS7i2UyNj6s=;
  b=eSoEenbnU933cPvZZ8rSwIf+d10lo0aeig9G1RWpjjawk6Eqm8cDWvSw
   HHxIH/Pp/tzHf444RJBCFsy3ZpgPHoY7WQxXImeO3dMkDwUTMbUkqlloY
   5afOWShIVoHu+MNQcxPVZ05UAevZWjtYlvthb3+8ogc875cyTou+ZEXCy
   faklbFYpbmPJDAdWBCsDP5OAjiewFO/0vfhK8nlPOKJmIukpbiUpjASFh
   dVS2P4GMkwZietYQCGGpzdRb+OWKz6SwROaPBKKL6E+U4JECJlYw/rQXG
   mrv2LkEQLH5XGUdzQbHAwOdF2mw3Fzmln4KGh8tGoYW7l1RtHwHSaaR8Y
   g==;
X-CSE-ConnectionGUID: OqLmGnYmScCllR/VtUVryA==
X-CSE-MsgGUID: 94DGrAGdQzSDMkcd/U5aZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2915250"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400";
   d="scan'208";a="2915250"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 11:41:39 -0800
X-CSE-ConnectionGUID: BXE39mR1TxaQFNCUs0domA==
X-CSE-MsgGUID: tRBy/kc0TyCLMXM5SkWPLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400";
   d="scan'208";a="7248337"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
  by orviesa005.jf.intel.com with ESMTP; 06 Nov 2026 11:41:37 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPPoc-00000000ALX-2eBe;
	Fri, 06 Nov 2026 19:41:34 +0000
Date: Fri, 06 Nov 2026 20:40:56 +0100
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org
Subject: [tiwai-sound:test/sound-rust-v7.3 39/56] warning: could not
 parse code block as Rust code
Message-ID: <202611062024.puM6nqyA-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: EDWZWVSXJTQF7Q336TND6YXAILBTUVPH
X-Message-ID-Hash: EDWZWVSXJTQF7Q336TND6YXAILBTUVPH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EDWZWVSXJTQF7Q336TND6YXAILBTUVPH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git test/sound-rust-v7.3
head:   070444a8abf14da700680a5331d0a95cd11e578b
commit: edc992b67167295cef057cda20bae7ea553e8fac [39/56] rust: usb: add ALSA-specific USB abstraction extensions
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20261106/202611062024.puM6nqyA-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611062024.puM6nqyA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611062024.puM6nqyA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: could not parse code block as Rust code
   --> rust/kernel/usb.rs:1463:5
   |
   1463 |   /// ```ignore
   |  _____^
   1464 | | /// Returns the USB interface with the given interface number, if any.
   1465 | | ///
   1466 | | /// This is a thin wrapper around `usb_ifnum_to_if`, needed by audio class
   ...    |
   1471 | | /// The returned reference borrows from the device; the interface pointer is
   1472 | | /// valid as long as the USB device is bound.
   | |_____________________________________________^
   |
   help: `ignore` code blocks require valid Rust code for syntax highlighting; mark blocks that do not contain Rust code as text: ```text
   --> rust/kernel/usb.rs:1463:5
   |
   1463 | /// ```ignore
   |     ^^^
   = note: error from rustc: unknown start of token: `
   = note: error from rustc: unknown start of token: `
   = note: `#[warn(rustdoc::invalid_rust_codeblocks)]` on by default
--
>> warning: Rust code block is empty
   --> rust/kernel/usb.rs:1517:5
   |
   1517 | /// ```
   |     ^^^
   |
   help: mark blocks that do not contain Rust code as text
   |
   1517 | /// ```text
   |        ++++

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
