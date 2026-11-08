Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2472B606A31C
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Nov 2026 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=nq1FRqqY;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QEQC/ZKs
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52762601E3;
	Sun,  8 Nov 2026 12:09:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52762601E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794136174;
	bh=zUrwpjHmgX2sQEIOLj74SCTZplyzWE0AapO1fDycG+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nq1FRqqYEavgLRTehhLxep5tYqTqSoVg2ZCfH5fATq77ak0MjHgVw7TpweqovZmTE
	 Y90ls2saDrIoTefc5VcbsrCs1tGELdeWVQWCoU3BDIbHHEYoxlMaS1G9s3+8m7EZ8O
	 g7DAE1p9VjJlEQYoodHDpFiInTRC0cJgzgzqR/rs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42198F80603; Sun,  8 Nov 2026 12:09:01 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B1EDF805FF;
	Sun,  8 Nov 2026 12:09:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EE8C8F80538; Sun,  8 Nov 2026 12:08:53 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794136132;
	b=Z8ekYxCsnqGRqlU+Ripq0H3Yz0IQcoQ/tL376hzafXlcOmbzVX6iFlcFKUkwjkFNhAhI
	 oNAf9OBM1Y8j8PrbDSoW8ANtAS1TK2HhMSL/A7NairpYDm2gdnRwSr0INLETHMBiVlpNu
	 qJ8IeLs8TzQMDOdgncW1PSfpuym6u0d2fBNks7HaRG550XO0VRIJCNcpMgDBM3W1sLhQL
	 sI208wIv0pjT6ehwdbgdErHSnWhJc6D6Y6cuki1UB9eQCOFhAHah22/dQF94SfOue601p
	 soJbEYRLGatrGWCR5Ws+eO607prUjxYbfjl9+NMIwZ7itcVe90ROsLZvNonOOB99msA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794136132;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=zUrwpjHmgX2sQEIOLj74SCTZplyzWE0AapO1fDycG+I=;
	b=md175ssVkAK86E7HvAIBaDmQUYb9WnDSkdc74einNP/d6H2ZCgaVmlkL+a3z8PHHcf19
	 QgXOdg9MNnMc7N2b9Fkil2M2Tb6cwmtpBJY6bOnLTFFzh89Uk6pDZT6mTT3psJaAX7S9p
	 VFzPIZ4wu41S2c8saKV0hnoX/2vrmuVczfi5cWD+tEGocwEflVpVdPkfAXV6N3YDvFvFg
	 f7gRJqBiwaKT5GqKbHDtTr8DL0D9+n2STlKgeog4na2x34IRpnzhcUPBoLzOpiTsHAq3i
	 3yYlzigyHscO0lEGm2Qh1ZdH1Sac0jo9N4NNbB29NUJJFR5uFyW+xIFYN+uI/PnSQbw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="QEQC/ZKs";
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8E4CCF80152;
	Sun,  8 Nov 2026 12:08:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E4CCF80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QEQC/ZKs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794136132; x=1825672132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zUrwpjHmgX2sQEIOLj74SCTZplyzWE0AapO1fDycG+I=;
  b=QEQC/ZKs3B+qeW/t3xzhy0uUcTalKjMDIna4UqNewF4lpWDkBjbxWepL
   Y0LQ1oZ6njVhg6wSPaUOfUqmSPTLkVmrjWoiUx6Hwsd6JAlrVrR0Dl2x9
   uPmR/QyRUVR6sIMrtAwM8weHnrKDXBfwiJB2I1KKwAj3YJAwY69e8E3fa
   Y6f00EV8JrIfCet4QVav1TO9IewvdhZDwOK3JzQB/rGYEt7vr9mD0lXRE
   8ahma9qlorAs/pbUSAG4bKL3gt2IMl63PCZ9aghkau2HOj/g2N3hFf0sX
   aWyoa1Hsg24lCOOYJ0TjUd1R4hzPONjSGdIzt+pd3hcOYdA8QSX7n98EY
   w==;
X-CSE-ConnectionGUID: XfIQIOI7TdqEIYfvQvB7dw==
X-CSE-MsgGUID: sHtQ6XRORXiKv78M5mtz/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2766793"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400";
   d="scan'208";a="2766793"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2026 03:08:45 -0800
X-CSE-ConnectionGUID: 6fFzp7XqRk67eSIeTVIQLQ==
X-CSE-MsgGUID: D6Sz5yH7Q3CFYCsZnSwV/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400";
   d="scan'208";a="7540748"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Nov 2026 03:08:41 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQ0lK-00000000sqN-0FOf;
	Sun, 08 Nov 2026 11:08:38 +0000
Date: Sun, 8 Nov 2026 19:08:27 +0800
From: kernel test robot <lkp@intel.com>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, vkoul@kernel.org,
	alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, yung-chuan.liao@linux.intel.com,
	Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
	venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
	Mario.Limonciello@amd.com, Richard.Gong@amd.com, Poojitha.N@amd.com,
	lee@kernel.org, Vijendar.Mukunda@amd.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	sound-open-firmware@alsa-project.org
Subject: Re: [PATCH 3/4] ASoC: SOF: amd: guard SDW IRQ work scheduling with
 interrupt_enabled flag
Message-ID: <202611081921.O3dE9COW-lkp@intel.com>
References: <20261107175339.3547918-4-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107175339.3547918-4-Vijendar.Mukunda@amd.com>
Message-ID-Hash: G6WBVNIQOTMLE3VYSJJZCKK2RLWFT3TL
X-Message-ID-Hash: G6WBVNIQOTMLE3VYSJJZCKK2RLWFT3TL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G6WBVNIQOTMLE3VYSJJZCKK2RLWFT3TL/>
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
patch link:    https://lore.kernel.org/r/20261107175339.3547918-4-Vijendar.Mukunda%40amd.com
patch subject: [PATCH 3/4] ASoC: SOF: amd: guard SDW IRQ work scheduling with interrupt_enabled flag
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20261108/202611081921.O3dE9COW-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261108/202611081921.O3dE9COW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611081921.O3dE9COW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sound/soc/sof/amd/acp.c:589:36: error: no member named 'interrupt_enabled' in 'struct amd_sdw_manager'
     589 |                         if (amd_manager && amd_manager->interrupt_enabled)
         |                                            ~~~~~~~~~~~  ^
   sound/soc/sof/amd/acp.c:621:37: error: no member named 'interrupt_enabled' in 'struct amd_sdw_manager'
     621 |                                 if (amd_manager && amd_manager->interrupt_enabled)
         |                                                    ~~~~~~~~~~~  ^
   2 errors generated.


vim +589 sound/soc/sof/amd/acp.c

   566	
   567	static irqreturn_t acp_irq_handler(int irq, void *dev_id)
   568	{
   569		struct amd_sdw_manager *amd_manager;
   570		struct snd_sof_dev *sdev = dev_id;
   571		const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
   572		struct acp_dev_data *adata = sdev->pdata->hw_pdata;
   573		unsigned int base = desc->dsp_intr_base;
   574		unsigned int val;
   575		int irq_flag = 0, wake_irq_flag = 0;
   576	
   577		val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET);
   578		if (val & ACP_DSP_TO_HOST_IRQ) {
   579			snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET,
   580					  ACP_DSP_TO_HOST_IRQ);
   581			return IRQ_WAKE_THREAD;
   582		}
   583	
   584		val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->ext_intr_stat);
   585		if (val & ACP_SDW0_IRQ_MASK) {
   586			snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ACP_SDW0_IRQ_MASK);
   587			if (adata->sdw) {
   588				amd_manager = dev_get_drvdata(&adata->sdw->pdev[0]->dev);
 > 589				if (amd_manager && amd_manager->interrupt_enabled)
   590					schedule_work(&amd_manager->amd_sdw_irq_thread);
   591			}
   592			irq_flag = 1;
   593		}
   594	
   595		if (val & ACP_ERROR_IRQ_MASK) {
   596			snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ACP_ERROR_IRQ_MASK);
   597			snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_sw0_i2s_err_reason, 0);
   598			/* ACP_SW1_I2S_ERROR_REASON is newly added register from rmb platform onwards */
   599			switch (adata->pci_rev) {
   600			case ACP_RMB_PCI_ID:
   601			case ACP63_PCI_ID:
   602			case ACP70_PCI_ID:
   603			case ACP71_PCI_ID:
   604			case ACP72_PCI_ID:
   605				snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SW1_I2S_ERROR_REASON, 0);
   606				break;
   607			default:
   608				break;
   609			}
   610			snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_error_stat, 0);
   611			irq_flag = 1;
   612		}
   613	
   614		if (desc->ext_intr_stat1) {
   615			val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->ext_intr_stat1);
   616			if (val & ACP_SDW1_IRQ_MASK) {
   617				snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat1,
   618						  ACP_SDW1_IRQ_MASK);
   619				if (adata->sdw) {
   620					amd_manager = dev_get_drvdata(&adata->sdw->pdev[1]->dev);
   621					if (amd_manager && amd_manager->interrupt_enabled)
   622						schedule_work(&amd_manager->amd_sdw_irq_thread);
   623				}
   624				irq_flag = 1;
   625			}
   626			switch (adata->pci_rev) {
   627			case ACP70_PCI_ID:
   628			case ACP71_PCI_ID:
   629			case ACP72_PCI_ID:
   630				wake_irq_flag = amd_sof_check_and_handle_acp70_sdw_wake_irq(sdev);
   631				break;
   632			}
   633		}
   634		if (irq_flag || wake_irq_flag)
   635			return IRQ_HANDLED;
   636		else
   637			return IRQ_NONE;
   638	}
   639	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
