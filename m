Return-Path: <SRS0=3aMq=K7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BC5C47082
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Jun 2021 12:48:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D11613AA
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Jun 2021 12:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D11613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF6EF16B6;
	Sat,  5 Jun 2021 14:47:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF6EF16B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622897283;
	bh=NPZmBwtEJ+WyiloWjR+RjO+v6SStFFbcKcFHQHsB6WI=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SODxnU6TkGudGGpSiMsrW49wLkYu8dRkHfVPQdWmY1XgewcPueQZ0Dz93VNbz+mDy
	 sVYt6CW7T1kl/3Fe758kHFknph43PUjso92ToRhXzw0kSZUDNN3c3XwlbXhsqZ+S7K
	 cYDN780P3ThVv8pJi5ltiSCr5guFJludmbVw8t+I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5EB64F800FF;
	Sat,  5 Jun 2021 14:47:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A4348F80253; Sat,  5 Jun 2021 14:47:09 +0200 (CEST)
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F9A1F80155
 for <alsa-devel@alsa-project.org>; Sat,  5 Jun 2021 14:47:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F9A1F80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="EYqb+Dk2"
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 155Cl0UD117149;
 Sat, 5 Jun 2021 12:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=vCqSKrJhl3KEpwiVAPQ1roxKQNiWvLHft/A6lvdVO7o=;
 b=EYqb+Dk27r8o1s4Fl5xW0njrnUEXICyj9yXxr/jNGpaEv9UwzqIsN5JAM4WusIDXTDsJ
 I8+Kf69kGVkR4cNW12BvLv1rYncEqt8uexxQ9a/lG037KSvHe814gcR8DxbeKkBmtQl2
 3YjUxmgvOLfsa6MhBqjsGEXcfK5W92dcGLUIuQtggE4PheSwoHXQYdGMi02TYgLhNvCW
 2yioJmbl+PYWhJ+rCawjOEY4qDMNyHH5kQ7xtMA9IZHP/OAU/o5aA/2eqDOYgz4XOKsE
 D1M2czL4pqvQk4XAqtV1BXEH57sERDIn3WtCAufNPUekBrNRe1hxEJ7MwdGA6hC+dj3u mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 38yxsc8ef3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 05 Jun 2021 12:47:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 155CkLPj135435;
 Sat, 5 Jun 2021 12:46:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3030.oracle.com with ESMTP id 38yxcsjr5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 05 Jun 2021 12:46:59 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 155Ckx5K136171;
 Sat, 5 Jun 2021 12:46:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 38yxcsjr5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 05 Jun 2021 12:46:59 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 155Ckqxu024989;
 Sat, 5 Jun 2021 12:46:57 GMT
Received: from mwanda (/41.212.42.34) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 05 Jun 2021 05:46:52 -0700
Date: Sat, 5 Jun 2021 15:46:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Clemens Ladisch <clemens@ladisch.de>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib: fix error codes for allocation failure
Message-ID: <YLtyL4VoArwVLor1@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: HDP0H6jfUng40qmVi-MzyKDBaQHKrI1t
X-Proofpoint-GUID: HDP0H6jfUng40qmVi-MzyKDBaQHKrI1t
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10005
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106050092
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>
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

Return -ENOMEM if kcalloc() fails.  Currently the code returns success.

Fixes: f9e5ecdfc2c2 ("ALSA: firewire-lib: add replay target to cache sequence of packet")
Fixes: 6f24bb8a157c ("ALSA: firewire-lib: pool sequence of packet in IT context independently")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/firewire/amdtp-stream.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 945597ffacc2..b37cec3cc579 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -1625,8 +1625,10 @@ static int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed,
 			s->ctx_data.tx.cache.tail = 0;
 			s->ctx_data.tx.cache.descs = kcalloc(s->ctx_data.tx.cache.size,
 						sizeof(*s->ctx_data.tx.cache.descs), GFP_KERNEL);
-			if (!s->ctx_data.tx.cache.descs)
+			if (!s->ctx_data.tx.cache.descs) {
+				err = -ENOMEM;
 				goto err_context;
+			}
 		}
 	} else {
 		static const struct {
@@ -1643,8 +1645,10 @@ static int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed,
 		};
 
 		s->ctx_data.rx.seq.descs = kcalloc(queue_size, sizeof(*s->ctx_data.rx.seq.descs), GFP_KERNEL);
-		if (!s->ctx_data.rx.seq.descs)
+		if (!s->ctx_data.rx.seq.descs) {
+			err = -ENOMEM;
 			goto err_context;
+		}
 		s->ctx_data.rx.seq.size = queue_size;
 		s->ctx_data.rx.seq.tail = 0;
 		s->ctx_data.rx.seq.head = 0;
-- 
2.30.2

