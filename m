Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0DD606A326
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2026 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=SY5dPTHo;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fS/t5tmD
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4669601DC;
	Fri,  6 Nov 2026 08:31:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4669601DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793950312;
	bh=gLsbIKaMeV52vEF3mJFFGEM9QjGvlInPZM1xlsYFMRg=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=SY5dPTHol5KOEgypIqm8gMd5wkCX7FJsog5xe6Rnx8vyCfx6ifkCQUqFGBJXM1C7F
	 hvv+MrQrPZTIJ0JnLZiWmQswEwl9WR2TuqrFyNn/VwCmu0cSGOgFrIve6UGgdMCKDM
	 gW7Y5MuH4Mo1VL8ZHcZB1TJrHvvWKTAj2qe0tbtQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7D1E2F80603; Fri,  6 Nov 2026 08:31:19 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F0E92F80600;
	Fri,  6 Nov 2026 08:31:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F224BF80510; Fri,  6 Nov 2026 08:31:12 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793950270;
	b=Db6zPluzBa70Pu3vfjQBOMi97b3Eui1mrNULnWtREb+loF8vAqT0w3krtl3988u2GgmM
	 czUZoduz8+Q66Kg+7a/1BUA33ttamxuMO016Rl5BMrF9NuM7KEoVeIESZMUVytQ+4lqTw
	 +KqGil5k7jfbS3D2vGM4gtUQiXfWNIWeQEjyqWfEOW9M+hiGk6EfujawBf8d2nYznloec
	 FPGE26u46NZLQ9aUM7Jw9PPTFkZYuR+NUEKWl+DldQrqfMr5hjubWNGskKGWI/lrn11yi
	 NzSSXAao7gIom8SUhRlLxJ5ftogcn6ahCyDzNZs1IjA3H873d8TiSV+51/2conwyHPg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793950270;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=gLsbIKaMeV52vEF3mJFFGEM9QjGvlInPZM1xlsYFMRg=;
	b=neq1WH7pjxmhAV/vUh3MaVVTtLz5JCJp8cFxGlaSJsZSGfErMH0KKAdOf5RVE8tHFg8b
	 dYgS0jg1yfEb9uWCamCHJaiJO1xpP9PPSXrdlWsGmGB3jnDkOL8Nu1QKAojRT9FQsd5Fg
	 /rEPdRmqFRwrdq3MNiKlh7mTxqnF0jmvF1a7+h82LtSIC3Y+NvurhzrOJItPSTTcJb6pE
	 w4GMuFaFD0Irf+3YdOQHRPWrM1DR05/srfRXpQRBFOcbscZhRZIM2gOGHIzLbawip64Q1
	 V29PI/HLrrzNKioe7N/4BsoiP3zTDEPwOrESqmJL7zhS61Cc0K31P6/4QMWqelIYJJQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="fS/t5tmD";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A924BF80124
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 08:31:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A924BF80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fS/t5tmD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793950270; x=1825486270;
  h=date:from:to:cc:subject:message-id;
  bh=gLsbIKaMeV52vEF3mJFFGEM9QjGvlInPZM1xlsYFMRg=;
  b=fS/t5tmDlBvL36tz8axcLuMtxEoDY3rv4Z3XK4ffI0nUIS/Tc4zLmH3X
   cAwG8iEty7/8RhqyfPcOUEQL7QPWvLPypbYP70fK/LKdgm13DSa6qpzvk
   /1zqxdGo5uLDEVTKsJ5Pkc2lOUmCI4/B3HjJMusTiA24vDTOElyP6cmn+
   8n43GNI2E2tK4XEciuH0PeQQD+7styUnS2jVAVjorIuS2JeKMIsrWmEDb
   WMblDpQRoVGXaWLKUKzlXgXYTxJoEcrcN8sHq0ei4BqG6v5UgvdgsVuOD
   PRZ14kAh8YUAHuWuvDaxwJSFZYSUOs4OwgLhbrvp8cGM5roAhXegVWDtx
   Q==;
X-CSE-ConnectionGUID: 02l9qw7UTJ2u4BvIfjB1jg==
X-CSE-MsgGUID: vuvr3DAuR0uK5uwJCijdiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2847371"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="2847371"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 23:31:04 -0800
X-CSE-ConnectionGUID: w0t+eUU7QQqZOkm+jts1Iw==
X-CSE-MsgGUID: xZ4OEfnQRKe7ghdisrk6dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="7090976"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 05 Nov 2026 23:31:03 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPEPc-00000000A83-0Nq8;
	Fri, 06 Nov 2026 07:31:00 +0000
Date: Fri, 06 Nov 2026 08:30:18 +0100
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org
Subject: [tiwai-sound:test/sound-rust-v7.3 24/56] +    pub fn
 hw_constraint_minmax(&self, var: i32, min: u32, max: u32) ->
 crate::error::Result {
Message-ID: <202611060844.oYnGWPdW-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: PQXXUOC6H32SA4O23J7DBJYWUGXJWJQP
X-Message-ID-Hash: PQXXUOC6H32SA4O23J7DBJYWUGXJWJQP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PQXXUOC6H32SA4O23J7DBJYWUGXJWJQP/>
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
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20261106/202611060844.oYnGWPdW-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611060844.oYnGWPdW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611060844.oYnGWPdW-lkp@intel.com/

All errors (new ones prefixed by >>):

   PATH=/opt/cross/clang-22/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   INFO PATH=/opt/cross/rustc-1.96.0-bindgen-0.72.1/cargo/bin:/opt/cross/clang-22/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 12h /usr/bin/make KCFLAGS=\ -fno-crash-diagnostics\ -Wno-error=return-type\ -Wreturn-type\ -funsigned-char\ -Wundef\ -falign-functions=64 W=1 --keep-going LLVM=1 -j32 -C source O=/kbuild/obj/consumer/x86_64-rhel-9.4-rust ARCH=x86_64 SHELL=/bin/bash rustfmtcheck 
   make: Entering directory '/kbuild/src'
   make[1]: Entering directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
   Diff in rust/kernel/sound/pcm.rs:4:
    //!
    //! C header: [`include/sound/pcm.h`](srctree/include/sound/pcm.h)
    
   +use super::card::Card;
    use crate::{
        bindings,
        error::to_result,
   Diff in rust/kernel/sound/pcm.rs:10:
        prelude::*,
        str::CStr,
   -    sync::{atomic::{ordering, Atomic}, Arc, ArcBorrow},
   +    sync::{
   +        atomic::{ordering, Atomic},
   +        Arc, ArcBorrow,
   +    },
        types::Opaque,
    };
    use core::ffi::c_void;
   Diff in rust/kernel/sound/pcm.rs:16:
   -use super::card::Card;
    
    use core::marker::PhantomData;
    
   Diff in rust/kernel/sound/pcm.rs:193:
        ///
        /// Returns 8 for 8-bit formats, 16 for 16-bit formats, etc.
        pub fn format_width(&self) -> i32 {
   -        unsafe {
   -            bindings::snd_pcm_format_width((*self.as_raw()).format)
   -        }
   +        unsafe { bindings::snd_pcm_format_width((*self.as_raw()).format) }
        }
    
        /// Returns the raw `*mut snd_pcm_runtime` pointer.
   Diff in rust/kernel/sound/pcm.rs:266:
        /// Constrains a runtime parameter to the range \[`min`, `max`\].
        ///
        /// Mirrors `snd_pcm_hw_constraint_minmax()`.
   -    pub fn hw_constraint_minmax(
   -        &self,
   -        var: i32,
   -        min: u32,
   -        max: u32,
>> -    ) -> crate::error::Result {
>> +    pub fn hw_constraint_minmax(&self, var: i32, min: u32, max: u32) -> crate::error::Result {
>>          crate::error::to_result(unsafe {
                bindings::snd_pcm_hw_constraint_minmax(self.as_raw(), var as _, min, max)
            })
   Diff in rust/kernel/sound/pcm.rs:446:
        }
    
        /// Called to set hardware parameters.
   -    fn hw_params(
   -        &self,
   -        substream: &Substream,
   -        params: &HwParams,
   -    ) -> Result {
   +    fn hw_params(&self, substream: &Substream, params: &HwParams) -> Result {
            let _ = (substream, params);
            Ok(())
        }
   Diff in rust/kernel/sound/pcm.rs:706:
            max: usize,
        ) -> Result {
            to_result(unsafe {
   -            bindings::snd_pcm_set_managed_buffer_all(
   -                self.as_raw(),
   -                dma_type as i32,
   -                dev,
   -                size,
   -                max,
   -            )
   +            bindings::snd_pcm_set_managed_buffer_all(self.as_raw(), dma_type as i32, dev, size, max)
            })
        }
    
   Diff in rust/kernel/sound/pcm.rs:741:
    pub fn format_name(fmt: i32) -> &'static CStr {
        // SAFETY: `snd_pcm_format_name` always returns a valid, statically-allocated,
        // NUL-terminated C string for any format value, including unknown ones.
   -    unsafe { CStr::from_char_ptr(bindings::snd_pcm_format_name(fmt as bindings::snd_pcm_format_t)) }
   +    unsafe {
   +        CStr::from_char_ptr(bindings::snd_pcm_format_name(
   +            fmt as bindings::snd_pcm_format_t,
   +        ))
   +    }
    }
    
    /// Non-owning handle to a PCM substream, for spinlock-guarded interrupt context.
   Diff in rust/kernel/sound/pcm.rs:1064:
        /// error paths that unwind through the PCM core), so rule pointers obtained
        /// from the returned handle are guaranteed to remain valid for the runtime's
        /// lifetime.
   -    pub fn store_hw_rules<U: Send + 'static>(&self, rules: crate::alloc::KBox<U>) -> HwRuleHandle<U> {
   +    pub fn store_hw_rules<U: Send + 'static>(
   +        &self,
   +        rules: crate::alloc::KBox<U>,
   +    ) -> HwRuleHandle<U> {
            unsafe extern "C" fn free_cb<U>(rt: *mut bindings::snd_pcm_runtime) {
                let ptr = unsafe { (*rt).private_data as *mut U };
                // SAFETY: ptr was set from KBox::into_raw in store_hw_rules.
   Diff in rust/kernel/sound/pcm.rs:1071:
   -            unsafe { drop(crate::alloc::KBox::from_raw(ptr)); }
   -            unsafe { (*rt).private_data = core::ptr::null_mut(); }
   +            unsafe {
   +                drop(crate::alloc::KBox::from_raw(ptr));
   +            }
   +            unsafe {
   +                (*rt).private_data = core::ptr::null_mut();
   +            }
            }
            let raw = crate::alloc::KBox::into_raw(rules);
            // SAFETY: raw is a fresh heap pointer from KBox::into_raw; set_private
   Diff in rust/kernel/sound/pcm.rs:1076:
            // is called exactly once per runtime.
   -        unsafe { self.set_private(raw as *mut c_void, free_cb::<U>); }
   +        unsafe {
   +            self.set_private(raw as *mut c_void, free_cb::<U>);
   +        }
            HwRuleHandle(raw)
        }
    }
   Diff in rust/kernel/sound/pcm.rs:1105:
            let rule_ptr = rule_ref as *const R as *mut c_void;
            to_result(unsafe {
                bindings::snd_pcm_hw_rule_add(
   -                runtime.as_raw(), cond, var,
   +                runtime.as_raw(),
   +                cond,
   +                var,
                    Some(hw_rule_trampoline::<R>),
                    rule_ptr,
   -                dep0, dep1, dep2, dep3,
   +                dep0,
   +                dep1,
   +                dep2,
   +                dep3,
                )
            })
        }
   Diff in rust/kernel/sound/pcm.rs:1194:
        ) -> crate::error::Result<Self> {
            // SAFETY: dev is a valid kernel device; snd_devm_alloc_pages manages
            // its own lifetime via devres.
   -        let ptr = unsafe {
   -            bindings::snd_devm_alloc_pages(dev.as_raw(), dma_type as i32, size)
--
        /// Registers a control with custom settings.
   -    pub fn add_control(&self, iface: ElemIface, name: &CStr, ops: impl KControlOps) -> Result<Handle> {
   +    pub fn add_control(
   +        &self,
   +        iface: ElemIface,
   +        name: &CStr,
   +        ops: impl KControlOps,
   +    ) -> Result<Handle> {
            self.add_kcontrol(KControlConfig::new(iface, name), ops)
        }
    
   Diff in rust/kernel/sound/control.rs:304:
        /// Low-level entry point for fully custom controls.
   -    pub fn add_kcontrol(&self, config: KControlConfig<'_>, ops: impl KControlOps) -> Result<Handle> {
   +    pub fn add_kcontrol(
   +        &self,
   +        config: KControlConfig<'_>,
   +        ops: impl KControlOps,
   +    ) -> Result<Handle> {
            let data = KBox::new(
                KControlData(KBox::new(ops, GFP_KERNEL)? as KBox<dyn KControlOps>),
                GFP_KERNEL,
   Diff in rust/kernel/sound/control.rs:327:
            };
    
            // SAFETY: template is a valid snd_kcontrol_new on the stack.
   -        let kctl = unsafe {
   -            bindings::snd_ctl_new1(&template, data_ptr as *mut core::ffi::c_void)
   -        };
   +        let kctl = unsafe { bindings::snd_ctl_new1(&template, data_ptr as *mut core::ffi::c_void) };
    
            if kctl.is_null() {
                // snd_ctl_new1 failed; free data ourselves.
   Diff in rust/kernel/sound/control.rs:339:
    
            if config.bump_on_collision {
                while !unsafe { bindings::snd_ctl_find_id(self.as_raw(), &(*kctl).id) }.is_null() {
   -                unsafe { (*kctl).id.index += 1; }
   +                unsafe {
   +                    (*kctl).id.index += 1;
   +                }
                }
            }
    
   Diff in rust/kernel/sound/mod.rs:14:
    pub mod control;
    pub mod pcm;
    
   +pub use crate::{new_owned_sound_card, new_sound_card};
    pub use card::{Card, OwnedCard};
   -pub use control::{KControlConfig, KControlOps, ElemIface, ElemType};
   -pub use pcm::{Pcm};
   -pub use crate::{new_sound_card, new_owned_sound_card};
   +pub use control::{ElemIface, ElemType, KControlConfig, KControlOps};
   +pub use pcm::Pcm;
    
   Diff in rust/kernel/sound/pcm.rs:4:
    //!
    //! C header: [`include/sound/pcm.h`](srctree/include/sound/pcm.h)
    
   +use super::card::Card;
    use crate::{
        bindings,
        error::to_result,
   Diff in rust/kernel/sound/pcm.rs:10:
        prelude::*,
        str::CStr,
   -    sync::{atomic::{ordering, Atomic}, Arc, ArcBorrow},
   +    sync::{
   +        atomic::{ordering, Atomic},
   +        Arc, ArcBorrow,
   +    },
        types::Opaque,
    };
    use core::ffi::c_void;
   Diff in rust/kernel/sound/pcm.rs:16:
   -use super::card::Card;
    
    use core::marker::PhantomData;
    
   Diff in rust/kernel/sound/pcm.rs:193:
        ///
        /// Returns 8 for 8-bit formats, 16 for 16-bit formats, etc.
        pub fn format_width(&self) -> i32 {
   -        unsafe {
   -            bindings::snd_pcm_format_width((*self.as_raw()).format)
   -        }
   +        unsafe { bindings::snd_pcm_format_width((*self.as_raw()).format) }
        }
    
        /// Returns the raw `*mut snd_pcm_runtime` pointer.
   Diff in rust/kernel/sound/pcm.rs:266:
        /// Constrains a runtime parameter to the range \[`min`, `max`\].
        ///
        /// Mirrors `snd_pcm_hw_constraint_minmax()`.
   -    pub fn hw_constraint_minmax(
   -        &self,
   -        var: i32,
   -        min: u32,
   -        max: u32,
>> -    ) -> crate::error::Result {
>> +    pub fn hw_constraint_minmax(&self, var: i32, min: u32, max: u32) -> crate::error::Result {
>>          crate::error::to_result(unsafe {
                bindings::snd_pcm_hw_constraint_minmax(self.as_raw(), var as _, min, max)
            })
   Diff in rust/kernel/sound/pcm.rs:446:
        }
    
        /// Called to set hardware parameters.
   -    fn hw_params(
   -        &self,
   -        substream: &Substream,
   -        params: &HwParams,
   -    ) -> Result {
   +    fn hw_params(&self, substream: &Substream, params: &HwParams) -> Result {
            let _ = (substream, params);
            Ok(())
        }
   Diff in rust/kernel/sound/pcm.rs:706:
            max: usize,
        ) -> Result {
            to_result(unsafe {
   -            bindings::snd_pcm_set_managed_buffer_all(
   -                self.as_raw(),
   -                dma_type as i32,
   -                dev,
   -                size,
   -                max,
   -            )
   +            bindings::snd_pcm_set_managed_buffer_all(self.as_raw(), dma_type as i32, dev, size, max)
            })
        }
    
   Diff in rust/kernel/sound/pcm.rs:741:
    pub fn format_name(fmt: i32) -> &'static CStr {
        // SAFETY: `snd_pcm_format_name` always returns a valid, statically-allocated,
        // NUL-terminated C string for any format value, including unknown ones.
   -    unsafe { CStr::from_char_ptr(bindings::snd_pcm_format_name(fmt as bindings::snd_pcm_format_t)) }
   +    unsafe {
   +        CStr::from_char_ptr(bindings::snd_pcm_format_name(
   +            fmt as bindings::snd_pcm_format_t,
   +        ))
   +    }
    }
    
    /// Non-owning handle to a PCM substream, for spinlock-guarded interrupt context.
   Diff in rust/kernel/sound/pcm.rs:1064:
        /// error paths that unwind through the PCM core), so rule pointers obtained
        /// from the returned handle are guaranteed to remain valid for the runtime's
        /// lifetime.
   -    pub fn store_hw_rules<U: Send + 'static>(&self, rules: crate::alloc::KBox<U>) -> HwRuleHandle<U> {
   +    pub fn store_hw_rules<U: Send + 'static>(
   +        &self,
   +        rules: crate::alloc::KBox<U>,
   +    ) -> HwRuleHandle<U> {
            unsafe extern "C" fn free_cb<U>(rt: *mut bindings::snd_pcm_runtime) {
                let ptr = unsafe { (*rt).private_data as *mut U };
                // SAFETY: ptr was set from KBox::into_raw in store_hw_rules.
   Diff in rust/kernel/sound/pcm.rs:1071:
   -            unsafe { drop(crate::alloc::KBox::from_raw(ptr)); }
   -            unsafe { (*rt).private_data = core::ptr::null_mut(); }
   +            unsafe {
   +                drop(crate::alloc::KBox::from_raw(ptr));
   +            }
   +            unsafe {
   +                (*rt).private_data = core::ptr::null_mut();
   +            }
            }
            let raw = crate::alloc::KBox::into_raw(rules);
            // SAFETY: raw is a fresh heap pointer from KBox::into_raw; set_private
   Diff in rust/kernel/sound/pcm.rs:1076:
            // is called exactly once per runtime.
   -        unsafe { self.set_private(raw as *mut c_void, free_cb::<U>); }
   +        unsafe {
   +            self.set_private(raw as *mut c_void, free_cb::<U>);
   +        }
            HwRuleHandle(raw)
        }
    }
   Diff in rust/kernel/sound/pcm.rs:1105:
            let rule_ptr = rule_ref as *const R as *mut c_void;
            to_result(unsafe {
                bindings::snd_pcm_hw_rule_add(
   -                runtime.as_raw(), cond, var,
   +                runtime.as_raw(),
   +                cond,
   +                var,
                    Some(hw_rule_trampoline::<R>),
                    rule_ptr,
   -                dep0, dep1, dep2, dep3,
   +                dep0,
   +                dep1,
   +                dep2,
   +                dep3,
                )
            })
        }
   Diff in rust/kernel/sound/pcm.rs:1194:
        ) -> crate::error::Result<Self> {
            // SAFETY: dev is a valid kernel device; snd_devm_alloc_pages manages
            // its own lifetime via devres.
   -        let ptr = unsafe {
   -            bindings::snd_devm_alloc_pages(dev.as_raw(), dma_type as i32, size)
..

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
