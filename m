Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B16D606A31B
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2026 01:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=CfjKKy3K;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EHonZ7y9
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD9C1601D9;
	Fri,  6 Nov 2026 02:57:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD9C1601D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793930248;
	bh=dbQeZFEndgkCrTQbe1Pp2dQY0hHVPftsiz/wri0Ui3A=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=CfjKKy3KarNErLDHL48UwpuWyx7A7NFXLfbRDJojwJWXZ9zzQp488Isx8V9cjeRRA
	 MfxNgSwzj8B3X/Y2BuI+1FcVJGq8WnYSbjSFWlyS6X3ZVaueDpd1yvkwJyMmSK6yao
	 yEnURzXkCbkMBrn7Tl/DQuYrOjwUTUYR9DXnmVpM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4638DF80601; Fri,  6 Nov 2026 02:56:54 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A7BC8F805F7;
	Fri,  6 Nov 2026 02:56:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 96ECDF80510; Fri,  6 Nov 2026 02:56:48 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793930207;
	b=Z142+Rmp6qkYEJ5ESfDepZnDUzck+uvL24m91GdZeSIZh1Jw9mqE6JwzoMNZ/gseWlAd
	 kuxx/vHknmD7vDuTG27hW5mZXBC9M/72fmiwpqaiMKBz2SQlAsZbVzU3zRzwCkMPv5vWY
	 VYjoivYfgg/AxOPQaqgmc3Uc6lzNcN7X433l1ArIB3AFh3UTQ+l5zVELvDScDYaTHkUI1
	 VDgpcNWAm1rxxqTeb4HXwUJKXzmYpdNFYLRox3fOnCXbsAB8K9VhOmdAWQsDdj+w7cOhk
	 yrj11tOeO+jXWwcKo5vWxM6CznxNiwB1+do6uR9Iujy9mH1YJiQC4WCQmH9JCcEVEfw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793930207;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=dbQeZFEndgkCrTQbe1Pp2dQY0hHVPftsiz/wri0Ui3A=;
	b=bR9mAcTAynGZ6TAG6k5Sis8fw2x5jB79bEhqCMLUULKq9hvtO5g7KExrMRDpsKl5hWhA
	 N7ZIxALa3hCQnt2gRJMeAgTv+NlpmeumCB6wdC9+bIPfan57MEgtOhV5jAEso4cYjqvDM
	 4nSHkobIzioiIUQsBMnUImcwokjl5K32+O0v4+QnjPLzdpCMlWjjB54e17SUR41HrEfue
	 rRn6J5wwz8FtWZB3bjKTYQUKROrMFaNGwoMqkALRCw/YqpgDP4Uf/EUvriBATpqFxBrfw
	 YWUCto0HrWwuk3j7H3Vu+iMVvW/G9VGqXtiXvn7YqZX8iYMRlHSyzZ6d6T4sA9DnKIw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EHonZ7y9;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 03E0DF8024C
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 02:56:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03E0DF8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EHonZ7y9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793930207; x=1825466207;
  h=date:from:to:cc:subject:message-id;
  bh=dbQeZFEndgkCrTQbe1Pp2dQY0hHVPftsiz/wri0Ui3A=;
  b=EHonZ7y9viT3uuhiE7K3aiQTBPq7oxspfQLKdz9P1Gq6tuiIRcVAAcYj
   mBTZoEOPu4m6LtnnpB3oyXKLKwXGW7wERL3DUjdjosTPonfF+3J+Pim1K
   VGtIwYjupyxV4M/lOm4SuU/rzHIMZztcTDZUdHaciYksThfbwNDlUdULh
   cr0+HJwSmJG1f/YSuJhF2X0MHyDikGE+RcvXpuTuAFFuLCB8I5jkYjJfV
   P8kqwKtyRXPGqov40qAWK2/ejINm64O892RGTboaz+dovV5xhV9FNN2DL
   hfRXe7NSgH9tqgFdhkX87UH17Jyq17mCd6lZpW/SRAtdm1TZ5YYO1UQ6o
   Q==;
X-CSE-ConnectionGUID: 28FGlxrcTOCOWOks6wzf/A==
X-CSE-MsgGUID: l4wv83ZoTeyCUIF3uYLSrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740552"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="2740552"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 17:56:42 -0800
X-CSE-ConnectionGUID: 7SWns9zdTZGhnyS9dejAJg==
X-CSE-MsgGUID: vCGrFNzGTxyFt4Ddai0BrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="7068398"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
  by orviesa005.jf.intel.com with ESMTP; 05 Nov 2026 17:56:40 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xP9C1-000000009xh-0N3P;
	Fri, 06 Nov 2026 01:56:37 +0000
Date: Fri, 06 Nov 2026 02:55:46 +0100
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 alsa-devel@alsa-project.org
Subject: [tiwai-sound:test/sound-rust-v7.3 32/56] error[E0425]:
 cannot find function `snd_ac97_suspend` in crate `bindings`
Message-ID: <202611060233.tMHVzepz-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: N3P5J3GPOGKO3NEZ5LRWARD2UNGFWNSJ
X-Message-ID-Hash: N3P5J3GPOGKO3NEZ5LRWARD2UNGFWNSJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N3P5J3GPOGKO3NEZ5LRWARD2UNGFWNSJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git test/sound-rust-v7.3
head:   070444a8abf14da700680a5331d0a95cd11e578b
commit: 213e33e4c0ede930090f9d3988c53fc5fc6bdeb6 [32/56] ALSA: rust: add AC97 codec abstraction
config: s390-randconfig-2000-20261105 (https://download.01.org/0day-ci/archive/20261106/202611060233.tMHVzepz-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 0fa861dbbf46e5a75f621406fd91cb015d8754bf)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611060233.tMHVzepz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611060233.tMHVzepz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find function `snd_ac97_suspend` in crate `bindings`
   --> rust/kernel/sound/ac97.rs:223:28
   |
   223 |           unsafe { bindings::snd_ac97_suspend(self.0) };
   |                              ^^^^^^^^^^^^^^^^
   |
   ::: rust/bindings/bindings_generated.rs:147923:5
   |
   147923 | /     pub fn snd_ac97_bus(
   147924 | |         card: *mut snd_card,
   147925 | |         num: ffi::c_int,
   147926 | |         ops: *const snd_ac97_bus_ops,
   147927 | |         private_data: *mut ffi::c_void,
   147928 | |         rbus: *mut *mut snd_ac97_bus,
   147929 | |     ) -> ffi::c_int;
   | |____________________- similarly named function `snd_ac97_bus` defined here
   |
   help: a function with a similar name exists
   |
   223 -         unsafe { bindings::snd_ac97_suspend(self.0) };
   223 +         unsafe { bindings::snd_ac97_bus(self.0) };
   |
--
>> error[E0425]: cannot find function `snd_ac97_resume` in crate `bindings`
   --> rust/kernel/sound/ac97.rs:229:28
   |
   229 |           unsafe { bindings::snd_ac97_resume(self.0) };
   |                              ^^^^^^^^^^^^^^^
   |
   ::: rust/bindings/bindings_generated.rs:147973:5
   |
   147973 | /     pub fn snd_ac97_reset(
   147974 | |         ac97: *mut snd_ac97,
   147975 | |         try_warm: bool_,
   147976 | |         id: ffi::c_uint,
   147977 | |         id_mask: ffi::c_uint,
   147978 | |     ) -> ffi::c_int;
   | |____________________- similarly named function `snd_ac97_reset` defined here
   |
   help: a function with a similar name exists
   |
   229 -         unsafe { bindings::snd_ac97_resume(self.0) };
   229 +         unsafe { bindings::snd_ac97_reset(self.0) };
   |

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
