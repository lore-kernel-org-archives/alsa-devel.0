Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBE2C4167B
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Dec 2023 12:35:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9186FDEB;
	Tue, 12 Dec 2023 13:35:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9186FDEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702384534;
	bh=LaRO3o7wYXlVIqJccSiEP8LxLE/M1CARjdL3pRfAw1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=A88EXe7uR8eAGF0a7gg1ceMIYx9VZLsiRBn/r/fAP8a3PHsCY7ZbZR4N+iQ5L+iuU
	 zYgNcILj7VZiVrQAegiNKqv9PO7a3q2OwV7UHko9RJAaXP8zMkeL7kPvQZB1X97FA9
	 dsTnC//QGjUIHdCnErnw4ZpJzlq1H5Ax1F42p9TE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0C02F8019B; Tue, 12 Dec 2023 13:35:02 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B5C99F80587;
	Tue, 12 Dec 2023 13:35:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E5AE2F8016A; Tue, 12 Dec 2023 13:34:57 +0100 (CET)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AA542F8001F
	for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2023 13:34:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA542F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=walle.cc header.i=@walle.cc header.a=rsa-sha256
 header.s=mail2022082101 header.b=asEntrfs
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id BC3E071;
	Tue, 12 Dec 2023 13:34:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101;
	t=1702384491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVsH9JrMU+kTllg4YnT8PH24+guNEqb5IZwuUj2+thc=;
	b=asEntrfsJUlVGUOuVaMNcSEyWMez6f94TkJxrdnYBhrPGNP6VFg/a3sxhqR0hd1IkQZIWX
	EqnahLwu8JFqlCzFkksUj3ny6AojzvDwmyknQs29Xh7cB7yHi+iJ89NEu1LhvV8Llb1+zd
	wSkrrDAcq6FjbYIDRFEwzQOgl5BHZOONLlYylIO0zjx2ZQP9D+c5+gKcVTG3kvhZpLXqNY
	mKCdx5SMagAm+jyjxpETjDt5y/h48F5k1qY6TYvDLz163Po8UJjJYyzZiLbu8MikXffurA
	7uVidvriQgkThLix3x5o1jZgUWuOoCZEU7OqZpUBVmiPBx3sNZmbF6Bg9ag2TA==
MIME-Version: 1.0
Date: Tue, 12 Dec 2023 13:34:51 +0100
From: Michael Walle <michael@walle.cc>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: broonie@kernel.org, tudor.ambarus@linaro.org, pratyush@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 sbinding@opensource.cirrus.com, lee@kernel.org, james.schulman@cirrus.com,
 david.rhodes@cirrus.com, rf@opensource.cirrus.com, perex@perex.cz,
 tiwai@suse.com, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH v11 00/10] spi: Add support for stacked/parallel memories
In-Reply-To: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
Message-ID: <30ffd8378d3ef1c4fa6dfe4324b18345@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: IT6YAYITK5FFBN7BOP6FVJWRP34KMVNW
X-Message-ID-Hash: IT6YAYITK5FFBN7BOP6FVJWRP34KMVNW
X-MailFrom: michael@walle.cc
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IT6YAYITK5FFBN7BOP6FVJWRP34KMVNW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> This patch series updated the spi-nor, spi core and the AMD-Xilinx 
> GQSPI
> driver to add stacked and parallel memories support.

Honestly, I'm not thrilled about how this is implemented in the core
and what the restrictions are.
First, the pattern "if (n==1) then { old behavior } else { copy old
code modify for n==2 }" is hard to maintain. There should be no copy
and the old code shall be adapted to work for both n=1 and n>1.

But I agree with Tudor, some kind of abstraction (layer) would be nice.

Also, you hardcode n=2 everywhere. Please generalize that one.

Are you aware of any other controller supporting such a feature? I've
seen you also need to modify the spi controller and intercept some
commands. Can everything be moved there?

I'm not sure we are implementing controller specific things in the
core. Hard to judge without seeing other controllers doing a similar
thing. I'd like to avoid that.

If we had some kind of abstraction here, that might be easier to adapt
in the future, but just putting everything into the core will make it
really hard to maintain. So if everything related to stacked and
parallel memory would be in drivers/mtd/spi-nor/stacked.c, we'd have
at least everything in one place with a proper interface between
that and the core.

-michael
