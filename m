Return-Path: <SRS0=b8gG=EI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ED3C00A89
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:00:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A642227F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R5reEnda";
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yNUori9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A642227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C987171E;
	Mon,  2 Nov 2020 16:00:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C987171E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604329251;
	bh=8j66TIBWXILvqygSj4CKLOGmUlomy8+qAnAsPEXcM7U=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R5reEndauLAl/xyapp8rVbqWas+/Qx85yCVu3Yy/KDFHssp5f4Fz/lsV8AdW8yPKX
	 u5+SgNtwq+h/ZLUUS7wLbhChJwaFYfoN9JiOTo4S30Wwju4x7z4Q5NNWNZf4S0UPq+
	 vIIHdH7cJFbIW2VGC+ICxXAsCZusYOiXWgtWvI1I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A0B1F80229;
	Mon,  2 Nov 2020 16:00:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBE14F80232; Mon,  2 Nov 2020 15:59:59 +0100 (CET)
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D2BA8F8015A
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2020 15:59:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D2BA8F8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="yNUori9l"
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A2ExWui142564;
 Mon, 2 Nov 2020 14:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=oSzoJ2/JEwfGSceWXmutharoUBDB84vGx8xKZZcetWg=;
 b=yNUori9lpzHuAzWGbny66FXrMMrmYMEDNPCRMaWJrfIDJKoN+Y7lDkSGkst1mbPguS/8
 jb8I7ka45yH6ABhkRyUzJQh6iSHMJsS/C2h/HpktnYGnDt16KiduPnQnzP6GmGhOPfdR
 voPywbwnOryPnRvtC//dkw1Spj41yO8sGRt4mnaCkOROeNfPP29NUYoa9RNBoHnnhgKF
 MihER9+etfUOjNApLJJqSiNjIWD+wwQ/kTHzo8y2cHTdhLp93ON11N5Z69p3wVlH+KNi
 jFPZl7dVPYjndBa8BMzMLrVVwyrAo61Jz8d0A0DG8UIfqS9yG1Sif+a5Y8O4PwBbLxMk sA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 34hhb1vbej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 02 Nov 2020 14:59:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A2EojmN148510;
 Mon, 2 Nov 2020 14:57:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 34jf46mpqr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Nov 2020 14:57:51 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A2Evpng014104;
 Mon, 2 Nov 2020 14:57:51 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 02 Nov 2020 06:57:50 -0800
Date: Mon, 2 Nov 2020 17:57:44 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [bug report] ASoC: fsl_xcvr: Add XCVR ASoC CPU DAI driver
Message-ID: <20201102145526.GY18329@kadam>
References: <20201102135317.GA41527@mwanda>
 <VI1PR0401MB2272D142F42AA5A2BDA10F6092100@VI1PR0401MB2272.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0401MB2272D142F42AA5A2BDA10F6092100@VI1PR0401MB2272.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=855 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=889 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020120
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
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

On Mon, Nov 02, 2020 at 02:02:42PM +0000, Viorel Suman wrote:
> Hi Dan,
> 
> There is no issue, the context is that the clock is enabled when " fsl_xcvr_en_aud_pll"
> function is called - please check the line 356. The clock is disabled at line 356 in order
> to allow the rate change at line 357, and then enabled at line 362. 
> 

Ah...  Right.  I have seen this pattern before and should have looked
for it.  :/  Thanks!

regards,
dan carpenter

