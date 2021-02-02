Return-Path: <SRS0=BHSX=HE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0FDC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 18:58:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B71B64F5D
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 18:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B71B64F5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 995D2177F;
	Tue,  2 Feb 2021 19:57:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 995D2177F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612292299;
	bh=HZkVdOswZY+dY33ZU0SYRXcIeIllvJsFNWLCqkuhJ8w=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OgylHsbo8QplhsA/sy3FgkJFk/4zO7dItswAuJ281OG7yfChdN4wKKGHEJO/FNB7+
	 EUifDBrLL/38952u127aprYJsq1GAJI3cRsqGKwMCOoGHY3bFLGop/5mIzqUSSPS50
	 ly0N0zRbWFY62qIP85eo2EQU+GtJY/R0YVqXkwCI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19F10F80152;
	Tue,  2 Feb 2021 19:57:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A0B24F80171; Tue,  2 Feb 2021 19:57:27 +0100 (CET)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CC4FCF8013C
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2021 19:57:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC4FCF8013C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="L/2S0sar"; 
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="lKgDPLRY"
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id 91F6FA188563C;
 Tue,  2 Feb 2021 19:57:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1612292240; bh=HZkVdOswZY+dY33ZU0SYRXcIeIllvJsFNWLCqkuhJ8w=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=L/2S0saro3zu1tnY1Yh7kkmhNX4nIljNM1TkSk2Ct7lhqGwGfZK81cnPdVaSKUOdZ
 C1k4/1dz7FIoZDTdfwUrlas0NvFT4GRvW+PokIb66mYB+dtEgEg/ojfllfPsn5WYsa
 GNhLN5ee4cFq8P+DBcO8FTNIjPi7lZ54F8NWhUiw=
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eAjbOzpxpuWh; Tue,  2 Feb 2021 19:57:15 +0100 (CET)
Received: from [192.168.105.119] (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id 32310A1875E3B;
 Tue,  2 Feb 2021 19:57:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1612292235; bh=HZkVdOswZY+dY33ZU0SYRXcIeIllvJsFNWLCqkuhJ8w=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=lKgDPLRYC8Vg+m06viQZoz9xr3puYL86rCrKSB2GDAq3Gwl2WZUKUMFREuYDi6Oue
 xVG6nbKqvPGbIA28nH6EYf8wX/G6kYMiDgOnQMJXUJ4iL7FEYQvz+cEL66/qaGu/rW
 Xhch6XcuIT9su77PpspUH4wZsVDlpiOSfDWfWjW4=
Subject: Re: question about ALSA devices not showing up in buildroot build
To: Bert Schiettecatte <bert@bertschiettecatte.com>
References: <CALd3UbT7DcXSmLO2VEDReY5aft5shpeEBS_wg7bWpoC6Q3qxzQ@mail.gmail.com>
 <9b19b22c-b096-2ba9-8323-5d3fd9a9ef49@ivitera.com>
 <CALd3UbQjJL194sJMy0nrjx6J7RZ3L44hm4OH4dffhpmSNNBaGA@mail.gmail.com>
From: Pavel Hofman <pavel.hofman@ivitera.com>
Message-ID: <4321a2f2-28e4-32a2-c590-90eeaec35682@ivitera.com>
Date: Tue, 2 Feb 2021 19:57:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CALd3UbQjJL194sJMy0nrjx6J7RZ3L44hm4OH4dffhpmSNNBaGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Dne 02. 02. 21 v 19:32 Bert Schiettecatte napsal(a):
> Hi Pavel
>> Do you have the /usr/share/alsa configs?
> 
> [root@rockchip:/usr/share/alsa]# ls -las
>       1 drwxr-xr-x    6 root     root          1024 Dec 21  2020 .
>       1 drwxr-xr-x   24 root     root          1024 Jan 23  2021 ..
>      10 -rw-r--r--    1 root     root          9876 Dec 21  2020 alsa.conf
>       2 drwxr-xr-x    2 root     root          2048 Dec 21  2020 cards
>       1 drwxr-xr-x    2 root     root          1024 Dec 21  2020 init
>       1 drwxr-xr-x    2 root     root          1024 Dec 21  2020 pcm
>       1 drwxr-xr-x    2 root     root          1024 Dec 21  2020 speaker-test
> [root@rockchip:/usr/share/alsa]#
> 

Sometimes strace has been of help to me, to see which file is being 
tried to open:

strace aplay -L 2>&1 | grep 'open('

The PCM devices are defined in the pcm/ and cards/ configs, with help of 
/usr/share/alsa/cards/aliases.conf . Maybe for your new driver no config 
is being used, but I think even an unknown card should have the very 
basic PCM devices defined.

Pavel.
