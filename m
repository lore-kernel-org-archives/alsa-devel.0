Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E951C433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 09:50:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0EE61157
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 09:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C0EE61157
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F61D1663;
	Mon, 27 Sep 2021 11:49:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F61D1663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632736240;
	bh=K18Fici03VctENcWS20fJ1v/Yw0D3HynPOeTZjAsWGc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qhkgfa3PFDsg4vd3a8gq7Uz0U9gwxCAkOKX9JaTeYyJevBF/k3wabyx1TsWrBoFDP
	 6PYqQ4waoD1fob40DFHCUlmvPZUM0K9JXIL7971RZUWlIw5IuKS/NXtm598ZY3yJI+
	 3Pof4X4i0URW6nO6qRoAAdnx8QJuWtLTUN28f16s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30CDCF801F7;
	Mon, 27 Sep 2021 11:49:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B6B88F80227; Mon, 27 Sep 2021 11:49:48 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67942F801EC
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 11:49:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67942F801EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="od+VUAW3"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18R5w8Tw023123; 
 Mon, 27 Sep 2021 04:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=pOBThfl8krBPbYHuGaRhDAIksQ2f9g1tQS1+l5OEcLE=;
 b=od+VUAW36mZpuzes8lKpkLbaBRWtmuXLghCyd1h67OAu1U/KNk4rWbNATfT23HIm/16Z
 V0rgfztish+TuzaXzb4QvCucUGeJ/zqUD0dbKZAnVandFMvBpArDVA0xph0s1oE1dqI4
 oyZJCPswAyRRZVoagsFXq/XdJh0AsDynlYMlaIRAY9Glz4HBcFVho7Ukbtw6ypDpi3pH
 Jt7Ti648LSY3Ryx7EC9kkM+Pr1gWKP9vE9MzcEtA7PcUScsiSKFYm8aS/MoOIM00LQt1
 fUOsfXRxEJ53R5RsQprg4leh2EC/gsTITu2V2qJCr9w42BDdLv4w3baWcAtLTouRTdf/ Hg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 3batd20q8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 27 Sep 2021 04:49:37 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 27 Sep
 2021 10:49:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Mon, 27 Sep 2021 10:49:35 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 43E09B12;
 Mon, 27 Sep 2021 09:49:35 +0000 (UTC)
Date: Mon, 27 Sep 2021 09:49:35 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] ASoC: dt-bindings: wlf, wm8978: Fix I2C address in example
Message-ID: <20210927094935.GD9223@ediswmail.ad.cirrus.com>
References: <0409470fbe6bba69ec74a3f30681b5fe93a372ba.1632470464.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0409470fbe6bba69ec74a3f30681b5fe93a372ba.1632470464.git.geert+renesas@glider.be>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: jXzsdFyUasTvIfrQPkBP6TMfP485Th33
X-Proofpoint-GUID: jXzsdFyUasTvIfrQPkBP6TMfP485Th33
X-Proofpoint-Spam-Reason: safe
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime@cerno.tech>
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

On Fri, Sep 24, 2021 at 10:02:50AM +0200, Geert Uytterhoeven wrote:
> According to the WM8978 datasheet, the address of the device is fixed as
> 0011010 in 2-wire mode.
> 
> Fixes: 5bd5699c494f42a3 ("ASoC: dt-bindings: Add WM8978 Binding")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
