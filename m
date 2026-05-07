Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E4ACD37AC
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2026 14:46:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9EC8560213;
	Mon, 11 May 2026 16:46:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9EC8560213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778510815;
	bh=EOCmFKaHNy/rP607ww9+hgeOBNLUNZo5ktNyjeT+UpE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=N9qDhoD9lX6vrcO1hP4afM9mHvl+/UnYlSOjISINYa0J3YaLaUxhDrYSP2Vo1Zo0L
	 REkjKJ1upyYTRJKpLfVl0OC3szvghNs3LtRb7uOfa4JZtUiudzBkfCpl1lZvciQEsL
	 Hck0xvyiOiUC/fL1s1vARgPtMG/USUu0M2i9hFYo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 79D29F805F7; Mon, 11 May 2026 16:44:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D954DF806AD;
	Mon, 11 May 2026 16:44:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A193F80518; Thu,  7 May 2026 21:36:20 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1EE94F800BA
	for <alsa-devel@alsa-project.org>; Thu,  7 May 2026 21:36:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1EE94F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HVHDUU2n
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3541C6024D;
	Thu,  7 May 2026 19:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468D2C2BCB8;
	Thu,  7 May 2026 19:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778182575;
	bh=EOCmFKaHNy/rP607ww9+hgeOBNLUNZo5ktNyjeT+UpE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HVHDUU2nNmHNRIRlrBP98tBb8kMi/p4s/1i271Q8r+Xc9IfAKJBcJwr/P+cCbFg2W
	 /cugPvQh72mO6CuMC/4SC2iyI+i/LKXypwE9DXoG+XX/g3pEDd4At9F53i+kYEJAGq
	 Zj9zHyGvfAmrcwDkl5ct2/QIRsee5WtSULOJsX6F/qV6ZTkkrxXo7GkIaMYhCPIgCU
	 Z9gKBjGUjl/kAaUKWM+oS17WSSY6JqrfxnTO0inlxRkWrBDQciigzBfOaWmHlsxhPk
	 GC+t/8iod+ynau/11HFCQ1WZz2capzjyc/OHiTNTQjSU+IhzHxvB2fyb0vBCUTX46u
	 NXq8QH5JVmTVQ==
Message-ID: <36454da7-840d-41ba-9e9d-84c45ff9af7f@kernel.org>
Date: Thu, 7 May 2026 14:36:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] ASoC: amd: acp7x: add ACP PCI driver probe/remove
 sequence
Content-Language: en-US
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260507181251.20594-1-Vijendar.Mukunda@amd.com>
 <20260507181251.20594-3-Vijendar.Mukunda@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260507181251.20594-3-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: superm1@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: V6CVBF3UIXYJ2DARMHXEUBMNLTG36KR7
X-Message-ID-Hash: V6CVBF3UIXYJ2DARMHXEUBMNLTG36KR7
X-Mailman-Approved-At: Mon, 11 May 2026 14:44:47 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V6CVBF3UIXYJ2DARMHXEUBMNLTG36KR7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 5/7/26 13:11, Vijendar Mukunda wrote:
> Add ACP7.x PCI driver probe and remove sequence for ACP7.D/7.E/7.F
> variants.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   sound/soc/amd/acp7x/acp7x.h     |  31 ++++++++++
>   sound/soc/amd/acp7x/pci-acp7x.c | 100 ++++++++++++++++++++++++++++++++
>   2 files changed, 131 insertions(+)
>   create mode 100644 sound/soc/amd/acp7x/acp7x.h
>   create mode 100644 sound/soc/amd/acp7x/pci-acp7x.c
> 
> diff --git a/sound/soc/amd/acp7x/acp7x.h b/sound/soc/amd/acp7x/acp7x.h
> new file mode 100644
> index 000000000000..b4586a2afae4
> --- /dev/null
> +++ b/sound/soc/amd/acp7x/acp7x.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * AMD Common ACP header file for ACP7.X variants(ACP7.D/7.E/7.F)
> + *
> + * Copyright (C) 2026 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#ifndef __SOUND_SOC_AMD_ACP7X_H
> +#define __SOUND_SOC_AMD_ACP7X_H
> +
> +#include <linux/io.h>
> +#include <linux/pci.h>
> +#include <linux/types.h>
> +
> +#include <sound/acp7x_chip_offset_byte.h>
> +
> +#define ACP_DEVICE_ID		0x15E2
> +#define ACP7X_REG_START		0x1240000
> +#define ACP7X_REG_END		0x125C000
> +
> +#define ACP7D_PCI_REV		0x7D
> +#define ACP7E_PCI_REV		0x7E
> +#define ACP7F_PCI_REV		0x7F
> +
> +int snd_amd_acp_find_config(struct pci_dev *pci);
> +
> +struct acp7x_dev_data {
> +	void __iomem *acp7x_base;
> +};
> +
> +#endif /* __SOUND_SOC_AMD_ACP7X_H */
> diff --git a/sound/soc/amd/acp7x/pci-acp7x.c b/sound/soc/amd/acp7x/pci-acp7x.c
> new file mode 100644
> index 000000000000..476b3ae52634
> --- /dev/null
> +++ b/sound/soc/amd/acp7x/pci-acp7x.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AMD common ACP PCI driver for ACP7.x variants
> + * which includes ACP7.D/7.E/7.F and future variants
> + * with same register layout.
> + *
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include "acp7x.h"
> +
> +static int snd_acp7x_probe(struct pci_dev *pci,
> +			   const struct pci_device_id *pci_id)
> +{
> +	struct acp7x_dev_data *adata;
> +	u32 addr;
> +	u32 flag;
> +	int ret;
> +
> +	flag = snd_amd_acp_find_config(pci);
> +	if (flag)
> +		return -ENODEV;
> +
> +	/* ACP PCI revision id check for ACP7.x platforms */
> +	switch (pci->revision) {
> +	case ACP7D_PCI_REV:
> +	case ACP7E_PCI_REV:
> +	case ACP7F_PCI_REV:
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +	if (pci_enable_device(pci)) {
> +		dev_err(&pci->dev, "pci_enable_device failed\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = pci_request_regions(pci, "AMD ACP7.x audio");
> +	if (ret < 0) {
> +		dev_err(&pci->dev, "pci_request_regions failed\n");
> +		goto disable_pci;
> +	}
> +	adata = devm_kzalloc(&pci->dev, sizeof(struct acp7x_dev_data),
> +			     GFP_KERNEL);
> +	if (!adata) {
> +		ret = -ENOMEM;
> +		goto release_regions;
> +	}
> +	addr = pci_resource_start(pci, 0);
> +	adata->acp7x_base = devm_ioremap(&pci->dev, addr,
> +					 pci_resource_len(pci, 0));
> +	if (!adata->acp7x_base) {
> +		ret = -ENOMEM;
> +		goto release_regions;
> +	}
> +	pci_set_master(pci);
> +	pci_set_drvdata(pci, adata);
> +	return 0;
> +
> +release_regions:
> +	pci_release_regions(pci);
> +disable_pci:
> +	pci_disable_device(pci);
> +
> +	return ret;
> +}
> +
> +static void snd_acp7x_remove(struct pci_dev *pci)
> +{
> +	pci_release_regions(pci);
> +	pci_disable_device(pci);
> +}
> +
> +static const struct pci_device_id snd_acp7x_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_DEVICE_ID),
> +	.class = PCI_CLASS_MULTIMEDIA_OTHER << 8,
> +	.class_mask = 0xffffff },
> +	{ 0, },
> +};
> +MODULE_DEVICE_TABLE(pci, snd_acp7x_ids);
> +
> +static struct pci_driver acp7x_pci_driver  = {
> +	.name = KBUILD_MODNAME,
> +	.id_table = snd_acp7x_ids,
> +	.probe = snd_acp7x_probe,
> +	.remove = snd_acp7x_remove,
> +};
> +
> +module_pci_driver(acp7x_pci_driver);
> +
> +MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
> +MODULE_DESCRIPTION("AMD ACP PCI driver for ACP7.X");
> +MODULE_LICENSE("GPL");

