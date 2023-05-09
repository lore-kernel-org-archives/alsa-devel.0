Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6C2C7EE22
	for <alsa-devel@archiver.kernel.org>; Wed, 10 May 2023 06:35:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE51B1050;
	Wed, 10 May 2023 08:34:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE51B1050
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683700535;
	bh=3pkxi8HnVp4j+GFddUdHqp1l+BbvCyZpqv3R/RwFTcY=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:Cc:From;
	b=Msa/BSyiJVyGmE3/ReHjd3qHSG8NGhVuWXK2AO7uT61VXVOv+abq8m4n6E1W4IL/i
	 B/dbDmiEKc72YcuCttAwYGXRVgT4WaAHmoqPULHU5/EFrs1eBrTw6sZfUzc6D1PpkR
	 KjaLlsEvStlowedeNP90uY97SD8zwjvt/y+D0rLw=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 53CDAF805A9;
	Wed, 10 May 2023 08:32:33 +0200 (CEST)
References: <20230508113037.137627-1-pan@semihalf.com>
 <20230508113037.137627-5-pan@semihalf.com>
 <b8306c55-8551-4c86-f85d-3aebe1ad0ca1@linaro.org>
 <ZFoYai1Zawd4GGtU@finisterre.sirena.org.uk>
In-Reply-To: <ZFoYai1Zawd4GGtU@finisterre.sirena.org.uk>
Date: Tue, 9 May 2023 12:39:31 +0200
Subject: Re: [PATCH v2 4/7] ASoC: dt-bindings: Add Google Chameleon v3 audio
 codec
To: Mark Brown <broonie@kernel.org>
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
X-Mailman-Approved-At: Wed, 10 May 2023 06:32:17 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WQELXFEWVB5RWSTWRTJNTHIYQAZMOP5T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>
MIME-Version: 1.0
Message-ID: 
 <168370035179.26.4813933196889513475@mailman-core.alsa-project.org>
From: =?utf-8?q?Pawe=C5=82_Anikiel_via_Alsa-devel?=
 <alsa-devel@alsa-project.org>
Reply-To: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
 lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
 amstan@chromium.org
Content-Type: message/rfc822
Content-Disposition: inline

Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 92192F8032D; Tue,  9 May 2023 12:39:49 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on alsa1.perex.cz
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.6
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 525F2F80087
	for <alsa-devel@alsa-project.org>; Tue,  9 May 2023 12:39:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 525F2F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=semihalf.com header.i=@semihalf.com header.a=rsa-sha256
 header.s=google header.b=X+rZIzKP
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-50bc570b4a3so10653747a12.1
        for <alsa-devel@alsa-project.org>;
 Tue, 09 May 2023 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1683628782; x=1686220782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRU5PEt+oDmkOJvCwl4AyqNhX/jjlVJcC8ztVdTKQLE=;
        b=X+rZIzKPdMbSlBMThdYfAojZTGhcsUbH9SWbS0mPquMKSXjX3kEtZ+AqsebDyh9xaW
         lE0GJl13J0k49ij3784AOfGHEhBxqujNOV0kvuvfZJjIkaUQOgJutt/4m1iCNvg8jFj3
         8Mu0H8hPnQmC4hiKwlnrKHAmAkvwgZfdGbd9xwQ7bsR8F/JzpI3Tyk7jUt6MfeYp4kbU
         IidhgNrwy93u5zMw8bN3Dl9KLC3fObB9FPjP8zLXTEPoODpGUeD0D7WYqZpkU5fqQIRQ
         KNVpTGiSxyhwmPa5wDelpGQYZ/XivJoLXWJmN/4s+n31zNAdoMCiHmHWFqy9yQ5E9yhj
         SBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683628782; x=1686220782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRU5PEt+oDmkOJvCwl4AyqNhX/jjlVJcC8ztVdTKQLE=;
        b=ahMQGeitx1/6z/iA+xUceMIFIK5V3CFPlK0OinlIxo3i6VZHXLIDFNCbOOgCEJ8zrO
         tu1NP/et//b/Rha/R28psk9ovopw+yOmb+KO7rnjz3pYJMrDjEMpi4tWVie85zwVqOxL
         Md1YfT97TeZl1MoV4RfE4caV9JY0VOxV+VeoH4AOOnPwifQc49samiLBF2wwuP5ODKCV
         SPRoqD7aGP7uDQnpMD/KqkcKWgIWAUOov8ACUlBemvf+BU6tixnPueK/7bfQPy+VliJh
         B4R+ZZOKOdGof3ynEUqwW1umD004VYZazaE5S1dAkXEjZulnvYqea5Vw7WLaJ0cX2S18
         U7eQ==
X-Gm-Message-State: AC+VfDybxt4HECM/c6EtjvfwZKyFyLKz70ArTgPUBgm8GDdgJegyKHTG
	5HRzADbV1VElMrMt+d4I6LlYcB9/6JvKgN0bDS/mEw==
X-Google-Smtp-Source: 
 ACHHUZ5X1A7lGSzOUQocjKDUPJO/UZV85RYU+AZC28CWaOm5bVpor/ag+VkqoWqHXFa5J7LyWaMGHQcKCW2raQWEHoo=
X-Received: by 2002:a17:907:1c03:b0:94e:4489:f24d with SMTP id
 nc3-20020a1709071c0300b0094e4489f24dmr11943775ejc.61.1683628781939; Tue, 09
 May 2023 03:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230508113037.137627-1-pan@semihalf.com>
 <20230508113037.137627-5-pan@semihalf.com>
 <b8306c55-8551-4c86-f85d-3aebe1ad0ca1@linaro.org>
 <ZFoYai1Zawd4GGtU@finisterre.sirena.org.uk>
In-Reply-To: <ZFoYai1Zawd4GGtU@finisterre.sirena.org.uk>
From: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Date: Tue, 9 May 2023 12:39:31 +0200
Message-ID: 
 <CAF9_jYSXxmnm80Yq4gD6U5ygHvBTDagR_HM4LcHQT1vq=d7tVw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] ASoC: dt-bindings: Add Google Chameleon v3 audio
 codec
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: pan@semihalf.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: WQELXFEWVB5RWSTWRTJNTHIYQAZMOP5T
X-Message-ID-Hash: WQELXFEWVB5RWSTWRTJNTHIYQAZMOP5T
X-Mailman-Approved-At: Wed, 10 May 2023 06:32:17 +0000
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
 lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
 amstan@chromium.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WQELXFEWVB5RWSTWRTJNTHIYQAZMOP5T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, May 9, 2023 at 11:54=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, May 09, 2023 at 08:18:15AM +0200, Krzysztof Kozlowski wrote:
> > On 08/05/2023 13:30, Pawe=C5=82 Anikiel wrote:
>
> > > +  "#sound-dai-cells":
> > > +    const: 0
>
> > No supplies? How do you get power?
>
> My understanding is that this is deployed to a FPGA so the power would
> be going into the FPGA.  In general a memory mapped I2S controller like
> this will be part of a larger SoC of some kind.

Yes, both the codec and i2s controller are implemented in the FPGA
part of the Arria 10 SoC.

Regards,
Pawe=C5=82
