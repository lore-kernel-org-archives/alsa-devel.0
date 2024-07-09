Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE723C3DA4B
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:30:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 821EBA4B;
	Wed, 17 Jul 2024 11:30:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 821EBA4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1721208631;
	bh=QL6vfS7t2ZXZBqDE+w38HqrlAOgIQ5D/Jl7C3qGdIq0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=i+ashztsHNeE6CdYwl5PNcD8oJdC4KLadiR5rgpnDI27R3XOfBxHNCprYOCehu7Zc
	 GSQ0W/Nd5ftcuJOF0JaayLBV8/6Ptcr5uz6l2WIYFukes+VCFluf4KfGMgiV2BBjoy
	 ajtt4wTuNU4kpuRcFUqSaOEHwEa0/tH0yIw13mZY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F2FFCF805BA; Wed, 17 Jul 2024 11:29:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 23B70F80588;
	Wed, 17 Jul 2024 11:29:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 32C78F801F5; Tue,  9 Jul 2024 20:13:49 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7A435F80074
	for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2024 20:13:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A435F80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=iO+yXysg
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3d938024c67so815746b6e.2
        for <alsa-devel@alsa-project.org>;
 Tue, 09 Jul 2024 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720548823; x=1721153623;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROMHyto+2d5m9gvIVW0NcBrDATzh3Wi6vpT55RVsNsM=;
        b=iO+yXysgTa8UJRgBD1k9OdFrSbWkhx7ylJcAMSIdUsKGO7cXMAbng9AaaovKBfr6BG
         FlKvKcORsYgd8JV6vNVccScBqrink0IjX4fV5NdRhc6V5nmFi48FXuJwTb7IHOS//b/B
         K3+Z/kwCCAAVTLFvMn+NuVwSPWYZu3O33ORW4ZtO13/CxC2RjpOLz6Pf1QQBl/3wWSrb
         2Jk0wJyyH4dcVZvpEfiMjVrOxF9hMq2MljhswYCJ+0An7aqmnASZYgb4vLM2ocb9W5cl
         27Z+qHKuolH+Bu9v05pLMDQIsM/SKRLWM8YgB3odP2RYPZoUd/uCXy51RQoSmjDLKSSk
         0rOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720548823; x=1721153623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROMHyto+2d5m9gvIVW0NcBrDATzh3Wi6vpT55RVsNsM=;
        b=MjOjFqo5y/Zq2Nppr41VihwDBKwibAytl1NxMY3j94BMTnx39cJHVv8njLDO9mazVE
         uDGm4WQR7lM1yt68QcVq+LfXYhAFE1Wc4FWrrZ/8gg7C+mbYH5ORx86yhS5fA6lY4Cvj
         ZcY247ANEY6StWRBqKHwzeBN5NNGmOhg5pNUlOWa+ySpoiZYItlI6YyePnkv7Qhv67R9
         97KSwVoMTrFj5nzUqwPnIzSSbqi4JM+HVVPpcNL74MsBpnSEPkXLF3bGRY5/nz1ujqGM
         CpSHdqWtDwD91cueXE9lUlenM5G92UDxLIqDsW6RxKUzd3V8HX5nin/mxgidaLQypvGJ
         Xm1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXebiVrIBVrZyCyy7N2YnAEr1ON3oRqwOqjRoCVlJGqOHogusgjGb4HafMwc2NtjgzZhykR8rat6so5g0uj22EsR/GUY5i+LsxKwVc=
X-Gm-Message-State: AOJu0YylC6SX7Vns9X/EyT+MWWO6Uek5AwBCdyNEF85AAsONn0Sodjsy
	d3I0kvjhLpekiUAuHlZSu1KO/lAPONPzEOoY70WWmoBcVTyigG7icxkzmqA4gsEbI2GmsnJaaol
	JSIktltWcp5Zz9huoDFX/u7Cyvm4=
X-Google-Smtp-Source: 
 AGHT+IHevraVd4VAfdho+QOwUt6YVkQU8bdQp+gENg36rqNZi9wUtYbQlbdAXUq6zj6JrypsVOIIC94IzJBFd1iJw6o=
X-Received: by 2002:a05:6871:b23:b0:25e:2b26:e05e with SMTP id
 586e51a60fabf-25eae83c5demr2302832fac.23.1720548822974; Tue, 09 Jul 2024
 11:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240707062702.174390-1-animeshagarwal28@gmail.com>
 <3d40f02f-529b-45ac-aa31-c4342f6f4f55@kernel.org>
In-Reply-To: <3d40f02f-529b-45ac-aa31-c4342f6f4f55@kernel.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Tue, 9 Jul 2024 23:43:31 +0530
Message-ID: 
 <CAE3Oz82KvEv3uJw-ha4RjXDuwqbMAy5ifEnK-gtR9ajkEbm-bA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: cirrus,cs4270: Convert to dtschema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: animeshagarwal28@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: J7DU7Z5JPDNGINEUJRWZLJ23NEUXSTIK
X-Message-ID-Hash: J7DU7Z5JPDNGINEUJRWZLJ23NEUXSTIK
X-Mailman-Approved-At: Wed, 17 Jul 2024 09:29:46 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J7DU7Z5JPDNGINEUJRWZLJ23NEUXSTIK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

xOn Mon, Jul 8, 2024 at 1:08=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 07/07/2024 08:26, Animesh Agarwal wrote:
> > +  va-supply:
> > +    description: Voltage regulator phandle for the VA supply.
>
> Your description is redundant: you did not say anything more than it is
> already said in the property name. This could be in such case just:
> ": true"
>
> Please keep this feedback for any future work (I feel I already said it
> once...).
>

I'll add proper descriptions for each of these instead, thanks for the head=
s-up.

> > +
> > +  vd-supply:
> > +    description: Voltage regulator phandle for the VD supply.
> > +
> > +  vlc-supply:
> > +    description: Voltage regulator phandle for the VLC supply.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
>
> This won't validate DTS... test the DTS. You miss dai-common.
>

Weirdly, this wasn't giving any errors upon running the dtbs_check,
however I should fix this.

> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      codec: cs4270@48 {
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation
> e.g. audio-codec or codec
>
> And drop unused label "codec:"
>

I can see some other cirrus bindings with this mistake, maybe because
they were written/converted several years ago. I shall fix it here.

>
> Best regards,
> Krzysztof
>
