Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F142EB64D9
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Jul 2023 07:57:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7AFBB210;
	Tue,  4 Jul 2023 09:56:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7AFBB210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688457436;
	bh=rYGRyJNHHXQ7oymock8xOkHIzpAdqjkA0dU69O2LoWM=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Icjqne+1qfblwB7cQkBuHhuDPDOcVJA8lC5Cd4f+VKIBNtEG2ozP4eOJ/Ct95U3la
	 BSVVx+oCSb51RO9/xWzfFing1aVUMt8bTSQZRHgk8HXWytfRXnVcMGiNCP5NFItSWP
	 C5gg5PW3ECQczFpU5xV/cL/E2ck3F+w5RaqaEUnE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C57F7F8053B; Tue,  4 Jul 2023 09:55:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 587E4F8053B;
	Tue,  4 Jul 2023 09:55:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 41CD8F80124; Mon,  3 Jul 2023 16:18:38 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 81018F80100
	for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2023 16:18:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81018F80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=fetSxyhg
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fa9850bfebso46156945e9.1
        for <alsa-devel@alsa-project.org>;
 Mon, 03 Jul 2023 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688393912; x=1690985912;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxB5kQuGTUex9qgEMykoEN13WoS4AeEsCPhxBgnGUm8=;
        b=fetSxyhgO9GgsrU43Q+X6DGKLQ6PnI539bmAxdU04I2Rs0l4v3G92WlCehgdlrxcEE
         tQoG+6Asflp0Fyor0XWGu96466Fc6bqrpPwULNFn2hk8XmTpA1UgwCeAgmwCCJqJNvGL
         +i0PAbNJGHO9MWfVeI/E/ihPuUzV/7/w0kLoe2mmZ1VsNpBKxehQTCxGY0FpxcMKZZ15
         OJamWz1R1k7Luko9OU/C6l3lRyJgIUQp24AO4i3ukn5/wrhvVCWSHo7UIEUsksIWg+Hd
         Aw4Rd0f/Q4UYWuvYTc4HSHY7X/V/IlNQbivC40vHdXNX+xWRyNiy6s/Pp+lDKrP1a+QJ
         evMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688393912; x=1690985912;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxB5kQuGTUex9qgEMykoEN13WoS4AeEsCPhxBgnGUm8=;
        b=ELLnOqCqOnrsqzmzhzWBjwjpDaAZy2iw4tT5dPOp6aByhScunmVbX7WA6bW1xCB1D3
         GSPPWZ5K7DqUUt1ix+5KabhiePACV+Ujehz8ANDNyYovgCVb/AmC1HDLjwdFnR2GgVrd
         3mbbKxGiBmPK2CTlA0zFJTtyqbZz4p47nbzV9fh23zSp0KhefiNe/xAmoXPzNtij8gul
         vwGtp2DACorl2JZeyYz7EjLtYarcmmtMOdqgwzCG1ru0qfltFcDpOugOyHHNKrJXRAMi
         9goroKh3onUk3/JmlRcYztVl2hYLQvT/svat8ee17eYH98EC32kZ8pUjsSpsCeKyzsq0
         siXg==
X-Gm-Message-State: AC+VfDxceqBmBIWcucZ2U+Gv4xCTt6PPwYXBxF2SmBvs8NXxpV9/kccw
	z8eYV4Amm6QfsEL219/kEsbyhg==
X-Google-Smtp-Source: 
 ACHHUZ4CeqsYD+kGlTx0UpeZLkUbvtru8rqzWMLlIOVRvaVfLR1NSaJZrifOoQx1XHGsRkhc7NUAqg==
X-Received: by 2002:a1c:f70a:0:b0:3fb:c060:8b3d with SMTP id
 v10-20020a1cf70a000000b003fbc0608b3dmr7813252wmh.40.1688393912291;
        Mon, 03 Jul 2023 07:18:32 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id
 f10-20020a7bc8ca000000b003fbad1b4904sm15869915wml.0.2023.07.03.07.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 07:18:31 -0700 (PDT)
Date: Mon, 3 Jul 2023 17:18:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: amadeuszx.slawinski@linux.intel.com
Cc: alsa-devel@alsa-project.org
Subject: [bug report] ALSA: jack: Access input_dev under mutex
Message-ID: <cf95f7fe-a748-4990-8378-000491b40329@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-MailFrom: dan.carpenter@linaro.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: BISISR5RWKP6MHRUQNK6P2LRAWDWHE3R
X-Message-ID-Hash: BISISR5RWKP6MHRUQNK6P2LRAWDWHE3R
X-Mailman-Approved-At: Tue, 04 Jul 2023 07:55:35 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BISISR5RWKP6MHRUQNK6P2LRAWDWHE3R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello Amadeusz Sławiński,

The patch 1b6a6fc5280e: "ALSA: jack: Access input_dev under mutex"
from Apr 12, 2022, leads to the following Smatch static checker
warning:

	sound/core/jack.c:673 snd_jack_report()
	warn: sleeping in atomic context

sound/core/jack.c
    663         jack->hw_status_cache = status;
    664 
    665         list_for_each_entry(jack_kctl, &jack->kctl_list, list)
    666                 if (jack_kctl->sw_inject_enable)
    667                         mask_bits |= jack_kctl->mask_bits;
    668                 else
    669                         snd_kctl_jack_report(jack->card, jack_kctl->kctl,
    670                                              status & jack_kctl->mask_bits);
    671 
    672 #ifdef CONFIG_SND_JACK_INPUT_DEV
--> 673         mutex_lock(&jack->input_dev_lock);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

That patch adds this mutex but we can't take mutex because we're already
holding a spinlock.  The problematic call trees are:

virtsnd_event_notify_cb() <- disables preempt
virtsnd_disable_event_vq() <- disables preempt
-> virtsnd_event_dispatch()
   -> virtsnd_jack_event()
      -> snd_jack_report()

The virtsnd_event_notify_cb() and virtsnd_disable_event_vq() functions
take the spin_lock_irqsave(&queue->lock, flags);

regards,
dan carpenter
