Return-Path: <SRS0=vuHx=ZK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E0AC432C0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 10:44:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2452071B
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 10:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="En6YHlEs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="4FFctuDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2452071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65F6A1668;
	Mon, 18 Nov 2019 11:43:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65F6A1668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574073848;
	bh=CwlSsrCQJnczt53oSjJ1C0/AWFHi+B2FQqpONRo+/H4=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=En6YHlEsJHM05DOOO7xMk5pksAjCX0rHO7bDFQw/YNn+f9/KJ44IesYyAKy2fuwNG
	 AXKbDLmUhYLKK1611SnlDnlHvB23LIsBWiZ0X0ADbuIXNqLQ9pwksZ7XESPIkJ/XKu
	 r8y8BKNetNsRpF3/hTV6dsT7ipcFaSrrhbHHPMQI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9484F80100;
	Mon, 18 Nov 2019 11:43:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9AAECF8013B; Mon, 18 Nov 2019 11:43:16 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04BC0F800F6
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2019 11:43:13 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 16C36A003F;
 Mon, 18 Nov 2019 11:43:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 16C36A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1574073793; bh=Q5w9BzvCClNvSMLhe6hCtQqJBZ4QiDyzh/keJW4rMZ8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=4FFctuDhWxJOW+PGFLujdjuh/SJYSjkle9K01xCKeVw3KjRJZBvwSY0aaTzvV40F6
 NX8RXhE+I9n8oIglLjR45H6vsUmnmeOOERIuOyo7EVgYtBr774tmmDjvSE0lUBIM23
 wjyBUd0S0kaEJmot4ckGDNjrcfORcUtGdxl2sW7s=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 18 Nov 2019 11:43:09 +0100 (CET)
To: Takashi Iwai <tiwai@suse.de>
References: <20191116142440.2b4e8e12@abudhabi.paradoxon.rec>
 <48906630-65c7-c0de-6b93-322153cc0968@perex.cz>
 <s5hftin4vx7.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <fabe7ce0-3627-9440-486b-ea9b9ce860c1@perex.cz>
Date: Mon, 18 Nov 2019 11:43:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <s5hftin4vx7.wl-tiwai@suse.de>
Content-Language: en-US
Cc: Lars Wendler <polynomial-c@gentoo.org>, alsa-devel@alsa-project.org,
 alsa-bugs@gentoo.org
Subject: Re: [alsa-devel] compression format of alsa-ucm-conf and
 alsa-topology-conf tarballs
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

Dne 16. 11. 19 v 17:40 Takashi Iwai napsal(a):
> On Sat, 16 Nov 2019 14:39:38 +0100,
> Jaroslav Kysela wrote:
>>
>> Dne 16. 11. 19 v 14:25 Lars Wendler napsal(a):
>>> Hello lists,
>>>
>>> some shell output says more than any explanation:
>>>
>>>
>>> lars@abudhabi:~/temp/alsa> wget -q
>>> https://www.alsa-project.org/files/pub/lib/alsa-topology-conf-1.2.1.tar.bz2
>>> lars@abudhabi:~/temp/alsa> wget -q
>>> https://www.alsa-project.org/files/pub/lib/alsa-ucm-conf-1.2.1.tar.bz2
>>> lars@abudhabi:~/temp/alsa> tar -xjf alsa-topology-conf-1.2.1.tar.bz2
>>> bzip2: (stdin) is not a bzip2 file.
>>> tar: Child returned status 2 tar: Error is not recoverable: exiting now
>>> lars@abudhabi:~/temp/alsa(2)> tar -xjf alsa-ucm-conf-1.2.1.tar.bz2
>>> bzip2: (stdin) is not a bzip2 file.
>>> tar: Child returned status 2
>>> tar: Error is not recoverable: exiting now
>>> lars@abudhabi:~/temp/alsa(2)> file alsa-topology-conf-1.2.1.tar.bz2
>>> alsa-topology-conf-1.2.1.tar.bz2: XZ compressed data
>>> lars@abudhabi:~/temp/alsa> file alsa-ucm-conf-1.2.1.tar.bz2
>>> alsa-ucm-conf-1.2.1.tar.bz2: XZ compressed data
>>> lars@abudhabi:~/temp/alsa>
>>>
>>> Please rename the tarballs if possible.
>>
>> Oops, it was a mistake. The tar balls are repacked. Thanks for your notice.
> 
> While we're at it: LICENSE file seems missing in both tarballs.

2nd oops, I fixed this right now.

			Thanks,
				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
