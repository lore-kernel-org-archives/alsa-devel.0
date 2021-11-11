Return-Path: <SRS0=P3rz=P6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B32C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Nov 2021 10:46:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C198961247
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Nov 2021 10:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C198961247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09F741616;
	Thu, 11 Nov 2021 11:45:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09F741616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636627566;
	bh=TaGP01NVDrKhVH208vwmq0y+JniA5BMGFe4pguzkiiM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E/wYyo/EKIadrc3e1T7Qu0WsEVz5xTW0a5mMvASsC7LbAkrF9adC4WeymQtH7RKoK
	 S8REK3+CyRA+JSdlXgb/er5xHOPXvmyJCEvWJBmvtkw1xX/UG4BRbb8IQjiXS9hbzk
	 DpinE0VS17qMlTo4TVGjTxIwniiROM0LWHH8KNV0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A27A6F80224;
	Thu, 11 Nov 2021 11:45:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33C7BF802D2; Thu, 11 Nov 2021 11:45:10 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91C94F80054
 for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2021 11:45:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91C94F80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="ojsvFbhZ"
Received: from [192.168.2.107] (unknown [123.112.64.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DDCCE3F197; 
 Thu, 11 Nov 2021 10:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1636627500;
 bh=J9QfUw4jCDmi68fRkO8PvvtnuTyEgtCvyODN+O2sVi4=;
 h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
 In-Reply-To:Content-Type;
 b=ojsvFbhZ54hYn8tAyvOSjyTh4jF0q3bZdIkVAQ0GismF/p87W+xVCiuwzSjYffhQT
 mSCKsPxvVx71Sfp1DITie9aB7PWCGvuMvn2/2WCpk3Z5dN6eH2EmcJ9KH2ZwA4P2dX
 Pagcp4ivj7aVCFZFB0qx+Bl2gwS29S/k8i5P+TlA7Dn6y9IbZI2UxgB5WlyTgZvcYj
 JiIekcodUnLygaGvrh5iH6M+YOuI1oaHKsm1XVqZOF48QZ5Ujc6Mzx5SpId7tKFqMd
 0wWs5Y6STq/QnMg3+L0GEdoYzrvtIdJQlONiE51YQ3VfDsOw413Tvu6RaWZQ2H7oyf
 GyBtCxEVbzT7w==
Subject: Re: [PATCH] ALSA: usb-audio: add the profile name of Dell desktop
To: =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
 Jaroslav Kysela <perex@perex.cz>, "broonie@kernel.org" <broonie@kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
References: <20211111091914.20917-1-shumingf@realtek.com>
 <7e82a4cd-ed51-e853-7338-eb570c88cb68@perex.cz>
 <3654e59d-52bd-5442-39d1-f017f5a14b2b@perex.cz>
 <7be27e54d3ce41b2ade3e062c939ece2@realtek.com>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <835606a2-586d-c5cb-7aa9-5775d14a4383@canonical.com>
Date: Thu, 11 Nov 2021 18:44:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7be27e54d3ce41b2ade3e062c939ece2@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 =?UTF-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 "Yijun.Shen@dell.com" <Yijun.Shen@dell.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
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


On 11/11/21 6:40 PM, Shuming [范書銘] wrote:
> Hi Jaroslav,
>
>>>>> Add the profile name to let userspace pick correct UCM profile
>>>> It's no longer necessary to force the card names in the drivers. UCM
>>>> can match the USB vendor / device IDs from the 'components' string, too.
>>>>
>>>> I think that we should abandon this way of the UCM configuration
>>>> selection for new devices with device IDs. The kernel already
>>>> exports necessary information to select the right UCM configuration
>>>> in the user
>>> space.
>>>
>>> Untested example:
>>>
>>>
>> https://github.com/perexg/alsa-ucm-conf/commit/74ced65440b5011bbec1680
>>> b2804c8a9c82b5152
>>>
>>> 					Jaroslav
>> Thanks a lot. I will take your example to test.
> I had tested with USB-Audio.conf that the system seems not to apply the UCM config.
>
> The related info of the test machine shows below.
> root@Latitude-5410:/usr/share/alsa/ucm2/USB-Audio# cat /proc/asound/cards
>   0 [PCH            ]: HDA-Intel - HDA Intel PCH
>                        HDA Intel PCH at 0xcc338000 irq 153
>   1 [Rear           ]: USB-Audio - USB audio Rear
>                        Generic USB audio Rear at usb-0000:00:14.0-2.2, high speed
>   2 [FRONT          ]: USB-Audio - USB audio FRONT
>                        Generic USB audio FRONT at usb-0000:00:14.0-2.1, high speed
>
> root@Latitude-5410:/usr/share/alsa/ucm2/USB-Audio# alsaucm --version
> alsaucm: version 1.2.2
>
> root@Latitude-5410:/usr/share/alsa/ucm2/USB-Audio# lsusb
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 002: ID 8564:4000 Transcend Information, Inc. RDF8
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 001 Device 003: ID 0a5c:5842 Broadcom Corp. 58200
> Bus 001 Device 002: ID 0bda:5532 Realtek Semiconductor Corp. Integrated_Webcam_HD
> Bus 001 Device 008: ID 04f3:0235 Elan Microelectronics Corp. Optical Mouse
> Bus 001 Device 007: ID 1c4f:0002 SiGma Micro Keyboard TRACER Gamma Ivory
> Bus 001 Device 006: ID 0bda:4c55 Realtek Semiconductor Corp. USB2.0 Hub
> Bus 001 Device 009: ID 0bda:4c54 Realtek Semiconductor Corp.
>
> May I ask you to give me some suggestions?
Looks like the alsa-lib in the ubuntu 20.04 doesn't support it.
>
