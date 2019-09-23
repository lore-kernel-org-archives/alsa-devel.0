Return-Path: <SRS0=ZcFB=XS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92C9C04EBF
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:24:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF0920820
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Zl/oi5rk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E2jh9CrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF0920820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 512861612;
	Mon, 23 Sep 2019 16:23:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 512861612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569248649;
	bh=lB1qjQIBbEuzTTPk0cAGm6qftx0T51gosAavZMGFzBQ=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Zl/oi5rkyapmyGxs6QJTNRsnI9D1IXC6EbGgqURlWhNPDVuMqWgVBZETVOB22cCaP
	 6GPNbyrDHWZPAeLk5l7QxaA82KUtNoJ/8TVTRWp9uMplZq9gfNfOek3wlCyipKBuoc
	 bqXGedqRxK4X7iaB7G+xf6veYYb2zsJFF0QblNBU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BACAFF802BD;
	Mon, 23 Sep 2019 16:23:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 122C9F8044C; Mon, 23 Sep 2019 16:23:17 +0200 (CEST)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD4D5F80307
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2019 16:23:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD4D5F80307
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="E2jh9CrE"
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8NEIjsH060919;
 Mon, 23 Sep 2019 14:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=Y1OboCrFjSM9iPGT/Aql2YTs9KFBvySeFqWFymUnyyo=;
 b=E2jh9CrE+2CTE2r7Sz20vQev+hWSAh2vCRWIya6U/RvgIrH0rLLsKxnZw1Hh2Xi+NlPI
 RWmm1o1TNzOHNQyAb9GtqyXaE9cosUHTnVmEjVVQ1dIfMNNi+tVbldp4EhtoyvJHzHSY
 Y9ioaa7u1yiJxaNHT3+9+humxzDY7PbQcHi3hUR3fibP3ahLMvlTCmnsxxtEW+tPvE4h
 0M3RlBKT18fDN939/6G3AutaDKXc3lWuSGF2ClYPOcD3fMrdTsmOXMvCuFCKZcZYTr8/
 PYZjk6jXHUpH2CIprd5z3PZ7nr7TvCH5sj4IkCro1M6dvuPkO2I7jYEXVZgFhwdMyY7v Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2v5btpqa26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2019 14:23:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8NEJESC076593;
 Mon, 23 Sep 2019 14:23:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2v6acvkp5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2019 14:23:10 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8NEN5G3005746;
 Mon, 23 Sep 2019 14:23:05 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 23 Sep 2019 07:23:04 -0700
Date: Mon, 23 Sep 2019 17:22:57 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Message-ID: <20190923142257.GB31251@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909230140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909230140
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
Subject: [alsa-devel] [PATCH] ASoC: soc-component: fix a couple missing
	error assignments
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

There were a couple places where the return value wasn't assigned so the
error handling wouldn't trigger.

Fixes: 5c0769af4caf ("ASoC: soc-dai: add snd_soc_dai_bespoke_trigger()")
Fixes: 95aef3553384 ("ASoC: soc-dai: add snd_soc_dai_trigger()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/soc/soc-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e163dde5eab1..a1b99ac57d9e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1070,7 +1070,7 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 			return ret;
 	}
 
-	snd_soc_dai_trigger(cpu_dai, substream, cmd);
+	ret = snd_soc_dai_trigger(cpu_dai, substream, cmd);
 	if (ret < 0)
 		return ret;
 
@@ -1097,7 +1097,7 @@ static int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream,
 			return ret;
 	}
 
-	snd_soc_dai_bespoke_trigger(cpu_dai, substream, cmd);
+	ret = snd_soc_dai_bespoke_trigger(cpu_dai, substream, cmd);
 	if (ret < 0)
 		return ret;
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
