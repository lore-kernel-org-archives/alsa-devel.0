Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20810606A31A
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Nov 2026 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=r8CVEN+W;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CskiKjFI
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3AFE601E5;
	Sun,  8 Nov 2026 07:19:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3AFE601E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794118798;
	bh=2kdw2iswn5VpOCLFBVV2+tOMUjMSYLfTUf1oxZrHC4s=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=r8CVEN+WgyWoCqNEUHqrYkzBPCohDvB0ATX0na4GXgBdfYURqCdou1c77/aduKxt/
	 /m7ytHZ3Rc8HCxs8jgzaRFcMxY9RytrCblfWQhUqXJ9xmEGY7ueyegvqHx4Rwu6gnr
	 87K4z8NnhlDq9LC82mZ3aClpfJjU/0OWFl9hEK5A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A30E5F80601; Sun,  8 Nov 2026 07:19:26 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A5E2BF805FF;
	Sun,  8 Nov 2026 07:19:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C4DD6F80538; Sun,  8 Nov 2026 07:19:18 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794118757;
	b=lLn6hrjbu5+uYmj0CyulW+bkRf4iN1EGPIDZxchJdHYQS3dRij65gvpbZrYdrMZKOaLN
	 TRBIC66bjOQdLXsIg0/TEBNjqVP+fB7GsWqLMH3fYI0IvLHweW2PcYb0NKzMAOlLOkzEc
	 ddMpdafFFCN3XBfgj/KdjPcexSv9Fa6aZB/cajM77IqJRjblWhaNfOjPXSLV20vK5li1s
	 VPt+7199ef9Vpbvz1JVr4TTk3eyLEJOhaXgCyGeujdVjE/knZmbnpvtySsZ/sgvxqM7dQ
	 Rb36lRQd55ZinurpL2xF5byUMKm67bmjMx4FfXrmMLTBm3ga+9+1JxPgwSqqpc8cPLg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794118757;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=2kdw2iswn5VpOCLFBVV2+tOMUjMSYLfTUf1oxZrHC4s=;
	b=da+a//0pNayewUo9B/XqoNRBp/XdXCIzxCklA2TVy/6zsJq2gQMlbufpz16CpQUpvWHr
	 SSysUBICGWoxayTt4MEo3wuA8NbGjLYTQuh7oWHc51ZVICf2K705Xtd9wgakVfA5DMarR
	 owFMbaKyPyZMvWgCsPZkV9QU98pgDAS4rkwuYXoByWl5cKgSGNIl2Fl0sfC7yiW9ctgbm
	 YHFOwQFHxAEHKG4cNngzIGwOnFXi4fB7bn362KWxPcqoamrNdo5A4lXkiK5wMnlb6gm9d
	 2KYoXdwbCPcZEfN5mPghq6J9r/p8x0hDsiS5gb/XCDutRcvuxNmCKXcstvaL1sYp/Og==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CskiKjFI;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D7577F80152
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2026 07:19:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7577F80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CskiKjFI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794118757; x=1825654757;
  h=date:from:to:cc:subject:message-id;
  bh=2kdw2iswn5VpOCLFBVV2+tOMUjMSYLfTUf1oxZrHC4s=;
  b=CskiKjFI5yKHtYiA2MBT/nCow7+qFaqoP1dobJ/fr7uAxmLZvT//CYPd
   va4SuZZK54+Ousotk6+zCZuNFgQook3bzp+ojXDSe1UFTYAFLyZPpSVrq
   P+SB6fTxj5Ke120ESA/JkJex9Mq4FAEiKjePxWDt1oslbavXNfAwB6lcq
   dVUY09PNZ49/IsY/ePUBi5uvlnjsfOEGVYLBK6hvOE7k/UKxDSPs1FCjq
   e18EhUcF8x2FVJfxwvU98f2WAoQi8lyzg/cIjIfKx/3AvgryMloFgNePE
   fCwDV868Ur8SwX4q0O2bBjXBfddK8epwyVkdGkyd0j2iXdvNF0+LiDGsA
   w==;
X-CSE-ConnectionGUID: 96CTmAxgSzWyViWDw+PsHw==
X-CSE-MsgGUID: KrZS2Yl8QiCrJCNJ5mh0xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2762311"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400";
   d="scan'208";a="2762311"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 22:19:12 -0800
X-CSE-ConnectionGUID: r5zDTpDOQeG49OxzKWbwcQ==
X-CSE-MsgGUID: qM4WG8cAQlilTBN+cB129w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400";
   d="scan'208";a="7786620"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 07 Nov 2026 22:19:09 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPwF9-00000000sHC-20u5;
	Sun, 08 Nov 2026 06:19:07 +0000
Date: Sun, 08 Nov 2026 14:18:26 +0800
From: kernel test robot <lkp@intel.com>
To: Colin Braun <colinbrauncl@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [tiwai-sound:test/sound-rust-v7.3 37/56] error[E0433]:
 cannot find `module_usb_driver` in `kernel`
Message-ID: <202611081435.FPB03bH2-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: 5TX3AOLLC7G43FG7TG2FR7NS4TJAJNSD
X-Message-ID-Hash: 5TX3AOLLC7G43FG7TG2FR7NS4TJAJNSD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5TX3AOLLC7G43FG7TG2FR7NS4TJAJNSD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git test/sound-rust-v7.3
head:   070444a8abf14da700680a5331d0a95cd11e578b
commit: 62a6ac49d75b79105edfb6f148ca23108899be6d [37/56] media: add gv-usb2 audio capture driver
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20261108/202611081435.FPB03bH2-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261108/202611081435.FPB03bH2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611081435.FPB03bH2-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> error[E0432]: unresolved import `kernel::usb`
   --> drivers/media/usb/gv-usb2/driver.rs:17:5
   |
   17 |     usb,
   |     ^^^ no `usb` in the root
   |
   note: found an item that was configured out
   --> rust/kernel/lib.rs:148:9
   |
   147 | #[cfg(CONFIG_USB = "y")]
   |       ---------------- the item is gated behind the `y` feature
   148 | pub mod usb;
   |         ^^^
--
>> error[E0433]: cannot find `module_usb_driver` in `kernel`
   --> drivers/media/usb/gv-usb2/gv_usb2.rs:7:9
   |
   7 | kernel::module_usb_driver! {
   |         ^^^^^^^^^^^^^^^^^ could not find `module_usb_driver` in `kernel`
--
>> error[E0433]: cannot find `usb_device_table` in `kernel`
   --> drivers/media/usb/gv-usb2/driver.rs:152:9
   |
   152 | kernel::usb_device_table!(
   |         ^^^^^^^^^^^^^^^^ could not find `usb_device_table` in `kernel`
--
>> error[E0425]: cannot find value `USB_TABLE` in this scope
   --> drivers/media/usb/gv-usb2/driver.rs:162:51
   |
   162 |     const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
   |                                                   ^^^^^^^^^ not found in this scope
--
>> warning: unused import: `crate::driver::GvUsb2Driver`
   --> drivers/media/usb/gv-usb2/gv_usb2.rs:5:5
   |
   5 | use crate::driver::GvUsb2Driver;
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   = note: `#[warn(unused_imports)]` (part of `#[warn(unused)]`) on by default

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
