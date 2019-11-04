Return-Path: <SRS0=j9WI=Y4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA14CA9ECF
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:48:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F4621D7D
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="j8R4xJ/6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="F6qs3mx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F4621D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1CA1E1751;
	Mon,  4 Nov 2019 10:47:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1CA1E1751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572860919;
	bh=1vyq5/9JYHmjyJ52Lni06P4maukVdOqSDuvddfSJ+jY=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j8R4xJ/6z7H9o5BhVgq7G39MX8fWb3ntHaiVA8bCGOCIvnuwGZ3qmZcs2Xk4fVtWJ
	 CrFgJ293WkhA+Z/Zp/RTMyKkvBYZ0B3hDMEhjyEulBzm/cRWZoi3zCPlp6qZZy2hAH
	 iXNhDz6uw10pWX00WQ8Y+Ob0mq52MUN9L1bqaLXg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FD87F80321;
	Mon,  4 Nov 2019 10:47:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79A65F8019B; Mon,  4 Nov 2019 10:47:45 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE375F8019B
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2019 10:47:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE375F8019B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="F6qs3mx8"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xA49i1F4016930; Mon, 4 Nov 2019 03:47:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=/R+ic8QxWeMcfXBwI3R7ulg2kJH8Alttq8+dogPdX0g=;
 b=F6qs3mx8ouvjmtF/7aXpiWLiZn3C9b8DYMtgmi38z9usoWri/IJPesipQUvGAppYjRb+
 i7NDPcpkpB766zt2ldwKM5rPngAPoFnRIGZ1Rkwx8lKwulXnn9cNhvAzNXk8sCkBxMWT
 DCqNZTzcisaKAvRX72FoNALTuYxU6sKDPlK6MYTXqRdCJxFj4l4r9iX1gbLiXf4kGiTr
 iOS6nAYqgr2eZ8Hhi6y5aGfISdT+i1PiNzLyPHI50sq8WPrDjJShGjWE0N8e/J4Haz2w
 sxzjMG+VtEPq7fwpmFvk/YXN+nskZUbwgFWg+Lyn+OkCZzFaaF+jpveLRvgEL84DEyXG Ng== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 2w167sj0uv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 04 Nov 2019 03:47:40 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 4 Nov
 2019 09:47:38 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via
 Frontend Transport; Mon, 4 Nov 2019 09:47:38 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1EE1A2A1;
 Mon,  4 Nov 2019 09:47:38 +0000 (UTC)
Date: Mon, 4 Nov 2019 09:47:38 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: David Rhodes <david.rhodes@cirrus.com>
Message-ID: <20191104094738.GG31391@ediswmail.ad.cirrus.com>
References: <1572550603-21560-1-git-send-email-david.rhodes@cirrus.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1572550603-21560-1-git-send-email-david.rhodes@cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 mlxlogscore=888 clxscore=1015 mlxscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1911040098
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 broonie@kernel.org, lgirdwood@gmail.com, Li Xu <li.xu@cirrus.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: wm_adsp: Expose mixer control API
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

On Thu, Oct 31, 2019 at 02:36:43PM -0500, David Rhodes wrote:
> From: Li Xu <li.xu@cirrus.com>
> 
> Expose mixer control API for reading and writing.
> The exposed API can be used by codec driver for
> interacting with mixer control in kernel space.
> This allows codec driver to implement more involved
> interactions with DSP firmware, such as Fast Use
> Case Switching.
> 
> Signed-off-by: Li Xu <li.xu@cirrus.com>
> Signed-off-by: David Rhodes <david.rhodes@cirrus.com>
> ---

Overall I think we have seen enough valid use-cases for this, but
we do need to be a little careful to police its usage.

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
