Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02801606A326
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2026 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=COpamxwo;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AFPPptbD
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF2FD601E3;
	Fri,  6 Nov 2026 00:23:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF2FD601E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793921042;
	bh=FCG55QVwiKpBDwugbFLe2PewKn8x9ZJcBDzB24vvX4I=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=COpamxwoGqssG0oxnaRzDTljVTaTs/5siev/yNUWt4bj4aROxhBootoVANO1yPuVT
	 31yPH0fC3YncA1Hvy9UZQyM+5yTrdoEvQZL2RLGzF/KzSQrRIDuLGtt+wCHzubvNzg
	 QFOZSqbW1idfi3pdol5bcNdxauyvRiR5zmsIdhQc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 33C30F805F1; Fri,  6 Nov 2026 00:23:28 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A075F805FF;
	Fri,  6 Nov 2026 00:23:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14B3CF80510; Fri,  6 Nov 2026 00:23:23 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793921001;
	b=aPqJpF4kFVDngbOGTAHt5Gv3Ie2UFq47Fvf0XVl5EAquQ5WXX5QVFZ18Hkde2RBNNG31
	 7/xm7B7Jk4HgjP8qNGmdFAu6w3Co2D1PG5IUqNih364H0qr25Cencuf/6Qr6cCsQhixS/
	 59fL9QoY6qQl4TxtdvJ7ANegubLv9wp+UY41ad0dW5gl9wo4X8uCvw2pV+9Dp/0KS7/dg
	 7kOW8QVb9942s+XMoKyPOasZ+9vlREPdrQSQJCBoAgpsv9nhbW9Vlt5unmzgLNEVI4yLA
	 c9X2+axJ2xvjsubFDf1bbRyLnDzZs8DVJh9pjKxEW42p+tx7DIzqQxKXdH4dR3clhuw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793921001;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=FCG55QVwiKpBDwugbFLe2PewKn8x9ZJcBDzB24vvX4I=;
	b=MAS/TQIzE9uDA628oPuzLsyfMV09/ay9OSask+hrdIMDLyJWnlQtf+HJm8sO+4IIMtyF
	 QnFjDf5NgFBCgOz7gi3Yq5Zjl58Avdw74EipEoG1zK5CG4kCqd/imCm3ko7ML4wK89p1w
	 60ihYtCdxsh+UjH85FAKbze851xnTDxiI0N1fYRgX6sjywDb8DiQctfL3b3SrVD+y4yAw
	 hE9ZdP2360ON3N8sF7Ziuv8hmase3Rk/ms4vtsldBydvL8dWULnG5FTzuDxY61Xai43+1
	 QFl71BpUA7kCj2LGyLxjPN7Bs/wLbY+tGjkuGSrss0OYvqWH1BdjiaKTiNJXk7Nzvdg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AFPPptbD;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 39E75F80124
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 00:23:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39E75F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AFPPptbD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793921002; x=1825457002;
  h=date:from:to:cc:subject:message-id;
  bh=FCG55QVwiKpBDwugbFLe2PewKn8x9ZJcBDzB24vvX4I=;
  b=AFPPptbDgieJincf2lQ6WiUS7qA5IZIGvCt8LXsyomDSy+QovUtR8vXv
   w6yXUqfpQu8h1y2mg/0agR/bj3uEUXbEDQicTWD95fa4JrAcrRIXQruB1
   S8kjkI1VOSNfq4SFIpR8XZCmg5gM+V4ScWwGPu1q5G1ZICOB2sE/cGtZ2
   DOWqGx3I8H73H+nn0k0G1IRwXhq37y64x8ihJ38LLtdD3hmX4ZXe458aE
   sYGDoGjybxcUDRb4OsuIbj9IuDKy2gq/CFORXqYKYb0MdijpmFfoNxYxb
   f6VLDD7XX33jF5I2azXcV0puaU/ct4lTj4A5ZiG4X05JofKIANO2uhFV4
   A==;
X-CSE-ConnectionGUID: yEjTigItQLexE+ET9YwMuw==
X-CSE-MsgGUID: yZWJpuoyTfqZxljQSQrs6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2831568"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="2831568"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 15:23:18 -0800
X-CSE-ConnectionGUID: 3VakEvy1TiiovtUxNd3Z2Q==
X-CSE-MsgGUID: ltVOhA8zRcK1VxsQz8dGkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="7464156"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2026 15:23:16 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xP6na-000000009sr-1ShE;
	Thu, 05 Nov 2026 23:23:14 +0000
Date: Fri, 06 Nov 2026 00:23:10 +0100
From: kernel test robot <lkp@intel.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.de>
Subject: [tiwai-sound:test/sound-rust-v7.3 7/56] Diff in
 rust/kernel/pm.rs:24:
Message-ID: <202611060004.YCuneUre-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: MULL6AJVKZYW4OLJIVQY65EULGU4MMZH
X-Message-ID-Hash: MULL6AJVKZYW4OLJIVQY65EULGU4MMZH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MULL6AJVKZYW4OLJIVQY65EULGU4MMZH/>
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
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20261106/202611060004.YCuneUre-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611060004.YCuneUre-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611060004.YCuneUre-lkp@intel.com/

All errors (new ones prefixed by >>):

   PATH=/opt/cross/clang-22/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   INFO PATH=/opt/cross/rustc-1.96.0-bindgen-0.72.1/cargo/bin:/opt/cross/clang-22/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 12h /usr/bin/make KCFLAGS=\ -fno-crash-diagnostics\ -Wno-error=return-type\ -Wreturn-type\ -funsigned-char\ -Wundef\ -falign-functions=64 W=1 --keep-going LLVM=1 -j32 -C source O=/kbuild/obj/consumer/x86_64-rhel-9.4-rust ARCH=x86_64 SHELL=/bin/bash rustfmtcheck 
   make: Entering directory '/kbuild/src'
   make[1]: Entering directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
>> Diff in rust/kernel/pm.rs:24:
        types::ForeignOwnable, //
    };
    
   -use core::{
   -    cell::UnsafeCell,
   -    marker::PhantomData
   -};
   +use core::{cell::UnsafeCell, marker::PhantomData};
    
    /// Runtime Power Management modes that determine how a particular PM
    /// transition is to be carried out.
>> Diff in rust/kernel/pm.rs:24:
        types::ForeignOwnable, //
    };
    
   -use core::{
   -    cell::UnsafeCell,
   -    marker::PhantomData
   -};
   +use core::{cell::UnsafeCell, marker::PhantomData};
    
    /// Runtime Power Management modes that determine how a particular PM
    /// transition is to be carried out.
   make[2]: *** [Makefile:2038: rustfmt] Error 123
   make[2]: Target 'rustfmtcheck' not remade because of errors.
   make[1]: Leaving directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'rustfmtcheck' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'rustfmtcheck' not remade because of errors.
   make: Leaving directory '/kbuild/src'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
