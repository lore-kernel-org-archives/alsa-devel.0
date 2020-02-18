Return-Path: <SRS0=1Vby=4G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62504C34026
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:10:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E331A20801
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z+jmKgyx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NsCAGbcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E331A20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 458A11672;
	Tue, 18 Feb 2020 14:09:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 458A11672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582031428;
	bh=e8CVTZoY2/8fGVfb6bMCURMFiV43qvJi7sf/2U6M+KA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z+jmKgyx2PTWVSthgVoADpQESeo2lpTBGRfEk4YwGkV2ihiHhRse3Egxmcs+ih4/u
	 hA1FhJ8BrBitk57WvlVZvYBAFwpKMm7injxoXZyntm/9zGjPAeBlCod+NiRZ3kPI0r
	 zK3HMuD9rAE3fjYzc5n+YTytQgtVkI1AJcZ1xQfM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0463F80145;
	Tue, 18 Feb 2020 14:09:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2B05F80148; Tue, 18 Feb 2020 14:09:36 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC798F80135
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 14:09:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC798F80135
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="NsCAGbcs"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01ID9UNt031732; Tue, 18 Feb 2020 07:09:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=oDcx9+nhLtRKd/7eK4F56Q9mkdC8+Ult+qCe6UIxF9s=;
 b=NsCAGbcsw+md0TtFXe9kWes3YmvZFfcZgPP7KR/NsxiVmjwa2j/TPV96ErN5zgQvmMqB
 jE3ZW+VNL7zyV5M5OHiFfpR1l0rbt6M+tq9a+/vpEnmbJUpzR1Wv0Qe48E3PRS0w/3r4
 ujHXOCh2LYbC7lv9p8KSmzuWe/2ntWpwbfGHOUalU2/yZAFB5MIgUofbAXrzuZ7ILsRs
 bUGJ8HosMA4hmNcwmCwXX9s0J1Cf2zglX87HrBSJ+VVWHRRZvGWItCVUdauEMw5ttQiU
 0RoSLANukDTLibLcV+1+Rw6sFC0GoxbamC0MNspKK4UTiZZXJFVBqESkkv2KD0aS38jD DQ== 
Authentication-Results: ppops.net;
 spf=pass smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
 by mx0a-001ae601.pphosted.com with ESMTP id 2y6ex9c1uc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 18 Feb 2020 07:09:30 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 18 Feb
 2020 13:09:25 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via
 Frontend Transport; Tue, 18 Feb 2020 13:09:25 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 401F72DC;
 Tue, 18 Feb 2020 13:09:25 +0000 (UTC)
Date: Tue, 18 Feb 2020 13:09:25 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: linux-next: Tree for Feb 18 (sound/soc/codecs/wm5110.c)
Message-ID: <20200218130925.GG108283@ediswmail.ad.cirrus.com>
References: <20200218152853.67e2482a@canb.auug.org.au>
 <89ef264f-12c9-ccb0-5cdd-ee5f70a469dd@infradead.org>
 <c2273472-18af-e206-c942-fd460e0d192c@infradead.org>
 <20200218100959.GD108283@ediswmail.ad.cirrus.com>
 <20200218113116.GA4232@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200218113116.GA4232@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180105
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 moderated for non-subscribers <alsa-devel@alsa-project.org>,
 patches@opensource.cirrus.com, Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>, geert@linux-m68k.org
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

On Tue, Feb 18, 2020 at 11:31:16AM +0000, Mark Brown wrote:
> On Tue, Feb 18, 2020 at 10:09:59AM +0000, Charles Keepax wrote:
> > 2) We could update the machine drivers to a depends on and make
> > the CODEC symbols manually selectable. I guess this also has the
> > advantages that it would be necessary for the simple card stuff
> > that seems to be everyones first choice for machine drivers these
> > days.
> 
> That's not good, it means people have to know exactly what CODECs and
> DAIs are on their board to even see the config option.
> 
> > Mark do you have any strong feelings on this I am leaning towards
> > 2?
> 
> Why not just continue adding the relevant dependencies to the machine
> drivers like we've always done?

Hmm... a good point. The machine drivers are already depending
on MFD_ARIZONA, if we swapped that for the actual CODECs
involved I guess that should fix the situation as well.

I will fire out a patch shortly.

Thanks,
Charles
