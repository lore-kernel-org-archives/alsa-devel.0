Return-Path: <SRS0=bL7i=LQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CDCC2B9F4
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 19:03:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED8361108
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 19:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED8361108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7016486E;
	Tue, 22 Jun 2021 21:02:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7016486E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624388593;
	bh=P/QvfWR6P4DYsrxrfTduFv4IgMt6a6CycvxGoFSQ/L4=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tA+aXElfcOVhHMRCTHF3ZyFYzFWommA8IXKTcO2zF/jZyFEh0n3nU6VjdifQ41k4b
	 YHnv1fY7XuxeqlFtnSmR48qsM4bzZdl853W5qOWyNCmdYMhNM0GZ5LbAC4ZLvU2vkY
	 iQYD4GVUdFMaUKMokgzdz4sK0nR3ILcwtd1r98Jc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ECF58F80268;
	Tue, 22 Jun 2021 21:02:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A76DCF8026A; Tue, 22 Jun 2021 21:02:21 +0200 (CEST)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3AC5CF8025F
 for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2021 21:02:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3AC5CF8025F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="FR8FZKAF"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15MIpX5M015464; Tue, 22 Jun 2021 19:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=u+Pcpdfv5XiIJVzj+HrRRNCTdf8HxwKR9fmNhdehMXM=;
 b=FR8FZKAFp/KkxakFDQMW0GTqafMMRN34Wbcf9pZl/uLTu5fOnH+Az+5C6nKkhbvVG/p2
 LPP8zBfkDzy2pywWbbALWKZ2CvvXOVcHBMV2jWHQlZPu1cx95IRllAgzf2TGKrun+YUp
 obryrqj0fntU8otYEMHHe4wprBwtggHWZRn7z5XgX+tVDR13+iNvH4O6uWgXNrNoPOoc
 HwF7vQzkz5fEhfXfSASju7wJ2Yasv6NMiv2Jm8WkWmRZ541AzGfgqI8a+5L+pUi8GvDo
 uCT6BZVXhAKIA9VNgqxng//f7uKHC0XL9gY3+1Id0t/hD3dHPDJzlI2WbXAFNPo4VJsN 0w== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 39ap66m53f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jun 2021 19:02:16 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
 by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15MJ2FnH141704;
 Tue, 22 Jun 2021 19:02:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3020.oracle.com with ESMTP id 399tbt72gw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jun 2021 19:02:15 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15MJ2Esc141663;
 Tue, 22 Jun 2021 19:02:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 399tbt72g0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jun 2021 19:02:14 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15MJ2Adc031545;
 Tue, 22 Jun 2021 19:02:11 GMT
Received: from mwanda (/102.222.70.252)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 22 Jun 2021 12:02:09 -0700
Date: Tue, 22 Jun 2021 22:02:02 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ALSA: hdsp: fix a test for copy_to_user() failure
Message-ID: <YNIzqpVR6L2t/RwJ@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: XfKTsGLLD1wiJBqPkRyD99cj_evkpHhH
X-Proofpoint-GUID: XfKTsGLLD1wiJBqPkRyD99cj_evkpHhH
Cc: alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
 Tong Zhang <ztong0001@gmail.com>, kernel-janitors@vger.kernel.org,
 Allen Pais <allen.lkml@gmail.com>, Huilong Deng <denghuilong@cdjrlc.com>,
 Romain Perier <romain.perier@gmail.com>, Jasmin Fazlic <superfassl@gmail.com>
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

The copy_to_user() function returns the number of bytes remaining to be
copied.  It doesn't return negatives.

Fixes: 66c8f75919dd ("ALSA: hdsp: Fix assignment in if condition")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/pci/rme9652/hdsp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index e3e4fabf4abf..8457a4bbc3df 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -4877,9 +4877,8 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 		memset(&hdsp_version, 0, sizeof(hdsp_version));
 		hdsp_version.io_type = hdsp->io_type;
 		hdsp_version.firmware_rev = hdsp->firmware_rev;
-		err = copy_to_user(argp, &hdsp_version, sizeof(hdsp_version));
-		if (err < 0)
-		    	return -EFAULT;
+		if (copy_to_user(argp, &hdsp_version, sizeof(hdsp_version)))
+			return -EFAULT;
 		break;
 	}
 	case SNDRV_HDSP_IOCTL_UPLOAD_FIRMWARE: {
-- 
2.30.2

