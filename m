Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72463C25B67
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Oct 2023 16:22:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A73D9E72;
	Thu, 26 Oct 2023 18:21:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A73D9E72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698337353;
	bh=PSBsHwPaPrIwGYV533W2QbyJ5sfH5vf3/0lxi8abbZI=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=RmotcX4XWccs3k4MYHd1dpf4PUmLSkPBa3CDL+OvmEnYB8y+F9hSBhW4z1NdArb/I
	 U9xW/E2b3n0w19qaywwjwliz9DsTKgrHEiV/zagiAwTRuZGtOZXeTVOep5BSH5H9MA
	 MtdxAAPyumCViI7sNC0ZW7Js2sx+pDJ+cn0jwnZc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09525F805C0; Thu, 26 Oct 2023 18:20:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 180FAF80567;
	Thu, 26 Oct 2023 18:20:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 45060F80165; Thu, 26 Oct 2023 07:21:00 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 76FD4F80152
	for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2023 07:20:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76FD4F80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WWwtvS6h
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32dff08bbdbso336239f8f.2
        for <alsa-devel@alsa-project.org>;
 Wed, 25 Oct 2023 22:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698297650; x=1698902450;
 darn=alsa-project.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hoP3vnLlfkIipbfKT/Q7LlQsP5Fq29mTmjFJg5eT+l0=;
        b=WWwtvS6hIaPEaMKn33nWWDEYYirZtPjLur4H8yaKgaCI5MvI2iDhYB3R9y98F8kePL
         /m1Zx5+Gq4hvzn1H9bvV9lmc3kzxPlFs2FGfH6Q9NKEgA3mwXeQoOFMqijTZ26/GXZW0
         NtQste44SH3Wc/KX/FuoIL5fbO5biyV8UMptY+uIvPPwv+gc0r+2SNosawVb2AWvBfq1
         jJ8T7yQxeDxdT2Ifx1CAWj7wA/XrQ2OEF81wPQ8MATDDA1UDghNaNBD6QJQO/FsN+vbf
         mghpQnvKl3paesGxlVBBl2WFy7LdJUQqAbmKrWUOSUwK1abPQJZXtcZM1em7bNWLs0NO
         ZOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698297650; x=1698902450;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hoP3vnLlfkIipbfKT/Q7LlQsP5Fq29mTmjFJg5eT+l0=;
        b=Y2veYoe1UaSRKYGFJk4zyksC6OHiPfiGWP3ZvXjqiEkPqgO3XEoHQocTC21FfJL7P5
         DNsy+TE2us42TOITQCGoUI3gGndvMefNfr5dDP2xUUc3Ody5F1ZTaxmPLM3HI/pDt+GE
         /GlIXZOGQCUbaWh4fF2+3GmDpcClEwcorW0jXDRKOrpAgkA05SY18WZyF6EYmtu66LJn
         qlNXOmKgjv1Idkfnmk5N65HMfAD2SC5LnQU4VR1ZqtDqlxVKHPYiCTKKfrj8t0NnbM9Z
         Z8HcZO3eUuvaUvN/4gWrNcBWM0lnptS8DmYTTvkQ2rsLrAB6R40byPzeDv5fzvYLddHB
         e/UA==
X-Gm-Message-State: AOJu0YzFtaKXZWM/S+zLxqAFqxSOcPX6PNadG67sauVM+TB8qWPzj74Q
	81xMqjH+T10SDA5P3AISYoec5dD9DEhRXkVv5LM=
X-Google-Smtp-Source: 
 AGHT+IHXMt3vZbSisgx5biH+EvaY333Dzg3s6Z4sBHgbE9UBgf/2nfyW5P6IRrjM1WM3X/OwmyZzxw==
X-Received: by 2002:a05:6000:108:b0:32d:9b80:e2c6 with SMTP id
 o8-20020a056000010800b0032d9b80e2c6mr11878546wrx.26.1698297650469;
        Wed, 25 Oct 2023 22:20:50 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id
 g17-20020a5d5551000000b0032cc35c2ef7sm13399642wrw.29.2023.10.25.22.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:20:50 -0700 (PDT)
Date: Thu, 26 Oct 2023 08:20:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org
Subject: [bug report] ASoC: cx20442: replace codec to component
Message-ID: <3e608474-e99a-4866-ae98-3054a4221f09@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-MailFrom: dan.carpenter@linaro.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 6FMQFODWO432KZEODVGSMIFM623L4NKZ
X-Message-ID-Hash: 6FMQFODWO432KZEODVGSMIFM623L4NKZ
X-Mailman-Approved-At: Thu, 26 Oct 2023 16:20:50 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6FMQFODWO432KZEODVGSMIFM623L4NKZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

[ I don't know why I am seeing warnings from 2018 today.  Also this
  patch didn't really introduce the bug, it's just the variables were
  renamed. -dan ]

Hello Kuninori Morimoto,

This is a semi-automatic email about new static checker warnings.

The patch d0fdfe34080c: "ASoC: cx20442: replace codec to component"
from Jan 29, 2018, leads to the following Smatch complaint:

    sound/soc/ti/ams-delta.c:311 cx81801_close()
    warn: variable dereferenced before check 'component' (see line 304)

sound/soc/ti/ams-delta.c
   303		struct snd_soc_component *component = tty->disc_data;
   304		struct snd_soc_dapm_context *dapm = &component->card->dapm;
                                                    ^^^^^^^^^^^^^^^^^^
Dereference.

   305	
   306		del_timer_sync(&cx81801_timer);
   307	
   308		/* Prevent the hook switch from further changing the DAPM pins */
   309		INIT_LIST_HEAD(&ams_delta_hook_switch.pins);
   310	
   311		if (!component)
                    ^^^^^^^^^^
Check for NULL is too late.

   312			return;
   313	

regards,
dan carpenter
