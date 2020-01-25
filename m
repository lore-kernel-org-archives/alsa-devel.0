Return-Path: <SRS0=22TH=3O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1C3C2D0DB
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Jan 2020 14:13:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05EF920704
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Jan 2020 14:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hfrFGiGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05EF920704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jensverwiebe.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59B3E1678;
	Sat, 25 Jan 2020 15:12:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59B3E1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579961626;
	bh=3XmDW5juFmO5/3cE4UMw1TxBaYtdMMvywz2HK8bRkvw=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hfrFGiGCQwjd7AWptbOObFEPvVKxMFUNv+y7us/pnDixNtw01h6o7YEiIsQGQsrJK
	 rGOzqwr+JwRxsj5Vm5GkGN11dK9xKfgeg8zQIN6fDTuVT+t5SdsJVm8wEuByejYWl2
	 APPN9NzemAzaTbaYPMqwzLccfiQC6gkfhaiTDm6A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB043F801D9;
	Sat, 25 Jan 2020 15:12:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06D17F801EC; Sat, 25 Jan 2020 15:12:53 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 422C5F8012E
 for <alsa-devel@alsa-project.org>; Sat, 25 Jan 2020 15:12:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 422C5F8012E
Received: from [192.168.178.21] ([77.10.30.73]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M2Plu-1isb1j1INy-003xNH for <alsa-devel@alsa-project.org>; Sat, 25 Jan 2020
 15:12:49 +0100
To: alsa-devel@alsa-project.org
References: <20200125132226.31277-1-nick83ola@gmail.com>
From: Jens Verwiebe <info@jensverwiebe.de>
Message-ID: <9b997da2-a292-9e4d-764e-ef3dedf0ce14@jensverwiebe.de>
Date: Sat, 25 Jan 2020 15:12:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200125132226.31277-1-nick83ola@gmail.com>
Content-Language: de-DE
X-Provags-ID: V03:K1:VnM9Ut977gkhwiID8opIm7tApJlQ4j3nkC5rqmQ1XXzY5YI/1rE
 VOmF1ijYkGVvJqtd9j+I3uJMCblKIwuWCd8jKOGeBFWzyKbWbc/pKU9tuLe+Zxc4mbJLlT9
 bH56M1chTCdg97iaUw/poVEp5uM2/mrug1P3qEIPduspZo2qC8FYvAEkPw4zDcukm0dW3/X
 sOdd/clrxEtDQ369ZQ01A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BhKq/QvG0PQ=:UdMGHiA1h4aMj69hFzJEIJ
 VGi1VTqo2u3hVHYLYYMPnHI2E/9Yyl6u1WAecCwBvbBEFgMff/OYMyrGwOArYz4XwhDt2Fssf
 8HnsRlaVKQHdi3FkBf5jE30ihAr3KlqySnUvG4omyT947+g+XRqDlWuBDBplNln6dQEb9Fjvf
 ROQpRo2Xn7pLzBlFnAYP3KZdHdLTWx1N3pg/8/9ygNYN8DcjAC8DtrfVbmSI96Krre6/YcCpI
 8JUvNpiwMNCpkuX9jRkO7DgYE6lsBOe9Q5n9FLi+IkmhRw3xJy0cHHL+Abzy6VTitcoW/obqN
 o6qFvdmAE/5MhEUaLdUWrRzfvcw0L0h31xkHIOOrTtBf+k5LejhcUVbjK5vq6JSucHYahoend
 A88JBafyTvGW0jy+YZ6sJdDt/qoZrNf1+/LXt/zhGTyrQIYOWGpC0MQgzuP3HpC1GPstcs/zP
 qo4OrUkQKkctHm/ZtPQmgq68WSuOiyEq4uXly+uQIglzMAQSTXK/WQqCb3fS4KOap+2Ugz/MJ
 sFLMDXFRVYaCv+OBWa+cnRzGtZMIdmjJLOW/3j5TnrLg32PtAn73GJBHkh+LoK2a9MRYoBFjI
 tha8MVtXmKa1Elnxwebgkz+vGWq+YQoc0oyaz2deUuk7OiDrVVxSBtMMlruRykRaQFCN7FsuJ
 X19wBz5LxpaFmVjAixGezklAo2fUbPXNVzXQlkFlMcv8kXSL8oTsYuUu9+3GtTkGQ7fcSbFEq
 ZKDt8Is8HCXhEwjzrd+YFZ6bmcKOvP4zVB1SrQfp9EPO90tUowcpblMp+ndhQYcexTqjT/eTA
 KCE5dH0Nxr4Q+oLY+7VzjM5rNnIA1JNmdnjWoKKt8FymP1E0A8OQqvC3OceMaS58xxHGvEo
Subject: Re: [alsa-devel] [PATCH] ALSA: usb-audio: add quirks for Line6
 Helix fw 2.82
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi

Why this incomplete patch ???

I longer informed you that with fw >= 2.8 lot of helix kind devices got 
a new ID:

So this patch should include at least the well known/collected data:

case USB_ID(0x0E41, 0x424a): /* Line6 Helix LT - firmware >= 2.8 */


Jens

-- 

Jens Verwiebe
Allerskehre 44 - 22309 Hamburg

Tel.: +49 40 68 78 50
mailto: info@jensverwiebe.de
web: https://www.jensverwiebe.de

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
