Return-Path: <SRS0=VSUR=JI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AA6C433B4
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Apr 2021 16:03:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FBF460C3D
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Apr 2021 16:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBF460C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hacklava.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF62215E5;
	Sun, 11 Apr 2021 18:02:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF62215E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618156979;
	bh=jntPDkaT16EW3HN/mfuI4tu/Z+NNiibSkvESR6qizhA=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vCkfiRpelwuZ/1GLcMS/s/WgsDhtmmTr8z66wFW8zcO+E4dKRdjMUCVlYlwNc0Nf9
	 LngQu/c3UYfjjYngALI8uGy6/Qf1nm6eUqTmfD9nwQYo0THlRTJjVOFyvFNzDXqjHk
	 VnPFvGekqx2uuqPKkxdNcaOmZuPhb91yCWq7j0a4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 592DFF8021D;
	Sun, 11 Apr 2021 18:02:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4A6DCF8022B; Sun, 11 Apr 2021 18:02:07 +0200 (CEST)
Received: from pmta11.teksavvy.com (pmta11.teksavvy.com [76.10.157.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 946EBF8013D
 for <alsa-devel@alsa-project.org>; Sun, 11 Apr 2021 18:02:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 946EBF8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=hacklava.net header.i=@hacklava.net
 header.b="3oA+25o7"
IronPort-SDR: ZzRoC2rgx6mQuPYtrJXSrU6MxWftM/fZUz1KWWIAZuHKZcVT5vRJTuk1OgkL6+cIt5NcqBVSRQ
 xyGStiQ3163A==
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AtUE0d6n1UTPVT68165jk8HPC207pDfN3im?=
 =?us-ascii?q?dD5ilNYBxZY6Wkvuqpm+kW0gKxtS0YX2sulcvFFK6LR37d8pAd2/hzAZ6JWg?=
 =?us-ascii?q?76tGy0aLxz9IeK+V3dMgDd1soY76dvdKBiFMb9ZGIQse/W6BS1euxP/PCp/K?=
 =?us-ascii?q?ykju/VzTNMYGhRGsRdxihjDALzKCFLbSxHH4d8KJ2H+sFcrSGhcnh/VLXdOl?=
 =?us-ascii?q?AhX/Lf4+HNjo7sexQcBxUqrDCJly7A0s+dLzG9/jMzFwxC2q0j92+tqW3Ez4?=
 =?us-ascii?q?GuqeuyxBOZ90K71eUupPLbxtFOBNOBh6EuQ12Hti+TeI9jV7ee1QpbnMiT7j?=
 =?us-ascii?q?8R/eXkklN6Y5106Tf6Xkzdm2qI5yDQlDIv5hbZuD2lvUc=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GFCwCEHHNg/zmCCkxaHQEBAQEJARI?=
 =?us-ascii?q?BBQUBQAmBSYN4AWqEQokEhjmBbmkBg0uYYAsBAQEBAQEBAQEJNAQBAQSBBQ5?=
 =?us-ascii?q?EhHAmOBMCAwEBDAEBAQUBAQEBAQYEAgKBAIVQDYRcgS9sFQgBARQkNAImAmw?=
 =?us-ascii?q?IAQGCbYMIrAKBMoEBggQBAQaCTINnfwmBDyqOEIILgRMnDIFWhmaCSoJggV6?=
 =?us-ascii?q?DWlCMToUijEqLIZFhgxWWS4YlBQsflCuQRrMhhTkNgWuBfTMiJgqDJFAZDo4?=
 =?us-ascii?q?fiEmGHCUDLzgCBgoBAQMJjDNeAQE?=
X-IPAS-Result: =?us-ascii?q?A2GFCwCEHHNg/zmCCkxaHQEBAQEJARIBBQUBQAmBSYN4A?=
 =?us-ascii?q?WqEQokEhjmBbmkBg0uYYAsBAQEBAQEBAQEJNAQBAQSBBQ5EhHAmOBMCAwEBD?=
 =?us-ascii?q?AEBAQUBAQEBAQYEAgKBAIVQDYRcgS9sFQgBARQkNAImAmwIAQGCbYMIrAKBM?=
 =?us-ascii?q?oEBggQBAQaCTINnfwmBDyqOEIILgRMnDIFWhmaCSoJggV6DWlCMToUijEqLI?=
 =?us-ascii?q?ZFhgxWWS4YlBQsflCuQRrMhhTkNgWuBfTMiJgqDJFAZDo4fiEmGHCUDLzgCB?=
 =?us-ascii?q?goBAQMJjDNeAQE?=
X-IronPort-AV: E=Sophos;i="5.82,214,1613451600"; d="scan'208";a="161419515"
Received: from 76-10-130-57.dsl.teksavvy.com (HELO mail.hacklava.net)
 ([76.10.130.57])
 by smtp11.teksavvy.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Apr 2021 12:01:59 -0400
Received: from [192.168.1.24] (unknown [192.168.1.24])
 (Authenticated sender: marc@hacklava.net)
 by mail.hacklava.net (Postfix) with ESMTPSA id BECEE34A
 for <alsa-devel@alsa-project.org>; Sun, 11 Apr 2021 12:01:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hacklava.net; s=mail;
 t=1618156918; bh=jntPDkaT16EW3HN/mfuI4tu/Z+NNiibSkvESR6qizhA=;
 h=To:From:Subject:Date:From;
 b=3oA+25o7UZcS3NUAs/Wk7EWIV7juVjQ8LVxiVUviTf5bUMnByws+tYvLgiHfHx6/z
 zQyohfCLCGMlqJQf1gm/Ari90C9jjRV4oR8jXHfiphwkFJY1gFKtn3y+dYsWJf/d63
 WqY/RNLhC/M5mxh+pOcMmlZfmkbyYITidC6mNH3nLr+hMwf8wXL5Kw0TCd5UoJp0PT
 HQfR96IDgWW94OnUUJ6Ce5d5w0/JkvY9Gpkx8p8F//0jh2vCJ4Je554l7taoOJFGn5
 KCh0EFbURz03OWJBTWPL9a0cIqBNRvFg0lKbydhv+0A1rI0XuY4Wzc/ohh6TweDem0
 hFiqIBARFkzCw==
To: alsa-devel@alsa-project.org
From: =?UTF-8?Q?Marc_Lavall=c3=a9e?= <marc@hacklava.net>
Subject: advice for creating special ALSA driver or plugin
Message-ID: <c1954dd5-fe9e-883e-6119-e7f3ae58745a@hacklava.net>
Date: Sun, 11 Apr 2021 12:01:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

Hi ALSA developers.

I'm completely new to ALSA developing, so I'm being lazy and ask for 
advices.

I have a USB recording device for four 16bit/48Khz channels, "encoded" 
in a stereo 16bit/96Khz track; because it is a USB audio recording 
device, so no special recording software is required, but a (proprietary 
Windows) converting software is provided (that I can't use).

Output channels are alternated at the sample level: L: 1313131313, R: 
2424242424, etc...

So basically the driver/plugin would alternates between input samples of 
a stereo track to output 4 channels (at half the input sample rate).

Is there a code base I could study and adapt to start my simple project?

Thanks for your attention.

Marc


