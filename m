Return-Path: <SRS0=HqWb=NX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DC5C432BE
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 10:12:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667E56101A
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 10:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 667E56101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95B071689;
	Wed,  1 Sep 2021 12:11:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95B071689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630491137;
	bh=bSYgtGDOQaLbwh0b0Q+d3v9ati0mwwuCE5zQR4o1zCM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JIk3/vFFpODStBrRMjHmvcnNzXgk2mjwbGYMoRd2/IjfrauRcrfvJRExuqmXeXkKG
	 EADKk5AHohXow/YgPBLXlKASpEdfvpkpBXULM3y4aS8/PsvhBiL4MTTZfII/76Ih8Q
	 ORHoHlM6sZ4sV2sap/aB6yR7GcL5wf/G3x8+YFAo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37B00F80227;
	Wed,  1 Sep 2021 12:11:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1787FF80254; Wed,  1 Sep 2021 12:11:25 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95977F80171
 for <alsa-devel@alsa-project.org>; Wed,  1 Sep 2021 12:11:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95977F80171
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="loh9ZljT"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1816KQCe025016; 
 Wed, 1 Sep 2021 05:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=1+Whm96Iiw8KuVT7H7CUIcuudZGCHLXA7USDAOOxlFI=;
 b=loh9ZljTOc5bnRh8E4E9o9GaFJAjlHCFso8wlbhbGm5yQZlP5etn2TPaAcGAjx6M71qh
 JJ1LQM6yRlqlBrh7EnmJHo5ajuczARcY+YHcUFRAg9nBByoHAbmoX9Yx05OtvR+mjmy2
 QNn1xLYscgq9cX7mzueMdgqnQUb3AOJ1IGF0v3qg0QmlGhq/n5CoT9LPu8q2NR7v21nW
 ZJeDS2FysbC/gX7jqg/IXzAbaWZNh8tkjysQp+IUUuI4i8bekZS/6jd+UTIs+P1Qw5UD
 dcHMfYRAqm2tQrnR/1Im+WHozonaQCrvY/FO7Dx8pSwdUlpG2p5LjwknCsCeQpEWfH4t jg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 3at0y8rebt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 01 Sep 2021 05:11:15 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 1 Sep
 2021 11:11:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Wed, 1 Sep 2021 11:11:12 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E0555B10;
 Wed,  1 Sep 2021 10:11:12 +0000 (UTC)
Date: Wed, 1 Sep 2021 10:11:12 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v2 01/52] ASoC: dt-bindings: Add WM8978 Binding
Message-ID: <20210901101112.GM9223@ediswmail.ad.cirrus.com>
References: <20210901091852.479202-1-maxime@cerno.tech>
 <20210901091852.479202-2-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210901091852.479202-2-maxime@cerno.tech>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: iZu5PNOFQurste-yltl-SY90sUPXLrZD
X-Proofpoint-GUID: iZu5PNOFQurste-yltl-SY90sUPXLrZD
X-Proofpoint-Spam-Reason: safe
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Rob Herring <robh@kernel.org>, patches@opensource.cirrus.com,
 Mark Brown <broonie@kernel.org>, linux-sunxi@googlegroups.com,
 Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

On Wed, Sep 01, 2021 at 11:18:01AM +0200, Maxime Ripard wrote:
> Even though we had the wm8978 driver for some time and a number of
> boards using it already, we never had a binding for it. Let's add it
> based on what the driver expects and the boards are providing.
> 
> Cc: alsa-devel@alsa-project.org
> Cc: devicetree@vger.kernel.org
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: patches@opensource.cirrus.com
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
