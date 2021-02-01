Return-Path: <SRS0=YhdC=HD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823FEC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 13:16:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F7764E2A
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 13:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F7764E2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 921CC171D;
	Mon,  1 Feb 2021 14:15:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 921CC171D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612185389;
	bh=tFRHIKar0mqgCr8lEwhTDPsSSHFccb+hE+OXowIFDoI=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LpElyLgnT7VCLGU9W96viSAEJCTLyw9/sa7+ABBDiIPRcL0Ecw2VSE7QZul5Ygo5r
	 WOhbDRQXpoQCtIueYXWKcbAvJ2D0te3iYuiWxqVbkREt7rqwe4O9w9n0CZIDGYii49
	 Ao4YsDanzMsCl3nxv1LCAoxHJ0mDLcGiwRvzX4TI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1FC7FF80152;
	Mon,  1 Feb 2021 14:15:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4FBC8F800E2; Mon,  1 Feb 2021 14:15:37 +0100 (CET)
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67939F800E2
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 14:15:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67939F800E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="qrMl3Z+c"
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111CsGad044758;
 Mon, 1 Feb 2021 13:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=TzfQ82pKUD6Nw5plssxoMpOxD9vVxmKwVvTF3Wyh2ag=;
 b=qrMl3Z+cAWAFQdqUGz+u7TC1B00eF1ePEGx+AHf8w+ez6mj6FyD3+c0P2sJQXNg+Nt66
 lpAG/XhV+DLTDYylEmlXPJUQ7MlktK6DO0VJ1QPE6/iCkjthUvie4D/zjX2IzcsNl981
 O8DP6Vg+6+KAWpiH0+DLAajhOIHMFcyww68zaerUxIo2tNlC+xJaLCroC7k6SuTlyk0y
 Y0UcjWhnUkbydomKRBY/3xlygETNcvgDLvsCoGcaK+ml3qyxBs8h/li5isiJDeyFkpO/
 cvgv8UdhTHTSmFRXjKAHPW6R3/Y4HdvSUS/kUbO72Z5qtoyYZL+v28vEptBcFRkuXF+9 GQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 36cxvqw62f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Feb 2021 13:15:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111CsroH048284;
 Mon, 1 Feb 2021 13:13:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 36dhbwkbh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Feb 2021 13:13:24 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 111DDJ5g006316;
 Mon, 1 Feb 2021 13:13:22 GMT
Received: from mwanda (/10.175.186.133)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 01 Feb 2021 05:13:19 -0800
Date: Mon, 1 Feb 2021 16:13:14 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: tiwai@suse.de
Subject: [bug report] ALSA: seq: Use no intrruptible mutex_lock
Message-ID: <YBf+arIyZvfQkDbP@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9881
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=935 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010066
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9881
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=852
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010066
Cc: alsa-devel@alsa-project.org
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

Hello Takashi Iwai,

The patch 04702e8d0092: "ALSA: seq: Use no intrruptible mutex_lock"
from Aug 1, 2018, leads to the following static checker warning:

	sound/core/seq/seq_clientmgr.c:2194 snd_seq_create_kernel_client()
	warn: called with lock held.  '&register_mutex'

sound/core/seq/seq_midi.c
   294          if (ports > (256 / SNDRV_RAWMIDI_DEVICES))
   295                  ports = 256 / SNDRV_RAWMIDI_DEVICES;
   296  
   297          mutex_lock(&register_mutex);
                           ^^^^^^^^^^^^^^^
Holding lock

   298          client = synths[card->number];
   299          if (client == NULL) {
   300                  newclient = 1;
   301                  client = kzalloc(sizeof(*client), GFP_KERNEL);
   302                  if (client == NULL) {
   303                          mutex_unlock(&register_mutex);
   304                          kfree(info);
   305                          return -ENOMEM;
   306                  }
   307                  client->seq_client =
   308                          snd_seq_create_kernel_client(
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Deadlock

   309                                  card, 0, "%s", card->shortname[0] ?
   310                                  (const char *)card->shortname : "External MIDI");
   311                  if (client->seq_client < 0) {
   312                          kfree(client);
   313                          mutex_unlock(&register_mutex);
   314                          kfree(info);
   315                          return -ENOMEM;
   316                  }
   317          }

regards,
dan carpenter
