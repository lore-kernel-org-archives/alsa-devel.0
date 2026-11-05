Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E015D606A326
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2026 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=CvXawCHg;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L3x0FpS+
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADF7E601DF;
	Fri,  6 Nov 2026 00:45:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADF7E601DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793922313;
	bh=/EOF5OTVfOoBzhuw2SJOB6s+/Ruf8F3tuGJElD8ZNsM=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=CvXawCHgrSw8yYgPsWfujBEfA51xUWpDLLBKcbaFxmbQWkGwtJydWWqy8iXZYLLBn
	 nF/NJLVExKjlIfcikbTo6YsQtP9GRNubgQxp/dewrdExVu4S39q+nj6T2D61eFkxVy
	 1o/ocvp8N7UJyYVxFdD2jl1bXrY854oToNULbfk4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5FC05F805F2; Fri,  6 Nov 2026 00:44:40 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C69ABF80600;
	Fri,  6 Nov 2026 00:44:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 98B23F80510; Fri,  6 Nov 2026 00:44:33 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793922269;
	b=q1qX/5SnCR5TX013FcWT2cuVA3RH0DxEVDBdgURWKUgEeZjzzDSfTA725xFqqrA55nNJ
	 t0Y4pHJu0rGWLvz+F6nAOyn/nGR/ahXAE22sq4e4q+PS7KS9YqAOyIWaQpyexOdwO8Lpb
	 abEIkkvxmOX8U0TbxEcTZO/a9kZAuJbOhKdz7mWtmTV6DnEIoVf1nAUuFYYIMmz0Cd7nW
	 9vaN0IoTNMYKJOezGRVCNOB2OgwCfvbrSoWqXJiFuURkut0lI+2gE9giOYVFJD/vDJXLk
	 3d/053EQpArid4rrbBzovmJP/VUjZwSNTfYhprGq7nZ6ZhB0eqhw2PIAwshFHdj3J6Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793922269;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=/EOF5OTVfOoBzhuw2SJOB6s+/Ruf8F3tuGJElD8ZNsM=;
	b=Bm6l8nYePk9nTX36RcAXC7uMoukbWTTEaSZTTZXD1r/lS8BQEe/5hMUmq/aR6upgj10e
	 qeKGHluvcCEBcJcHaaJPFmLAZSN6m3nJiUgtd5MEJ2eTBwl6U6xD/P/JSn1EZ7OHeLxWM
	 BDOsw0LZtJIM0MwDh08T+MD6CPKdlpK4XdqxDxlUrmdI4pgVKrNTF7xiYQTSz6jj8eNut
	 BZgawSE9hiozhVmN/N9pQijA8mhmA06wqplfsST5593tp4D181uJdHm+IBkPL8I622m2Y
	 gCIXYDrL7z5HvNZVw9bVNwWznyj1QiJmxjSEBxCCdw3mun2xsDaqkYBITZkJPyVXI4Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=L3x0FpS+;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 654E6F8016D
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 00:44:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 654E6F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=L3x0FpS+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793922269; x=1825458269;
  h=date:from:to:cc:subject:message-id;
  bh=/EOF5OTVfOoBzhuw2SJOB6s+/Ruf8F3tuGJElD8ZNsM=;
  b=L3x0FpS+BhgTIAD1JwqsaSQ2Hu/goGnc74Jm887UhdOiZZ0ku85jfH18
   aOq48rOa3weHKBm6RD2GpWbHDgyEiJRP9lej+bGqm+sD6rw0TsrervO5I
   Ftxi37EsMr7bSV+u9vIc3WuNAq9/Tht96ADWJ6zOzL/XDauTid3dj7rnS
   7hhdM5/ixaMaccLjsfI1+HU1sUnhK+OVFo81Aw9aLSx5KrWpTl+XTTXHK
   /LhbfYK2wH3rbYDuwi/34wddDMw1p0HXsg8+exAuKmaIoNTcxwoRJJJ2e
   Iq5Wr1eHe89N3jAuwRtUQGrfWdauPQAn1Z1I0PkMzCCAOMj6RP/kbGchE
   Q==;
X-CSE-ConnectionGUID: GSTdGRdVSwiNXBHbs0YGBA==
X-CSE-MsgGUID: FVAQ1gR7Q9CUtL2QzsZo7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2754613"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="2754613"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 15:44:20 -0800
X-CSE-ConnectionGUID: 900j8yFLTLWxct0DKZ55+Q==
X-CSE-MsgGUID: 37pA78O3TcyiWqwHrTN5nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="7309584"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
  by fmviesa003.fm.intel.com with ESMTP; 05 Nov 2026 15:44:18 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xP77w-000000009tb-1uld;
	Thu, 05 Nov 2026 23:44:16 +0000
Date: Fri, 06 Nov 2026 00:44:00 +0100
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 alsa-devel@alsa-project.org
Subject: [tiwai-sound:test/sound-rust-v7.3 26/56] error[E0425]:
 cannot find function `snd_pcm_suspend_all` in crate `bindings`
Message-ID: <202611060048.OHu58JrR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: 5CMWMQX5OCOQQA3BEDLRGLOOVB5AGCQZ
X-Message-ID-Hash: 5CMWMQX5OCOQQA3BEDLRGLOOVB5AGCQZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5CMWMQX5OCOQQA3BEDLRGLOOVB5AGCQZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git test/sound-rust-v7.3
head:   070444a8abf14da700680a5331d0a95cd11e578b
commit: 5f8a12175afdf1ad3ab75535be1efc491d89805b [26/56] ALSA: rust: add PM and runtime PM support
config: s390-randconfig-2000-20261105 (https://download.01.org/0day-ci/archive/20261106/202611060048.OHu58JrR-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 0fa861dbbf46e5a75f621406fd91cb015d8754bf)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611060048.OHu58JrR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611060048.OHu58JrR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find function `snd_pcm_suspend_all` in crate `bindings`
   --> rust/kernel/sound/pcm.rs:748:38
   |
   748 |         to_result(unsafe { bindings::snd_pcm_suspend_all(self.as_raw()) })
   |                                      ^^^^^^^^^^^^^^^^^^^ not found in `bindings`

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
