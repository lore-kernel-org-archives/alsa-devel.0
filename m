Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE5606A326
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=F5CSd/mY;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TLOWf0Xo
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21602601DB;
	Fri,  6 Nov 2026 10:45:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21602601DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793958364;
	bh=PRq1oDoWmk2Mb5FIRNK/OQjgvY1nx5a1/OarPhatuHw=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=F5CSd/mYWJ/tvDoUGglUO9sX+qJ98XzLedJZv2+/QFPvmvZWwwt6x0Pb2fkMkDS2W
	 f7x7LsedbNXLYOH879p7BqDvyoeBan74VUrzI6avYyE89EM0YJYo56yfjJABA6wOtt
	 kou38zs0ASyAzJPVpx7UzGDpu5OfoJvz/2PsjaGQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90E90F805F4; Fri,  6 Nov 2026 10:45:31 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 30492F80601;
	Fri,  6 Nov 2026 10:45:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DFC4CF80510; Fri,  6 Nov 2026 10:45:25 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793958324;
	b=FZeDnp0xPhET23cwwIihihRN9m8n8l6oyFWc7B5k+7nNXFK4cnOYm+fkIRtJ+SxLft4X
	 1wZViZ4VotheCYVGkP7qdUIjr6J3ETWfd22V1QovoQUKor052N7//O7FWTt1z6aHpKp/L
	 qkGb8HY8xHsNyKXn7U0Gh1hBrirN8toLVR5fFZxaBcntRLuvoJt0dulcpbmgSWb7m52ka
	 UdlArVTRt3+hA92zHilvVLrpZjHZNQKJP4Kfs1oEL30xAWUJtTxFXgfd0EWStHEMXiITX
	 5qJHX2x5IAEmnxS3r6QYerK4xIBaVf5Dm0HZq4lz7dYTY6EhpiAReCB1hM3Bt+OJL6Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793958324;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=PRq1oDoWmk2Mb5FIRNK/OQjgvY1nx5a1/OarPhatuHw=;
	b=Wsfyr9ggcDd5+rMc0UO3AmnNB0aCRpBdSfAteEGA7M40/CtykH2N8lhPJXCpVVds6tvO
	 rfERCGCXfQ2/m+ZHHynRjetsZ4SKJpG3fmHB+knvoD1EV5D/nxunW3ssjj7FzF/9+sCVt
	 d4ZZfczpFOLH/Aiu9x5qjDbExkkllDvf6MZzl1NqkTc3SPc7Uja2rbeBR0Q/d6IwkME5T
	 BKZ8+dFvvHN2IjMhd4ved/hj23evgfAYUzJ9Meq3LkgW4JNJeZqC1V2UgXJwIaXNkmVBh
	 82iKOG2QLgFZat1g2ge50ZLoZbX+KR1kpNYNWpNkVAvlD/uuMA8gYgSBTgxwfQDjUHw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=TLOWf0Xo;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EFA27F8024C
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 10:45:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFA27F8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=TLOWf0Xo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793958324; x=1825494324;
  h=date:from:to:cc:subject:message-id;
  bh=PRq1oDoWmk2Mb5FIRNK/OQjgvY1nx5a1/OarPhatuHw=;
  b=TLOWf0XoLTCAOIhLA1UJHkOIbaRp//RFQlDQlI1TFAb/LZN6cC+UO2s8
   kFKOJ73WldF018pE2w57AUzzbafAZOvz5AtD55qFAe2yTfxq11p3jJvbU
   Bmn1tEjOXfXKjNLUu0Y5V/L57tZKe7bEcwdCLkI+e90Qiz8eAbYhoCncr
   0eD/lBUBFRU/b25a/A8hub5vgKHaZD9vzBDlEJ3tSzy4PKefQGRXnS/rc
   0ezawJktsLdhBG2oPCiFnTNt4F+XLA4aPDBhf6N2s1yWPjBUnU2TL90bw
   eR2t1YOPo1IWc9qSMFGIFsV3oURZ5E+S8MtOLBkvw3cw6zym5iYOnLaVV
   w==;
X-CSE-ConnectionGUID: yWmSlD2PSBOkY6+9o7HpVw==
X-CSE-MsgGUID: 3eOKJpffSM29b03H9Q5SWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2759602"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="2759602"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 01:45:18 -0800
X-CSE-ConnectionGUID: GruqIT+HTVGvimdjHrJALA==
X-CSE-MsgGUID: aeFsqZbCQj2lQ73z3mbiUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="7577519"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
  by fmviesa009.fm.intel.com with ESMTP; 06 Nov 2026 01:45:17 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPGVX-00000000ABT-0GRJ;
	Fri, 06 Nov 2026 09:45:15 +0000
Date: Fri, 06 Nov 2026 10:45:04 +0100
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org
Subject: [tiwai-sound:test/sound-rust-v7.3 24/56]
 rust/helpers/sound.c:74:undefined reference to `snd_pcm_hw_rule_add'
Message-ID: <202611061033.mR5eK0QO-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: 4QTWXMX2Z4LRKUGXZQLHDSEDRHA54R3T
X-Message-ID-Hash: 4QTWXMX2Z4LRKUGXZQLHDSEDRHA54R3T
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4QTWXMX2Z4LRKUGXZQLHDSEDRHA54R3T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git test/sound-rust-v7.3
head:   070444a8abf14da700680a5331d0a95cd11e578b
commit: 6a450838191295e224845ae206d9594315682abc [24/56] ALSA: rust: pcm: Add hw_rule_add and hw_constraint_minmax abstractions
config: um-randconfig-2200-20261105 (https://download.01.org/0day-ci/archive/20261106/202611061033.mR5eK0QO-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611061033.mR5eK0QO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611061033.mR5eK0QO-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/lib/gcc/i686-linux-gnu/14/../../../../i686-linux-gnu/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permissions
   /usr/lib/gcc/i686-linux-gnu/14/../../../../i686-linux-gnu/bin/ld: rust/helpers/helpers.o: in function `snd_devm_alloc_pages':
   include/sound/memalloc.h:110:(.text+0x9212): undefined reference to `snd_devm_alloc_dir_pages'
   /usr/lib/gcc/i686-linux-gnu/14/../../../../i686-linux-gnu/bin/ld: rust/helpers/helpers.o: in function `rust_helper_snd_pcm_hw_rule_add':
>> rust/helpers/sound.c:74:(.text+0x94aa): undefined reference to `snd_pcm_hw_rule_add'
   clang: error: linker command failed with exit code 1 (use -v to see invocation)


vim +74 rust/helpers/sound.c

    64	
    65	/*
    66	 * snd_pcm_hw_rule_add is variadic; provide a fixed 4-dep wrapper.
    67	 * Pass -1 for unused dep slots.
    68	 */
    69	__rust_helper int rust_helper_snd_pcm_hw_rule_add(
    70		struct snd_pcm_runtime *runtime, unsigned int cond, int var,
    71		snd_pcm_hw_rule_func_t func, void *private,
    72		int dep0, int dep1, int dep2, int dep3)
    73	{
  > 74		return snd_pcm_hw_rule_add(runtime, cond, var, func, private,

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
