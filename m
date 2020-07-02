Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41543C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:30:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD8820771
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="N3GISKXq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WZQ6L/Qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD8820771
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B49416AB;
	Thu,  2 Jul 2020 11:29:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B49416AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593682234;
	bh=n4dvV1XkBOw1b2ou31MqwcZPGaT8nhOR7VL5KQL0pwk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N3GISKXqJC6NCm9WkiQZgkuLEhD/ft/x6gddiFr5hu/oyY4xHbGWxvuTJrETEK+1M
	 sJQ/8JP9MpziMZVZgZTvJZyajsqN5LUurQW62wJ3YwK5klW0P5aCyJ7TMIjX5xWgHU
	 EsFOx140ZuvR7QN4vsKO8i1S92vxfRRT0wIqi684=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5BBCF8022B;
	Thu,  2 Jul 2020 11:29:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03325F8022D; Thu,  2 Jul 2020 11:29:39 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8C6C6F80134
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 11:29:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C6C6F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="WZQ6L/Qj"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0629GRWs025172; Thu, 2 Jul 2020 04:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=w/ZS+NN9FMNqtzEq9OQKf0Dckp7KEUTUNyMoLvBWt9c=;
 b=WZQ6L/QjPlMClTw0JnquXUosNNOeyziiyBkJf/gVbYIDDOOZUAOC/SJ3ll1GciP3iy6C
 bw0QvzHkfthhYIi0pb68qy3uqUjG+Qkew3rdcF/r9Nsc+WP5DyvkJj4a9TeZcLjLnejd
 OU0C0NSEuQZPPQNYq6kzWk+vhRpq9+usv1+NQOSjdxnUiO34EyiBZCaZR+oNHJN5RSR0
 jlDzLg6Jix5Se/5fzuTcNYB+TQyjkQ42kuFIsQnUrf6FeuKSN1rPFv8HvMaP9pEmG7hf
 SFUNnuRW1JlzxI0dN6GZrWgsjAH5m9qiftjFAWyfSbOv5/2vpplxh5T3eASpNHmZtKtl rQ== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 31x2hpy9ya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 02 Jul 2020 04:29:32 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 2 Jul 2020
 10:29:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 2 Jul 2020 10:29:30 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A13B7448;
 Thu,  2 Jul 2020 09:29:30 +0000 (UTC)
Date: Thu, 2 Jul 2020 09:29:30 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <puyou.lu@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: wm8974: fix Boost Mixer Aux Switch
Message-ID: <20200702092930.GM71940@ediswmail.ad.cirrus.com>
References: <1593657025-4903-1-git-send-email-puyou.lu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1593657025-4903-1-git-send-email-puyou.lu@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=736 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0
 cotscore=-2147483648 suspectscore=1 priorityscore=1501 spamscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007020069
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 broonie@kernel.org, lgirdwood@gmail.com
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

On Thu, Jul 02, 2020 at 10:30:25AM +0800, puyou.lu@gmail.com wrote:
> From: Puyou Lu <puyou.lu@gmail.com>
> 
> Clear BIT6 of INPPGA means not muted (Switch On).
> 
> Signed-off-by: Puyou Lu <puyou.lu@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
