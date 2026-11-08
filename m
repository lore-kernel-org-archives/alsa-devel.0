Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E04606A326
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Nov 2026 01:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Mn1y75NN;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HBtSuUl+
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04AF6601DC;
	Sun,  8 Nov 2026 02:27:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04AF6601DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794101254;
	bh=62G6CXvWJYpeXqAlqKEtBedlRvUTL3ZsGFn1+x5tC/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Mn1y75NNeXPI/ErLGkfQIq4DcSgcKN7lvmZp9xoeKMbW+lIbnIzTaCBPlVxKcuE2l
	 YWIQU0auC1/O18Z4I7RhC+c0wGVTG7ngxM0jiMWnzYq8dB/DiYNFzYyS7xQM5JEz3C
	 wGCuy1/bLgFLOqo10409vwBuIS3JulzbA47HpCAU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 492E1F8060F; Sun,  8 Nov 2026 02:27:00 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 75F6BF805F6;
	Sun,  8 Nov 2026 02:27:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D498EF80538; Sun,  8 Nov 2026 02:26:53 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794101209;
	b=GBDg2yPzLIsIRfogQN8G6DFkZ7rswrSJ6mlQ7px6ZVT6/1vbwGdfwVuX6DOVNyyWAklt
	 Ay9FXXZlJdh+SdvrRZ43uMdCacOk1UtXntwbTaCleiBn/utPg+Jcvo5TeYiiYqCqDPUTv
	 QnwTbuPh3sB+8Xqzf7sHU6HQ7IEEB6Wm7A72cadJUfdeigVP0WI4djhni+pqzmP3wUcHR
	 /V2IKeokxAUIjCS1gq2Ak4NnzhrPRk+C4SYcr6aTrqPC5x/aHBr5kz+IboAzxosL5bY67
	 tW6vFfBFGXUKAiQeQhUTDc94BN1mLxpV+wkQgvXh0Vs3Tx0eNZfPrMnIxTPXcT1SSfw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794101209;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=62G6CXvWJYpeXqAlqKEtBedlRvUTL3ZsGFn1+x5tC/Y=;
	b=aZYWbmsM1RYmhnVLVI1st7/Pr/CPjbAwftqxAzagcIGYWZAkJqMHi6RuG8vsZCce9m3+
	 tvV+YgLjLocRIWiMwNaaqw5k3bz5LjItPZB7OiYsZ4j4oS6tGdYIYUDXpYadOeh7D+5ZV
	 PwhsvZYeVJLaRY5ISg195TWcIbSq2uD9bzh/2CpzxQeynbgvXPmCKXmEOnTPiKcHqx8fb
	 RsJ5+jD9nNbY42np7omS9uJSCJERz6CuihVcTIm+4j27tsDYjRjN+cA1STyxLOPPZW1PS
	 jtF6EJGAwCzXAytNj6tycvzw2yVF+eQLHpjUqgHafO3LIqm2Qe5iMCMtdhitrGWWgzQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HBtSuUl+;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AB9D8F8014B;
	Sun,  8 Nov 2026 02:26:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB9D8F8014B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HBtSuUl+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794101210; x=1825637210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=62G6CXvWJYpeXqAlqKEtBedlRvUTL3ZsGFn1+x5tC/Y=;
  b=HBtSuUl+Wp7GR0G6PSkui4wORz1Ic9ZRCdm1L1we3Alu1gs9MFLqGBju
   SmyHqB9KIJuBe7QMMpWc2q36G05t+3OaJfun84RYmXDLHLOvSZF7IqtcT
   GjBsYwbAg3L6v39WxL8QUvudr5se3A7D1qKhlnEgpVxmrqzsSifz0uXsX
   yelI6RvwPUwB9MTmfYt1h7FkBUOi1MMrb1MBCuMAo6NlpA9I6Cwk3za+D
   KPm9BI5lhUdvcrp3JTBlWMlj5QVDKYIuPmLC3dZSPvFTwdGHO8eaBOYFt
   tKdGdtFlevfI/zl5CCSn4E7br9sW7id/j1e0G6jGvdRoE8gYAZqoaTwue
   w==;
X-CSE-ConnectionGUID: ecFkAKidRKSkmejeqhJTsQ==
X-CSE-MsgGUID: E45i9yEQRsiw0qhRicnDJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2772348"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400";
   d="scan'208";a="2772348"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 17:26:43 -0800
X-CSE-ConnectionGUID: vybv3uPPTWKHzk1p+7wyMQ==
X-CSE-MsgGUID: +YDOCgh+Q0u2MwqxxSp20g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400";
   d="scan'208";a="7579703"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Nov 2026 17:26:38 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPrg3-00000000rsx-1BhI;
	Sun, 08 Nov 2026 01:26:35 +0000
Date: Sun, 8 Nov 2026 09:25:58 +0800
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
Subject: Re: [PATCH 3/4] ASoC: SOF: amd: guard SDW IRQ work scheduling with
 interrupt_enabled flag
Message-ID: <202611080910.HG54RIuC-lkp@intel.com>
References: <20261107175339.3547918-4-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107175339.3547918-4-Vijendar.Mukunda@amd.com>
Message-ID-Hash: 4KVECTMMFLYO55VBVBYPCQ6YVKKQDAU4
X-Message-ID-Hash: 4KVECTMMFLYO55VBVBYPCQ6YVKKQDAU4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4KVECTMMFLYO55VBVBYPCQ6YVKKQDAU4/>
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
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20261108/202611080910.HG54RIuC-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261108/202611080910.HG54RIuC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611080910.HG54RIuC-lkp@intel.com/

All errors (new ones prefixed by >>):

   sound/soc/sof/amd/acp.c: In function 'acp_irq_handler':
>> sound/soc/sof/amd/acp.c:589:55: error: 'struct amd_sdw_manager' has no member named 'interrupt_enabled'
     589 |                         if (amd_manager && amd_manager->interrupt_enabled)
         |                                                       ^~
   sound/soc/sof/amd/acp.c:621:63: error: 'struct amd_sdw_manager' has no member named 'interrupt_enabled'
     621 |                                 if (amd_manager && amd_manager->interrupt_enabled)
         |                                                               ^~


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
