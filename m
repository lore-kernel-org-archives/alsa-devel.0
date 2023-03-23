Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B308C6FD1C
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Mar 2023 01:58:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D10FEEBD;
	Thu, 23 Mar 2023 02:57:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D10FEEBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679536712;
	bh=OliN5SU9p8WB/u3ZBRw6Au/EilEaml/KOeJO/ZVXuUQ=;
	h=From:Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=F0euRDyASuijyYVmzuAi/4AP50A0db/v4m9oN6UqtkFNQO/cf2qYx3nujBQBBvJ3t
	 /v+gCyJ89+kvcRWcow8izGaZ02mCEot0+qWTL7y7/0/rHWMpSv/P8VqkBy2SV6+RQx
	 oCKYPgp/aMv3YxQIK8jquyQrKPbxJfS66vyYmziw=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D1780F8027B;
	Thu, 23 Mar 2023 02:57:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 970D2F8027B; Thu, 23 Mar 2023 02:57:15 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 813C4F80093
	for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2023 02:57:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 813C4F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=Gg47yRo4
Received: by mail-yb1-xb2b.google.com with SMTP id l16so13652115ybe.6
        for <alsa-devel@alsa-project.org>;
 Wed, 22 Mar 2023 18:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679536627;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OliN5SU9p8WB/u3ZBRw6Au/EilEaml/KOeJO/ZVXuUQ=;
        b=Gg47yRo4aboyjGitlgoge2zrj4x7S2XBFTRRS3NW/DORKWY2+Ph6F8MIoCMcn7kNbz
         QUWcKgpBSPH3F/wQGpg4MM8QFc3uFVCtMAKpJz9u9chUqYbnDziXiwWmenHm0zrhH5Js
         btK1JJx2lTJh5AAUrS1+60dEO4Hj5lw/huykP4JSywfh3L0bLx1pycJE2ZaWSY3R6vhM
         7vaIkQ5hHSBDomrp13dkAjpfI+3VYqD9NmZJCdRxnneSBS4w3u0IiLm1rXvt2lxVQG5g
         OTdsTcQHy0jPvqpjAKSwznWNok4OiBjYNCNjbCVqtRRTdnG68U7MskMT8LfX+X19cjgF
         +y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679536627;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OliN5SU9p8WB/u3ZBRw6Au/EilEaml/KOeJO/ZVXuUQ=;
        b=R86GU+7/92QaION56XZniyxNxEn0bA+pcFMdGRopemmILw/69Pk8Jq8jfEoUrXON72
         ZePNUnLMC8n2TOe6vrNlJoCuQ7DM3Dc0d2bHXRq57av5PMTtlSQ/b9yDg3//pSUQrfLF
         fDDpGZTlmVDAg8zjKDGSJ0AchOPrz6npZcP+J8P51fi5DR1gjzmGavwJI807k4irDXC/
         diQQsjG6RqcG9Yxj9SXbfxWIE+GxpvC2KyHT0wlTl3IVwksUMtZ3S1bQsm+HWx08W5H1
         00++VCzsPa+1sbhgMg4iH5PbUuVNYcH36UNc1WActF7zkiZzRhsYJCdeuCBKDZugs6vA
         +jMw==
X-Gm-Message-State: AAQBX9dl2rslfpe4tuj0GNVvEz0rEh8ol9w9Umz5kALT4Fa5aNVUaJlb
	KwuHJljCkD4q63/jSNbKVjnrQWYjH1owfqkZHRg=
X-Google-Smtp-Source: 
 AKy350YBAIl8p0CcAb7DvPvd6SaeANyl6hb7iXj0Hampngqr+Ez263Ws3Q1hcWrUS/SPHGN1gDC0tUJEpw7hHlZU8do=
X-Received: by 2002:a05:6902:1811:b0:acd:7374:f15b with SMTP id
 cf17-20020a056902181100b00acd7374f15bmr1167835ybb.13.1679536627180; Wed, 22
 Mar 2023 18:57:07 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5rKI5LiA6LaF?= <zhuning0077@gmail.com>
Date: Thu, 23 Mar 2023 09:56:56 +0800
Message-ID: 
 <CANPLYpD8Ty9QjMf3vs9n8wCCFyaHiiRpYM-b3kNGiA0r3q+sEg@mail.gmail.com>
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables sound
 for systems with a ES8336 codec
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: PAOBEQWMOG74TBA2MJ7PDH6VY74ZVLAB
X-Message-ID-Hash: PAOBEQWMOG74TBA2MJ7PDH6VY74ZVLAB
X-MailFrom: zhuning0077@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, posteuca@mutex.one, tiwai@suse.com,
 yangxiaohua <yangxiaohua@everest-semi.com>,
 =?UTF-8?B?5rKI5LiA6LaF?= <zhuning0077@gmail.com>,
 Zhu Ning <zhuning@everest-semi.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PAOBEQWMOG74TBA2MJ7PDH6VY74ZVLAB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> > Regarding playing the speaker and headphone simultaneously, is not
> > something I took into account. Is this even a valid usecase? The intel driver
> > for es8336 doesn't seem to support it.
>
> Yes, for example consider a critical notification - the system
> may wish to ensure it is audible even if the user has taken off
> their headphones for some reason.

In practice the speaker and the headphone are conflicting devices, see
https://github.com/alsa-project/alsa-ucm-conf/blob/master/ucm2/Intel/sof-essx8336/HiFi.conf

There is no such situation, and the system doesn't produce sound from speaker
when headphones are plugged in. The user may manually open speaker using
amixer sset 'Speaker' on or pavucontrol.

The GPIO thing on Huawei Intel platform is too complicated, they use two GPIOs
for headphone and speaker, and the headphone GPIO is inverted, which means low
means on and high means off. Luckily there should be only one hardware config
for the AMD acp3x platform GPIO and you may just choose the correct one.
