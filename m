Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F66FC433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:29:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01A1208D5
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gukIzfQY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="amgDiB5x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="iescjjWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01A1208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4949E16D5;
	Thu,  2 Jul 2020 13:28:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4949E16D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593689365;
	bh=8m+PM+LCrWZ2koWJWY43evGDydzDs6zKD03sZE5CEgM=;
	h=Subject:From:To:References:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gukIzfQY+t8dwsCUauR9OwmLTI9RG02oFjxGj6jtPhUr5J8QGzFCFEFXykYLz56rf
	 2YSb8zop1/PJXtrb/FFJjSZ3RDsR/23+pd9+1DWMFbNGahK6Nbb1D0Vnr/E4ULdkla
	 vz/Zy9xXrPTCSDDpF59WLq6C/UMVJ5u41KDU3eeg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3524F8022B;
	Thu,  2 Jul 2020 13:28:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE23DF8022D; Thu,  2 Jul 2020 13:28:30 +0200 (CEST)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0417F80134
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 13:28:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0417F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="amgDiB5x"; 
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="iescjjWf"
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id A4F35A1F439AB
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 13:28:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1593689305; bh=8m+PM+LCrWZ2koWJWY43evGDydzDs6zKD03sZE5CEgM=;
 h=Subject:From:To:References:Date:In-Reply-To:From;
 b=amgDiB5xWRrpNUvgWUOYunnVr74DEsHVt50Dod4nTjanNHE+Bxe+lRSh7XoNr2QbL
 UtDrE5fz2Bww5BiEqUWcrE4taXFSPIkmSaBD+ltgPw2WZM0ew9L3kMqzb9msb4cxul
 0My7tf476JaY1mMpSe0vi3wnbNhx245B761CWXGA=
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jEIh4XubN3k6 for <alsa-devel@alsa-project.org>;
 Thu,  2 Jul 2020 13:28:19 +0200 (CEST)
Received: from [192.168.105.151] (dustin.pilsfree.net [81.201.58.138])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id BE9BFA1F3DE3E
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 13:28:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1593689299; bh=8m+PM+LCrWZ2koWJWY43evGDydzDs6zKD03sZE5CEgM=;
 h=Subject:From:To:References:Date:In-Reply-To:From;
 b=iescjjWfJLJjyCe+bm+uhN7droIowahtZ2G5xFaIxVYIGvh+bRrQrWDt1EWbK7yXM
 Dh69sL/02EnYsXWrMOuL0ANLLuI26D8Bllg1F/hTFMY/2i5maBYD2RSNW2/4yu5pvt
 Zd90Qj1YPA3LRjGClbBOG1Ulfdl7BrFwN1b6EGUY=
Subject: Re: Ignored USB-audio implicit feedback in kernel 5.8rc3
From: Pavel Hofman <pavel.hofman@ivitera.com>
To: alsa-devel@alsa-project.org
References: <5be78c36-bca0-da9c-43ec-2e2a538948a8@ivitera.com>
 <51a129ba-d74f-bfe3-933c-4805bc87804a@ivitera.com>
Message-ID: <5bd5efb4-66f0-955c-783e-57aff997028a@ivitera.com>
Date: Thu, 2 Jul 2020 13:28:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <51a129ba-d74f-bfe3-933c-4805bc87804a@ivitera.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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


Dne 29. 06. 20 v 17:08 Pavel Hofman napsal(a):
> Dne 29. 06. 20 v 13:28 Pavel Hofman napsal(a):
>>
>> Audio analyzer RTX6001 (XMOS-based) is using implicit feedback, yet the
>> feedback is not used by the latest kernel 5.8 rc3 (i.e. already with the
>> latest implicit-feedback patches).
>>
>> Two analyzers on two different PCs are getting clicks in duplex-mode
>> loobpack, one every 10 secs, the other one every 50 secs.
>>

I am very sure the problem is identical to that for MOTU M2/4, Solid
State Logic SSL2+, Fractal Audio Axe-Fx III etc.
https://github.com/torvalds/linux/commit/e7585db1b0b5b4e4eb1967bb1472df308f7ffcbf
. I will try the simple quirk, IMO it will work OK. BTW if I understand
correctly all these devices use the XMOS.

However, I would like to ask, why a quirk for these devices is required.
The comment explanation in this interesting patch
https://lore.kernel.org/patchwork/patch/1174179/ talks about the same EP
numbers, but in the different direction. 0x01 EP OUT + 0x81 EP IN
implicit feedback data. All the devices mentioned above have this
numbering, just the EP IN is in a different interface than the EP OUT.
But please are there actually any duplex implicit feedback devices
having EP OUT and implicit-feedback EP IN  in the same interface? The
explicit feedback EP IN is clear, they are in the same interface. E-MU
0404 USB has EP OUT + EP IN explicit feedback in interface 1, together,
EP IN implicit feedback data in interface 2. My other soundcards,
adaptive OUT and async IN again each in a different interface (though
there is no feedback to solve).

Please is the requirement that EP OUT + EP IN implicit feedback data
must be in the same interface really necessary? If such a requirement
was dropped, IMO many devices could be removed from the existing
set_sync_ep_implicit_fb_quirk and many devices would work out of the
box, as they require no other quirk (unlike the MOTUs, but that's a
different issue).

Thank you very much for comments. Very likely I am missing something
important, I just do not see what :-)

Best regards,

Pavel.

