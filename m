Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A0606A325
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=a7tW+iqn;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJqKRtuH
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 60EBC601F7;
	Fri, 20 Nov 2026 16:51:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 60EBC601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795189919;
	bh=MmsDmAXwergZgMM5yvh5taIlamjrkCtehaE+x1riQ8E=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=a7tW+iqnItISA2wT5e2384rLIK9odqB6I8OmGYvOpOCW190IqoMmgSmHDb1z0Lpqf
	 y2LIOh9r1Utiw04T27ZhVcDVeZfsjAi5SzyXLnISFRDvdNVoPFU2P2GD1Vfd/CXUh8
	 iud45XXFtxXN2dzYWvnOe5CSiHYYqIRlUXNae/KM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67048F805F0; Fri, 20 Nov 2026 16:51:21 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C43F4F805FF;
	Fri, 20 Nov 2026 16:51:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 937CBF8025F; Fri, 20 Nov 2026 16:51:12 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795189871;
	b=Ucavlhn5wbDnv6QlfU2QESMgnYfvNAkAOVjpK0dN9v92zjQ/9KrhIov6ucSPvypRTAMl
	 KjyCoe5hpLPsAgLQf3oybcJmxtSYF9XtjJ/4qyZgQz8u6HxGQqmE1kw3OI63L/jF/ctDy
	 HaWEJqjC7ff2ccVLBS2+tP0+0WDc3ngp4rXjDmHbd31U8332dgUsim17XIdseJY+0J9Pn
	 i41gfgDQ5jgrvtp8cUN1qxe3wceUlwIgKyf633uspTZDjG4/6l+ODmbOAZorMsrBKRrDK
	 99O72mjILrsbGBOja1bagwRNQRHLstkHiqpYhSIYXQy2asqjHjXKWpaUPdywmR3A19Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795189871;
	h=DKIM-Signature:MIME-Version:Subject:From:To:Date:Message-Id;
	bh=MmsDmAXwergZgMM5yvh5taIlamjrkCtehaE+x1riQ8E=;
	b=Q3X6gAdlcf4ktnEa11hQCcioaP63/+Vlgv6LhKmy7z1ytj54+fvqao3UMwxgM6hjKqL9
	 Wdmk7ggJhbFVSsigXSAoJhWxY7/3HhKW+lg/jm4A5kqv8XnMkx5ehNUk9A2WOhIrM7D8J
	 d+vGFLs9W8X9FB9B+XRgd1h2KwSTKhZu6KN0pvzsDClG4Gl6oW746EhTnc9fry3FrGX8f
	 Bqhkixn0qyw66RvgEU6CnigB5pV++U8RQ43mKy7mILPxacEFg0izl/LK04L6yw+hSLMFB
	 dXjFOAsFldhs3G451WCLYvQD5MpAq3W9a8Kt8EJZpsj+1HZlpOudpJloTSk/yiUw+KQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hJqKRtuH;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F09A1F80152
	for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2026 16:51:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F09A1F80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hJqKRtuH
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4DDAC601D7;
	Fri, 20 Nov 2026 15:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CC51F000C4;
	Fri, 20 Nov 2026 15:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795189866;
	bh=gHQlAvGfXai4P0Ur+OtnG7chLLJh7KNbFTLF8Ef0EMo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=hJqKRtuHg9BF4LeKnTV7+x3wkKABeBj6uAcfAuVLuY81FTLVL4VTfRhnfZSBTLvcC
	 KAkKhzgBnqIa88P59XBVm/nLG42gsqO1QzBsXDeFhk4+g03YBI2CTSbpu83IDWMwca
	 UERmXbQQcYHVk7kmfuHBT2+dy19GLzfk+PVlW+APxb3G3u3Yd62m9mJ7KwHxbtGSh0
	 YHREA09OyAjYncid8qCZ3y3E7nuPC8020XtVq49UC2SwVE0XMyrlhyAq1VyU11IaX4
	 4BF5awM2Iw46jzsecj3s9aJEJD5Hd6L7sqq3C/2QRwaoPJMiU7wKKYEEdCtEp58PnK
	 +5vhWqZnl269Q==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/2] ASoC: codecs: nau8310: Add NAU83G10 amplifier
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
 robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 neo.chang70@gmail.com, kchsu0@nuvoton.com, sjlin0@nuvoton.com
In-Reply-To: <20261118084214.527804-1-YLCHANG2@nuvoton.com>
References: <20261118084214.527804-1-YLCHANG2@nuvoton.com>
Date: Fri, 20 Nov 2026 15:51:01 +0000
Message-Id: <179518986190.6016.8091344211412804808.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=510; i=broonie@kernel.org;
 h=from:subject:message-id; bh=MmsDmAXwergZgMM5yvh5taIlamjrkCtehaE+x1riQ8E=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIZctJWKvuFXK20qdAVNIs+F+vCeSpxY6vmAl47dzulb
 R9cF3F3lLIwiHExyIopssRlcb+sL3m9hu/gwjaYOaxMIEMYuDgFYCLeMQz/E8LPC7uuuuekFmla
 bHaCa9Nppicmwlqqs/c3uu+3NlzYyMjwTWqKf6IPn9WOGdeOC7Md35E1K9vsZ6L570o1NSG73io
 +AA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: PTADWVKVHJSTS2TESPLGQUQSVYRE56L4
X-Message-ID-Hash: PTADWVKVHJSTS2TESPLGQUQSVYRE56L4
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PTADWVKVHJSTS2TESPLGQUQSVYRE56L4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

> This patch series adds support for the Nuvoton NAU83G10 audio amplifier.
> 
> The NAU83G10 is a mono boost Class-D audio amplifier with
> an integrated DSP and I/V-sense support. The driver supports
> I2C register access through regmap.
> DAPM widgets and routes, TDM interface configuration, and DSP firmware
> loading.

There's a few issues here but the driver is mostly fine so I think they
can be fixed incrementally rather than needing a full revision.

-- 
Mark Brown <broonie@kernel.org>
