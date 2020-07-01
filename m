Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5B2C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:03:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B4F206C3
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QjHkon7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B4F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6091B1670;
	Wed,  1 Jul 2020 11:02:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6091B1670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593594225;
	bh=y8Rk2XgIBUZ2YYRyRLukdfkIM+GGHwhOgVeMCORbiCI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QjHkon7Yn4HHFxAcPqvA5lB4Rkb69TFDbW7bthL7q1Iz2ttaeQNhkW76nrl08Qh3i
	 HkFLT8ABEEVccx+eeOrKAFzHREcRADafUkdELLyo5enEez6paGJJy0oiayCC1OYZSb
	 DDqT5umpEL8n0B3rlJpk7VHWiabekmJAmDLGdx6s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E8358F8020C;
	Wed,  1 Jul 2020 11:02:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 064CFF80217; Wed,  1 Jul 2020 11:02:52 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A95F5F800EA
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 11:02:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A95F5F800EA
IronPort-SDR: SaZXjME9hzsDBU4QIWI2StjQ0ybyIAWiE4O2RjSyhN0LekQRHjP17JraRlG0lfsreKcEbyalat
 E+6ji9oqct1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="208023149"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; d="scan'208";a="208023149"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 02:02:39 -0700
IronPort-SDR: +BWSTkWy0JRHmhihh1dhe9hs23j4qPM7JrRo2jof1hQuRkxsDKF+G44Cu4Odcw6iEiSW2K0yzr
 u3ZHTXQ9whFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; d="scan'208";a="265347404"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 01 Jul 2020 02:02:37 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1jqYdY-0002qO-J9; Wed, 01 Jul 2020 09:02:36 +0000
Date: Wed, 1 Jul 2020 17:02:01 +0800
From: kernel test robot <lkp@intel.com>
To: Harsha Priya <harshapriya.n@intel.com>, alsa-devel@alsa-project.org,
 tiwai@suse.de
Subject: Re: [PATCH v2] ALSA: hda/hdmi: Add Intel silent stream support
Message-ID: <202007011647.rp21Ypnt%lkp@intel.com>
References: <1593476606-24147-1-git-send-email-harshapriya.n@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593476606-24147-1-git-send-email-harshapriya.n@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kai.vehmanen@intel.com, Harsha Priya <harshapriya.n@intel.com>,
 kbuild-all@lists.01.org, Emmanuel Jillela <emmanuel.jillela@intel.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Harsha,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on sound/for-next]
[also build test ERROR on v5.8-rc3 next-20200701]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Harsha-Priya/ALSA-hda-hdmi-Add-Intel-silent-stream-support/20200630-082719
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
config: ia64-randconfig-s032-20200701
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-3-gfa153962-dirty
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sound/pci/hda/Kconfig:258: unexpected 'if' within menu block
>> sound/pci/hda/Kconfig:260: unexpected 'menu' within if block
   sound/Kconfig:102: 'if' in different file than 'if'
   sound/pci/hda/Kconfig:2: location of the 'if'
   sound/Kconfig:104: 'if' in different file than 'if'
   sound/pci/hda/Kconfig:2: location of the 'if'
>> sound/Kconfig:106: unexpected 'if' within menu block
>> drivers/Kconfig:239: syntax error
   drivers/Kconfig:238: invalid statement
   make[2]: *** [scripts/kconfig/Makefile:71: oldconfig] Error 1
   make[1]: *** [Makefile:606: oldconfig] Error 2
   make: *** [Makefile:185: __sub-make] Error 2
   make: Target 'oldconfig' not remade because of errors.
--
>> sound/pci/hda/Kconfig:258: unexpected 'if' within menu block
>> sound/pci/hda/Kconfig:260: unexpected 'menu' within if block
   sound/Kconfig:102: 'if' in different file than 'if'
   sound/pci/hda/Kconfig:2: location of the 'if'
   sound/Kconfig:104: 'if' in different file than 'if'
   sound/pci/hda/Kconfig:2: location of the 'if'
>> sound/Kconfig:106: unexpected 'if' within menu block
>> drivers/Kconfig:239: syntax error
   drivers/Kconfig:238: invalid statement
   make[2]: *** [scripts/kconfig/Makefile:71: olddefconfig] Error 1
   make[1]: *** [Makefile:606: olddefconfig] Error 2
   make: *** [Makefile:185: __sub-make] Error 2
   make: Target 'olddefconfig' not remade because of errors.

vim +/if +258 sound/pci/hda/Kconfig

   243	
   244	config SND_HDA_INTEL_HDMI_SILENT_STREAM
   245		bool "Enable Silent Stream always for HDMI"
   246		depends on SND_HDA_INTEL
   247		help
   248		  Intel hardware has a feature called 'silent stream', that
   249		  keeps external HDMI receiver's analog circuitry powered on
   250		  avoiding 2-3 sec silence during playback start. This mechanism
   251		  relies on an info packet and preventing the codec from going to
   252		  D3. (increasing the platform static power consumption when a
   253		  HDMI receiver is plugged-in). 2-3 sec silence at the playback
   254		  start is expected whenever there is format change. (default is
   255		  2 channel format).
   256		  Say Y to enable Silent Stream feature.
   257	
 > 258	endif
   259	
 > 260	endmenu

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
