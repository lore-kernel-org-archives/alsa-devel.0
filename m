Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C718606A31A
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Nov 2026 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=LQ8I1UWe;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AbhTV4RP
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAE32601E1;
	Sun,  8 Nov 2026 05:17:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAE32601E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794111463;
	bh=8Q+VZbenjtYNCan7x5h6v4egymzH94QrLAWhp6uxPaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=LQ8I1UWeZPwvuK9NUQoKlXyTWE/JMhQs+2PNeoFAJOeJk1sfq6RdcFPKxikhgk8J6
	 3AfH7zaImpHYvTmk0qtmMli50jtVvfNnUQxiHaVLTO0fpuDqHXj/1Z+4sMm040BWLs
	 ZEb6RiHRGkP2tEuBAesGKUrU2ZvGKwWyCmO0uvs4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AC91CF80605; Sun,  8 Nov 2026 05:17:10 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1BC3FF80601;
	Sun,  8 Nov 2026 05:17:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1AF67F80538; Sun,  8 Nov 2026 05:17:04 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794111422;
	b=Ukjz6F7lsAYsV6+LDSrOV2PQfPWP6gMQRdu3m7jD/weoNkwvF9GEFZt3sqv+O1s8Q+vB
	 LQr6qInbonAyw+sg991YVtpaivVUZC2llqfa54QnfXn4Po9JfrR+4KjhvFJp4nvRPWMlE
	 Ol5XRw2hH2WOKctRc+GgkB35eIiPSqPIqnNeaRtPFM1nh3WPH9lc7jFaCqC+l2hyqM6T5
	 dSYKlfegrdtV8eJgGgAYGjGpylfB3jBMFggGdWCjPkjdIHcUoN+ybkNbnBrptn9zbux+w
	 HbrNOC0mmmoGwR20P0XvevKu3m78Paz1HuEKnnk3l+bY5WNHOB5k/87XyCzzi/G/0PA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794111422;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=8Q+VZbenjtYNCan7x5h6v4egymzH94QrLAWhp6uxPaM=;
	b=HvsGR65Rf0Y76OkwFyMOPnHNr+lhmUjBK7NT4pzlE+MHuay0t/xKCFIpvnlNE6H9Rwga
	 dGkkDxeMDJjbq9qukHTBM2u4ew8Xfsq5AUEGiQxdfuYGtA7SOypUfKPZFJeFjyEpkFq2/
	 yV4sOqSrmz/RSKv5jvssy8uKGHHxRc9uyMkZnF6LoP35NiX/2yr+D9U3xtQFobJg0+FsY
	 ifiw63Lw4LgoHLILZ+9KRIMSfeeG6/gu1I1GVjoDrriyGGbSJCVFpzUJlk3k0Kdxn2f7r
	 uJXGg/jQeSNHGa2C9yFqSY2vIMMbgtr53LG2aXu0FKhV2PIR1DFC+5ycVj6SmFZDbfQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AbhTV4RP;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9A2DFF80124;
	Sun,  8 Nov 2026 05:16:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A2DFF80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AbhTV4RP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794111421; x=1825647421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Q+VZbenjtYNCan7x5h6v4egymzH94QrLAWhp6uxPaM=;
  b=AbhTV4RPIshaz1q4eAOmtOjNCOcgzDYyffEoK1oGZ/EkicfDgWJxSPia
   3JxBRDqrXFacR66NkjiQymt2EziVWTwtOZqLv+JmxssWn6n9qhn9e8Qi+
   ETWNykVdhqbt7t/PmUucOXU5qjKbU4pT0tKyG1GHL+LimFrqZttZfWUH5
   FDtGCGT05aooFFDx4YOs6+MSjtHq4rayL4VjOaSIQWoL8NfyOxFngc1D3
   M6AC8Q1KPPhIE1M1auy5Zz/55We35eLE32fK0R2jqhHEj9wal8N6OBwsa
   +RLjPppf7rWup0TA1Pg8ag+6d8V0skUPJ/H4WlegaN3PcHXa29tEiixBD
   g==;
X-CSE-ConnectionGUID: jGL+L1mwSxign494b2RkgA==
X-CSE-MsgGUID: 87xWSLrnRL6D1Pn6wXhjCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2775231"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400";
   d="scan'208";a="2775231"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 20:16:52 -0800
X-CSE-ConnectionGUID: cWI89eCdT7uNvkgdyPugyw==
X-CSE-MsgGUID: hBBQBA72R+a0W3RdhTt7AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400";
   d="scan'208";a="7597346"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Nov 2026 20:16:48 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPuKj-00000000s2B-20KO;
	Sun, 08 Nov 2026 04:16:45 +0000
Date: Sun, 8 Nov 2026 12:16:35 +0800
From: kernel test robot <lkp@intel.com>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, vkoul@kernel.org,
	alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, yung-chuan.liao@linux.intel.com,
	Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
	venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
	Mario.Limonciello@amd.com, Richard.Gong@amd.com, Poojitha.N@amd.com,
	lee@kernel.org, Vijendar.Mukunda@amd.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	sound-open-firmware@alsa-project.org
Subject: Re: [PATCH 4/4] ASoC: amd: ps: guard SDW IRQ work scheduling with
 interrupt_enabled flag
Message-ID: <202611081206.vQhseto9-lkp@intel.com>
References: <20261107175339.3547918-5-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107175339.3547918-5-Vijendar.Mukunda@amd.com>
Message-ID-Hash: 42TWSEXPFASJ43LVQ7U33W2JVIRJWJY2
X-Message-ID-Hash: 42TWSEXPFASJ43LVQ7U33W2JVIRJWJY2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/42TWSEXPFASJ43LVQ7U33W2JVIRJWJY2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Hi Vijendar,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on vkoul-dmaengine/next linus/master v7.4-rc1 next-20261105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vijendar-Mukunda/ASoC-amd-ps-guard-adata-sdw-dereferences-with-NULL-check-in-IRQ-handler/20261107-232226
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20261107175339.3547918-5-Vijendar.Mukunda%40amd.com
patch subject: [PATCH 4/4] ASoC: amd: ps: guard SDW IRQ work scheduling with interrupt_enabled flag
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20261108/202611081206.vQhseto9-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261108/202611081206.vQhseto9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611081206.vQhseto9-lkp@intel.com/

All errors (new ones prefixed by >>):

   sound/soc/amd/ps/pci-ps.c: In function 'acp63_irq_handler':
>> sound/soc/amd/ps/pci-ps.c:218:55: error: 'struct amd_sdw_manager' has no member named 'interrupt_enabled'
     218 |                         if (amd_manager && amd_manager->interrupt_enabled)
         |                                                       ^~
   sound/soc/amd/ps/pci-ps.c:229:55: error: 'struct amd_sdw_manager' has no member named 'interrupt_enabled'
     229 |                         if (amd_manager && amd_manager->interrupt_enabled)
         |                                                       ^~


vim +218 sound/soc/amd/ps/pci-ps.c

   194	
   195	static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
   196	{
   197		struct acp63_dev_data *adata;
   198		struct pdm_dev_data *ps_pdm_data;
   199		struct amd_sdw_manager *amd_manager;
   200		u32 ext_intr_stat, ext_intr_stat1;
   201		u16 irq_flag = 0;
   202		u16 wake_irq_flag = 0;
   203		u16 sdw_dma_irq_flag = 0;
   204	
   205		adata = dev_id;
   206		if (!adata)
   207			return IRQ_NONE;
   208		/* ACP interrupts will be cleared by reading particular bit and writing
   209		 * same value to the status register. writing zero's doesn't have any
   210		 * effect.
   211		 * Bit by bit checking of IRQ field is implemented.
   212		 */
   213		ext_intr_stat = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
   214		if (ext_intr_stat & ACP_SDW0_STAT) {
   215			writel(ACP_SDW0_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
   216			if (adata->sdw) {
   217				amd_manager = dev_get_drvdata(&adata->sdw->pdev[0]->dev);
 > 218				if (amd_manager && amd_manager->interrupt_enabled)
   219					schedule_work(&amd_manager->amd_sdw_irq_thread);
   220			}
   221			irq_flag = 1;
   222		}
   223	
   224		ext_intr_stat1 = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
   225		if (ext_intr_stat1 & ACP_SDW1_STAT) {
   226			writel(ACP_SDW1_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
   227			if (adata->sdw) {
   228				amd_manager = dev_get_drvdata(&adata->sdw->pdev[1]->dev);
   229				if (amd_manager && amd_manager->interrupt_enabled)
   230					schedule_work(&amd_manager->amd_sdw_irq_thread);
   231			}
   232			irq_flag = 1;
   233		}
   234	
   235		if (ext_intr_stat & ACP_ERROR_IRQ) {
   236			writel(ACP_ERROR_IRQ, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
   237			/* TODO: Report SoundWire Manager instance errors */
   238			writel(0, adata->acp63_base + ACP_SW0_I2S_ERROR_REASON);
   239			writel(0, adata->acp63_base + ACP_SW1_I2S_ERROR_REASON);
   240			writel(0, adata->acp63_base + ACP_ERROR_STATUS);
   241			irq_flag = 1;
   242		}
   243	
   244		if (adata->acp_rev >= ACP70_PCI_REV)
   245			wake_irq_flag = check_and_handle_acp70_sdw_wake_irq(adata);
   246	
   247		if (ext_intr_stat & BIT(PDM_DMA_STAT)) {
   248			ps_pdm_data = dev_get_drvdata(&adata->pdm_dev->dev);
   249			writel(BIT(PDM_DMA_STAT), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
   250			if (ps_pdm_data->capture_stream)
   251				snd_pcm_period_elapsed(ps_pdm_data->capture_stream);
   252			irq_flag = 1;
   253		}
   254	
   255		sdw_dma_irq_flag = check_and_handle_sdw_dma_irq(adata, ext_intr_stat, ext_intr_stat1);
   256		if (sdw_dma_irq_flag)
   257			return IRQ_WAKE_THREAD;
   258	
   259		if (irq_flag || wake_irq_flag)
   260			return IRQ_HANDLED;
   261		else
   262			return IRQ_NONE;
   263	}
   264	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
