Return-Path: <SRS0=zq5f=2U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D3CC2D0C2
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Dec 2019 10:45:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17C420748
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Dec 2019 10:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="K8r9qa51";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EL9pLURo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17C420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F7A916DE;
	Mon, 30 Dec 2019 11:45:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F7A916DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577702756;
	bh=Ek1RP03IrZ4Y90vsEQ7KmOfG5cTNNk/Qzpbl61LMuFw=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K8r9qa51HLwP2mwYaoJFmMK9ihVX3m5/VXZPqlSh99quwzq2Gkgw/qQIRB6bzF2FX
	 ODu6cJwTcXN+4y8jRoX80VRLITezAz8uX1Wg0BsW5nqz8yqvke0OAcy75Bp2Epa4f2
	 p5pGIEjepvTDfhG0RlUXF/HQG+GW2LkWV2hE4hbM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B87B1F80126;
	Mon, 30 Dec 2019 11:45:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B3FBDF8015D; Mon, 30 Dec 2019 11:45:03 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60589F80126
 for <alsa-devel@alsa-project.org>; Mon, 30 Dec 2019 11:44:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60589F80126
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="EL9pLURo"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBUAiuYh031107; Mon, 30 Dec 2019 04:44:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=VaGdZjmNiXn+e3fOnWQrXgYdyILFsmQJFn+WM/zYtm0=;
 b=EL9pLURoWu6MMb/eWLf4ZX5kFN6ry+j+qQpivxaRJZmWfVwKB7SYbu/+SDoD7CCYrI3u
 qy7MFjCKgsb/wb/oj3XzVlJD4nyyZ1KpT4xTGQrC7GjUFCibux0y0ujB7tfqjdxWH0F5
 8uMCesle9JyUjxEM3T7yv4lfDCU9E8P23VAF3rJGVn2iiKSRxIhNnTv/87+rKnGfeBCh
 EdqamZxeUWsPo0vAew34N4mFrfM3Df/F4KTTNpVlgUxGYqJptoZyQ33JjABFphhAxsSp
 1hPeFr00w3ndZLLc0Eu93X+U+UJDpHE2si4sqmqMEk87j34igfVez4i/J9J2pVC0S06w 0Q== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
 by mx0a-001ae601.pphosted.com with ESMTP id 2x65b7a5sm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 30 Dec 2019 04:44:56 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 30 Dec
 2019 10:44:54 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via
 Frontend Transport; Mon, 30 Dec 2019 10:44:54 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 55B8E2A1;
 Mon, 30 Dec 2019 10:44:53 +0000 (UTC)
Date: Mon, 30 Dec 2019 10:44:53 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <20191230104453.GG10451@ediswmail.ad.cirrus.com>
References: <20191226162907.9490-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191226162907.9490-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912300099
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, tiwai@suse.com, kernel-janitors@vger.kernel.org,
 lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, rf@opensource.cirrus.com,
 broonie@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: cs47l92: Simplify error handling
 code in 'cs47l92_probe()'
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, Dec 26, 2019 at 05:29:07PM +0100, Christophe JAILLET wrote:
> If 'madera_init_bus_error_irq()' fails,
> 'wm_adsp2_remove(&cs47l92->core.adsp[0])' will be called twice.
> Once in the 'if' block, and once in the error handling path.
> This is harmless, but one of this call can be axed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
