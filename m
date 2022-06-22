Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B597C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jun 2022 08:42:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DF6A245A;
	Wed, 22 Jun 2022 10:41:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DF6A245A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655887323;
	bh=lfCre8ivv7Zd1IkJm7XBr2ruY993pMUvBr7MGHnoa5E=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EVRQH7EjktbqBf0ssaLjvXZeUMiH541ZPua4o5Ht3+qkfdyk3QgAzJB1YnH/ZgWyQ
	 hkT6lay2B6iaX4FIxLd+p8qelYkWAzAz5IdLK1cdJSgaN6Fu9Mfi1lpQWvaFc/nQDz
	 eH6X5Pe7DjrBx7o1jNdCLcIBwZzLHdyWG7l78Knc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98272F800CB;
	Wed, 22 Jun 2022 10:40:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83260F80482; Wed, 22 Jun 2022 10:40:44 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 112E6F8019B
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2022 10:40:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 112E6F8019B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="LZD/AJo+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655887239; x=1687423239;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=lfCre8ivv7Zd1IkJm7XBr2ruY993pMUvBr7MGHnoa5E=;
 b=LZD/AJo+JVQIuy8qBXr4+9K1V0VeIlJjqFbGwijgPRBIj+X6zhvmyR/N
 G7ybKa+i9+FZP9H1eRSQcitdGWzm/sc80SQyLquR8M8dnZeVg6PpWqqdA
 OaIyHGgMWTSaDy5ZfoVy5ecC39zkr1zXZ6h0y2GtOSNxXdmYMKZWlL5hJ
 BEBtQDx5hlTnLPFp/5ekhEAxj5af7/sInAy1twU6TM5Zssg3J/+a5o9AO
 04phXhxpk61XSkcifBE9L5eoZEvmrIDW7vwtqp7KkYqSS0NxiPXuYvzn2
 1S52sWcMeBnp5L2KjmuNkqcjAJe3bAZDjGQTgDk4rLZfOwkm2FtVNBRO9 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="260787577"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; d="scan'208";a="260787577"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 01:40:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; d="scan'208";a="644080043"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.103])
 ([10.99.249.103])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 01:40:31 -0700
Message-ID: <c0bd4b10-f846-6a6e-06a4-57284f536a98@linux.intel.com>
Date: Wed, 22 Jun 2022 10:40:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 05/14] ALSA: hda: cs35l41: Save Subsystem ID inside
 CS35L41 Driver
Content-Language: en-US
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>
References: <20220622074653.179078-1-vitalyr@opensource.cirrus.com>
 <20220622074653.179078-6-vitalyr@opensource.cirrus.com>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220622074653.179078-6-vitalyr@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Stefan Binding <sbinding@opensource.cirrus.com>
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

On 6/22/2022 9:46 AM, Vitaly Rodionov wrote:
> From: Stefan Binding <sbinding@opensource.cirrus.com>
> 
> The Subsystem ID is read from the HDA driver, and will
> be used by the CS35L41 driver to be able to uniquely
> identify the laptop, which is required to be able to
> define firmware to be used by specific models.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
> ---
>   sound/pci/hda/cs35l41_hda.c   | 3 +++
>   sound/pci/hda/cs35l41_hda.h   | 1 +
>   sound/pci/hda/hda_component.h | 1 +
>   sound/pci/hda/patch_realtek.c | 1 +
>   4 files changed, 6 insertions(+)
> 
> diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
> index 92c6d8b7052e..7f0132694774 100644
> --- a/sound/pci/hda/cs35l41_hda.c
> +++ b/sound/pci/hda/cs35l41_hda.c
> @@ -356,6 +356,9 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
>   		return -EBUSY;
>   
>   	comps->dev = dev;
> +	if (!cs35l41->acpi_subsystem_id)
> +		cs35l41->acpi_subsystem_id = devm_kasprintf(dev, GFP_KERNEL,
> +							    "%.8x", comps->subsystem_id);

Wouldn't comps->codec->core.subsystem_id instead of comps->subsystem_id 
work here? You already added saving of codec in patch 3, and then you 
don't need rest of this patch?
