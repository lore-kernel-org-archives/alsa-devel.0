Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EAD606A333
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=tFwgpvsA;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EZYLhnSJ
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2098601C2;
	Thu,  5 Nov 2026 22:47:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2098601C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793915256;
	bh=ZPoh/QYmCABz2+oFT9fd4Xv8DN25knfPuPIGrF8NcA0=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=tFwgpvsANSLDKMkTdbX+WkQyOOCld6EWQvzKPRjECZzy9B1OlLsiD3pvuQoD4YWLa
	 bOeWTZPP5b7chc5Nh3UED3uGeqKUpMIh3Gui0sC125VEf8ZgpFHosOJqaxfFFJLhDC
	 Djv+QwnvyYFB3xgsHcq+Qn2BcKrCNm7EQVKionEk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 322AFF80604; Thu,  5 Nov 2026 22:47:03 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A6F9FF80600;
	Thu,  5 Nov 2026 22:47:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A4E96F804FF; Thu,  5 Nov 2026 22:46:57 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793915216;
	b=lGgW/ixUe4yl9AbulLawOaZlGwMyUo7yBleF7t+dwzWKbeMYqmAI1/jpBDTxT6IH/X5A
	 zzPcWzmrWN8VwdTDuEthg44ndG2wLTqX46knWp5M35awOBG3i7N2w0ZgcaTG2hT+Q7cNt
	 4U4kXXMu2MPFojayPBA7NI5ehhgz8cH76oSlUdhcieN324MveJ/DzK9USf89K0klX6spg
	 NDlbfRMvJGbaW+GyWjS7n5nP6e720Apqoigdvk9olsBwExsd1jdCNxBkc+wgwzlSFzol0
	 dwwRmJWCQgKGXscr25NZBlThJdMKBm62MlqJtg9lCXw1IhIga1st6A2mrwOI+8K3IJA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793915216;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=ZPoh/QYmCABz2+oFT9fd4Xv8DN25knfPuPIGrF8NcA0=;
	b=HbIwOeoewg/rJVW50IREt/EesRv11GcQ/owHhuLgSvfN0CpYZnQjnb0BsSNw8hiKhqsV
	 OGFEvKyGWcwRkVFuofqUowm6waiDt1Bc3bbUEx5tTIQ6t/MTL03RtWsdR2Wt2QtoJQxxF
	 rCgvkjVnTf4cUb5Iq8CZhERx/LkZo/tfo11l2tVT0U7gZpvnTkvPzXYAGl0uB0UJcjcus
	 IaVgk0vrn0fk0pSb/egGE4RDVlQ9hyoAS6J3lQh1odXVdAa0XeIUUmcNA+QJ2SxohEqsC
	 Hehfsqlmfo/riy146XyTIqARWnmsgahczJsIbVmO9NLgBFB/ZNWuk7iRJFH948L8JnQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EZYLhnSJ;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 29175F8016D
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2026 22:46:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29175F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EZYLhnSJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793915217; x=1825451217;
  h=date:from:to:cc:subject:message-id;
  bh=ZPoh/QYmCABz2+oFT9fd4Xv8DN25knfPuPIGrF8NcA0=;
  b=EZYLhnSJKIDdT3eqh6ha1xV+c4dMqqzWlBqSxoQy4lYjEVBfR2SJtAz0
   4UtWXo68Ta8gOu93Woe6Uo7mpM09Nrt7V6DjfapMd4DRYhNHgB/K0Y0eu
   1sqEbxhwNf3peOlDCASTGu+oQsfqZ1xIV/ROGJ8o74QA2IYjB9601w4Mu
   T0aaUljvlo//sS0YupHBoR2elO2fxBgHEenBGYq2u4qxsDBMIfNZQApTp
   SBATpbD947OK0QyQpHO/fKHbVwcY0WGv0mrNQB5Uu1RGLji4sDe6kYIlz
   Uoad5QNmYaamKkmrfuX5+pjscOtz5XUUwWwLaXhPFYMhe7spEdPlo23jq
   A==;
X-CSE-ConnectionGUID: 8ESnX5nDTAuzJdboM4fY6g==
X-CSE-MsgGUID: RN5kCS7DScuM+dwxtrBjYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2608437"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="2608437"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 13:46:53 -0800
X-CSE-ConnectionGUID: Iacfi1QpRmm+OquRml4bQQ==
X-CSE-MsgGUID: enA+Zn2SR7KVbcDtMm1S7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="7244907"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 05 Nov 2026 13:46:52 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xP5IH-000000009oN-00g2;
	Thu, 05 Nov 2026 21:46:49 +0000
Date: Thu, 05 Nov 2026 22:46:23 +0100
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org
Subject: [tiwai-sound:test/sound-rust-v7.3 6/56] warning: unresolved
 link to `try_cancel`
Message-ID: <202611052232.yMW005rX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: T5DR4MXUPHSRVJHJPHJ4LHC4F7L6MT3I
X-Message-ID-Hash: T5DR4MXUPHSRVJHJPHJ4LHC4F7L6MT3I
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T5DR4MXUPHSRVJHJPHJ4LHC4F7L6MT3I/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git test/sound-rust-v7.3
head:   070444a8abf14da700680a5331d0a95cd11e578b
commit: c3689bd90a621f170b38c269d1c78881a5c54cac [6/56] rust: hrtimer: add try_cancel() and cancel_or_noop() to ArcHrTimerHandle
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20261105/202611052232.yMW005rX-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611052232.yMW005rX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611052232.yMW005rX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: unresolved link to `try_cancel`
   --> rust/kernel/time/hrtimer/arc.rs:71:16
   |
   71 |     /// Like [`try_cancel`] but also releases the handle's `Arc` refcount
   |                ^^^^^^^^^^ no item named `try_cancel` in scope
   |
   = help: to escape `[` and `]` characters, add '\' before them like `\[` or `\]`
   = note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
