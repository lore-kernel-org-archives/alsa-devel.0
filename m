Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092BA606A31B
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=ZHM19YCK;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DFBWH0t3
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 078A0601CC;
	Thu,  5 Nov 2026 23:09:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 078A0601CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793916581;
	bh=hYq1eyPP5thvjzV5wc19zyoNAegNO2EOM4+eY207AVg=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ZHM19YCKmmY86lfCfPwIVOM5MDseGEGtK6zUgiL5ASqmuKkQbo+/U1DajKQZTJ/Iv
	 0Fo1hkleauhu1EgbTEpui0PLQycsteJLt6GN/S9mCT26uqezNI/s4OrVFOG6mdycQz
	 8dtf+NZTXZTNVjToxe/ytWBEiS03eXTGMVsC0dWY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3179F805FA; Thu,  5 Nov 2026 23:09:08 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B04A0F805F7;
	Thu,  5 Nov 2026 23:09:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7B2CDF804FF; Thu,  5 Nov 2026 23:09:03 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793916542;
	b=bel/lPzbqkjoe52KlD16+077GaEFIH3THa9PCNyd6zgkbtXRUqb4NBwfYOUT3uDP0xBV
	 nCyeqBojyKRIr0RWiNGpffnfyhudUk1Z/xLxdLLXrFUTZCKWv+o7aSMR+gN9TfUn2WUhT
	 bclzNMf33tv+OZzLrD0kxDCulGaLFPRIHfeaS7dKbqwh84ewg7J3ylv6FAgPUgleJ2aGt
	 FT9jDL3g3cnF5SN2yjJTx6tpCYnsnNXfca8kCeXWYejd8SnIMNU7vitvJENiXmYz6t2ab
	 TayYUL3yBZSXkQ6ZGaEcrvVUyLLkgRSYz4W8ipK2wl8FwC7PRNXIf/qO2esUMSC5JNg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793916542;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=hYq1eyPP5thvjzV5wc19zyoNAegNO2EOM4+eY207AVg=;
	b=qqLNQfnI0sVrLkjBXWhmq0Udl/iOdrAxNOaD5fM+OOlwabF2edtJCRr1S6B5jYHtFnP7
	 mXVGj7TQ9i7EeUTnL7G9dQHw+ObAvV+MVVPvaKIYM2PGAyPUB4iPW+LhQmZdCNXtzXbEe
	 /axT7F2tzHuummpn/HIFxviUv3MReqO3A9lPwcPaajFZtcgXV9qaodN95/JuuO/2VIZxO
	 MW+NFCaar+2k3yCRZNPJN+Q8RN1bIMupnwYEQo+0fsOm/XXdts80I1cqY1TVTw4ZB/Tgp
	 ghDUqiEA0cmm/BFjE73LfEDGwPPzNlG/6PlGNOiOxXaAE9Poq41rTcOJ4SDmIviiqkg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DFBWH0t3;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D41F1F800EE
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2026 23:08:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D41F1F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DFBWH0t3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793916542; x=1825452542;
  h=date:from:to:cc:subject:message-id;
  bh=hYq1eyPP5thvjzV5wc19zyoNAegNO2EOM4+eY207AVg=;
  b=DFBWH0t3nHAXTxa4BGf4E3yOcPgpo0OUUCKV0U6wKYB/iWHRC8aAo0dS
   FLucSgmEyXYYft4QkmcfSdjczcEAH1q2cPrD89TnlUaJ0zjhUVvXG6SKt
   Wcbdl+5ojRVHpe1IilrrvgmxAxm1hOi/yz04C0AYtD+Dz2ICsOA/qY5np
   Ttf8wy42a1o2s266Cvz1/lECccz7QbPNG6LDLljmyMnTjlHEHarJW3KLk
   ZfkFFfy/zquiomvS961Q5tMkjO0ZRFZW3jMUZUIbqfvsPa7Mmb7cLnkzv
   M9Gm6oRdcUZhhlkNRH760FSHcc5BZvppTNMGTht2Zb0sDTcTnLSKfAjGD
   A==;
X-CSE-ConnectionGUID: lzxwxtE/TR2tlbphPRnrRw==
X-CSE-MsgGUID: D6SSDZrET7yTML3NLr84mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2717846"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="2717846"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 14:08:58 -0800
X-CSE-ConnectionGUID: J7xunbtBQDuBCS7LrUx0qA==
X-CSE-MsgGUID: s35NXF8hQ06iQidGTYdWjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="7273971"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 05 Nov 2026 14:08:56 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xP5dd-000000009pb-35Ua;
	Thu, 05 Nov 2026 22:08:53 +0000
Date: Thu, 05 Nov 2026 23:08:21 +0100
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org
Subject: [tiwai-sound:test/sound-rust-v7.3 25/56] error[E0425]:
 cannot find function `snd_info_get_line` in crate `bindings`
Message-ID: <202611052249.DPhLpTfI-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: 5KGYXWNW4MHKNIGB4RKU2RZA4PTBZ4XW
X-Message-ID-Hash: 5KGYXWNW4MHKNIGB4RKU2RZA4PTBZ4XW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5KGYXWNW4MHKNIGB4RKU2RZA4PTBZ4XW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git test/sound-rust-v7.3
head:   070444a8abf14da700680a5331d0a95cd11e578b
commit: e181d3e8f00ae014f1e75fade71c9dada6a53976 [25/56] ALSA: rust: add proc text-entry binding
config: arm64-randconfig-2200-20261105 (https://download.01.org/0day-ci/archive/20261105/202611052249.DPhLpTfI-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611052249.DPhLpTfI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611052249.DPhLpTfI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find function `snd_info_get_line` in crate `bindings`
   --> rust/kernel/sound/info.rs:55:23
   |
   55 |             bindings::snd_info_get_line(
   |                       ^^^^^^^^^^^^^^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `snd_info_get_str` in crate `bindings`
   --> rust/kernel/sound/info.rs:71:23
   |
   71 |             bindings::snd_info_get_str(
   |                       ^^^^^^^^^^^^^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `snd_info_create_card_entry` in crate `bindings`
   --> rust/kernel/sound/info.rs:230:23
   |
   230 |             bindings::snd_info_create_card_entry(
   |                       ^^^^^^^^^^^^^^^^^^^^^^^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `snd_info_register` in crate `bindings`
   --> rust/kernel/sound/info.rs:259:38
   |
   259 |         to_result(unsafe { bindings::snd_info_register(entry) })
   |                                      ^^^^^^^^^^^^^^^^^
   |
   ::: rust/bindings/bindings_generated.rs:138216:5
   |
   138216 |     pub fn snd_card_register(card: *mut snd_card) -> ffi::c_int;
   |     ------------------------------------------------------------ similarly named function `snd_card_register` defined here
   |
   help: a function with a similar name exists
   |
   259 -         to_result(unsafe { bindings::snd_info_register(entry) })
   259 +         to_result(unsafe { bindings::snd_card_register(entry) })
   |

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
