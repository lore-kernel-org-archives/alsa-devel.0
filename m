Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E23C25B6F
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Oct 2023 08:53:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 85CC2828;
	Thu, 26 Oct 2023 10:52:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 85CC2828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698310422;
	bh=UjXiw7LqimSxBuhKlh1uhYKSGp4q86/bShPct7sA+Ig=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ldP3ZscyoMsC9MKIb2V+NEw0PXey/ZnJ9BuMQkRXy/S7+uLxboSusKsHvrlTaZwFt
	 6OrJUq+aSDaklbAVngn3UdUgAKkS+22L+9SgOLOij+DnoYbWzY/23q7JbLnmDB3Y+s
	 AaVQge3gwGqv0Fwak0VSc35hGYnvjiGUMRt/LhkM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C5244F8014B; Thu, 26 Oct 2023 10:52:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 54B6DF8019B;
	Thu, 26 Oct 2023 10:52:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F29D4F8019B; Thu, 26 Oct 2023 10:52:18 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1FAFEF80152
	for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2023 10:52:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FAFEF80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=MKALE7Zr
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39Q8q7rb024330;
	Thu, 26 Oct 2023 03:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=kn7sxBhOsELqzoR
	r18OgyCCml9vh04uG8hrPgCqczQ0=; b=MKALE7ZrCXsPHUH1Fy+AqpwPmFQvXAf
	pkeTlz1XnubxSjk8xfnsMefeqKWtwxb+yIkANrJU+Ys+k7ry+02uzNUjyQ8NSNvr
	z1ZHXmZ4zQqE4DPuyJKEH4gRI9TDiAFavMI04L2lTKVRgG6JFBeuLqCL0cvMi756
	CnZBZqAeil4mucI8mvbFTPEiHsJcqrw06uWaYlvWFK6LSw/UGeOFx2wdLd8MofZ/
	aoWFOPpabSDgKc267QG5WEGFJSkayW/Qk9SUgvhlQfZ6S+hd2RY8XpNDjv6JpTXh
	BYh95dZC5z8FoK1sM5McR3xRgdFDW/chwVtqjYwee86QeU9NlpQuolw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3tvb2j6dr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Oct 2023 03:52:07 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 26 Oct
 2023 09:52:05 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Thu, 26 Oct 2023 09:52:05 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com
 [198.61.86.93])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 334922A1;
	Thu, 26 Oct 2023 08:52:05 +0000 (UTC)
Date: Thu, 26 Oct 2023 08:52:05 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Lars-Peter
 Clausen" <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami
	<bgoswami@quicinc.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Matthias Brugger
	<matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Sylwester Nawrocki
	<s.nawrocki@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [RFT PATCH 09/17] ASoC: codecs: wm8962: Handle component name
 prefix
Message-ID: <20231026085205.GY103419@ediswmail.ad.cirrus.com>
References: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
 <20231023095428.166563-10-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231023095428.166563-10-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: YA9XHH5fSQzaTnEZvx6NShHuGyet7YQj
X-Proofpoint-ORIG-GUID: YA9XHH5fSQzaTnEZvx6NShHuGyet7YQj
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: BMSIM2ZVTFGEW257QAPEEEO2LRXOJ7Y5
X-Message-ID-Hash: BMSIM2ZVTFGEW257QAPEEEO2LRXOJ7Y5
X-MailFrom: prvs=566375e2f7=ckeepax@opensource.cirrus.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BMSIM2ZVTFGEW257QAPEEEO2LRXOJ7Y5/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Oct 23, 2023 at 11:54:20AM +0200, Krzysztof Kozlowski wrote:
> Use snd_soc_dapm_widget_name_cmp() helper when comparing widget names,
> to include also the component's name prefix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Alas I don't have hardware of these CODECs to test, but looks
fine to me:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
