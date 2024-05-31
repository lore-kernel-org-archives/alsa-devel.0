Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3090C25B75
	for <alsa-devel@archiver.kernel.org>; Fri, 31 May 2024 12:48:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0D88846;
	Fri, 31 May 2024 14:48:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0D88846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1717159691;
	bh=SBf8+jOuywRaezyxYyKLbzW9z3O7DhhdigY77jay4Wo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vaNqSPgAR4slUIm9W2qDep2KxumGMieoIWTdz+vqIPoFKVPQ9H00THRo0IDFJPpHl
	 axd5dRZS+cLg/wSxm+fbArytmyhuEJY713C+GGXmncSoaGHm2nqvF3f8eGsaqy6dgD
	 a9LZQllAUtpGTuLgiCt8JiBplVmlgv5TsBU1SOzE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1153BF805D2; Fri, 31 May 2024 14:47:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AA453F805C5;
	Fri, 31 May 2024 14:47:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 365CCF805B1; Fri, 31 May 2024 14:47:27 +0200 (CEST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [208.88.110.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5F07CF8059F
	for <alsa-devel@alsa-project.org>; Fri, 31 May 2024 14:47:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F07CF8059F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com
 header.a=rsa-sha256 header.s=DFC430D2-D198-11EC-948E-34200CB392D2
 header.b=FzJMj/lB
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E16039C096E;
	Fri, 31 May 2024 08:47:22 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id RoyjbGfD5dWH; Fri, 31 May 2024 08:47:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5C8FF9C57BB;
	Fri, 31 May 2024 08:47:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 5C8FF9C57BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717159642; bh=EgSdYLrxxil3DM2ZfEl9AZaBLurlfnS7atm+wMgVU5M=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=FzJMj/lBQgsaylMZozyQI2kIuLdeUCa2HURR7HPzGXXXZVlJTOgmNAMKseJ2KzE0e
	 j+LJ0vqdOFwvAfgJvmAh6/1qIre+43sFCrAVETVmoS971gpKsOryyb3kPVx9pr5xKI
	 5lQnazBd19NEpCjTdgkIF5rU6fAUAGcEa5ISXITdEkGEFregawm7Sto3AwQE0W4wjk
	 XMmxUw46cr1Ec/RiCHKwDDSHhIJ+YhSIInROB0kSDCCCbCfM+5/txtbKhbo1wFuM12
	 OmcgGSObwusX8pOV4FXRcKXLsb+He224rFMi976Vn2s+tQiLILQIK5h3Ia3xOO8TiG
	 7/7/A26s54wKw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 30jGWh-XiV8C; Fri, 31 May 2024 08:47:22 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2911D9C096E;
	Fri, 31 May 2024 08:47:22 -0400 (EDT)
Date: Fri, 31 May 2024 08:47:22 -0400 (EDT)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	shengjiu wang <shengjiu.wang@gmail.com>,
	Xiubo Lee <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound <linux-sound@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	alsa-devel <alsa-devel@alsa-project.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: 
 <477405270.701257.1717159642136.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <aa212906-6579-4884-82b5-6d0eb8b0b7a0@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com>
 <20240515135411.343333-9-elinor.montmasson@savoirfairelinux.com>
 <20d8eb96-6346-4341-95ee-74729001c01a@sirena.org.uk>
 <1607626951.349332.1715936738428.JavaMail.zimbra@savoirfairelinux.com>
 <aa212906-6579-4884-82b5-6d0eb8b0b7a0@sirena.org.uk>
Subject: Re: [PATCHv4 8/9] ASoC: fsl-asoc-card: add DT property
 "cpu-system-clock-direction-out"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - GC112
 (Linux)/8.8.15_GA_4581)
Thread-Topic: ASoC: fsl-asoc-card: add DT property
 "cpu-system-clock-direction-out"
Thread-Index: fy+ROOUy4SJ9oY7KJCX4xYYvCNq6Yw==
Message-ID-Hash: 2B6TXD26TOMF77UKIXQGHOEZWH6745OE
X-Message-ID-Hash: 2B6TXD26TOMF77UKIXQGHOEZWH6745OE
X-MailFrom: elinor.montmasson@savoirfairelinux.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2B6TXD26TOMF77UKIXQGHOEZWH6745OE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: "Mark Brown" <broonie@kernel.org>
Sent: Friday, 17 May, 2024 13:06:03
> On Fri, May 17, 2024 at 05:05:38AM -0400, Elinor Montmasson wrote:
> 
>> This new compatible is intended to be used when there is no codec
>> device/driver. There is technically no codec device/driver for which
>> the clock input can be set.
> 
> This is obviously not true, there clearly is a driver.
> 
>> Is it a bad idea to allow setting the cpu sysclk direction only ?
>> Should the compatible be limited to use-cases where the cpu sysclk
>> direction cannot be set by the machine driver ?
> 
> When I said "this should use the clock bindings" I meant that we should
> use the clock bindings for configuration here.

As far I as know, it's not possible to set the direction with
the clock bindings, but maybe there is and I missed something ?
