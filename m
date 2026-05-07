Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD8CCD37BE
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2026 14:46:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF8F160223;
	Mon, 11 May 2026 16:46:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF8F160223
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778510786;
	bh=oNdusZkwgqwJI2KQMDw1olIVuO2PU9mOwfxBIKkwmlE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UgE9ehovFYw/XQuZe/DXsZE/vvRj3v36xZ8ElQE1kYwR49WcuN0XJ9WSmwfl3yyhI
	 iEl65KD/H6kXTJHuO806oTih0IW0/SeMMMvQ3Hueh9pBDYAgPKDwI61OyVc1wrMpeB
	 G7OrHZktpNyA8aHi8mjbnDLSWAqvMspdrD+RbSJo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C52C7F806C3; Mon, 11 May 2026 16:44:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 91A6EF806CB;
	Mon, 11 May 2026 16:44:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8FFD6F8051F; Thu,  7 May 2026 21:34:50 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4C27FF80212
	for <alsa-devel@alsa-project.org>; Thu,  7 May 2026 21:34:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C27FF80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=G0x4ziH6
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 99D6B4328E;
	Thu,  7 May 2026 19:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61CFC2BCC4;
	Thu,  7 May 2026 19:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778182485;
	bh=oNdusZkwgqwJI2KQMDw1olIVuO2PU9mOwfxBIKkwmlE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G0x4ziH6+yIDAioHArGTa6yIALsbxvxFTc7iTUma6uyX/ZJqzEt5NBnH5ntBPan1X
	 na+z5LL0Wf9e7BkJtgINujyb6WENI+HZzSEXAfXxFXJ+aB1HWhwrSMQfbH4J17nE4E
	 AtKWNTqOhJugyxaFHz0Gx1RZI9P0qJAJ/ace4QNcU6pT6lcM8Tovu1DbanJQFJAUkT
	 vvCtH0I5lGoRNs0qdZLdYpiVMDSccokdk8MT7P4nl4iwqV+rmA9wfBWMv9YY6Lg0do
	 fQAE54i2KGmXlRs9oQtu4xZfLuZtYvDfUk5ZuXERI2qlirYfbswxQHNfF21J9Elga6
	 83u3ZIOQN8Cqg==
Message-ID: <5e5be9a3-9220-4da1-b672-4285acf013b8@kernel.org>
Date: Thu, 7 May 2026 14:34:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ASoC: amd: acp7x: add helper functions and hw ops
Content-Language: en-US
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260507181251.20594-1-Vijendar.Mukunda@amd.com>
 <20260507181251.20594-4-Vijendar.Mukunda@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260507181251.20594-4-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: superm1@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: DF3CTKUVH23N4FAM6DFQ6ZQJ4LEL3H6O
X-Message-ID-Hash: DF3CTKUVH23N4FAM6DFQ6ZQJ4LEL3H6O
X-Mailman-Approved-At: Mon, 11 May 2026 14:44:47 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DF3CTKUVH23N4FAM6DFQ6ZQJ4LEL3H6O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 5/7/26 13:11, Vijendar Mukunda wrote:
> Add ACP7.x init/deinit helper routines and wire up PCI hw ops for
> ACP7.D/7.E/7.F variants.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   sound/soc/amd/acp7x/acp7x-common.c | 82 ++++++++++++++++++++++++++++++
>   sound/soc/amd/acp7x/acp7x.h        | 78 +++++++++++++++++++++++++++-
>   sound/soc/amd/acp7x/pci-acp7x.c    | 39 +++++++++++++-
>   3 files changed, 197 insertions(+), 2 deletions(-)
>   create mode 100644 sound/soc/amd/acp7x/acp7x-common.c
> 
> diff --git a/sound/soc/amd/acp7x/acp7x-common.c b/sound/soc/amd/acp7x/acp7x-common.c
> new file mode 100644
> index 000000000000..68f9b47766c4
> --- /dev/null
> +++ b/sound/soc/amd/acp7x/acp7x-common.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AMD ACP PCI driver callback routines for ACP7.x
> + * platforms.
> + *
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/types.h>
> +
> +#include "acp7x.h"
> +
> +static int acp7x_power_on(void __iomem *acp_base)
> +{
> +	u32 val = 0;
> +
> +	val = readl(acp_base + ACP_PGFSM_STATUS);
> +	if (!(val & ACP7X_PGFSM_STATUS_MASK))
> +		return 0;
> +
> +	writel(ACP7X_PGFSM_CNTL_POWER_ON_MASK, acp_base + ACP_PGFSM_CONTROL);
> +	val = readl(acp_base + ACP_PGFSM_CONTROL);
> +	return readl_poll_timeout(acp_base + ACP_PGFSM_STATUS, val,
> +				  ((val & ACP7X_PGFSM_STATUS_MASK) == 0), DELAY_US, ACP7X_TIMEOUT);
> +}
> +
> +static int acp7x_reset(void __iomem *acp_base)
> +{
> +	u32 val;
> +	int ret;
> +
> +	writel(1, acp_base + ACP_SOFT_RESET);
> +	ret = readl_poll_timeout(acp_base + ACP_SOFT_RESET, val,
> +				 val & ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK,
> +				 DELAY_US, ACP7X_TIMEOUT);
> +	if (ret)
> +		return ret;
> +
> +	writel(0, acp_base + ACP_SOFT_RESET);
> +	return readl_poll_timeout(acp_base + ACP_SOFT_RESET, val, !val, DELAY_US, ACP7X_TIMEOUT);
> +}
> +
> +static int acp7x_init(void __iomem *acp_base, struct device *dev)
> +{
> +	int ret;
> +
> +	ret = acp7x_power_on(acp_base);
> +	if (ret) {
> +		dev_err(dev, "ACP power on failed\n");
> +		return ret;
> +	}
> +	writel(0x01, acp_base + ACP_CONTROL);
> +	ret = acp7x_reset(acp_base);
> +	if (ret) {
> +		dev_err(dev, "ACP reset failed\n");
> +		return ret;
> +	}
> +	writel(0, acp_base + ACP_ZSC_DSP_CTRL);
> +	return 0;
> +}
> +
> +static int acp7x_deinit(void __iomem *acp_base, struct device *dev)
> +{
> +	int ret;
> +
> +	ret = acp7x_reset(acp_base);
> +	if (ret) {
> +		dev_err(dev, "ACP reset failed\n");
> +		return ret;
> +	}
> +	writel(0x01, acp_base + ACP_ZSC_DSP_CTRL);
> +	return 0;
> +}
> +
> +void acp7x_hw_init_ops(struct acp_hw_ops *hw_ops)
> +{
> +	hw_ops->acp_init = acp7x_init;
> +	hw_ops->acp_deinit = acp7x_deinit;
> +}
> diff --git a/sound/soc/amd/acp7x/acp7x.h b/sound/soc/amd/acp7x/acp7x.h
> index b4586a2afae4..d3a57705385a 100644
> --- a/sound/soc/amd/acp7x/acp7x.h
> +++ b/sound/soc/amd/acp7x/acp7x.h
> @@ -8,6 +8,8 @@
>   #ifndef __SOUND_SOC_AMD_ACP7X_H
>   #define __SOUND_SOC_AMD_ACP7X_H
>   
> +#include <linux/device.h>
> +#include <linux/errno.h>
>   #include <linux/io.h>
>   #include <linux/pci.h>
>   #include <linux/types.h>
> @@ -22,10 +24,84 @@
>   #define ACP7E_PCI_REV		0x7E
>   #define ACP7F_PCI_REV		0x7F
>   
> -int snd_amd_acp_find_config(struct pci_dev *pci);
> +/* Common register helper bits used by acp7x-common.c */
> +#define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
> +
> +#define DELAY_US				5
> +#define ACP7X_TIMEOUT				5000
> +
> +#define ACP7X_PGFSM_CNTL_POWER_ON_MASK		7
> +#define ACP7X_PGFSM_STATUS_MASK			0x3F
> +
> +struct acp_hw_ops {
> +	int (*acp_init)(void __iomem *acp_base, struct device *dev);
> +	int (*acp_deinit)(void __iomem *acp_base, struct device *dev);
> +	int (*acp_suspend)(struct device *dev);
> +	int (*acp_resume)(struct device *dev);
> +	int (*acp_suspend_runtime)(struct device *dev);
> +	int (*acp_resume_runtime)(struct device *dev);
> +};
>   
>   struct acp7x_dev_data {
>   	void __iomem *acp7x_base;
> +	struct acp_hw_ops *hw_ops;
> +	u32 addr;
> +	u32 reg_range;
> +	u32 acp_rev;
>   };
>   
> +void acp7x_hw_init_ops(struct acp_hw_ops *hw_ops);
> +
> +static inline int acp_hw_init(struct acp7x_dev_data *adata, struct device *dev)
> +{
> +	if (adata && adata->hw_ops && adata->hw_ops->acp_init)
> +		return adata->hw_ops->acp_init(adata->acp7x_base, dev);
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int acp_hw_deinit(struct acp7x_dev_data *adata, struct device *dev)
> +{
> +	if (adata && adata->hw_ops && adata->hw_ops->acp_deinit)
> +		return adata->hw_ops->acp_deinit(adata->acp7x_base, dev);
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int acp_hw_suspend(struct device *dev)
> +{
> +	struct acp7x_dev_data *adata = dev_get_drvdata(dev);
> +
> +	if (adata && adata->hw_ops && adata->hw_ops->acp_suspend)
> +		return adata->hw_ops->acp_suspend(dev);
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int acp_hw_resume(struct device *dev)
> +{
> +	struct acp7x_dev_data *adata = dev_get_drvdata(dev);
> +
> +	if (adata && adata->hw_ops && adata->hw_ops->acp_resume)
> +		return adata->hw_ops->acp_resume(dev);
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int acp_hw_suspend_runtime(struct device *dev)
> +{
> +	struct acp7x_dev_data *adata = dev_get_drvdata(dev);
> +
> +	if (adata && adata->hw_ops && adata->hw_ops->acp_suspend_runtime)
> +		return adata->hw_ops->acp_suspend_runtime(dev);
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int acp_hw_runtime_resume(struct device *dev)
> +{
> +	struct acp7x_dev_data *adata = dev_get_drvdata(dev);
> +
> +	if (adata && adata->hw_ops && adata->hw_ops->acp_resume_runtime)
> +		return adata->hw_ops->acp_resume_runtime(dev);
> +	return -EOPNOTSUPP;
> +}
> +
> +int snd_amd_acp_find_config(struct pci_dev *pci);
> +
>   #endif /* __SOUND_SOC_AMD_ACP7X_H */
> diff --git a/sound/soc/amd/acp7x/pci-acp7x.c b/sound/soc/amd/acp7x/pci-acp7x.c
> index 476b3ae52634..237eb06e3cad 100644
> --- a/sound/soc/amd/acp7x/pci-acp7x.c
> +++ b/sound/soc/amd/acp7x/pci-acp7x.c
> @@ -16,6 +16,26 @@
>   
>   #include "acp7x.h"
>   
> +static int acp_hw_init_ops(struct acp7x_dev_data *adata, struct pci_dev *pci)
> +{
> +	adata->hw_ops = devm_kzalloc(&pci->dev, sizeof(struct acp_hw_ops),
> +				     GFP_KERNEL);
> +	if (!adata->hw_ops)
> +		return -ENOMEM;
> +
> +	switch (adata->acp_rev) {
> +	case ACP7D_PCI_REV:
> +	case ACP7E_PCI_REV:
> +	case ACP7F_PCI_REV:
> +		acp7x_hw_init_ops(adata->hw_ops);
> +		break;
> +	default:
> +		dev_err(&pci->dev, "ACP device not found\n");
> +		return -ENODEV;
> +	}
> +	return 0;
> +}
> +
>   static int snd_acp7x_probe(struct pci_dev *pci,
>   			   const struct pci_device_id *pci_id)
>   {
> @@ -27,7 +47,6 @@ static int snd_acp7x_probe(struct pci_dev *pci,
>   	flag = snd_amd_acp_find_config(pci);
>   	if (flag)
>   		return -ENODEV;
> -
>   	/* ACP PCI revision id check for ACP7.x platforms */
>   	switch (pci->revision) {
>   	case ACP7D_PCI_REV:
> @@ -60,8 +79,19 @@ static int snd_acp7x_probe(struct pci_dev *pci,
>   		ret = -ENOMEM;
>   		goto release_regions;
>   	}
> +	adata->addr = addr;
> +	adata->reg_range = ACP7X_REG_END - ACP7X_REG_START;
> +	adata->acp_rev = pci->revision;
>   	pci_set_master(pci);
>   	pci_set_drvdata(pci, adata);
> +	ret = acp_hw_init_ops(adata, pci);
> +	if (ret) {
> +		dev_err(&pci->dev, "ACP hw ops init failed\n");
> +		goto release_regions;
> +	}
> +	ret = acp_hw_init(adata, &pci->dev);
> +	if (ret)
> +		goto release_regions;
>   	return 0;
>   
>   release_regions:
> @@ -74,6 +104,13 @@ static int snd_acp7x_probe(struct pci_dev *pci,
>   
>   static void snd_acp7x_remove(struct pci_dev *pci)
>   {
> +	struct acp7x_dev_data *adata;
> +	int ret;
> +
> +	adata = pci_get_drvdata(pci);
> +	ret = acp_hw_deinit(adata, &pci->dev);
> +	if (ret)
> +		dev_err(&pci->dev, "ACP de-init failed\n");
>   	pci_release_regions(pci);
>   	pci_disable_device(pci);
>   }

