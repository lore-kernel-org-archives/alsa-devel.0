Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E193C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 15:40:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E8261494
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 15:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E8261494
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F2E21755;
	Tue,  2 Mar 2021 16:39:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F2E21755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614699609;
	bh=QaHA9X5OswDlxaAHGziquicz0JjnI6eBGCu04Ebt0mE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IBcHhLhkDjmWmP+6O5d5OXcF663Px4lhR5AyIBbEB3NxeaoD+8nu3g+CvSX28ruwU
	 cMtDHrclqZ/psefn5FCkT0xinTiiDrB0hBqL7QfNL8Z5Ed+qA7j2Hc4vZhWM9DPn1F
	 njkWYy15MvsMrc5+PIknZspZG8tfZEQ3KBmvAWEg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C230DF8025B;
	Tue,  2 Mar 2021 16:38:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5CBF8F802E7; Tue,  2 Mar 2021 16:38:27 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A21DCF80271
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 16:38:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A21DCF80271
IronPort-SDR: +gSMlSA7vizKF6KZ5xM5iWL+/h5ekXawuzngfEj+vsg2c+9F9dZUvQFYwX/+wwJ0j6cdHKaTko
 gY1I0xyP93/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="166091285"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="166091285"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 07:38:17 -0800
IronPort-SDR: gRdgfcqWl6QH00IgRBRP4pJt0G+jxV2OASezPNbhybhVycmtkr91WTSY5w5brA8iJFFPxHrpin
 mWWknS9qFbPw==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="406768987"
Received: from bgrewell-mobl3.amr.corp.intel.com (HELO [10.212.242.206])
 ([10.212.242.206])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 07:38:17 -0800
Subject: Re: [PATCH] ALSA: hda: ignore invalid NHLT table
To: Mark Pearson <markpearson@lenovo.com>
References: <markpearson@lenovo.com>
 <20210302141003.7342-1-markpearson@lenovo.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <420b9b48-0a80-634b-9a98-973c6bdb544c@linux.intel.com>
Date: Tue, 2 Mar 2021 08:46:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210302141003.7342-1-markpearson@lenovo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, "Rojewski,
 Cezary" <cezary.rojewski@intel.com>, Mark Brown <broonie@kernel.org>,
 Philipp Leskovitz <philipp.leskovitz@secunet.com>
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

Adding Mark, Takashi, Jaroslav and Cezary in Cc:

On 3/2/21 8:10 AM, Mark Pearson wrote:
> On some Lenovo systems if the microphone is disabled in the BIOS
> only the NHLT table header is created, with no data. This means
> the endpoints field is not correctly set to zero - leading to an
> unintialised variable and hence invalid descriptors are parsed
> leading to page faults.
> 
> The Lenovo firmware team is addressing this, but adding a check
> preventing invalid tables being parsed is worthwhile.
> 
> Tested on a Lenovo T14.
> 
> Tested-by: Philipp Leskovitz <philipp.leskovitz@secunet.com>
> Reported-by: Philipp Leskovitz <philipp.leskovitz@secunet.com>
> Signed-off-by: Mark Pearson <markpearson@lenovo.com>

The change looks good to me

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Out of curiosity, does this impact Kabylake or CometLake+ systems?

Thanks!

> ---
>   sound/hda/intel-nhlt.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/sound/hda/intel-nhlt.c b/sound/hda/intel-nhlt.c
> index 059aaf04f..0889f2cc5 100644
> --- a/sound/hda/intel-nhlt.c
> +++ b/sound/hda/intel-nhlt.c
> @@ -37,6 +37,11 @@ int intel_nhlt_get_dmic_geo(struct device *dev, struct nhlt_acpi_table *nhlt)
>   	if (!nhlt)
>   		return 0;
>   
> +	if (nhlt->header.length <= sizeof(struct acpi_table_header)) {
> +		dev_warn(dev, "Invalid DMIC description table\n");
> +		return 0;
> +	}
> +
>   	epnt = (struct nhlt_endpoint *)nhlt->desc;
>   
>   	for (j = 0; j < nhlt->endpoint_count; j++) {
> 
