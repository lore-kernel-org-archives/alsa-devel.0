Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EF3C35274
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Dec 2023 10:47:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A128E72;
	Mon, 18 Dec 2023 11:47:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A128E72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702896434;
	bh=/e+N/7efDKzNbaoFbBulNt3D6lXhfGB0YrWVJy0wYaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XVx5uea3X8EaKsTmlOWjjQfSGd1egUaC6pvq0gvuZuzaytu/b1npLuHyvA0UvX1LX
	 Td55VNMKT1cgETDlUmv+IM8ZtW32cOhG41ltWfsCa8Lv7ZoYHCdZi8ldR2GXsctrIG
	 PBMU9W4AiQZVO+3CnyVkQ9w5sk5y9Ji8lcXOORUo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 92F8AF8056F; Mon, 18 Dec 2023 11:46:41 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6885CF805A0;
	Mon, 18 Dec 2023 11:46:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C52CF80431; Mon, 18 Dec 2023 11:46:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A379CF800D2
	for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2023 11:46:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A379CF800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=k/1wDnvd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702896392; x=1734432392;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/e+N/7efDKzNbaoFbBulNt3D6lXhfGB0YrWVJy0wYaw=;
  b=k/1wDnvdZLnC/4SQShskuhZfkq4w71IN8nzIX/Z+aui5iLZYFWFMI17j
   azSbsxvwZjmCwWlW5bziU3RYe7TFUCyWe81NPwmvgvIUjyoAl68seuugd
   HGJEgq+ZUilW6phKgd08aIhLBtiCFKG8LUvacb3mMHAR5mlFVUVal0KSE
   mZYd8y2+NsQKD3ES89b/ASjPtRsm/x9YyA/x3K398GLiulasMBB2LlJdS
   AMNMXnwGBAkgH4VTVNpVnljKjO3Jua4e7M1Ez5mvKgcjIK8QxlrYLqIOy
   5rxT8dok4ShRz8IQsT6z+3G/EWqB/lJY6h33kFTcKsFQ74KIBb5TgybAg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="8851339"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600";
   d="scan'208";a="8851339"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2023 02:46:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="779048112"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600";
   d="scan'208";a="779048112"
Received: from mmaiores-mobl1.ger.corp.intel.com (HELO [10.249.34.197])
 ([10.249.34.197])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2023 02:46:23 -0800
Message-ID: <b57c7a24-d7fd-4a89-8293-8ab761be013d@linux.intel.com>
Date: Mon, 18 Dec 2023 10:40:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: Intel: bytcr_rt5640: Add quirk for the Medion
 Lifetab S10346
Content-Language: en-US
To: Hans de Goede <hdegoede@redhat.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
References: <20231217213221.49424-1-hdegoede@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231217213221.49424-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: JN7YXB3V7U4SXYZTWPRJQFPMZRNWJ7ES
X-Message-ID-Hash: JN7YXB3V7U4SXYZTWPRJQFPMZRNWJ7ES
X-MailFrom: pierre-louis.bossart@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JN7YXB3V7U4SXYZTWPRJQFPMZRNWJ7ES/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 12/17/23 15:32, Hans de Goede wrote:
> Add a quirk for the Medion Lifetab S10346, this BYTCR tablet has no CHAN
> package in its ACPI tables and uses SSP0-AIF1 rather then SSP0-AIF2 which
> is the default for BYTCR devices.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++++

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

