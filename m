Return-Path: <SRS0=SID+=55=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E29C2BA19
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2020 10:48:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CEB206E9
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2020 10:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lmlVD4mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CEB206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B89D16F9;
	Mon, 13 Apr 2020 12:47:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B89D16F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586774920;
	bh=o9w576DJMqvEVPGemeGJqvrTsBuNZxdGJEzuxcot9DM=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lmlVD4mjH7M6W356QvgSGPes0W/MrPaO3omwZC9i1uvMKvqL+y8P3MlMG+ctj65YE
	 zK+aMw/Om5P5uR/8U6QhatQDhl1GvTxqY5ofnin7+Qt2ujlz/ssU/8LagppYh+7Khd
	 VNjM7UemZQzmONlWE9gweWhmFk32E5zquZH8USjY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D650CF80266;
	Mon, 13 Apr 2020 12:46:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2BE12F80264; Mon, 13 Apr 2020 12:46:53 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A476F800B9
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2020 12:46:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A476F800B9
IronPort-SDR: xTIET9U+o0m9uS6DOesoTqwcepwKMlaaNL+PO/D7L4uUr1iNq9lACD/mX5ibNkb2gpCy2ozfPW
 67BmxzumEobA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2020 03:46:43 -0700
IronPort-SDR: hS1Dpwyw+cI4F9GNkPj4D9kAz5TVKSvN0C7TOC8V43fLfo/7ak/DCuW2r+CLwASvAKs3aGh3yF
 AGLAILnI3vUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; d="scan'208";a="243507799"
Received: from ftehrig-mobl.amr.corp.intel.com (HELO [10.209.82.92])
 ([10.209.82.92])
 by fmsmga007.fm.intel.com with ESMTP; 13 Apr 2020 03:46:37 -0700
Subject: Re: [PATCH 1/2] ASoC: intel: soc-acpi-intel-icl-match: remove useless
 'rt1308_2_adr'
To: Jason Yan <yanaijie@huawei.com>, cezary.rojewski@intel.com,
 liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
 rander.wang@intel.com, christophe.jaillet@wanadoo.fr,
 alsa-devel@alsa-project.org
References: <20200410081117.21319-1-yanaijie@huawei.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c12c8084-7a30-2271-85e5-db1b3b8e41cc@linux.intel.com>
Date: Fri, 10 Apr 2020 10:17:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200410081117.21319-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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



On 4/10/20 3:11 AM, Jason Yan wrote:
> Fix the following gcc warning:
> 
> sound/soc/intel/common/soc-acpi-intel-icl-match.c:90:45: warning:
> ‘rt1308_2_adr’ defined but not used [-Wunused-const-variable=]
>   static const struct snd_soc_acpi_adr_device rt1308_2_adr[] = {
>                                               ^~~~~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Patch 1 and 2:

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/common/soc-acpi-intel-icl-match.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/sound/soc/intel/common/soc-acpi-intel-icl-match.c b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
> index ef8500349f2f..16ec9f382b0f 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-icl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
> @@ -87,14 +87,6 @@ static const struct snd_soc_acpi_adr_device rt1308_1_adr[] = {
>   	}
>   };
>   
> -static const struct snd_soc_acpi_adr_device rt1308_2_adr[] = {
> -	{
> -		.adr = 0x000210025D130800,
> -		.num_endpoints = 1,
> -		.endpoints = &single_endpoint,
> -	}
> -};
> -
>   static const struct snd_soc_acpi_adr_device rt1308_1_group1_adr[] = {
>   	{
>   		.adr = 0x000110025D130800,
> 
