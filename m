Return-Path: <SRS0=P2CN=XW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23270C4360C
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:28:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27726217D9
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OP+S4t0z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fkktZQXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27726217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB49015E4;
	Fri, 27 Sep 2019 16:27:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB49015E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569594527;
	bh=68SF2C68vyusPmxVFn6A4u3Uz7SUZh858kjKvZUviP8=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OP+S4t0z9x1p58QnfnLVV9ZbJpAdf1GUuRgVxcprRY+Fj7m1UDy3weGPVFp2cUyuK
	 WBO9sfyWdrcOE/+uSKQ2i0K1Yc1u58mruS2SBLLr7iQgx/51o+7LvNz3DcnOaf7gjH
	 H9i08vAhbIz7lyWPKQDF4tcugSrbOa0O34S0oaOE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C4A5F80140;
	Fri, 27 Sep 2019 16:27:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7454CF8049A; Fri, 27 Sep 2019 16:27:55 +0200 (CEST)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C38B3F80140
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2019 16:27:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C38B3F80140
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="fkktZQXA"
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8REOIZF190898;
 Fri, 27 Sep 2019 14:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Rz1WKelrhXx/CX8CfO1Ki+c8gnklPMpb9zMgJPDFb08=;
 b=fkktZQXAnJ5jRf9NfvPe73M8qlAx3rnCqZhbmta/wD/sexw4ILyBAHwrID5c9OMu3POJ
 G2/nsxeGCnBAu2ExYHdtETIwNVnqGFagyeochWDiGTBQcq0xr6ILDHMrCgoIbZ943lI+
 0fw1YGQXNwI/J5UnKbwMZCofKL7OsowuGxep9hSW1YFXKc6lo2S8+PDPej5l9refK4rb
 nJ7hywdJGSl6ErksGW5YpA9C926H5GsrVR7X3fxAd4wQIVf5lIe87iXU2hiK7aTj1ehe
 lpkUFzVNa499m7gO2UvezmYdedHRxDuLYiwQYlcyb9nIl/JErP1xMiksycZlPDeFjMcL Og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2v5btqjm9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2019 14:27:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8RENX6P019009;
 Fri, 27 Sep 2019 14:27:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2v9m3f0adv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2019 14:27:48 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8RERi3U019336;
 Fri, 27 Sep 2019 14:27:45 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 27 Sep 2019 07:27:44 -0700
Date: Fri, 27 Sep 2019 17:27:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Colin Ian King <colin.king@canonical.com>
Message-ID: <20190927142552.GH27389@kadam>
References: <20190927103858.631-1-colin.king@canonical.com>
 <729ae953-b78a-9452-e8b3-3583a21a1295@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <729ae953-b78a-9452-e8b3-3583a21a1295@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9393
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909270134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9393
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909270134
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: amd: acp3x: clean up an indentation
	issue
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

On Fri, Sep 27, 2019 at 11:43:31AM +0100, Colin Ian King wrote:
> On 27/09/2019 11:38, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There is a return statement that is indented too deeply, remove
> > the extraneous tab.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  sound/soc/amd/raven/acp3x-pcm-dma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
> > index bc4dfafdfcd1..ea57088d50ce 100644
> > --- a/sound/soc/amd/raven/acp3x-pcm-dma.c
> > +++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
> > @@ -631,7 +631,7 @@ static int acp3x_audio_probe(struct platform_device *pdev)
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	if (!res) {
> >  		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
> > -			return -ENODEV;
> > +		return -ENODEV;
> >  	}
> >  
> >  	adata = devm_kzalloc(&pdev->dev, sizeof(*adata), GFP_KERNEL);
> > 
> Oops, I've sent this fix before. ignore. apologies.

Haha.  I used to do this all the time.  Now my QC script searches my
outbox.  I still send duplicates sometimes if I'm travelling and forget
to copy my outbox over.

regards,
dan carpenter

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
