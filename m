Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8167A606A326
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=qwCakxL4;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QQKj32qU
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0680F601F6;
	Fri,  6 Nov 2026 18:07:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0680F601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793984842;
	bh=iI/vz1l76rk0fJ23Snfx+DJ7L9bblPm1j4Dvgi3JptY=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=qwCakxL4g5QcnlT3Ru7nFEaW/0UAzAAU2I8W05suWKtOOaRMlE8OFiw0ALxJaRX6m
	 uq/ntSE8jTudyB3sqO1hdFDgA4m1PxTSLqxucM8I9wAHsFASfMHHD39lIv5iExe4Z2
	 00iG3zDOuwvan1q6IujAsSZGNNWz98AiFSNVahHk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3589DF805F7; Fri,  6 Nov 2026 18:06:50 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DB94AF805F7;
	Fri,  6 Nov 2026 18:06:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DDAAAF80510; Fri,  6 Nov 2026 18:06:44 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793984800;
	b=rqORtdX5wDZqZiAxEn6+3Qx+CTuMYetsDt2Pe85287Wae4sivNs+yYTElI5aPGK8My9f
	 sKDmFRpH+Lw/eftH4T54VQdNsKZZrERDFhMutBlaL098jXMDsfa7jUCqQs+MhcWfkMl0R
	 R/fdCRj9zHqvCRzMAa2yLmccYG5cjgPAIymFjXvG39ayGTVGc2XpAcHpC2JgYlCSx+N/6
	 e0WVVCrpZxu46XIgd/wdyBRXHr0jN4YFJ8BHSxYEkKTKPuj4aEcl/1mA0UKKBIS+2S63a
	 p1i4iSVmxbEz2FAw1blNMJbaZFU3pp6yDQZ+EYCQDfovqHXUyPA+sovg1ckF4rn/eAw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793984800;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=iI/vz1l76rk0fJ23Snfx+DJ7L9bblPm1j4Dvgi3JptY=;
	b=Zku2567IkmvJi9oT1EZmIWXIpRH4zFnUi898da1+BoV8JzmBjs+zgTFn+LuB5TrvYHme
	 HBJql39mzZhSMn/Lpu4n18fDbZEX8I0NuplIN/NE960nx4gW73OL/QJOxGyjJRWX6jOC/
	 +KYcJRsxbtFtUfUD36P7p1OkYsWk0ux9QPZXA93GyeNp6rnihScbVdamldoKYtRCBNluy
	 AfShQ9jxgIE06TO/X/5cPWvQ+MRz0/c1rxeLVzwtTdpArSn23JFnGfw9oq+MwJA/yB8Hv
	 kfo/lJDJBkZoWOtkf4GzkDsmmavBRRG0EHEu/uRyVOw9kUNjpD9mGNAqd19i2jXy4VA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QQKj32qU;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CF004F8016D
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 18:06:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF004F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QQKj32qU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793984800; x=1825520800;
  h=date:from:to:cc:subject:message-id;
  bh=iI/vz1l76rk0fJ23Snfx+DJ7L9bblPm1j4Dvgi3JptY=;
  b=QQKj32qU8BVbO59Phc9vdtNEzNgKuJLn0Kafr48Nmqp9Lds+UMZr2BUl
   BzIht8q5BIEw7h0sI/cEqA+D21soVpe1hr3LX3vOQk+jHeif5fB17I7b+
   AhCDh/65g8Eznc3nwUYsOuzg03BXTUigFxn8VVXJGB5fXr78dmACXWIJ8
   6PsUHrp2vNqYZEJmwif7PYAVZHqnV/sIhv4QpPpCIfKcz6nmdS87Wu2wG
   qopok6PjYHJPK2F5XB1pMhvs/9tSwAd7a6Tx24L/2DI0ot+GCFu5xc9kP
   z4erBzj3FpzDOGM2fsvcStK+Z81tiop5ikV+ZsmmqKR62bnu69yz82wtH
   A==;
X-CSE-ConnectionGUID: inUN/N5TQ5iwDhmoXzfbYw==
X-CSE-MsgGUID: KQ2GLUN5Qxu/n6A5ob7FPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2893536"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="2893536"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 09:06:34 -0800
X-CSE-ConnectionGUID: 88jJX7FOTfGKtLISFJ8OOQ==
X-CSE-MsgGUID: a1hDD7N5SB6OTo+gEhURmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="7377183"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
  by orviesa006.jf.intel.com with ESMTP; 06 Nov 2026 09:06:32 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPNOX-00000000AK7-0JpQ;
	Fri, 06 Nov 2026 17:06:29 +0000
Date: Fri, 06 Nov 2026 18:05:42 +0100
From: kernel test robot <lkp@intel.com>
To: Colin Braun <colinbrauncl@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.de>
Subject: [tiwai-sound:test/sound-rust-v7.3 35/56] Diff in
 rust/kernel/usb.rs:32:
Message-ID: <202611061749.sOMovkvI-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: KZKYXCWQJVJVJ32DA42EAXAXQ56YDKFM
X-Message-ID-Hash: KZKYXCWQJVJVJ32DA42EAXAXQ56YDKFM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KZKYXCWQJVJVJ32DA42EAXAXQ56YDKFM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git test/sound-rust-v7.3
head:   070444a8abf14da700680a5331d0a95cd11e578b
commit: 579098a741b1256ae5092d4eb8ae8116057c8458 [35/56] rust: usb: add usb host interface and endpoint abstractions
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20261106/202611061749.sOMovkvI-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611061749.sOMovkvI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611061749.sOMovkvI-lkp@intel.com/

All errors (new ones prefixed by >>):

        fn new() -> impl PinInit<Self, Error> {
            try_pin_init!(Self {
   Diff in sound/rust/dummy.rs:181:
    
        fn trigger(&self, substream: &pcm::Substream, cmd: pcm::TriggerCommand) -> Result {
            match cmd {
   -            pcm::TriggerCommand::Start |
   -            pcm::TriggerCommand::Resume => {
   +            pcm::TriggerCommand::Start | pcm::TriggerCommand::Resume => {
                    let runtime = substream.runtime();
                    let rate = runtime.rate() as i64;
                    let period_size = runtime.period_size();
   Diff in sound/rust/dummy.rs:204:
                    let handle = self.timer.clone().start(Delta::from_nanos(period_ns));
                    self.chip.lock().timer_handle = Some(handle);
                }
   -            pcm::TriggerCommand::Stop |
   -            pcm::TriggerCommand::PausePush |
   -            pcm::TriggerCommand::Suspend => {
   +            pcm::TriggerCommand::Stop
   +            | pcm::TriggerCommand::PausePush
   +            | pcm::TriggerCommand::Suspend => {
                    // Clear substream so the callback returns NoRestart on its
                    // next (or current) invocation.
                    self.timer.substream.clear(ordering::Release);
   Diff in sound/rust/dummy.rs:332:
    fn cstr_slice(s: &[u8]) -> &[u8] {
        match s.iter().position(|&b| b == 0) {
            Some(n) => &s[..n],
   -        None    => s,
   +        None => s,
        }
    }
    
   Diff in sound/rust/dummy.rs:374:
                let _ = write!(buf, " knot");
            }
            const RATES: &[(u32, u32)] = &[
   -            (bindings::SNDRV_PCM_RATE_5512,   5512),
   -            (bindings::SNDRV_PCM_RATE_8000,   8000),
   -            (bindings::SNDRV_PCM_RATE_11025,  11025),
   -            (bindings::SNDRV_PCM_RATE_16000,  16000),
   -            (bindings::SNDRV_PCM_RATE_22050,  22050),
   -            (bindings::SNDRV_PCM_RATE_32000,  32000),
   -            (bindings::SNDRV_PCM_RATE_44100,  44100),
   -            (bindings::SNDRV_PCM_RATE_48000,  48000),
   -            (bindings::SNDRV_PCM_RATE_64000,  64000),
   -            (bindings::SNDRV_PCM_RATE_88200,  88200),
   -            (bindings::SNDRV_PCM_RATE_96000,  96000),
   +            (bindings::SNDRV_PCM_RATE_5512, 5512),
   +            (bindings::SNDRV_PCM_RATE_8000, 8000),
   +            (bindings::SNDRV_PCM_RATE_11025, 11025),
   +            (bindings::SNDRV_PCM_RATE_16000, 16000),
   +            (bindings::SNDRV_PCM_RATE_22050, 22050),
   +            (bindings::SNDRV_PCM_RATE_32000, 32000),
   +            (bindings::SNDRV_PCM_RATE_44100, 44100),
   +            (bindings::SNDRV_PCM_RATE_48000, 48000),
   +            (bindings::SNDRV_PCM_RATE_64000, 64000),
   +            (bindings::SNDRV_PCM_RATE_88200, 88200),
   +            (bindings::SNDRV_PCM_RATE_96000, 96000),
                (bindings::SNDRV_PCM_RATE_176400, 176400),
                (bindings::SNDRV_PCM_RATE_192000, 192000),
            ];
   Diff in sound/rust/dummy.rs:415:
    
                let mut val_buf = [0u8; 20];
                buf.get_str(&mut val_buf, rest);
   -            let Some(val) = parse_u64(cstr_slice(&val_buf)) else { continue };
   +            let Some(val) = parse_u64(cstr_slice(&val_buf)) else {
   +                continue;
   +            };
    
                let mut hw = self.chip.lock();
                match name {
   Diff in sound/rust/dummy.rs:422:
   -                b"formats"          => hw.pcm_hw.formats          = val,
   -                b"rates"            => hw.pcm_hw.rates             = val as u32,
   -                b"rate_min"         => hw.pcm_hw.rate_min          = val as u32,
   -                b"rate_max"         => hw.pcm_hw.rate_max          = val as u32,
   -                b"channels_min"     => hw.pcm_hw.channels_min      = val as u32,
   -                b"channels_max"     => hw.pcm_hw.channels_max      = val as u32,
   -                b"buffer_bytes_max" => hw.pcm_hw.buffer_bytes_max  = val as usize,
   -                b"period_bytes_min" => hw.pcm_hw.period_bytes_min  = val as usize,
   -                b"period_bytes_max" => hw.pcm_hw.period_bytes_max  = val as usize,
   -                b"periods_min"      => hw.pcm_hw.periods_min       = val as u32,
   -                b"periods_max"      => hw.pcm_hw.periods_max       = val as u32,
   +                b"formats" => hw.pcm_hw.formats = val,
   +                b"rates" => hw.pcm_hw.rates = val as u32,
   +                b"rate_min" => hw.pcm_hw.rate_min = val as u32,
   +                b"rate_max" => hw.pcm_hw.rate_max = val as u32,
   +                b"channels_min" => hw.pcm_hw.channels_min = val as u32,
   +                b"channels_max" => hw.pcm_hw.channels_max = val as u32,
   +                b"buffer_bytes_max" => hw.pcm_hw.buffer_bytes_max = val as usize,
   +                b"period_bytes_min" => hw.pcm_hw.period_bytes_min = val as usize,
   +                b"period_bytes_max" => hw.pcm_hw.period_bytes_max = val as usize,
   +                b"periods_min" => hw.pcm_hw.periods_min = val as u32,
   +                b"periods_max" => hw.pcm_hw.periods_max = val as u32,
                    _ => {}
                }
            }
>> Diff in rust/kernel/usb.rs:32:
        marker::PhantomData,
        mem::offset_of,
        ptr::NonNull, //
   -    slice, //
   +    slice,        //
    };
    
    pub mod ch9;
   Diff in rust/kernel/sound/info.rs:13:
    //!
    //! C header: [`include/sound/info.h`](srctree/include/sound/info.h)
    
   +use super::card::Card;
    use crate::{bindings, error::to_result, prelude::*, sync::Arc};
    use core::marker::PhantomData;
   -use super::card::Card;
    
    //
    // InfoBuffer
   Diff in rust/kernel/sound/info.rs:52:
        pub fn get_line(&mut self, line: &mut [u8]) -> bool {
            // SAFETY: self.0 is valid; line is a writable slice of the given length.
            let ret = unsafe {
   -            bindings::snd_info_get_line(
   -                self.0,
   -                line.as_mut_ptr(),
   -                line.len() as core::ffi::c_int,
   -            )
   +            bindings::snd_info_get_line(self.0, line.as_mut_ptr(), line.len() as core::ffi::c_int)
            };
            ret == 0
        }
   Diff in rust/kernel/sound/info.rs:208:
        where
            T: TextOps + Sync + Send + 'static,
        {
   -        self.proc_new_impl(name, data, Some(TextOpsTable::<T>::c_read), Some(TextOpsTable::<T>::c_write))
   +        self.proc_new_impl(
   +            name,
   +            data,
   +            Some(TextOpsTable::<T>::c_read),
   +            Some(TextOpsTable::<T>::c_write),
   +        )
        }
    
        /// Common implementation for [`ro_proc_new`] and [`rw_proc_new`].
   Diff in rust/kernel/sound/info.rs:216:
            &self,
            name: &CStr,
            data: Arc<T>,
   -        read: Option<unsafe extern "C" fn(*mut bindings::snd_info_entry, *mut bindings::snd_info_buffer)>,
   -        write: Option<unsafe extern "C" fn(*mut bindings::snd_info_entry, *mut bindings::snd_info_buffer)>,
   +        read: Option<
   +            unsafe extern "C" fn(*mut bindings::snd_info_entry, *mut bindings::snd_info_buffer),
   +        >,
   +        write: Option<
   +            unsafe extern "C" fn(*mut bindings::snd_info_entry, *mut bindings::snd_info_buffer),
   +        >,
        ) -> Result
        where
            T: TextOps + Sync + Send + 'static,
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
--
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
    
   Diff in rust/kernel/sound/pcm.rs:753:
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
   Diff in rust/kernel/sound/pcm.rs:1076:
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
   Diff in rust/kernel/sound/pcm.rs:1083:
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
   Diff in rust/kernel/sound/pcm.rs:1088:
            // is called exactly once per runtime.
   -        unsafe { self.set_private(raw as *mut c_void, free_cb::<U>); }
   +        unsafe {
   +            self.set_private(raw as *mut c_void, free_cb::<U>);
   +        }
            HwRuleHandle(raw)
        }
    }
   Diff in rust/kernel/sound/pcm.rs:1117:
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
   Diff in rust/kernel/sound/pcm.rs:1206:
        ) -> crate::error::Result<Self> {
            // SAFETY: dev is a valid kernel device; snd_devm_alloc_pages manages
            // its own lifetime via devres.
   -        let ptr = unsafe {
   -            bindings::snd_devm_alloc_pages(dev.as_raw(), dma_type as i32, size)
   -        };
   +        let ptr = unsafe { bindings::snd_devm_alloc_pages(dev.as_raw(), dma_type as i32, size) };
            if ptr.is_null() {
                Err(ENOMEM)
            } else {
>> Diff in rust/kernel/usb.rs:32:
        marker::PhantomData,
        mem::offset_of,
        ptr::NonNull, //
   -    slice, //
   +    slice,        //
    };
    
    pub mod ch9;
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
   Diff in rust/kernel/pci/irq.rs:185:
            // SAFETY: `irq` is a valid IRQ number for `self.dev`, resolved from this registration.
            // `self.dev` carries the full `'a` lifetime; `.as_ref()` preserves it so the returned
            // `IrqRequest<'a>` has the correct lifetime without any borrow shortening.
   -        Ok((unsafe { IrqRequest::new(self.dev.as_ref(), irq as u32) }, self))
   +        Ok((
   +            unsafe { IrqRequest::new(self.dev.as_ref(), irq as u32) },
   +            self,
   +        ))
        }
    }
    
   Diff in rust/kernel/pci/irq.rs:185:
            // SAFETY: `irq` is a valid IRQ number for `self.dev`, resolved from this registration.
            // `self.dev` carries the full `'a` lifetime; `.as_ref()` preserves it so the returned
            // `IrqRequest<'a>` has the correct lifetime without any borrow shortening.
   -        Ok((unsafe { IrqRequest::new(self.dev.as_ref(), irq as u32) }, self))
   +        Ok((
   +            unsafe { IrqRequest::new(self.dev.as_ref(), irq as u32) },
   +            self,
   +        ))
        }
    }
    
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
