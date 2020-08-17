Return-Path: <SRS0=tpTD=B3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C5BC433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:26:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCAB22072D
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="M9I5v+tl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kVBF4LkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAB22072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 506C516E0;
	Mon, 17 Aug 2020 11:25:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 506C516E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597656395;
	bh=v5C0i8Aibv8oWHxYZ0zb/51Y6ITNtKmlTWvmXQwNGSA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M9I5v+tltiqE7PPSKIZTiLK5JDa5ZbEcT9zVeva7teU+oEfAmB5C4rxnpVZEykA09
	 vuRoSL9xhLht+E+Iy8V9rE8whMB8Np3Ni1/WM9l/16YIEoXAlpfHCuA7pSSyw6OPCV
	 Gn3PPHE71DKHUfeo4H5Z9yoE//AlEmaINjWK2MkA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB984F80260;
	Mon, 17 Aug 2020 11:22:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0BA76F80260; Mon, 17 Aug 2020 11:22:37 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DEE9DF80216
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 11:22:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DEE9DF80216
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="kVBF4LkT"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07H9Eei0010088; Mon, 17 Aug 2020 04:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=TIgmhQPJma7LMTwk9a2r2DrIV+fSdBsZPGpZsfznD4U=;
 b=kVBF4LkTLx+vxHzdlXI1tA7RDqD1CjQfpE84Hhq/pf2ALXeTa8QDni7zy382rlhUn1ls
 xPiR1Vo8Jpnsa2/INR2kWExSzu5ENhrUH+2xECCel8ELvmTXiKy9ATK+zyMuCt1ZDRHH
 5AXYi2s8hgkVEt7MjOx+sY2DlByUWWI8pctYa0OsCet7v1n2qqdezmKeL0XvgnXCY7bm
 SPVxvzgliAALRuMLzSFUPg4SHjBSKywMfcS6ImkMBMLZo1XKu9F6F9LiwxPmJqu7krsQ
 QmE6oDxyJG/cC/lG0xPaqv+yt0XMttcHMU9OIsQkidCstX7sDrE1DujKkDAcJDtZBILG vw== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 32xd42t8c0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 17 Aug 2020 04:22:23 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 17 Aug
 2020 10:22:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 17 Aug 2020 10:22:21 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AB8B42C3;
 Mon, 17 Aug 2020 09:22:21 +0000 (UTC)
Date: Mon, 17 Aug 2020 09:22:21 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Subject: Re: [PATCH] ASoC: wm8962: Export DAC/ADC monomix switches
Message-ID: <20200817092221.GE10899@ediswmail.ad.cirrus.com>
References: <3662154.EqNIRYjrc8@pliszka>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3662154.EqNIRYjrc8@pliszka>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=756
 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170070
Cc: alsa-devel@alsa-project.org, "kernel@puri.sm" <kernel@puri.sm>,
 patches@opensource.cirrus.com,
 Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 linux-kernel@vger.kernel.org
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

On Sun, Aug 16, 2020 at 03:23:34AM +0200, Sebastian Krzyszkowiak wrote:
> This allows solutions like ALSA UCM to utilize hardware mono downmix
> for cases where mono output to a single speaker is desired only in
> specific situations (like on a mobile phone).
> 
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
