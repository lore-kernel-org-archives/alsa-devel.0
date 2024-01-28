Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5215C47258
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Jan 2024 08:07:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5FE0846;
	Sun, 28 Jan 2024 09:07:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5FE0846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706429234;
	bh=V/uxGuIdjQtXLUat9Wg34EnJS/gDqQBII63hArr4gMs=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=LPGNTMi958YnKENrJiHwW8TNHmnEpjjhC4jLcJprmANSjFtk7OjtyyocV0SG5qUrO
	 3ojWDBOdwV4SyYd7y/flPK/ep/mZa/UlppuJJGZ1qQbBVHkOImPVpiFrRXXq7NXiU5
	 8mIOfshTSUC+WrtrPawjLtLHFGYzy5L80/O+gDLw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 41295F8055B; Sun, 28 Jan 2024 09:06:42 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A5CAF8055B;
	Sun, 28 Jan 2024 09:06:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EC99FF80310; Sun, 28 Jan 2024 09:05:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 40E2BF8017A
	for <alsa-devel@alsa-project.org>; Sun, 28 Jan 2024 09:01:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40E2BF8017A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mzK1SoeA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706428888; x=1737964888;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V/uxGuIdjQtXLUat9Wg34EnJS/gDqQBII63hArr4gMs=;
  b=mzK1SoeARs2vjtd0I2QrxqG3roo4eGHauNRQj7ydf4zS0c6ACF6VUcTl
   6cjGh3pdCmefFi85pfIX3W8JQCmBFo4kelRd6535cO2wIS2Y/55UU9nyk
   st/sBRGj3OE3Qi55D4B9mzwM1CfyfhZ3fkXursL3FvRysIrRbEH3xaAco
   66e4L4QNFsKV+EGd4O9dBuHEPCzUPTbPjrwfovH+6ntLI15CIfsoQS3So
   F5J3EKeOEWPHmCrhINaSK2ZgDXwckv5vbO7QIDA7oT7CK0cVEqLNV2P+v
   UymzbfHxGG0YzwzeH1AL5n6o24K++93vwlcCeO8TeB+1Cu7iLaeTICxcn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="21283062"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400";
   d="scan'208";a="21283062"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2024 00:01:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="787514997"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400";
   d="scan'208";a="787514997"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Jan 2024 00:01:20 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rU06P-0003EQ-2a;
	Sun, 28 Jan 2024 08:01:17 +0000
Date: Sun, 28 Jan 2024 16:01:15 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org
Subject: [tiwai-sound:topic/pm-ops 11/29] sound/arm/aaci.c:742:22: warning:
 unused variable 'aaci'
Message-ID: <202401281542.hlZQZx6m-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: 7WRUC6KB7PIGTLIE54NRFAWNURGSNDGW
X-Message-ID-Hash: 7WRUC6KB7PIGTLIE54NRFAWNURGSNDGW
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7WRUC6KB7PIGTLIE54NRFAWNURGSNDGW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Takashi,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git topic/pm-ops
head:   2fe6ffd7c79f740b73533d44de3ae0e542674857
commit: 8c975a919c0e6139ddf3692fa44992364587070c [11/29] ALSA: aaci: Replace with DEFINE_SIMPLE_DEV_PM_OPS()
config: arm-randconfig-004-20240127 (https://download.01.org/0day-ci/archive/20240128/202401281542.hlZQZx6m-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401281542.hlZQZx6m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401281542.hlZQZx6m-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/arm/aaci.c: In function 'aaci_do_suspend':
>> sound/arm/aaci.c:742:22: warning: unused variable 'aaci' [-Wunused-variable]
     742 |         struct aaci *aaci = card->private_data;
         |                      ^~~~


vim +/aaci +742 sound/arm/aaci.c

cb5a6ffc5c09bc Russell King 2005-05-12  736  
cb5a6ffc5c09bc Russell King 2005-05-12  737  /*
cb5a6ffc5c09bc Russell King 2005-05-12  738   * Power Management.
cb5a6ffc5c09bc Russell King 2005-05-12  739   */
b13a714923fe4d Ulf Hansson  2013-12-03  740  static int aaci_do_suspend(struct snd_card *card)
cb5a6ffc5c09bc Russell King 2005-05-12  741  {
cb5a6ffc5c09bc Russell King 2005-05-12 @742  	struct aaci *aaci = card->private_data;
792a6c51875c9d Takashi Iwai 2005-11-17  743  	snd_power_change_state(card, SNDRV_CTL_POWER_D3cold);
cb5a6ffc5c09bc Russell King 2005-05-12  744  	return 0;
cb5a6ffc5c09bc Russell King 2005-05-12  745  }
cb5a6ffc5c09bc Russell King 2005-05-12  746  

:::::: The code at line 742 was first introduced by commit
:::::: cb5a6ffc5c09bc354af69407dae710dcddcced37 [ALSA] ARM AACI primecell driver

:::::: TO: Russell King <rmk@arm.linux.org.uk>
:::::: CC: Jaroslav Kysela <perex@suse.cz>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
