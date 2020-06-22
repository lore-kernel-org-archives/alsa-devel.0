Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F57C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:28:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0652206D7
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OTYSSREr";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="3SDsfbv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0652206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64B2F16BC;
	Mon, 22 Jun 2020 15:27:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64B2F16BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592832513;
	bh=uvSEl9qT9+rff+OO4Iicai8iw5Nl64Pu7/nzvjE5hA0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OTYSSRErkFJothskH6H2m9ArssOsZmUueWEx5wSlln6YbBI6n2u+PPD4gYKZkMzhQ
	 TLtImrK/gp3SKE3RQqZJb+OHHwp1IpP19ghjYhI0D73+JXyCmHXlSKruQNzwqxE3MT
	 Xf7/uIipDDKnBw9bwzX7u34gfb1Mlpr+DEd5GAL0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6928F80157;
	Mon, 22 Jun 2020 15:27:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74571F8015B; Mon, 22 Jun 2020 15:27:41 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26190F80157
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 15:27:31 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 8CD4AA0040;
 Mon, 22 Jun 2020 15:27:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 8CD4AA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1592832450; bh=24rJYlFZoSjnsYi8nu5mQYRQ8G2JbGsDMFs86T1jYD8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=3SDsfbv8uCQISha/KTayEPr3cWhi8cvnC9fUtGLYJbH+lgzrMOpUMyErJUEtSqpWi
 M0XmXnqxsLgJay3OsY1zQrJr5Y34zET+gn67d2zcOlSLtGtfmweKnzWUx7DlZfWLu+
 aoEPGDrowsQGgnbUfhGcjlrCmaBewZqiQB4wxnEI=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 22 Jun 2020 15:27:25 +0200 (CEST)
Subject: Re: [PATCH] ASoC: amd: add logic to check dmic hardware runtime
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, alsa-devel@alsa-project.org
References: <1592654687-24574-1-git-send-email-Vijendar.Mukunda@amd.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <46604924-3293-062e-db29-2647ecbc0701@perex.cz>
Date: Mon, 22 Jun 2020 15:27:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1592654687-24574-1-git-send-email-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Alexander.Deucher@amd.com, hui.wang@canonical.com,
 Virendra-Pratap.Arya@amd.com
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

Dne 20. 06. 20 v 14:04 Vijendar Mukunda napsal(a):
> Add logic to check DMIC hardware exists or not on
> the platform at runtime.
> 
> Add module param for overriding DMIC hardware check
> at runtime.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>   sound/soc/amd/renoir/rn-pci-acp3x.c | 29 +++++++++++++++++++++++++++++
>   sound/soc/amd/renoir/rn_acp3x.h     |  7 +++++++
>   2 files changed, 36 insertions(+)
> 
> diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c b/sound/soc/amd/renoir/rn-pci-acp3x.c
> index 859ed67..ef6eeba 100644
> --- a/sound/soc/amd/renoir/rn-pci-acp3x.c
> +++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
> @@ -5,6 +5,7 @@
>   //Copyright 2020 Advanced Micro Devices, Inc.
>   
>   #include <linux/pci.h>
> +#include <linux/acpi.h>
>   #include <linux/module.h>
>   #include <linux/io.h>
>   #include <linux/delay.h>
> @@ -18,6 +19,16 @@ static int acp_power_gating;
>   module_param(acp_power_gating, int, 0644);
>   MODULE_PARM_DESC(acp_power_gating, "Enable acp power gating");
>   
> +/**
> + * dmic_acpi_check = 0 - Skips DMIC device creation and returns probe failure
> + *                 = 1 - Assumes that platform has DMIC support and skips ACPI
> + *                       method check
> + *                 = 2 - Checks ACPI method to know DMIC hardware status runtime
> + */
> +static int dmic_acpi_check = ACP_DMIC_AUTO;

I would prefer to have 0 = auto, 1 = force, 2 = skip to put the 
dmic_acpi_check variable to BSS. Otherwise the patch looks good. Thanks.

					Jaroslav
-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
