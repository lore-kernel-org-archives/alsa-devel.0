Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39EFC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 10:31:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F69061027
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 10:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5F69061027
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C9241662;
	Mon, 27 Sep 2021 12:30:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C9241662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632738685;
	bh=TC/UWkHIZmg3a1d7UnMvZIon/9VJpd8xqODBMercj/4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MxQuWHDZftcXr9KeBqlF8ZuOEfLH8UZJgvG1eRsafjYl4uHlFTF2Jn8O8lBCiqvvY
	 EUU9689egY++pyDRl6xuS210tzga4qQeyNvm0QJkiugjmyg2QnHkiww3NBEZaG6gAk
	 fNiZySMEIZzkB8ar+55FWo8E+hOA5UYhQpo/Dgjc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ABCFFF801F7;
	Mon, 27 Sep 2021 12:30:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26AB3F8026D; Mon, 27 Sep 2021 12:30:04 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97F93F802C4
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 12:29:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97F93F802C4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="Nc1ZCD+Q"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18R5VmC8014488; 
 Mon, 27 Sep 2021 05:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=FRJouVbd/qqTQZ9lTF/sMzBW1B4pIoOYcLmRmUZMPBE=;
 b=Nc1ZCD+QGRW5WKlonXa4WG5ZYP6sOeI4N7RkIF5hfMqFMkc2wFr1IriL7shGR6idgILm
 cgp8UkflVVQ6vpMevGDwlqEwYzm3k+kZ28DTY4T8R7zf+xQpszpRLl5+znELIsjre76D
 N8DiY8tT29RmnqrsVcdmVTQmwBVrOmGf9IrSey/UEyJOiFwuA/IR0uAQM38CQHr7dDoG
 0E56FMaRKPWTpoklu+CDu4MCKmEt3AzoTkg1y69MCt/ZJOJijzfs4bC9ofrELZnJ8Srq
 /l9wrRy/4MXnMjXOcChOQs5UTUNZdn7oOnoRAQQ8R56OVOJP+aAanCRUxpZbdWhpN4A0 nw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 3barbh8t6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 27 Sep 2021 05:29:51 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 27 Sep
 2021 11:29:50 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Mon, 27 Sep 2021 11:29:50 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 11B13B10;
 Mon, 27 Sep 2021 10:29:50 +0000 (UTC)
Date: Mon, 27 Sep 2021 10:29:50 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs4341: Add SPI device ID table
Message-ID: <20210927102950.GF9223@ediswmail.ad.cirrus.com>
References: <20210924194844.45974-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210924194844.45974-1-broonie@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 6sbBsaRO8EoHJZSBGJItRc4Rotf4q0Gg
X-Proofpoint-ORIG-GUID: 6sbBsaRO8EoHJZSBGJItRc4Rotf4q0Gg
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>
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

On Fri, Sep 24, 2021 at 08:48:44PM +0100, Mark Brown wrote:
> Currently autoloading for SPI devices does not use the DT ID table, it uses
> SPI modalises. Supporting OF modalises is going to be difficult if not
> impractical, an attempt was made but has been reverted, so ensure that
> module autoloading works for this driver by adding SPI IDs for parts that
> only have a compatible listed.
> 
> Fixes: 96c8395e2166 ("spi: Revert modalias changes")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: patches@opensource.cirrus.com
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
