Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B27FEB64D7
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Jun 2023 11:07:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96C3E7F8;
	Fri, 30 Jun 2023 13:07:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96C3E7F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688123272;
	bh=CdAU2IjeZB76vtS5XyCLrXOmJWMiZnSf8TozRN8J2qQ=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=c1BS1n4FQOa0ymakUYxLAo2i6WmnVmaSikXCr0M+B91pNbb63y1SUg57r5Yq9aOEx
	 9UJC8yN1lo1mxX4b5311eSBiod6iPSlRlglSsVhCeWY7DWwZWACYjh74x5EAMQkpyY
	 /u8DqtXmwzTvHt9UY8xpLOOOXEWDxbmLJm5G6ViQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14A45F80535; Fri, 30 Jun 2023 13:06:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F953F800E3;
	Fri, 30 Jun 2023 13:06:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 850B4F80212; Fri, 30 Jun 2023 13:06:34 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E9909F80124
	for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2023 13:06:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9909F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BDM0W7Ih
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688123190; x=1719659190;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CdAU2IjeZB76vtS5XyCLrXOmJWMiZnSf8TozRN8J2qQ=;
  b=BDM0W7IhMeMekZoAPo2nVQW1hNkhZp4mhQA+nMpeajwLgesVfDxr2Y2R
   RJ+XW3zbNo6NDwPv898XFRhfla3GJCPc8rBxukxOtkLyC0A4N/bFhjb5T
   HYgSaVOU7odO37fLAEQt8lKpbzILGXW/wPfy8KGGB7j4IWi4IzTVqifLP
   kjVTz1X1m/hsn1o9lzKe2fNYJ01I18YZPFFoFOy6a00hxHV2wpE52YhLU
   i6/9DzbP+gfAs9BwwW00ACE59C3PBXbmA/r9RAAn/e8lCAq3HE36HT2S0
   e5N2AlGsjqel8nTqkvE5B67FYGmMS/e5hoS5ZVxG2lw7JFw/hxBnzsFd8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="347150961"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200";
   d="scan'208";a="347150961"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 04:06:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="752961625"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200";
   d="scan'208";a="752961625"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 30 Jun 2023 04:06:23 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qFBxG-000Etf-17;
	Fri, 30 Jun 2023 11:06:22 +0000
Date: Fri, 30 Jun 2023 19:05:29 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org
Subject: [tiwai-sound:topic/midi20-gadget 58/62] f_midi2.c:undefined
 reference to `snd_ump_switch_protocol'
Message-ID: <202306301830.QG614gSO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: 6Z5J23F7QPCNOCOR7BINWHNTXUJXR272
X-Message-ID-Hash: 6Z5J23F7QPCNOCOR7BINWHNTXUJXR272
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
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6Z5J23F7QPCNOCOR7BINWHNTXUJXR272/>
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
config: x86_64-buildonly-randconfig-r001-20230629 (https://download.01.org/0day-ci/archive/20230630/202306301830.QG614gSO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230630/202306301830.QG614gSO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306301830.QG614gSO-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/usb/gadget/function/f_midi2.o: in function `f_midi2_create_card.constprop.0':
   f_midi2.c:(.text+0x35b6): undefined reference to `snd_ump_endpoint_new'
   ld: f_midi2.c:(.text+0x3bba): undefined reference to `snd_ump_block_new'
   ld: drivers/usb/gadget/function/f_midi2.o: in function `process_ump_stream_msg':
>> f_midi2.c:(.text+0x4b0f): undefined reference to `snd_ump_switch_protocol'
   ld: drivers/usb/gadget/function/f_midi2.o: in function `f_midi2_ep_out_complete':
   f_midi2.c:(.text+0x598e): undefined reference to `snd_ump_receive_ump_val'
   ld: f_midi2.c:(.text+0x5b36): undefined reference to `snd_ump_receive'
   ld: drivers/usb/gadget/function/f_midi2.o: in function `process_ump_transmit':
   f_midi2.c:(.text+0x5de1): undefined reference to `snd_ump_transmit'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
