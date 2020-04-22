Return-Path: <SRS0=We8V=6G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448D8C55186
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:24:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12E820735
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NuEzXEcY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N3cNlE7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12E820735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12C4516A9;
	Wed, 22 Apr 2020 11:23:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12C4516A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587547454;
	bh=km7egsPCgWO+7fmVctsOQOv8pZ5yu7UFocTycD6mvAc=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NuEzXEcYNXVSqqwMzSODKcsU4EQhlzL1kwM9S0COGgVDGELXDben82MYhnchnLfZp
	 f+u8scPkThM3y3hghbSQOYm+L2qnLM13K81iRfuE0153CvpcpAHu3AqEvTItUgvMwr
	 THvwNYzLNNiFaEViYWiCJdD+5b6Y6uooToprZKXY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FF41F80142;
	Wed, 22 Apr 2020 11:23:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 655A4F801D9; Wed, 22 Apr 2020 11:23:21 +0200 (CEST)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 869F7F80108
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 11:23:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 869F7F80108
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="N3cNlE7+"
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03M9Ik2c021841;
 Wed, 22 Apr 2020 09:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=dLtRYqGNB9RgcVygXcN07syddWJjMdr6zGGihKEe1WI=;
 b=N3cNlE7+XLHuBDccnIykeUBb9a1b3piPoiPenD+ZiTIHUEhFqv0MpNIj6G53+Rv57v0f
 rXhL2WUzqYrR3yBlPMVSxc1sb2IK8/bYbuO1ne7oJ6sydbsV7F2G+IpR57xpqFmmoCy8
 f09onpXJwQ/HpycvXqhJFVYcLFAo2Zclhik+aecXNdPktpdSfIT0cMyt/NMbIAA/H9eb
 27oQBTga9rxZ4WaAwAQc6ZWCf2yLSbuVssCNJa+Zf16fIb8hQ8ibc+QPLIFrrEtOvClF
 RFtEf/XMS/qQmBjV9ISzBUxac34M2Itzxiw4eBSCQvd5ZHL76jgdThZHOVElEhWEh9cA HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 30fsgm1nvc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Apr 2020 09:23:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03M9ILxw119121;
 Wed, 22 Apr 2020 09:23:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 30gb1j46hd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Apr 2020 09:23:14 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03M9N1Yp005013;
 Wed, 22 Apr 2020 09:23:06 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 02:23:01 -0700
Date: Wed, 22 Apr 2020 12:22:55 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ALSA: usb-audio: Fix a limit check in
 proc_dump_substream_formats()
Message-ID: <20200422092255.GB195357@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220075
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 Allison Randal <allison@lohutok.net>
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

This should be ARRAY_SIZE() instead of sizeof().  The sizeof() limit is
too high so it doesn't work.

Fixes: 093b8494f299 ("ALSA: usb-audio: Print more information in stream proc files")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/usb/proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/proc.c b/sound/usb/proc.c
index 5a36e192ebb0..889c550c9f29 100644
--- a/sound/usb/proc.c
+++ b/sound/usb/proc.c
@@ -140,7 +140,7 @@ static void proc_dump_substream_formats(struct snd_usb_substream *subs, struct s
 
 			snd_iprintf(buffer, "    Channel map:");
 			for (c = 0; c < map->channels; c++) {
-				if (map->map[c] >= sizeof(channel_labels) ||
+				if (map->map[c] >= ARRAY_SIZE(channel_labels) ||
 				    !channel_labels[map->map[c]])
 					snd_iprintf(buffer, " --");
 				else
-- 
2.26.1

