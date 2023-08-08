Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED866C001DF
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Aug 2023 10:43:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 414B5EA1;
	Tue,  8 Aug 2023 12:42:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 414B5EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691491420;
	bh=G0JGoL/rMNRUtDqtTifRpYE2RlmXvngvcsipnYYMJRM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PQBQbHPiPvKxWIPQ4A/o9vNr5CZg4PdzvXwaBjOyXGNiKxX13A2IylyqRlQBmI2n+
	 R8czmtz+IspYwaMKhmxBhEC8r1e7o/A5FF+IInLSine7uWkHeUIOt/T8onhHlERIMs
	 dltVHxRJcOCl3+pGGfmnevWVD4De2sM7kXLmXJuU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0AE2EF806AF; Tue,  8 Aug 2023 12:36:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F787F806AF;
	Tue,  8 Aug 2023 12:36:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 85271F80549; Tue,  8 Aug 2023 09:50:08 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 26D71F80544
	for <alsa-devel@alsa-project.org>; Tue,  8 Aug 2023 09:50:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26D71F80544
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=daynix-com.20221208.gappssmtp.com
 header.i=@daynix-com.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=Mkj09u9b
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bb9e6c2a90so47065585ad.1
        for <alsa-devel@alsa-project.org>;
 Tue, 08 Aug 2023 00:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691481004;
 x=1692085804;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5gVaSTYejp99j2UgPSGmR/5wX1Q1ia2oLZnesCpWyfk=;
        b=Mkj09u9bcVbsCucPmPddVcFJ5hivx1RdNSIbYfNCkNhq3dAtuTsUtqmegXzUQ5vmC1
         qG4nmxZSfvwjAsA/nVPlR1HaeOw5yfH424ZaAaKf4ZrvzM51eOz2Wg3dJeFeM+z0U6L7
         Lwzft25xYUixVjTAG+15A5vESIFyNVhSVUJ9sLglcE67kAg8/E7xU5lndq/0fKGBEQt2
         ApIFCigtun01oYO51ilCsXcui/nM9fNdw8SkRriEKEVqhGCfVdL/lMENHS1y+QVHWqKy
         FV7IqnaxcAPW029SdYHHkaLaN+FMaGatafaGJQywMqk+JKQCsz9AnU1HuoVsgd69eZJX
         hbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691481004; x=1692085804;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gVaSTYejp99j2UgPSGmR/5wX1Q1ia2oLZnesCpWyfk=;
        b=E7OlNNY+yKNn0GvajlzoIoY01n/xDfmeOZWGGeDTng7jUJTzgdnkyVmrVBcn77v9OT
         ApQiSp7iCDKAUn9QqqTVgq8qfSYIXjoaNaHi9anC7rziGt6mN0pO1EdS2QtPdpVI8SHO
         OIC65+ZKBmSYv++bgxRnOcGZ1uduKAXtJQV9Qs9MPXTtFBe8wVZVFR6TG25fNL5eESvD
         VFv3PNL68vE3KnlzPQK/fTMXfuG63F0YhxKlefAhvSnOALTEPjxCV7EnRUy5gx0gTbHE
         KhLyzwyWTmllUC4PsE1EE529y5K5WNTVR90/avmEeYH1gnVricAiuPFWm4fr1rwvbNrX
         52rQ==
X-Gm-Message-State: AOJu0Yx8YnzbMbm2cbIuE1X+TBo3PFW65vtgrNW7Cy9QbF8I87VPz7r9
	HGOEFT6Zt7OIO5dJeQHjcRsx2v6eseSVh+wDgPw=
X-Google-Smtp-Source: 
 AGHT+IFAVyiXcimI9tXWuEj4R9mV4WwBOWaAXHFFMihxNpDn6eurFOXPD6dXxTtApytWiEcQwiKdmw==
X-Received: by 2002:a17:902:e546:b0:1b8:a697:3719 with SMTP id
 n6-20020a170902e54600b001b8a6973719mr14036571plf.25.1691481003938;
        Tue, 08 Aug 2023 00:50:03 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id
 a7-20020a170902ecc700b001bba7aab822sm8261067plh.5.2023.08.08.00.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 00:50:03 -0700 (PDT)
Message-ID: <bbf345f8-3476-4b0f-ab79-0cab3db73472@daynix.com>
Date: Tue, 8 Aug 2023 16:50:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH] ASoC: amd: acp3x-rt5682-max9836: Configure jack as not
 detecting Line Out
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
References: <20230805162216.441410-1-alpernebiyasak@gmail.com>
Content-Language: en-US
In-Reply-To: <20230805162216.441410-1-alpernebiyasak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: akihiko.odaki@daynix.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: IMBX6XRBOB7QJ4INVN36XPPDK6RX3ZBT
X-Message-ID-Hash: IMBX6XRBOB7QJ4INVN36XPPDK6RX3ZBT
X-Mailman-Approved-At: Tue, 08 Aug 2023 10:36:35 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IMBX6XRBOB7QJ4INVN36XPPDK6RX3ZBT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 2023/08/06 1:22, Alper Nebi Yasak wrote:
> The RT5682, RT1015 and RT1015p codecs used in this driver do not seem
> capable of distinguishing Line Out connections from Headphone, but
> the driver configures its jack object as if it can. Remove the wrong
> value from the jack creation call to avoid any confusion.
> 
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
