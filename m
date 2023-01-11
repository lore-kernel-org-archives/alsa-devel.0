Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A11C46467
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Jan 2023 16:40:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A15FF760E;
	Wed, 11 Jan 2023 17:39:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A15FF760E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673455225;
	bh=/lWO9em8bpuZCH9dItRfGVyYoxvw1jBBMDLOYUCca7U=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=AX7tzrrN3lL5aTj5GdKCrEjjJUbc9DQFaKXp/VeDgCU04OfmlYoFV0SGi1Q/h9phM
	 V+e2MAQlFFgASaxhj1r6i0FlyqUJx+e8cK9gywZWww6xNvm/NGzisJTP2EHpV9WtM/
	 5E0BlJ/s9O7hefFNKFrmr7PDJwVee943F1IX03aQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5481CF805C0;
	Wed, 11 Jan 2023 17:36:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 147A7F805C0; Wed, 11 Jan 2023 17:36:25 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF026F805B1
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2023 17:36:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF026F805B1
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RbriOdB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673454984; x=1704990984;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/lWO9em8bpuZCH9dItRfGVyYoxvw1jBBMDLOYUCca7U=;
 b=RbriOdB3HuqyYZH18jETbsM6wK8gIUWfnB6kg3aq75itRXL+h8cUWwgb
 BF59Nzwe5hug1LGlxL2wnH7xq++SQs7rPlma3ypEPa1OtPtxHo3LKW9sD
 HcGZoVLo0klnZ+8sD4yagctJMC1Iz7GlEhoNLc/SxLfLcl3ZVPPVF1Hr8
 6u205R5CUKiasurMXrr/Kt5AS2ZJjjjZezPxeZe2DtQsEdJYsmek8y5xi
 SVcSU8Q9LE1WMTXwyX8ho4wzwB4OLWUhx2BwNHUouHEFn1iJZlkIgonc7
 upVUVwxCM5mluMytrZWMwLCSeJCjVaI1l9YdcYGJecDr2kKA+m9RLS9Ev g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324704312"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; d="scan'208";a="324704312"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2023 08:32:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607408856"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; d="scan'208";a="607408856"
Received: from flobatol-mobl1.amr.corp.intel.com (HELO [10.212.110.208])
 ([10.212.110.208])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2023 08:32:49 -0800
Message-ID: <c7f018e3-c8be-6819-0ece-244bfb943c62@linux.intel.com>
Date: Wed, 11 Jan 2023 10:02:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 19/19] ASoC: amd: ps: increase runtime suspend delay
Content-Language: en-US
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
 vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-20-Vijendar.Mukunda@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230111090222.2016499-20-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Mastan.Katragadda@amd.com, Sunil-kumar.Dommati@amd.com,
 Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>,
 Mario.Limonciello@amd.com, arungopal.kondaveeti@amd.com,
 Syed Saba Kareem <Syed.SabaKareem@amd.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 1/11/23 03:02, Vijendar Mukunda wrote:
> To avoid ACP entering into D3 state during slave enumeration and
> initialization on two soundwire controller instances for multiple codecs,
> increase the runtime suspend delay to 3 seconds.

You have a parent PCI device and a set of child devices for each
manager. The parent PCI device cannot suspend before all its children
are also suspended, so shouldn't the delay be modified at the manager level?

Not getting what this delay is and how this would deal with a lengthy
enumeration/initialization process.

> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/ps/acp63.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
> index 833d0b5aa73d..6c8849f2bcec 100644
> --- a/sound/soc/amd/ps/acp63.h
> +++ b/sound/soc/amd/ps/acp63.h
> @@ -51,7 +51,7 @@
>  #define MIN_BUFFER MAX_BUFFER
>  
>  /* time in ms for runtime suspend delay */
> -#define ACP_SUSPEND_DELAY_MS	2000
> +#define ACP_SUSPEND_DELAY_MS	3000
>  
>  #define ACP63_DMIC_ADDR		2
>  #define ACP63_PDM_MODE_DEVS		3
