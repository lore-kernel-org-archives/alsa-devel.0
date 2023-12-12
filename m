Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC43C4167B
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Dec 2023 12:31:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED66CDF1;
	Tue, 12 Dec 2023 13:31:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED66CDF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702384297;
	bh=W8Xrqoc5n3sIOYVcKZQu5NFbl9TtOzyF5UEx7RM6xd8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iQsUNrDzm6euf26j5CfVQM4w9NFXW2HHNsGoshMFB8F7xb7y4awVIbyQrS3BtfvBN
	 5lHyD2/erk36o0RW3CvIJSF6dZDjDCbyi7GAxhoNX0WOsPxrV8lEZSgsNz1eRRLJpd
	 pRGs3LGfg0BbjvGYMRvQ0x8IlvRCfTlcdYpz0WYo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 72AC5F80568; Tue, 12 Dec 2023 13:31:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F1E0DF8057B;
	Tue, 12 Dec 2023 13:31:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 919C7F8016A; Tue, 12 Dec 2023 13:30:58 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CB87AF8001F
	for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2023 13:30:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB87AF8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=pBdu7Tt2
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3BC6V1UD016265;
	Tue, 12 Dec 2023 06:30:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=nPRJvl3VBcj2Fd6
	XFnbw1C0De3KTbG8ckK4ud7nuDjI=; b=pBdu7Tt22fe9Q1fd547SnLJ5yHZ3yrz
	IKclmczkG4tK/GSa48MeAl5b3hrVl5ehUqL6r3Oy4Mltj8AhVSytLMV4sq591IBl
	FFH9wrdm11W0lBWNPaelCO9Ab4/eYl6KPxAWBOmL4dr2AJrmAjvRj5p1OwjO0luS
	VB8tdv4/LeO3NUU+jsclTeJiPFu+gpm0n78ZNBppCdiLhTuRGV8Ww9Cw5brjrGBr
	ah4hTOLT5xgyTPuxEbXq8wqIRXslHOxfqYKCKrm1AvqxqMjACWkPMcwv+dFU7WEa
	JdtSCbB3CDJVPpuTPvqCN3f4PgfL8PFa1zoSLXPnidQsMeo2DGXGDOQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3uwawkac30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 06:30:47 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Dec
 2023 12:30:45 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Tue, 12 Dec 2023 12:30:45 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com
 [198.61.86.93])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9B83815A0;
	Tue, 12 Dec 2023 12:30:45 +0000 (UTC)
Date: Tue, 12 Dec 2023 12:30:45 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <tiwai@suse.de>, <broonie@kernel.org>, <vinod.koul@intel.com>,
        Bard liao
	<yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>,
        Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>,
        Kai Vehmanen
	<kai.vehmanen@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>,
        <vijendar.mukunda@amd.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Shuming Fan
	<shumingf@realtek.com>, Jack Yu <jack.yu@realtek.com>,
        Oder Chiou
	<oder_chiou@realtek.com>
Subject: Re: [RFC PATCH 06/16] soundwire: stream: reuse existing code for BPT
 stream
Message-ID: <20231212123045.GY14858@ediswmail.ad.cirrus.com>
References: <20231207222944.663893-1-pierre-louis.bossart@linux.intel.com>
 <20231207222944.663893-7-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231207222944.663893-7-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: 0M-s16s4bDFnvqAe1U7vkvHAjZq5hvIu
X-Proofpoint-GUID: 0M-s16s4bDFnvqAe1U7vkvHAjZq5hvIu
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: XOOINU2QKLRWGVXMSIHZFPP74ZBMDUML
X-Message-ID-Hash: XOOINU2QKLRWGVXMSIHZFPP74ZBMDUML
X-MailFrom: prvs=7710dd07de=ckeepax@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XOOINU2QKLRWGVXMSIHZFPP74ZBMDUML/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Dec 07, 2023 at 04:29:34PM -0600, Pierre-Louis Bossart wrote:
> DP0 (Data Port 0) is very similar to regular data ports, with minor
> tweaks we can reuse the same code.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
> -	dpn_prop = sdw_get_slave_dpn_prop(s_rt->slave,
> -					  s_rt->direction,
> -					  t_params->port_num);
> -	if (!dpn_prop)
> -		return -EINVAL;
> +	if (t_params->port_num) {
> +		struct sdw_dpn_prop *dpn_prop;
> +
> +		dpn_prop = sdw_get_slave_dpn_prop(s_rt->slave,
> +						  s_rt->direction,
> +						  t_params->port_num);
> +		if (!dpn_prop)
> +			return -EINVAL;
> +
> +		read_only_wordlength = dpn_prop->read_only_wordlength;
> +		port_type = dpn_prop->type;
> +	} else {
> +		read_only_wordlength = false;
> +		port_type = SDW_DPN_FULL;
> +	}

Would it be nicer to just add a special case sdw_get_slave_dpn_prop
to return dp0_prop and avoid all this special casing in the rest
of the code?

Thanks,
Charles
