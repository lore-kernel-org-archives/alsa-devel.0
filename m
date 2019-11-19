Return-Path: <SRS0=I/J9=ZL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D960AC432C3
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:30:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C8A222DD
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iPpX3SKK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jGtW79A1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C8A222DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3FC05168B;
	Tue, 19 Nov 2019 15:29:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3FC05168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574173818;
	bh=rDBLhCYr9hKvDa8Po60EmMElhig9vycbOCCcT2kAzy0=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iPpX3SKKArEeXxqS/gkcM52VnPqb3GJ7on/MgJ4rvgJv4AhQveilufGIoWqf5/je0
	 Ob8s2cRAIfLMckoGZnbuByMD8xqduB5sR04WT8hx6WMp9fYo4bHzskTJeNogO6CfBA
	 zH8Wu1bRCoxK3pyjzViG0+96vPcWmNFWKyGw5/qI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC238F80137;
	Tue, 19 Nov 2019 15:29:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00157F80138; Tue, 19 Nov 2019 15:29:25 +0100 (CET)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72707F800FF
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2019 15:29:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72707F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="jGtW79A1"
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJEJFrj171891;
 Tue, 19 Nov 2019 14:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=YGqCGMrjp855JQhfRhha1mrka4pAadiq0XrsZH5hYAw=;
 b=jGtW79A1pr9OPnc5oA91hidud7AxlatNcxYphekZmeVmfzy+ypV4kHy6qK9RNCH4eBMD
 D2Jlgwa/4Y7oldYkflEq16oQsCJSErifIWvenZQNNFvEEsiV5lgUKVqTKUFm8EjbmYGb
 8Y3S8Kn2gZ5BqyfRJIZyH/AYo0IuWZNS0fvdkbOPuV2Y/Odxy/ISzkEcwSPAp/yeDBNh
 /u15xaW8YEh++soJ/JxI8H9YGhCNOkFvHgjTbeNrv6bIjmUFkmPp52PrLN+Efp7ATdGJ
 j/2dXvCZarL8bAUNh65YpFt+vF5ZussuG3jENLqp8zfTl5p6bIv4qlxU+LX7Usupj/Kz 1A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2wa92pq6kh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2019 14:29:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJES0U2101336;
 Tue, 19 Nov 2019 14:29:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2wbxm4bu1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2019 14:29:20 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAJETDHY032503;
 Tue, 19 Nov 2019 14:29:14 GMT
Received: from kadam (/41.210.141.188) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 19 Nov 2019 06:29:12 -0800
Date: Tue, 19 Nov 2019 17:28:57 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Message-ID: <20191119142856.GE30789@kadam>
References: <1574172508-26546-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1574172508-26546-7-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1574172508-26546-7-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190133
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 djkurtz@google.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Alexander.Deucher@amd.com, Colin Ian King <colin.king@canonical.com>,
 Akshu.Agrawal@amd.com
Subject: Re: [alsa-devel] [PATCH v10 6/6] ASoC: amd: Added ACP3x system
 resume and runtime pm
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

This is improved.  Thanks!

regards,
dan carpenter
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
