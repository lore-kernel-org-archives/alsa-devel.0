Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AD3C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Apr 2022 15:03:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DE4D195A;
	Fri,  1 Apr 2022 17:02:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DE4D195A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648825402;
	bh=vK8YtcbM8fx4DPbHV/29zhwoP2I79rX/2+cMYX/qDeU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NkYAOeQJtV53+dDNAJ0zSd9MTuPKg82/4VOdmnRJotwUAlVmnchykFHBRZsWPDRTG
	 Cn3nS76fxfWNS6oynUrxUJy3gUsENXkF5d4cSvaoQxRXeqS3eDTzG3cMqRJa++AVXR
	 EkUKbaZCCe633JUxYLvy6mzvYm5+2mJi0eVzfPcM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5E3FF8020D;
	Fri,  1 Apr 2022 17:02:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09702F80279; Fri,  1 Apr 2022 17:02:29 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 224ACF80100
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2022 17:02:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 224ACF80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="f5Y3eL2w"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 231CJbL4008410;
 Fri, 1 Apr 2022 10:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=PdYyuppgFyyHYAEkB/pCVaPIbFP1vk2s7gMdjvDUBi4=;
 b=f5Y3eL2wKH9irysVBEy3+mjnCENUWDETwnm1up4R1WbiMHyCEfXoCAt7cSQ6173TADjD
 mDGf01jJnd6Bc7PjHkq4b46O/5GXYPBCVO9xjsbdiyHlhV3CosrNcaJOBoe4B8uD8OzX
 GAzncZec1Pv6uIFqjgOGXLGfHDlyjMcIEBsLwdckEoH85qs/1mncCAZErEXlCj9e6sIg
 ZKIaOwYXwgQ8Nzr5Oytg9IsCKI0viJFi7SwBNOYrANUfA2WXkYFuHlmd8MuAl4EuAbbs
 4HJ500afQQmrPUHkWD/9V4VnSRDzSXKuG5i/9p4h+ZuVb7vXFLUS+lMLsLxU9/SzfEt4 3g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f2081jg3u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 01 Apr 2022 10:02:18 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 1 Apr
 2022 16:02:16 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via
 Frontend Transport; Fri, 1 Apr 2022 16:02:16 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B32C211D1;
 Fri,  1 Apr 2022 15:02:16 +0000 (UTC)
Date: Fri, 1 Apr 2022 15:02:16 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Fix 'enum' lists with duplicate entries
Message-ID: <20220401150216.GK38351@ediswmail.ad.cirrus.com>
References: <20220401141247.2993925-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220401141247.2993925-1-robh@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: foSJCjKXTi2Rwva_dqLI1GjRicTPaoII
X-Proofpoint-GUID: foSJCjKXTi2Rwva_dqLI1GjRicTPaoII
X-Proofpoint-Spam-Reason: safe
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-gpio@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>, Sebastian Reichel <sre@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, - <patches@opensource.cirrus.com>,
 linux-media@vger.kernel.org
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

On Fri, Apr 01, 2022 at 09:12:47AM -0500, Rob Herring wrote:
> There's no reason to list the same value twice in an 'enum'. Fix all the
> occurrences in the tree. A meta-schema change will catch future ones.
> 
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> Cc: - <patches@opensource.cirrus.com>
> Cc: linux-media@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
