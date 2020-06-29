Return-Path: <SRS0=wrte=AK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D08C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:09:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF5823D4E
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="D2Twgy2E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="MO/MX9n5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="bgiJiQnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF5823D4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABEB084C;
	Mon, 29 Jun 2020 17:08:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABEB084C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593443380;
	bh=CB5P5bMWCWR7TxUAuxiLdWMc2z5AtMS4kCAZsTx45Xs=;
	h=Subject:From:To:References:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D2Twgy2EbqoqEurbLE4/p8u1SyCTbFWLNGU3pufz7AkFItFAc/8DxjFS8C4qJyLqq
	 jNbrT6XKp1x+hNM6Op9RaZtsDeJT3ob2o48Y2mRJwNtsdOlbN0SYJqC9rETvahQkL3
	 XB8lghPV53J3UvOUdhrqSmKDA8EzyYV1pS8iZOcw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 410E5F8020C;
	Mon, 29 Jun 2020 17:08:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B984F80217; Mon, 29 Jun 2020 17:08:48 +0200 (CEST)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C272EF800EA
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2020 17:08:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C272EF800EA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="MO/MX9n5"; 
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="bgiJiQnB"
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id 84BB5A1F42AEE
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2020 17:08:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1593443322; bh=CB5P5bMWCWR7TxUAuxiLdWMc2z5AtMS4kCAZsTx45Xs=;
 h=Subject:From:To:References:Date:In-Reply-To:From;
 b=MO/MX9n5uUe/n70D+EN73Nbeqcua0tB0pkUgHmSUhxpyaSnwGeWP53L2m9vkDO718
 2PLKN3T7twTx+f2ydGNCXAljuIBGIBxiCILXnqoQyjqD7GKNWFlXbk4lYcFmiFZDCE
 aRDlSGqxItRoylZ+peTFeH+u8Ncq2ClJ4TCzN9xs=
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nQqzlFEqMPbF for <alsa-devel@alsa-project.org>;
 Mon, 29 Jun 2020 17:08:37 +0200 (CEST)
Received: from [192.168.105.151] (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id EA532A1F3D0C2
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2020 17:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1593443317; bh=CB5P5bMWCWR7TxUAuxiLdWMc2z5AtMS4kCAZsTx45Xs=;
 h=Subject:From:To:References:Date:In-Reply-To:From;
 b=bgiJiQnB3GqOex+deMZPKlrLqtS4DkRzPT77sc1B5W3gwMKuJGWDWpHyESu29qXBh
 /tDqs18WUsZRyILebJNG/c/7akdPGpDFE//3mpQbuANwMQKmqgHF+17apCzSapxJHO
 nAe7d+O4l2L7nfIcg9AXGE8W6FulPfH7hJUbJJCo=
Subject: Re: Ignored USB-audio implicit feedback in kernel 5.8rc3
From: Pavel Hofman <pavel.hofman@ivitera.com>
To: alsa-devel@alsa-project.org
References: <5be78c36-bca0-da9c-43ec-2e2a538948a8@ivitera.com>
Message-ID: <51a129ba-d74f-bfe3-933c-4805bc87804a@ivitera.com>
Date: Mon, 29 Jun 2020 17:08:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5be78c36-bca0-da9c-43ec-2e2a538948a8@ivitera.com>
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

Dne 29. 06. 20 v 13:28 Pavel Hofman napsal(a):
> 
> Audio analyzer RTX6001 (XMOS-based) is using implicit feedback, yet the
> feedback is not used by the latest kernel 5.8 rc3 (i.e. already with the
> latest implicit-feedback patches).
> 
> Two analyzers on two different PCs are getting clicks in duplex-mode
> loobpack, one every 10 secs, the other one every 50 secs.
> 

I am sorry, correct stream0 for duplex operation (kernel 5.4, the same
behaviour as in 5.8-rc3):

RTX A/S RTX6001 USB Audio 2.0 at usb-0000:00:13.2-4, high speed : USB Audio

Playback:
  Status: Running
    Interface = 1
    Altset = 1
    Packet Size = 72
    Momentary freq = 48000 Hz (0x6.0000)
  Interface 1
    Altset 1
    Format: S32_LE
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 44100, 48000, 88200, 96000, 176400, 192000
    Data packet interval: 125 us
    Bits: 32
  Interface 1
    Altset 2
    Format: S32_LE
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 44100, 48000, 88200, 96000, 176400, 192000
    Data packet interval: 125 us
    Bits: 24
  Interface 1
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 44100, 48000, 88200, 96000, 176400, 192000
    Data packet interval: 125 us
    Bits: 16

Capture:
  Status: Running
    Interface = 2
    Altset = 1
    Packet Size = 72
    Momentary freq = 48000 Hz (0x6.0000)
  Interface 2
    Altset 1
    Format: S32_LE
    Channels: 2
    Endpoint: 1 IN (ASYNC)
    Rates: 44100, 48000, 88200, 96000, 176400, 192000
    Data packet interval: 125 us
    Bits: 32
  Interface 2
    Altset 2
    Format: S32_LE
    Channels: 2
    Endpoint: 1 IN (ASYNC)
    Rates: 44100, 48000, 88200, 96000, 176400, 192000
    Data packet interval: 125 us
    Bits: 24
  Interface 2
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 1 IN (ASYNC)
    Rates: 44100, 48000, 88200, 96000, 176400, 192000
    Data packet interval: 125 us
    Bits: 16

Thanks a lot.

Pavel.
