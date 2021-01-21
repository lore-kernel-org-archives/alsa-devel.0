Return-Path: <SRS0=oBR+=GY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692C8C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 06:13:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDDA6238EC
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 06:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDA6238EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 82CE91877;
	Thu, 21 Jan 2021 07:13:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 82CE91877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611209632;
	bh=NscA5zXi3oV1B1Js+eCDW/HDxoqQnDar7+BN5CJl9ks=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GfzIvNjpwjKlUj79ArkbxsQgHm43z28NcVc3QiUpv2whiW8yHb/ot7MizKEjg5AtH
	 Bf/LNWLaThoeAChgqrJozvAqTLEjthPwBvfiLL45tcBJ9oa6WKFr7zrmiHeemNwblv
	 9bswPrt0Z7wk6uLA2EbY4uSUl9e1AvzBI6rGpSjU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DCFFF80255;
	Thu, 21 Jan 2021 07:13:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29B1BF80257; Thu, 21 Jan 2021 07:13:00 +0100 (CET)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99B5DF80164
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2021 07:12:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99B5DF80164
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="F/Oen6yz"
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10L64gfX056820;
 Thu, 21 Jan 2021 06:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=TU60lfUQSHpxKTXeid3VaiKFUQOIYza8NvJjcJRQUAk=;
 b=F/Oen6yzgnoswiWBuqmr/yanhMDHX4i+6Z6rzLVyfkIHbKgglifM7HLM9p4/GxWoZ5OZ
 1KPJa4g41aAEE1EwdSfoSXa2ZFewvxsZEzT9IXHH3Ab1c2GEjuS5Gy2Cn05V8YL3B7Fa
 Gepa7RsFuk6DsNA4cmSQM85VaTHF71MKLJ0U8OVopUACYwTNcjd8/XqoJ1kBqlH9i7PQ
 N674Atv12gGE9PLf3FrMKBIbuH2QGv+QjNtsAfwFfULYdmS4pKbVxOZ25iKOvGhaGLmT
 2Un4uQWdQYo4qYPGxtFZDki3DpYKIDTOlNlX3cJ4aV71Pzs9ninvCfgOkEmMe+cueb/j +g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 3668qmwr7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Jan 2021 06:12:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10L65iWe007557;
 Thu, 21 Jan 2021 06:10:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 3668recvdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Jan 2021 06:10:54 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10L6Ari2021260;
 Thu, 21 Jan 2021 06:10:53 GMT
Received: from mwanda (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 20 Jan 2021 22:10:52 -0800
Date: Thu, 21 Jan 2021 09:10:47 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] ALSA: fireface: fix info leak in hwdep_read()
Message-ID: <YAka5xudQNQgRkuC@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210031
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
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

If "ff->dev_lock_changed" has not changed and "count" is too large then
this will copy data beyond the end of the struct to user space.

Fixes: f656edd5fb33 ("ALSA: fireface: add hwdep interface")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/firewire/fireface/ff-hwdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/fireface/ff-hwdep.c b/sound/firewire/fireface/ff-hwdep.c
index 4b2e0dff5ddb..b84dde609a03 100644
--- a/sound/firewire/fireface/ff-hwdep.c
+++ b/sound/firewire/fireface/ff-hwdep.c
@@ -35,12 +35,12 @@ static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf,  long count,
 	}
 
 	memset(&event, 0, sizeof(event));
+	count = min_t(long, count, sizeof(event.lock_status));
 	if (ff->dev_lock_changed) {
 		event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
 		event.lock_status.status = (ff->dev_lock_count > 0);
 		ff->dev_lock_changed = false;
 
-		count = min_t(long, count, sizeof(event.lock_status));
 	}
 
 	spin_unlock_irq(&ff->lock);
-- 
2.29.2

