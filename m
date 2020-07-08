Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309A0C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 11:02:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82E22067D
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 11:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BjwjckC7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nf82Y60r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82E22067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 290361678;
	Wed,  8 Jul 2020 13:01:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 290361678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594206166;
	bh=un6ADwbRfMjQVuc3mYG6tna2wmYHv4XhI0/jN5LNpEM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BjwjckC7G97CB6vIxY/lnAXdc1SrbeunycQ/in0DZraVuzXNZuBxVKXyKtxNjcBvP
	 s3sUttlT8Pz7FBTAlDR2JqjfKTI7aq70A/LOieLd03HT5Yuqz2YnLQrZJwJGgaT7/z
	 BMOCvEfsQ1sO6ONm2Ajg+avVDNPKajyODwvVAeCo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B66C2F800AE;
	Wed,  8 Jul 2020 13:01:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09339F8015A; Wed,  8 Jul 2020 13:01:54 +0200 (CEST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2B02F800AE
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 13:01:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2B02F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="Nf82Y60r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594206101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mpwcBcVOqWo2vWhK3ZHzCBKqd/c7GeCFs8iwgkkI1Y=;
 b=Nf82Y60rf7V5IeTSYWrBqHDm/bRBOZnL4xHsPjvYcl24U9ygx7duQr78ucKLycLfnv6AKc
 TFSTNz2iIgIszQRWx/wN/oc/IyeZaOaq3af/Bz4J6x9CBnoGcEo2OTQLcGCHE8W+SZV2ts
 CUWlBaTwrcMRLocyqLAv2gSbmKVWj/4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-gIU9PpB8M6mlm-4McGOD8g-1; Wed, 08 Jul 2020 07:01:37 -0400
X-MC-Unique: gIU9PpB8M6mlm-4McGOD8g-1
Received: by mail-ed1-f72.google.com with SMTP id y92so53942053eda.12
 for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2020 04:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7mpwcBcVOqWo2vWhK3ZHzCBKqd/c7GeCFs8iwgkkI1Y=;
 b=S4WYVBombFjmjawYd9L+zTXGT3QdJLjqBQzlL0YZ/I56hKjBKP8s/GB3bHJWc2jQS0
 SZdewVzKAwW7MapMPYN6UKDJ+Sy3x1bBIC/YiorXGMJCeqOPZH1ExjMeRjq5MpW60YI0
 q1mxMUAEmSktINHtA1GvQOODDMQ+nu99Jyfg3Y0c/vE0fghsvv3zR0KERqZ0uEF9YrjH
 SIugcVNeV3AfLfpeYEXKc9WvYDPNxWL6hhfcfrLu4+z5CiIqCp0R3eHq03nehEQcHk99
 qZ1f0bb2qKRD7nb1/FiiJB/n/g1p0lxzBJF1NJC5nOpGgRHLYkUU7Lhe3z0Dh/AKHo2h
 9Wjw==
X-Gm-Message-State: AOAM5300fQlogOGBPcwUT+sRiPi4JmYxb0vQ6vZYO1NW6S9MIpHXWRbC
 p8DowTUbCAaVt4qlArdOyMu1aXI0p8aGCU4/YidvNxQNRYAgDLFoEH9Rvj+hxXPYACqxTrtZbl6
 ewHooL2Cpvvgs5XTNvjGsnvw=
X-Received: by 2002:a05:6402:543:: with SMTP id
 i3mr45729399edx.182.1594206096308; 
 Wed, 08 Jul 2020 04:01:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQYOwlXd9z9b5GX8vCI0fodR5ilbW7iNNKfVwmUo6weDMlbUb4GtDXfKFHOnZT9ZrFR1YyRw==
X-Received: by 2002:a05:6402:543:: with SMTP id
 i3mr45729373edx.182.1594206096112; 
 Wed, 08 Jul 2020 04:01:36 -0700 (PDT)
Received: from x1.localdomain
 (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
 by smtp.gmail.com with ESMTPSA id dt22sm1881261ejc.104.2020.07.08.04.01.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 04:01:35 -0700 (PDT)
Subject: Re: [PATCH 0/4] crypto: add sha256() function
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20200707185818.80177-1-ebiggers@kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <7b5617f4-905f-5f27-9caf-3c842cbdb0d8@redhat.com>
Date: Wed, 8 Jul 2020 13:01:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707185818.80177-1-ebiggers@kernel.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-efi@vger.kernel.org,
 Tzung-Bi Shih <tzungbi@google.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Guenter Roeck <groeck@chromium.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.01.org,
 Ard Biesheuvel <ardb@kernel.org>, Cheng-Yi Chiang <cychiang@chromium.org>
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

On 7/7/20 8:58 PM, Eric Biggers wrote:
> This series adds a function sha256() to the sha256 library so that users
> who want to compute a hash in one step can just call sha256() instead of
> sha256_init() + sha256_update() + sha256_final().
> 
> Patches 2-4 then convert some users to use it.
> 
> Eric Biggers (4):
>    crypto: lib/sha256 - add sha256() function
>    efi: use sha256() instead of open coding
>    mptcp: use sha256() instead of open coding
>    ASoC: cros_ec_codec: use sha256() instead of open coding
> 
>   drivers/firmware/efi/embedded-firmware.c |  9 +++-----
>   include/crypto/sha.h                     |  1 +
>   lib/crypto/sha256.c                      | 10 +++++++++
>   net/mptcp/crypto.c                       | 15 +++----------
>   sound/soc/codecs/cros_ec_codec.c         | 27 ++----------------------
>   5 files changed, 19 insertions(+), 43 deletions(-)
> 
> 
> base-commit: 57c8aa43b9f272c382c253573c82be5cb68fe22d

I've done some quick tests on this series to make sure that
the efi embedded-firmware support did not regress.
That still works fine, so this series is;

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

