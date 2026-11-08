Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62AA606A320
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Nov 2026 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=ZZCF1+32;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gFUU2QwS
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C1A9601DE;
	Sun,  8 Nov 2026 09:36:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C1A9601DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794126973;
	bh=QRReOroKM2rdIiE8TyOumsZ3Gz64Yt6XKRGQ8EPxfj8=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ZZCF1+32j1LO6Hz9WLEvZMRxUUVICSZBQtspw9HAXsFB7en/dReT6KWHOrlh4KdhX
	 oaaqVoFQRcGdMN6Rs0VnDyxkBmLvCvOTO4lTdMqjPB5FILv4HZI+rTxYNyjieZ2BT7
	 c1/WUYrR8tCeon7UyEIkOFik1KzhEqrAsLREnSAs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0445F805FE; Sun,  8 Nov 2026 09:35:38 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 63390F80601;
	Sun,  8 Nov 2026 09:35:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 10510F80538; Sun,  8 Nov 2026 09:35:33 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794126932;
	b=IDmbErFerJJ1GhEdTgHHc1lI/UOVjnaI/MPJ457YxyIx8Zywz+iDwHimxzii+eByd560
	 HJgrDIXKsMoQykprm1vLhTxoBsumUsXLFMnJeqcxnO7wrYqnGZ0VELovIu6asm1x00KWD
	 IN02UPlhTili94fqN+EvNA80Ms585nNAu7sLKVYcN2hQo5KUh0tfivLEh2Da2GapQXI1P
	 V3MpJAX3yxiu4+WVyv36ULZU51/2PDEQkU53s9EjrL9mrYcBTVUJsy+H7zgSQ7wmgEUqo
	 Lw15pNnG5PO6QRGvJy1O0PTKDKid1mQPB57fOPqm6zggJY5h+s4WD2S3CiOS/NE6lxg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794126932;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=QRReOroKM2rdIiE8TyOumsZ3Gz64Yt6XKRGQ8EPxfj8=;
	b=IX2Gp0ouZfOgYcXntd8LGozuJ+4flnvGSvdFgJVV0E/6iHCqPiQwIJm3Bn0Po/x01cfW
	 vjekzIYhME1JLCj+oIACdp+cogOIYeF44/f0TCx3gdA5LeN3luFauLhX2CcLyEryy1KK+
	 skCKxhD6XKIzUVKn1yihPSm1D+L4IlW34Gg2ffS5FYlyi1fPO2FqeJVySvJMDwywrf4n3
	 6mK0oMGq3JhbC579Wlt6c8z4GLLrz1MzKuQfdBmq+/3/EoJxr/ZB8YYe1EDFWzCrWbGlO
	 VRLithFsQo1IFacezBbrGLtfhOM8nczAH3YzCB134aLbugcG6rWm5+fFHX94VPap6Lg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gFUU2QwS;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6FFD0F8014B
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2026 09:35:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FFD0F8014B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gFUU2QwS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794126931; x=1825662931;
  h=date:from:to:cc:subject:message-id;
  bh=QRReOroKM2rdIiE8TyOumsZ3Gz64Yt6XKRGQ8EPxfj8=;
  b=gFUU2QwSACiZrL7HG0VG/pxRtzxg4n87+pWCnrDaMFLvAD04SZkU9UWV
   Yldl/cp0WU2udXYrCqrtHMzX8hDh1YNuf5sU0+toRZnHe+fZNMRzJw6UA
   PdRQCtZLq6W6nVyzgyvAG1ifkm/g1nVTlMi9DhrGKH0aTSfSQGOJ909HU
   L/Gt7hjP+xpEUJidlL07HWI9+qtBTY6utZEQ/MpmzEQtn5nQ2jDV675bA
   dtf+7A691diC+8DARfgX8fbH4VN/2dyjqmhpefrw4httgHNVaPKtx07zf
   xt/0lFlwCq4EStdUAewLlZ0yVLROUiUHJojTeulUHI/vWq0O+Ic5iJ6kw
   g==;
X-CSE-ConnectionGUID: l8EA88L4TeiE0u7Fek7ckA==
X-CSE-MsgGUID: vR8trPI5RGOFf3y90QZ4aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2781276"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400";
   d="scan'208";a="2781276"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2026 00:35:26 -0800
X-CSE-ConnectionGUID: L0I1r/8PSTikmm+qoFBeSg==
X-CSE-MsgGUID: 6LvrtWATTnCQTi476MRchQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400";
   d="scan'208";a="9369696"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
  by fmviesa012.fm.intel.com with ESMTP; 08 Nov 2026 00:35:24 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPyMz-00000000BLH-2Krw;
	Sun, 08 Nov 2026 08:35:21 +0000
Date: Sun, 08 Nov 2026 09:35:12 +0100
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org
Subject: [tiwai-sound:test/sound-rust 32/56] error[E0425]: cannot
 find type `Ac97BusOpsTable` in this scope
Message-ID: <202611080941.9qo4R6Fh-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: VLNKRIICJP4DZHU24AZ57KTTTW46EXFQ
X-Message-ID-Hash: VLNKRIICJP4DZHU24AZ57KTTTW46EXFQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VLNKRIICJP4DZHU24AZ57KTTTW46EXFQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git test/sound-rust
head:   85650012d32d6724c5a416eab5ddc324b945e9f6
commit: 9c97f088f138c82c1b4f57f1731ac544fa4b47e6 [32/56] ALSA: rust: add AC97 codec abstraction
config: arm64-randconfig-2200-20261108 (https://download.01.org/0day-ci/archive/20261108/202611080941.9qo4R6Fh-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261108/202611080941.9qo4R6Fh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611080941.9qo4R6Fh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find type `Ac97BusOpsTable` in this scope
   --> rust/doctests_kernel_generated.rs:18624:24
   |
   18624 | static MYDRV_AC97_OPS: Ac97BusOpsTable<MyChip> = Ac97BusOpsTable::new();
   |                        ^^^^^^^^^^^^^^^ not found in this scope
   |
   = help: consider importing this struct:
   kernel::sound::ac97::Ac97BusOpsTable
--
>> error[E0425]: cannot find type `MyChip` in this scope
   --> rust/doctests_kernel_generated.rs:18624:40
   |
   18624 | static MYDRV_AC97_OPS: Ac97BusOpsTable<MyChip> = Ac97BusOpsTable::new();
   |                                        ^^^^^^ not found in this scope
--
>> error[E0433]: cannot find type `Ac97BusOpsTable` in this scope
   --> rust/doctests_kernel_generated.rs:18624:50
   |
   18624 | static MYDRV_AC97_OPS: Ac97BusOpsTable<MyChip> = Ac97BusOpsTable::new();
   |                                                  ^^^^^^^^^^^^^^^ use of undeclared type `Ac97BusOpsTable`
   |
   = help: consider importing this struct:
   kernel::sound::ac97::Ac97BusOpsTable

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
