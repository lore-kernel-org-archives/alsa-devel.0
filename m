Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5832AC27C53
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Jun 2024 10:26:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C77AAE8;
	Wed, 19 Jun 2024 12:26:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C77AAE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718792794;
	bh=oRd71k4awj/6s9BRMEV7w3ZoQI9623aTuz0KN1OcpdA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lrujfiq+h/0CgxfUA6zysTatzn6kgS81mUQLlKOc5LWzT0UufdB0QsWW/vLcz0zVy
	 Sulc/Iv090p+E341zUhz+iQgfLwx2HfFGzGilI4H3xDj5axcUOxoQIdFt+MjAG0ekb
	 Hr6KPs6nrRXhokzx/yF9cJs4JKcYpU5WjbKf1AxY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0345F805A9; Wed, 19 Jun 2024 12:26:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3408DF805B3;
	Wed, 19 Jun 2024 12:26:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EEDB0F8023A; Wed, 19 Jun 2024 12:24:13 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 76236F80154
	for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2024 12:24:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76236F80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=VMNoveSj
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id
 45J6sYgY029887;
	Wed, 19 Jun 2024 05:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=RPk4rBMEEC3dEWsw4E893T9mznv8r6hBMz9IHmL9niE=; b=
	VMNoveSjmRpH0g0U3QBmQU/2CxVO8AUB3GSvSihrz5ou8Mlv7/2xOSSACm9Zc1XL
	fSEgfbWQnTOGa8Jp+kk31uYliOtnpxmvHjgNew0B0GyI/buoDkA2aVhSxkfGoLNe
	04k5ZFqe/6FZsBbOrQxKW+Q9FCVyDVEgUguSnX/UzWK4KtmYnOo3Qq7p+4CZBlLe
	ROzAHis1RxP6sXSZ9LYwUxH5AfBh8AjvORChy7GSvsHYyFsTVMxIJAp6opCNntLB
	t6he/b1BAWqmOinZz1aTdQl5d1e56VpSMV9PuTfw1DoMLnwAPnEmZj3JfZ8yme6a
	dZ0enXU8AHkh6iZF/7No4g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3yuj8m0g1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 05:24:09 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 11:24:07 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 19 Jun 2024 11:24:07 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 01DCD820248;
	Wed, 19 Jun 2024 10:24:07 +0000 (UTC)
Message-ID: <97da8398-599e-45cb-abb2-97cc66567628@opensource.cirrus.com>
Date: Wed, 19 Jun 2024 11:24:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: cs35l56: Accept values greater than 0 as IRQ
 numbers
To: Mark Brown <broonie@kernel.org>
CC: Simon Trimmer <simont@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20240617135338.82006-1-simont@opensource.cirrus.com>
 <fe9dd613-8909-4c7d-a7d7-9094b75fe8fb@opensource.cirrus.com>
 <941d2b8a-18b5-43ad-9aec-6785f841dfaa@sirena.org.uk>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <941d2b8a-18b5-43ad-9aec-6785f841dfaa@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YpzMdpZlHV6yBMraLsbqwHkcovA7cKyq
X-Proofpoint-ORIG-GUID: YpzMdpZlHV6yBMraLsbqwHkcovA7cKyq
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: V4SJQLQFY6ENCJLKRYCDYA7LGWQUS6B6
X-Message-ID-Hash: V4SJQLQFY6ENCJLKRYCDYA7LGWQUS6B6
X-MailFrom: prvs=3900c876c3=rf@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V4SJQLQFY6ENCJLKRYCDYA7LGWQUS6B6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 19/06/2024 11:22, Mark Brown wrote:
> On Wed, Jun 19, 2024 at 10:44:47AM +0100, Richard Fitzgerald wrote:
> 
>> Mark, I don't understand what your objection is.
>> What is it you want us to do to get this bugfix accepted?
> 
> Have patience.
Ah, ok. Sorry, I assumed you were objecting not just overloaded.
