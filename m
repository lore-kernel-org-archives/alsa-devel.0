Return-Path: <SRS0=S+eB=7S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43721C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:02:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27D5207D5
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kZNf1aKH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kyOWvtGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27D5207D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2638A1655;
	Fri,  5 Jun 2020 13:02:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2638A1655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591354975;
	bh=D7ETs0PIbOrtxRkTAyntNG1MlqDJOvpMcBV7CmFZwxM=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kZNf1aKHOR/FKdng8T+Ie/F9DfCWdxCxpXRFa4k8P0N75RPV62EKyj1dBIExOjlOG
	 4nWbQYM04RG8jvl96a+MQiFcIbePxvrItIIw9hZjKSxB1qY+9/JZ98vRS9w7KKSiNT
	 4xUUy/iaZePuowSVUs6nicZ9o0GcAIwOJCmdHd74=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D975F801EC;
	Fri,  5 Jun 2020 13:01:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4A17F801ED; Fri,  5 Jun 2020 13:01:54 +0200 (CEST)
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E517F80132
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2020 13:01:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E517F80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="kyOWvtGb"
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055AwQWk161962;
 Fri, 5 Jun 2020 11:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Mx+BqpuuCLvvrJLCUOoA+Q1GJiz6R0T3Bxyce55kH4U=;
 b=kyOWvtGbYmNJIt0vi4iJK6j6Uo94Y+kZBGbwmKCp7Chalm9j9h5dKflZmwerZjpHBxmh
 2F7m1mrVh5BNXp0buCo+eY7wHjbNaPOd0gKmwsFaG4rDfInIE9rZNOfqQRJyYGH/RPen
 zwzD2cBZFDr5Ud44Goou8ov7u1vGeS0rkUd/+LSBi/Cgxt33Cd9Q7H5+puh99cxH6t88
 VF7UOIeSy4JmcTDH3k2lBKAL0begjMHGmqUBDmWkoVGaXPLt0jz2L2KKcCNFcG1mKntR
 IN632+w+4qSL6b2fNSvxsvtwDDCEiwmHcdYhvp6xdIl0OKqh8aRcGpcrCwtFe9BxYDB1 UA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 31f9262a04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 05 Jun 2020 11:01:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055Avdp9010100;
 Fri, 5 Jun 2020 11:01:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 31f925a5jv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Jun 2020 11:01:47 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 055B1fGt029976;
 Fri, 5 Jun 2020 11:01:44 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 05 Jun 2020 04:01:41 -0700
Date: Fri, 5 Jun 2020 14:01:34 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] ALSA: emu10k1: delete an unnecessary condition
Message-ID: <20200605110134.GC978434@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006050084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0
 suspectscore=0 cotscore=-2147483648 bulkscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050084
Cc: Hariprasad Kelam <hariprasad.kelam@gmail.com>,
 kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
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

The "val" variable is an unsigned int so it's always <= UINT_MAX.  This
check is always true so it can be removed.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/pci/emu10k1/emu10k1x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index ddb7c2ce3f7c9..def8161cde4c2 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -1040,7 +1040,7 @@ static void snd_emu10k1x_proc_reg_write(struct snd_info_entry *entry,
 		if (sscanf(line, "%x %x %x", &reg, &channel_id, &val) != 3)
 			continue;
 
-		if (reg < 0x49 && val <= 0xffffffff && channel_id <= 2)
+		if (reg < 0x49 && channel_id <= 2)
 			snd_emu10k1x_ptr_write(emu, reg, channel_id, val);
 	}
 }
-- 
2.26.2

