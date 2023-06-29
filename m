Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49ACEB64D9
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jun 2023 22:07:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B0C3B7F4;
	Fri, 30 Jun 2023 00:06:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B0C3B7F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688076457;
	bh=KroM8puHGKZ2GhPTHV5bkuvKmw/g83hXo9qNzMJhDzg=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=SMWcRzmjedcGdarigA8fKDpUinEvrPCdiNQF7PY3zz3j/i/rDhzpmO1g/I7DHyMFH
	 V4UpDCJ5UGqe6mNsGrN5rYIN8BIN+RUpfkNUw0h1uego1e5plyYx0UTuD/SYzq9n8d
	 gKiLUs7cIXXT997oj7KQJbh5v7k9js47n0VblIs8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 39CD8F80212; Fri, 30 Jun 2023 00:06:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E0CBAF80124;
	Fri, 30 Jun 2023 00:06:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4A7EFF80246; Fri, 30 Jun 2023 00:06:19 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 40818F80124
	for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2023 00:06:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40818F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=C7iwInYO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688076373; x=1719612373;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KroM8puHGKZ2GhPTHV5bkuvKmw/g83hXo9qNzMJhDzg=;
  b=C7iwInYOKZcd34hfoXl0d5mm+QBUaoqF843Di/mI5UgvIQaKO9b3s6YR
   G10GIDMSdFbf/cuxu03E940e05LVdo/nFw0ZLcohymzIYvb8iZ58hmhzF
   g0a1ICBFVK84ZIz4GxJzM1hi8UgXUOYWh1xOhRjrcDfD9TTSHt0TJ56dg
   lP/G1nnYfoNcD0p9pNdw77iGLSGe0nZet4WSPa4IyD4UdeFy4lLXOuG/B
   ceQcZTi3gjmZ9qlT8ABP+m+GUlB5w2nGVJTjYY6lLubvj4Mp2N5JzQ5kp
   yLj+gEoJaGiPMsLMt0Ica1CGvarSdXyxZE9dQOMYTKsn5BEAGLFSlLdFV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="364819238"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200";
   d="scan'208";a="364819238"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 15:06:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="711605553"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200";
   d="scan'208";a="711605553"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Jun 2023 15:06:00 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qEzm3-000ERR-3B;
	Thu, 29 Jun 2023 22:05:59 +0000
Date: Fri, 30 Jun 2023 06:05:23 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	alsa-devel@alsa-project.org
Subject: [tiwai-sound:topic/midi20-gadget 56/56] ld.lld: error: undefined
 symbol: snd_ump_transmit
Message-ID: <202306300550.yyh6cWzj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: 7RF6OZ6IWDJRDWUNWTMLJ2AMJZVQNRS7
X-Message-ID-Hash: 7RF6OZ6IWDJRDWUNWTMLJ2AMJZVQNRS7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7RF6OZ6IWDJRDWUNWTMLJ2AMJZVQNRS7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git topic/midi20-gadget
head:   ed28b6939ebadd073e731ccf0f2c6ce4ab102ffd
commit: ed28b6939ebadd073e731ccf0f2c6ce4ab102ffd [56/56] usb: gadget: add support for USB MIDI 2.0 function driver (WIP)
config: i386-randconfig-r023-20230629 (https://download.01.org/0day-ci/archive/20230630/202306300550.yyh6cWzj-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230630/202306300550.yyh6cWzj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306300550.yyh6cWzj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: snd_ump_transmit
   >>> referenced by f_midi2.c:644 (drivers/usb/gadget/function/f_midi2.c:644)
   >>>               drivers/usb/gadget/function/f_midi2.o:(process_ump_transmit) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: snd_ump_endpoint_new
   >>> referenced by f_midi2.c:946 (drivers/usb/gadget/function/f_midi2.c:946)
   >>>               drivers/usb/gadget/function/f_midi2.o:(f_midi2_bind) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: snd_ump_block_new
   >>> referenced by f_midi2.c:957 (drivers/usb/gadget/function/f_midi2.c:957)
   >>>               drivers/usb/gadget/function/f_midi2.o:(f_midi2_bind) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: snd_ump_receive
   >>> referenced by f_midi2.c:623 (drivers/usb/gadget/function/f_midi2.c:623)
   >>>               drivers/usb/gadget/function/f_midi2.o:(f_midi2_ep_out_complete) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: snd_ump_receive_ump_val
   >>> referenced by f_midi2.c:599 (drivers/usb/gadget/function/f_midi2.c:599)
   >>>               drivers/usb/gadget/function/f_midi2.o:(f_midi2_ep_out_complete) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
