Return-Path: <SRS0=puNT=PR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E2CC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 11:56:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C10D610EA
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 11:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C10D610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3FB516CB;
	Fri, 29 Oct 2021 13:55:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3FB516CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635508558;
	bh=tNYWsba+D0W/csXywpKQFDLzllRPQcdyIe3tH7mDTCg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AXBAQUOh8FDKCFsRwWcW0Bd9dN9iOZBTzqFOrq1efY6YJr3kowJH4MQvXJTH1Uya6
	 hkUVklYlFDJ2fTOFCauNs6iTdh5GX/W1sfeWXX2lrRkGI3W4BuGvM91fsuJ+yYbeB8
	 osjkLbHeUCy89nTB698266AOwDtUA175mBuG/APw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A634F801EC;
	Fri, 29 Oct 2021 13:55:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C05A8F8025A; Fri, 29 Oct 2021 13:55:05 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1351F800D1
 for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2021 13:54:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1351F800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="p8RLolHR"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19T9dXwP027028; 
 Fri, 29 Oct 2021 06:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=kEDTtI4Kmg97IJO2WoQYdCw1XIYOjOxgPMAGQLirbPc=;
 b=p8RLolHRjCEpyfhksh07E2LR3dbEr4IZn13OqlX5t247kcqz/I3m2b47Y6cM6MKNlBQf
 V0H57S1tYPiYUeUiZ0DzHxyt9uxlatqUUxJdZip3FqNyskcZ8VuHEb4OONK539Pj6iL/
 8ph8K8K2+VboJMW0cLD8Ul1RzGaEnxlpmv89shlXizowGwL/sMRuxzaOJQoYErw8b0ZR
 dQVfJf1m7SmRWEqgpEf/Y0MfNfxLZ49R/uS34HbgGImQxtOKhjyhzkwYUJVJWKm/fIhn
 l3zKICucUxtPI/XZ+gGVriqke5Pyne0jwN6KM+HhwZrKlAN+gESh+C7YShHyrkj/+JrJ Pw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 3c0egyr48q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 29 Oct 2021 06:54:53 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 29 Oct
 2021 12:54:51 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Fri, 29 Oct 2021 12:54:51 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 805B711CB;
 Fri, 29 Oct 2021 11:54:50 +0000 (UTC)
Date: Fri, 29 Oct 2021 11:54:50 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v2] dt-bindings: sound: wlf,wm8903: Convert txt bindings
 to yaml
Message-ID: <20211029115450.GH28292@ediswmail.ad.cirrus.com>
References: <20211028124639.38420-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211028124639.38420-1-david@ixit.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: AFVpuzUCs6QToA3GPdZe_C-FWua-QtNg
X-Proofpoint-ORIG-GUID: AFVpuzUCs6QToA3GPdZe_C-FWua-QtNg
X-Proofpoint-Spam-Reason: safe
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 - <patches@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, ~okias/devicetree@lists.sr.ht
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

On Thu, Oct 28, 2021 at 02:46:38PM +0200, David Heidelberg wrote:
> Convert the Wolfson WM8903 Ultra-Low Power Stereo CODEC Device Tree
> binding documentation to json-schema.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
