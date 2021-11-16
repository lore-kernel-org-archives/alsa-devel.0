Return-Path: <SRS0=I3pN=QD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B05C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 18:45:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63AC863227
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 18:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63AC863227
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2CB0B1816;
	Tue, 16 Nov 2021 19:44:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2CB0B1816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637088320;
	bh=6dPUnHtL1TJnn/deUYCkiI/DRo7XgXt5QjI6FbdwmfU=;
	h=From:To:References:In-Reply-To:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DKyUmGHf5WDfrLllM2IH5DJflM5mJ31bDQU78e+YIjVNKlXCjodtF64fW8HZzj2N5
	 Uwu+8H7gzTUQKmoCq6eUwvEAHFtABS+4YAlm32NH7UUKB8YO/vBlgzgLQec4GAmAdJ
	 dMh8tPhdXlougaFSHLjVkmICxHq83opSW3L7ypOg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FE3AF8026D;
	Tue, 16 Nov 2021 19:44:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18BEEF80272; Tue, 16 Nov 2021 19:44:21 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0EBEF80134
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 19:44:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0EBEF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="c3tlMxDN"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AGHB7XE002574;
 Tue, 16 Nov 2021 12:44:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 references : in-reply-to : subject : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=hWu24fXT72BFCIemN1wBMW9x6jBYYlrawthJ6fCWl4w=;
 b=c3tlMxDNjannzT+OjW9UOR2j6iyGrs49OHQOhAwfCAdc367fCeao00UiqtKvSb69C2Zr
 fmlvQC9KCqB1SHnLQ2lkeuLE1YPCIs3rT/a3QxrVoidqSbxaurrP3/FjiiPg/a8Ra9CY
 VS1xKR5rEILasy77aXybMtxoILMMxdPYf5MjccJW+F6wsRkF4UN4OfKMQwWqMOvlttUn
 XreNrJQ3ofkRc4p4jnsDJ9EHtzjd2HJxWZdJ8xAgc604NecsIs8ugFrDFFoUA0ye1NoI
 X+BCwUQ9IQn1RIk0xbdrabbKTKtgCvBf+rvZ7Fbnz0Tna+vamjhWl/bnGy6KD03uLetS sw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ccgtn03w7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 16 Nov 2021 12:44:08 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 18:44:07 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Tue, 16 Nov 2021 18:44:07 +0000
Received: from LONN13613Z2 (unknown [198.90.238.231])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A85C811DC;
 Tue, 16 Nov 2021 18:44:06 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: 'Mark Brown' <broonie@kernel.org>, 'Charles Keepax'
 <ckeepax@opensource.cirrus.com>
References: <20211116161609.12223-1-ckeepax@opensource.cirrus.com>
 <20211116161609.12223-3-ckeepax@opensource.cirrus.com>
 <YZPzgvB2+oXaCupw@sirena.org.uk>
In-Reply-To: <YZPzgvB2+oXaCupw@sirena.org.uk>
Subject: RE: [PATCH 03/10] firmware: cs_dsp: Add version checks on coefficient
 loading
Date: Tue, 16 Nov 2021 18:44:06 +0000
Message-ID: <001901d7db19$efbc2830$cf347890$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHLPByKRi77+1E8qPglckbSLl3OCQOO0onSAePGKSSr9CYI0A==
Content-Language: en-us
X-Proofpoint-GUID: WWb2ZJ8tJ1dxq0AB8zZZ5tNDTuVQS3KI
X-Proofpoint-ORIG-GUID: WWb2ZJ8tJ1dxq0AB8zZZ5tNDTuVQS3KI
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com
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

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, November 16, 2021 6:08 PM
> To: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: lgirdwood@gmail.com; patches@opensource.cirrus.com; alsa-devel@alsa-
> project.org
> Subject: Re: [PATCH 03/10] firmware: cs_dsp: Add version checks on
coefficient
> loading
> 
> On Tue, Nov 16, 2021 at 04:16:02PM +0000, Charles Keepax wrote:
> > The firmware coefficient files contain version information that is
> > currently ignored by the cs_dsp code. This information specifies which
> > version of the firmware the coefficient were generated for. Add a check
> > into the code which prints a warning in the case the coefficient and
> > firmware differ in version, in many cases this will be ok but it is not
> > always, so best to let the user know there is a potential issue.
> >
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> > ---
> 
> This has Simon's signoff after yours but no other indication of his
> involvement?

I have been working with Charles on most of these patches over the last few
months and I'd fixed some internal review comments on this one before we
shared it. If it helps I can certainly ack the chain?

