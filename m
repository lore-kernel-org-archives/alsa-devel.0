Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC433EB64D7
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Jun 2023 10:15:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F2B783E;
	Fri, 30 Jun 2023 12:14:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F2B783E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688120129;
	bh=cIjaWWgKmxvRy9EARsTHBx4xO6XBMWkVAgQy1+arw3w=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=p8VqEdbD4Wup2aQLDqPDNoitfPfdVD79DbphuvJfVDEfSTDRomJh9Afoyh0+3mGWx
	 X/ooCZ/oO/pP6gBZKQhMVVX7AX3aM8UdQAlTDApQpsk/UZVMbsaW12tj3ID/1ZZYCS
	 6lVSiTGPhuVIiHlHH3czVGrdY0gqCz+OXFX2Df0Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5AD7CF80553; Fri, 30 Jun 2023 12:13:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B2871F80549;
	Fri, 30 Jun 2023 12:13:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D0CCF80246; Fri, 30 Jun 2023 12:13:45 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B2CDEF800E3
	for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2023 12:13:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2CDEF800E3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ihvEknwa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688120007; x=1719656007;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cIjaWWgKmxvRy9EARsTHBx4xO6XBMWkVAgQy1+arw3w=;
  b=ihvEknwaGCsVklNlEP/Vh8J2juL8qdxqDveJ4fvNpm3QlWP7ny4VQIXD
   kVifMOa5pMpGW6p/jrhDL6+tVB3o8iiwfX4U1nfT1pXpmMznUDnywycFd
   XaLuCCPdJvQIRwEDuTdxmamtOO5ojxa/AytE73LekJG1uo/Jc0yqyCqnU
   FcpUCtW3Ot0SeFdwRbi54j+th+y0aRaTyzFlc/wMiePsfKVRAg+p23bqF
   4uhkX2vi32QIcvuLq9wcJq8JuWrPjY72xP1GoBJyqqt+FO4KjVz6/ZFYn
   cJhnWh+1/nLVaLNCVjOokY1of3X/iGQQyqYadC48rmYojeUobF+jG++fe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="393089289"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200";
   d="scan'208";a="393089289"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 03:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="711771801"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200";
   d="scan'208";a="711771801"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 30 Jun 2023 03:13:22 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qFB7x-000EsJ-1T;
	Fri, 30 Jun 2023 10:13:21 +0000
Date: Fri, 30 Jun 2023 18:13:07 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org
Subject: [tiwai-sound:topic/midi20-gadget 58/62] ERROR: modpost:
 "snd_ump_switch_protocol" [drivers/usb/gadget/function/usb_f_midi2.ko]
 undefined!
Message-ID: <202306301823.km1gb5Cd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: XCSBMUDA32G674REDBZIMVTOTHKCVH52
X-Message-ID-Hash: XCSBMUDA32G674REDBZIMVTOTHKCVH52
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git topic/midi20-gadget
head:   9d606002a91a37796ae62afc5e6667126314e21b
commit: 0417de91e87de93793cd0d2cc4aef9062dc62f05 [58/62] usb: gadget: Add support for USB MIDI 2.0 function driver
config: openrisc-randconfig-r001-20230630 (https://download.01.org/0day-ci/archive/20230630/202306301823.km1gb5Cd-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230630/202306301823.km1gb5Cd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306301823.km1gb5Cd-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_ext_1g (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_ext_10g (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_ext_25g (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_ext_40g (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_ext_50g_base_r (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_ext_50g_base_r2 (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_ext_100g_base_r2 (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_ext_100g_base_r4 (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_1g (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_10g (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_20g (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_25g (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_40g (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_50g (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_1000 (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_10000 (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_20000 (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_25000 (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_40000 (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_50000 (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_100000 (section: .init.rodata)
ERROR: modpost: "snd_ump_block_new" [drivers/usb/gadget/function/usb_f_midi2.ko] undefined!
>> ERROR: modpost: "snd_ump_switch_protocol" [drivers/usb/gadget/function/usb_f_midi2.ko] undefined!
ERROR: modpost: "snd_ump_receive_ump_val" [drivers/usb/gadget/function/usb_f_midi2.ko] undefined!
ERROR: modpost: "snd_ump_transmit" [drivers/usb/gadget/function/usb_f_midi2.ko] undefined!
ERROR: modpost: "snd_ump_receive" [drivers/usb/gadget/function/usb_f_midi2.ko] undefined!
ERROR: modpost: "snd_ump_endpoint_new" [drivers/usb/gadget/function/usb_f_midi2.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
