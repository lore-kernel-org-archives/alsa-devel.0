Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C005606A329
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2026 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=d4UjwTry;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RP+snD7N
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0354A601DD;
	Fri,  6 Nov 2026 19:30:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0354A601DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793989860;
	bh=niduVHgOwCARHhCv8zIGF9VsLXhfTyz/hG12dmON+r4=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=d4UjwTryF8Fslbql1FLPZriVE+0Oqgi/i34lIHqNRiOia3UTVNKR0maIvbfvJ+LhI
	 3JAwYxAhGKjH3uV54U0FKPK4JAwWgyRzQlYe0N3M6nHE2c85JBcwad2aqdcTpFdTg/
	 EGw2H1zOYFTkx9JlG3yzwL1NdLhKPcg6KtWjl350=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 45446F805FE; Fri,  6 Nov 2026 19:30:26 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C758EF805F1;
	Fri,  6 Nov 2026 19:30:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30686F80510; Fri,  6 Nov 2026 19:30:19 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793989814;
	b=U9tn62p0/xI3INqrnEXKvT1z31et3t+LAJGdGyF3qsX7d42mNoqZ5nxJEb45wTUrW11O
	 uUoTqrAzmSvmMhIfS3rJbiLu9qdntlmXOEay24tvBiQh+Hj86rKep73sJtP5FHcOvrfDu
	 K3eoyd4c0/qhMm9Li0rKz4QOP/Aiu1DgVDcUkrdCpIrzv30+bom2isg1SnbI1CGoQwUfT
	 MHrBNwQHqBji3dBgtSsvG390pSSuB6MDOkP1Mj6RR8TpoKHlohSAixwL09a+LXDyx3CxB
	 EwNnl2+qpbsm+I8+FWX1BWr7jdzUOT6adyk1mtPynGn0FOCRYeizxVTT7ylGR85xVMQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793989814;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=niduVHgOwCARHhCv8zIGF9VsLXhfTyz/hG12dmON+r4=;
	b=Grzwg+U39kLr3dheit7++8TSunJhq3P7J6Y4FKRbg1buAELdXUgpRjgsHkP4+iTUAKcP
	 V7v9aDVCcGbEGu1OelyAcg3r0n9m/vk1rm051NEV/qrw7SKq60MNRGvMBSAyCMBPwZ3cc
	 3qo6zlpkSNLMjLiohSHQt1K7m1wwb+dYiTTjqZ1zmNRU04/tf6oD7ypyXwrBL3ktogx01
	 csEHoMgE1RDHszoKiEC8I99sKvNuL8WvhrT76AX7XKc32DWD1qfUiiJy+rrds0B2ltwRy
	 slkW8m7TkthQQ2K7jYyUncu5Wf+eIp0J/+7xB01n2REGAcs5R9ad6ZxSuNCPX9bhJiw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RP+snD7N;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 31329F8024C
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 19:30:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31329F8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RP+snD7N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793989814; x=1825525814;
  h=date:from:to:cc:subject:message-id;
  bh=niduVHgOwCARHhCv8zIGF9VsLXhfTyz/hG12dmON+r4=;
  b=RP+snD7NXr1rxeraHjzjRtE+wWxJ7p87U5+L5+5bFpsi/xssyssu+AAv
   JR/u03kSYxgSd4ITTaJtgcGh2naPthssNAWvr0CNX8dq51cCPuUEaOkix
   cJcY5vqCoIHAm1Mfkfz4km/Kc+E55BTCw1YYGUjg9MVIRhme0FVimXmwa
   CR6x3ylPdM4WOb1C3KIWbnba2dkO8rdZ3zxfomYD3xI6h3SlGjXaEL5xE
   tyPDEAwWvnYnFlveWJ9OOuyeijIjAHJVMK3FyBMu9QIESq/T9MOYx163O
   8fPsN2lBiot8ex+jk7zTnJk/BK7FsCUchRTdG/pDdzNu+BE0vdaqXh6he
   Q==;
X-CSE-ConnectionGUID: ckzTB8CrSl6I2QTZCgWcWQ==
X-CSE-MsgGUID: OF3eEtD6QheJCrNWq2y0GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2709039"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="2709039"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 10:30:08 -0800
X-CSE-ConnectionGUID: 8IQKHsVxT1GM2dd4rwspqA==
X-CSE-MsgGUID: 5xU6t8OhTr21CsWaCD4zIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="7320987"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
  by fmviesa004.fm.intel.com with ESMTP; 06 Nov 2026 10:30:07 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPOhQ-00000000AKd-3fCI;
	Fri, 06 Nov 2026 18:30:04 +0000
Date: Fri, 06 Nov 2026 19:29:08 +0100
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org
Subject: [tiwai-sound:test/sound-rust-v7.3 38/56] warning: casts from
 `u8` to `u32` can be expressed infallibly using `From`
Message-ID: <202611061930.kJUSXVkl-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: QOIYTW6VW3SIERFBYJN62QHMZKRIODVF
X-Message-ID-Hash: QOIYTW6VW3SIERFBYJN62QHMZKRIODVF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QOIYTW6VW3SIERFBYJN62QHMZKRIODVF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git test/sound-rust-v7.3
head:   070444a8abf14da700680a5331d0a95cd11e578b
commit: a95673578a867ad8c65f4c68a929107b718f9c5d [38/56] rust: usb: Add safe accessors for Device, IAD, and interface descriptors
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20261106/202611061930.kJUSXVkl-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611061930.kJUSXVkl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611061930.kJUSXVkl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: casts from `u8` to `u32` can be expressed infallibly using `From`
   --> rust/kernel/usb.rs:362:9
   |
   362 |         self.cur_altsetting().number() as u32
   |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   = help: an `as` cast can become silently lossy if the types change in the future
   = help: for further information visit https://rust-lang.github.io/rust-clippy/rust-1.96.0/index.html#cast_lossless
   = note: requested on the command line with `-W clippy::cast-lossless`
   help: use `u32::from` instead
   |
   362 -         self.cur_altsetting().number() as u32
   362 +         u32::from(self.cur_altsetting().number())
   |

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
