Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC158606A326
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2026 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Vhj57j4t;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g05MNw1V
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99C23601DB;
	Fri,  6 Nov 2026 01:54:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99C23601DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793926469;
	bh=ZwciZFt7S0xReHHbErecsLoVH2veCrPQob1fYs/5U7g=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Vhj57j4tXQV0vxT/oKezpl7Pu3utfTWujH8Qz0E+pfzYIK/57X3eVvXQ1gzuhx+zy
	 8dZVxvz4/fvCNVLdpvbRzCVF0PQ7jPi+F/s58ML8t8VTMc+D05+yRmt0NvPo1SONUh
	 pmkrl+hBwCKoGpibucQBIfpq/JAj7wdQadYmtTO8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42ABEF805FB; Fri,  6 Nov 2026 01:53:54 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D69DDF805F5;
	Fri,  6 Nov 2026 01:53:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 793BFF80510; Fri,  6 Nov 2026 01:53:47 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793926425;
	b=FyNjpSafbTPUG2T2YftEbw15AEEKFOehnhtF5eWfnVZdJKcGsIFgFmjXj/oGhj1g/Mut
	 WfXhV0NCyaqsMwHAjg9ebbjAFxqP7xfv6f8heesgk3yyr0fKIH8NCUwRgwsldMPLzlX85
	 aDhiz1hwcpzWdV7ElT1BgQalhH8Buh9jhSFwjhPFRgYlFCF8UiobBcFApZ3gZpO2U9GYr
	 pPd0+QUDlTlc2CbMXErVUlqokFJEbgHnvwMrJpdy+4/zuKxCduJldhltKN5d3x6uN07cm
	 zPohSPX4NCu4RCBd/u/D/HJh+VxoUr/It/oGgqBHkIwjqmjzeLbr+WgeZVnfTGeeVlA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793926425;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=ZwciZFt7S0xReHHbErecsLoVH2veCrPQob1fYs/5U7g=;
	b=cmG8jEEpECBgRI6q89SOVkpBaLnBxdH9Uo7mPpSkB/vw/ab6N3A3pUm7/Ob87yBxOLE1
	 F5KtmbekODw9prs8uWcvB8JyANDy/7HrkgebnLwsHrg0B48vTCe0Z8Z1KW9KvBkQJH9ja
	 wg/2fMx5cHNFqtwHBDNlVw/ktqXqU64BhgM+PbXd53PPqIlzEWTV55M0Hrgt5QjnSX/j1
	 IVRSwC9uPfzzNH/qmjxCZ1pHNAU8ARcV52J3YlBgxRyvh1daVUUSodf2ODiP0RaLVz9T+
	 J5iCrA9o78njQwgfPjDJYwcQgSTXS6DVVkCKiguyub3NqjeXK7d21sawvayOGkA0u5Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=g05MNw1V;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3423DF8024C
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 01:53:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3423DF8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=g05MNw1V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793926426; x=1825462426;
  h=date:from:to:cc:subject:message-id;
  bh=ZwciZFt7S0xReHHbErecsLoVH2veCrPQob1fYs/5U7g=;
  b=g05MNw1VNccJRYKIAEhQolPulpsQO4PLvwdIgbpBTcfk53coHP1/zhye
   Qr18QP86XxAcVe1sBsvVWXBgpwDhWJR5G2uGWfxL+QV/baUL8ayzdKHHG
   Tsh4cwLA6Lg70r5BGCZ7LkqFbCaNCJKdLUyWFzzM03pQoXXnfvW7HpVDt
   fzZZvxvoNzvDMlJG6wyS5nvwuxHQziKh/SRDLIcXlb0kEGp0GZqNiIntV
   m4njWOhxGFHJ+0B4REHgtZN6vlZjdNI+2U4YyOeg2sxcBhxLslKNAymNk
   aFdjTwEodwmTrMG5QXOcHke9jyrpUOg4ynkYbC9oTL4aj1Pm82Ejp1lk2
   A==;
X-CSE-ConnectionGUID: txDPuc3IR2yEthcCiW7lWQ==
X-CSE-MsgGUID: +TCnZZzwSZGDPiiuO9H0Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2742511"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="2742511"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 16:53:37 -0800
X-CSE-ConnectionGUID: +5/FRX+6SJStqkTUs6FSXg==
X-CSE-MsgGUID: +U/FOr9cSXuWS5hTvqigSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="7479503"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2026 16:53:35 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xP8Cy-000000009wV-17te;
	Fri, 06 Nov 2026 00:53:32 +0000
Date: Fri, 06 Nov 2026 01:53:24 +0100
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org
Subject: [tiwai-sound:test/sound-rust-v7.3 11/56] Diff in
 rust/kernel/sound/card.rs:4:
Message-ID: <202611060149.jsR21Ibx-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: 2OVX2CPV7CNK7LZ3EPQIAV3HC3G2FEVP
X-Message-ID-Hash: 2OVX2CPV7CNK7LZ3EPQIAV3HC3G2FEVP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2OVX2CPV7CNK7LZ3EPQIAV3HC3G2FEVP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git test/sound-rust-v7.3
head:   070444a8abf14da700680a5331d0a95cd11e578b
commit: 8c3e8dd553f3af45e664df85daa4a3e065d274c1 [11/56] ALSA: rust: add sound card abstraction (kernel::sound::card)
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20261106/202611060149.jsR21Ibx-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611060149.jsR21Ibx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611060149.jsR21Ibx-lkp@intel.com/

All errors (new ones prefixed by >>):

   PATH=/opt/cross/clang-22/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   INFO PATH=/opt/cross/rustc-1.96.0-bindgen-0.72.1/cargo/bin:/opt/cross/clang-22/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 12h /usr/bin/make KCFLAGS=\ -fno-crash-diagnostics\ -Wno-error=return-type\ -Wreturn-type\ -funsigned-char\ -Wundef\ -falign-functions=64 W=1 --keep-going LLVM=1 -j32 -C source O=/kbuild/obj/consumer/x86_64-rhel-9.4-rust ARCH=x86_64 SHELL=/bin/bash rustfmtcheck 
   make: Entering directory '/kbuild/src'
   make[1]: Entering directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
>> Diff in rust/kernel/sound/card.rs:4:
    //!
    //! C header: [`include/sound/core.h`](srctree/include/sound/core.h)
    
   -use crate::{
   -    bindings,
   -    device,
   -    error::to_result,
   -    prelude::*,
   -    types::Opaque,
   -    ThisModule,
   -};
   +use crate::{bindings, device, error::to_result, prelude::*, types::Opaque, ThisModule};
    
    /// A sound card.
    ///
   Diff in rust/kernel/sound/card.rs:67:
        pub fn set_driver(&self, s: &CStr) {
            // SAFETY: `self.as_raw()` is valid; `driver` is a fixed-size array of 16 bytes.
            unsafe {
   -            s.copy_to_raw(
   -                (*self.as_raw()).driver.as_mut_ptr() as *mut u8,
   -                16,
   -            );
   +            s.copy_to_raw((*self.as_raw()).driver.as_mut_ptr() as *mut u8, 16);
            }
        }
    
   Diff in rust/kernel/sound/card.rs:78:
        pub fn set_short_name(&self, s: &CStr) {
            // SAFETY: `self.as_raw()` is valid; `shortname` is a fixed-size array of 32 bytes.
            unsafe {
   -            s.copy_to_raw(
   -                (*self.as_raw()).shortname.as_mut_ptr() as *mut u8,
   -                32,
   -            );
   +            s.copy_to_raw((*self.as_raw()).shortname.as_mut_ptr() as *mut u8, 32);
            }
        }
    
   Diff in rust/kernel/sound/card.rs:89:
        pub fn set_long_name(&self, s: &CStr) {
            // SAFETY: `self.as_raw()` is valid; `longname` is a fixed-size array of 80 bytes.
            unsafe {
   -            s.copy_to_raw(
   -                (*self.as_raw()).longname.as_mut_ptr() as *mut u8,
   -                80,
   -            );
   +            s.copy_to_raw((*self.as_raw()).longname.as_mut_ptr() as *mut u8, 80);
            }
        }
    
   Diff in rust/kernel/sound/card.rs:100:
        pub fn set_mixer_name(&self, s: &CStr) {
            // SAFETY: `self.as_raw()` is valid; `mixername` is a fixed-size array of 80 bytes.
            unsafe {
   -            s.copy_to_raw(
   -                (*self.as_raw()).mixername.as_mut_ptr() as *mut u8,
   -                80,
   -            );
   +            s.copy_to_raw((*self.as_raw()).mixername.as_mut_ptr() as *mut u8, 80);
            }
        }
    
   Diff in rust/kernel/sound/card.rs:116:
        pub fn as_raw(&self) -> *mut bindings::snd_card {
            self.0.get()
        }
   -
    }
    
    // SAFETY: `Card` holds only an `Opaque<snd_card>`, whose thread-safety is
>> Diff in rust/kernel/sound/card.rs:4:
    //!
    //! C header: [`include/sound/core.h`](srctree/include/sound/core.h)
    
   -use crate::{
   -    bindings,
   -    device,
   -    error::to_result,
   -    prelude::*,
   -    types::Opaque,
   -    ThisModule,
   -};
   +use crate::{bindings, device, error::to_result, prelude::*, types::Opaque, ThisModule};
    
    /// A sound card.
    ///
   Diff in rust/kernel/sound/card.rs:67:
        pub fn set_driver(&self, s: &CStr) {
            // SAFETY: `self.as_raw()` is valid; `driver` is a fixed-size array of 16 bytes.
            unsafe {
   -            s.copy_to_raw(
   -                (*self.as_raw()).driver.as_mut_ptr() as *mut u8,
   -                16,
   -            );
   +            s.copy_to_raw((*self.as_raw()).driver.as_mut_ptr() as *mut u8, 16);
            }
        }
    
   Diff in rust/kernel/sound/card.rs:78:
        pub fn set_short_name(&self, s: &CStr) {
            // SAFETY: `self.as_raw()` is valid; `shortname` is a fixed-size array of 32 bytes.
            unsafe {
   -            s.copy_to_raw(
   -                (*self.as_raw()).shortname.as_mut_ptr() as *mut u8,
   -                32,
   -            );
   +            s.copy_to_raw((*self.as_raw()).shortname.as_mut_ptr() as *mut u8, 32);
            }
        }
    
   Diff in rust/kernel/sound/card.rs:89:
        pub fn set_long_name(&self, s: &CStr) {
            // SAFETY: `self.as_raw()` is valid; `longname` is a fixed-size array of 80 bytes.
            unsafe {
   -            s.copy_to_raw(
   -                (*self.as_raw()).longname.as_mut_ptr() as *mut u8,
   -                80,
   -            );
   +            s.copy_to_raw((*self.as_raw()).longname.as_mut_ptr() as *mut u8, 80);
            }
        }
    
   Diff in rust/kernel/sound/card.rs:100:
        pub fn set_mixer_name(&self, s: &CStr) {
            // SAFETY: `self.as_raw()` is valid; `mixername` is a fixed-size array of 80 bytes.
            unsafe {
   -            s.copy_to_raw(
   -                (*self.as_raw()).mixername.as_mut_ptr() as *mut u8,
   -                80,
   -            );
   +            s.copy_to_raw((*self.as_raw()).mixername.as_mut_ptr() as *mut u8, 80);
            }
        }
    
   Diff in rust/kernel/sound/card.rs:116:
        pub fn as_raw(&self) -> *mut bindings::snd_card {
            self.0.get()
        }
   -
    }
    
    // SAFETY: `Card` holds only an `Opaque<snd_card>`, whose thread-safety is
   Diff in rust/kernel/pm.rs:24:
        types::ForeignOwnable, //
    };
    
   -use core::{
   -    cell::UnsafeCell,
   -    marker::PhantomData
   -};
   +use core::{cell::UnsafeCell, marker::PhantomData};
    
    /// Runtime Power Management modes that determine how a particular PM
    /// transition is to be carried out.
>> Diff in rust/kernel/sound/card.rs:4:
    //!
    //! C header: [`include/sound/core.h`](srctree/include/sound/core.h)
    
   -use crate::{
   -    bindings,
   -    device,
   -    error::to_result,
   -    prelude::*,
   -    types::Opaque,
   -    ThisModule,
   -};
   +use crate::{bindings, device, error::to_result, prelude::*, types::Opaque, ThisModule};
    
    /// A sound card.
    ///
   Diff in rust/kernel/sound/card.rs:67:
        pub fn set_driver(&self, s: &CStr) {
            // SAFETY: `self.as_raw()` is valid; `driver` is a fixed-size array of 16 bytes.
            unsafe {
   -            s.copy_to_raw(
   -                (*self.as_raw()).driver.as_mut_ptr() as *mut u8,
   -                16,
   -            );
   +            s.copy_to_raw((*self.as_raw()).driver.as_mut_ptr() as *mut u8, 16);
            }
        }
    
   Diff in rust/kernel/sound/card.rs:78:
        pub fn set_short_name(&self, s: &CStr) {
            // SAFETY: `self.as_raw()` is valid; `shortname` is a fixed-size array of 32 bytes.
            unsafe {
   -            s.copy_to_raw(
   -                (*self.as_raw()).shortname.as_mut_ptr() as *mut u8,
   -                32,
   -            );
   +            s.copy_to_raw((*self.as_raw()).shortname.as_mut_ptr() as *mut u8, 32);
            }
        }
    
   Diff in rust/kernel/sound/card.rs:89:
        pub fn set_long_name(&self, s: &CStr) {
            // SAFETY: `self.as_raw()` is valid; `longname` is a fixed-size array of 80 bytes.
            unsafe {
   -            s.copy_to_raw(
   -                (*self.as_raw()).longname.as_mut_ptr() as *mut u8,
   -                80,
   -            );
   +            s.copy_to_raw((*self.as_raw()).longname.as_mut_ptr() as *mut u8, 80);
            }
        }
    
   Diff in rust/kernel/sound/card.rs:100:
        pub fn set_mixer_name(&self, s: &CStr) {
            // SAFETY: `self.as_raw()` is valid; `mixername` is a fixed-size array of 80 bytes.
            unsafe {
   -            s.copy_to_raw(
   -                (*self.as_raw()).mixername.as_mut_ptr() as *mut u8,
   -                80,
   -            );
   +            s.copy_to_raw((*self.as_raw()).mixername.as_mut_ptr() as *mut u8, 80);
            }
        }
    
   Diff in rust/kernel/sound/card.rs:116:
        pub fn as_raw(&self) -> *mut bindings::snd_card {
            self.0.get()
        }
   -
    }
    
    // SAFETY: `Card` holds only an `Opaque<snd_card>`, whose thread-safety is
   Diff in rust/kernel/pm.rs:24:
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
