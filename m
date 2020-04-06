Return-Path: <SRS0=9St4=5W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B614C2BA1E
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2020 12:14:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B66320678
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2020 12:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YG9z03PS";
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlcIYXZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B66320678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46FA9822;
	Mon,  6 Apr 2020 14:14:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46FA9822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586175296;
	bh=Q7jNlvM7uMOnr6p4bHIixma2wZxlbIRNdkxdy8Ay/5Y=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YG9z03PSRNTZ+YYZa2f9LcmtKCmFY2up4GxAGStq4SJSOYR3BD6O953tWw833xcBi
	 DlIEoPr+d5iaXKZMnSNDCSVkuy0hB79L16JUjxCvSmBwcPmP1bnZImejbHaQemLV1F
	 jnE3V87ou+PYECg3xYKTCnfBU4CjJW8pLoy1LRAc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5036F80140;
	Mon,  6 Apr 2020 14:14:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28BB7F80142; Mon,  6 Apr 2020 14:14:04 +0200 (CEST)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E494CF80140
 for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2020 14:13:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E494CF80140
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="XlcIYXZW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586175238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOnCN2dDdbxaf+mvUyjPZb3wQdzWE3NtfGSL7xYH0g4=;
 b=XlcIYXZWwVTQsAC7GSII3p1F5W1YR3hpJ+3n7TfMPBkBZjOQnqdkPV+bEZ4a0BfxtUoRAN
 KhobZXJNLJUWqZnN/9QJF7SHbAWuDXlo0RbenNsUju1badlNAfZloq0roCjKTI3sBHtOEg
 pV/SD8mYtGLW03wkUQ6fnwLJwFLcCfs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-Hq8qv_mUN-CbgG-xh74oRA-1; Mon, 06 Apr 2020 08:13:55 -0400
X-MC-Unique: Hq8qv_mUN-CbgG-xh74oRA-1
Received: by mail-wm1-f70.google.com with SMTP id s9so4833242wmh.2
 for <alsa-devel@alsa-project.org>; Mon, 06 Apr 2020 05:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bAi29GbZJLxMlrOaLML+1Bbop6TFWW26NteweWs5OvI=;
 b=j1GQc5YMbAe/e1Db3c6oSD5WNGdsl18GAfj/3sjhbbgC/llfFFbK3DbrVSL2Js0SUl
 2xiT/TrYGjkLqwS2gUDAY6/mQj8YvH68f2NI5A5nMnmGeMIbPJafhyL+Z9ntM3g8Ej1c
 hPRq5I9Ce30S1J829ySywC4pb+mY3c5gBD0Fvsk5utR7O7tpLkouNvZOwDbkzhmqGyt0
 hShtZCB6wkEUSRtwlgwPuKfmOitPGD2x0MzBxYaC4ZbdJkzdxnS/zo1XsmdBAs4BqwWh
 KQo98PBSoXfaHmu2hBQG/CfaqJS6i3QZmEwBY9zHvhMiEEvY3ArDmmYYUhBGXuVhYgtR
 V+Pg==
X-Gm-Message-State: AGi0Puagqej1a3OYOzOm+E/sH4gvsOO1TJhfia5tT+1P1efNAQnBquyW
 YYUfUOYdb0oyPd6J+/D/NT13O927QIZwB7ykk7IYrM2LxC0+AysB8VZDMBo+IHlbNcjwHPs7PX2
 bFrddW1lm1moXWg+2bF83K50=
X-Received: by 2002:adf:81b6:: with SMTP id 51mr17129461wra.229.1586175234053; 
 Mon, 06 Apr 2020 05:13:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypJE5ZUgLJ7WYXqulybBpA8cvnFHK+6oi1OYAUW1tmCUmzqU8ZWHKxfd7aJ2SM2oY4ENLTAOFw==
X-Received: by 2002:adf:81b6:: with SMTP id 51mr17129446wra.229.1586175233787; 
 Mon, 06 Apr 2020 05:13:53 -0700 (PDT)
Received: from x1.localdomain
 (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
 by smtp.gmail.com with ESMTPSA id y22sm7776738wma.0.2020.04.06.05.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 05:13:53 -0700 (PDT)
Subject: Re: [PATCH 5/5] cht-bsw-rt5672: Fix HiFi-stereo-dmic2 conf not
 loading / working
To: Jaroslav Kysela <perex@perex.cz>
References: <20200405183454.34515-1-hdegoede@redhat.com>
 <20200405183454.34515-5-hdegoede@redhat.com>
 <1e466650-dc6f-4757-a36b-6f32639e99be@perex.cz>
 <08414d2b-0498-4e38-3178-b7549d6534ff@redhat.com>
 <39890bf8-a247-9e00-a842-84a07fec5a99@perex.cz>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <7ea2a4f9-060b-99ea-ddde-90cb8f1c8be2@redhat.com>
Date: Mon, 6 Apr 2020 14:13:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <39890bf8-a247-9e00-a842-84a07fec5a99@perex.cz>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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

Hi,

On 4/6/20 1:28 PM, Jaroslav Kysela wrote:
> Dne 06. 04. 20 v 11:50 Hans de Goede napsal(a):
>> Hi,
>>
>> On 4/6/20 11:34 AM, Jaroslav Kysela wrote:
>>> Dne 05. 04. 20 v 20:34 Hans de Goede napsal(a):
>>>> Fix HiFi-stereo-dmic2 conf not loading because of references to
>>>> non existing devices in the ConflictingDevices sections.
>>>>
>>>> Stop playing Rename + Remove tricks with the output (Speaker2) and
>>>> input (DMIC1) devices which we do not want to be part of this config,
>>>> this does not work now that we only allow devices which are actually
>>>> part of our config in the ConflictingDevices sections.
>>>
>>> The Remove and Rename operations should also manage (remove and rename)=
 devices in ConflictingDevices/SupportedDevices sections. What's the exact =
error you hit?
>>>
>>> If I simulate this via ucm-validator I get this device structure:
>>>
>>>    =C2=A0Verb: "HiFi"
>>>    =C2=A0=C2=A0=C2=A0 File: HiFi-stereo-dmic2.conf
>>>    =C2=A0=C2=A0=C2=A0 Device: "Headphones"
>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ConflictingDevices.0 =3D Speaker
>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Value.PlaybackPriority =3D 300
>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Value.PlaybackPCM =3D 'hw:${CardId}'
>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Value.JackControl =3D 'Headphone Jack=
'
>>>    =C2=A0=C2=A0=C2=A0 Device: "Headset"
>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ConflictingDevices.0 =3D Mic
>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Value.CapturePriority =3D 300
>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Value.CapturePCM =3D 'hw:${CardId}'
>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Value.JackControl =3D 'Headset Mic Ja=
ck'
>>>    =C2=A0=C2=A0=C2=A0 Device: "Speaker"
>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ConflictingDevices.0 =3D Headphones
>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Value.PlaybackPriority =3D 200
>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Value.PlaybackPCM =3D 'hw:${CardId}'
>>>    =C2=A0=C2=A0=C2=A0 Device: "Mic"
>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ConflictingDevices.0 =3D Headset
>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Value.CapturePriority =3D 200
>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Value.CapturePCM =3D 'hw:${CardId}'
>>>
>>> It appears like an issue in alsa-lib.
>>
>> With an unmodified UCM2 profile I get the following:
>>
>> [hans@localhost ~]$ alsaucm -c cht-bsw-rt5672 set _verb HiFi set _enadev=
 Speaker
>> ALSA lib parser.c:1138:(verb_dev_list_add) error: unable to find device =
'Speaker2'
>> ALSA lib parser.c:1433:(parse_verb_file) error: device management error =
in verb 'HiFi'
>> ALSA lib main.c:962:(snd_use_case_mgr_open) error: failed to import cht-=
bsw-rt5672 use case configuration -2
>> alsaucm: error failed to open sound card cht-bsw-rt5672: No such file or=
 directory
>>
>> Note the _enadev does not matter, things break before it gets parsed,
>> if I replace Speaker with XXX I get the exact same errors.
>>
>> I'm happy to try any alsa-lib patches on this (Thinkpad8) hw for you.
>=20
> I think that I found the culprit. Could you test this, please?
>=20
> https://github.com/alsa-project/alsa-lib/commit/c9605484d165d2b707f78eef1=
4a224b0b47ba322

I added that patch to the alsa-lib-1.2.2 package, did a build and
installed it, unfortunately it does not help:

[hans@localhost ~]$ rpm -q alsa-lib
alsa-lib-1.2.2-1.hdg1.fc33.x86_64
[hans@localhost ~]$ alsaucm -c cht-bsw-rt5672 set _verb HiFi set _enadev Sp=
eaker
ALSA lib parser.c:1138:(verb_dev_list_add) error: unable to find device 'Sp=
eaker2'
...

Regards,

Hans

