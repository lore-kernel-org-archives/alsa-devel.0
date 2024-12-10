Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491B6E77182
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2024 22:53:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25D9B1948;
	Tue, 10 Dec 2024 23:52:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25D9B1948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1733871185;
	bh=vOQZ+hRArK+7+2LfL9+F0yLhkn29I12pqL4H5D46RMw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DEdGP/x8iFhtoxDGkR0fxljKQkR1cy0ocOd0CZ3pNwluJejEkZmzzNA3cwehv1NJv
	 o5YgZjQnRJ9tionKJU70tQiETUao1CLBoQoQVPK62QCmvz6kryciIHRTMC9d5iINN3
	 KYr9Tz7hxskxA8dmze+SErk6I5fVCdzpyPiaFk7k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 982EEF805ED; Tue, 10 Dec 2024 23:52:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 117B1F805EC;
	Tue, 10 Dec 2024 23:52:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0849F80482; Tue, 10 Dec 2024 23:52:17 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 22866F8032D
	for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2024 23:52:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22866F8032D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=p64w2bPf
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EAB5AA41C0C;
	Tue, 10 Dec 2024 22:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C50C4CED6;
	Tue, 10 Dec 2024 22:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733871133;
	bh=vOQZ+hRArK+7+2LfL9+F0yLhkn29I12pqL4H5D46RMw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=p64w2bPfQ7oTtuiNKwmmAgT/9L6cNOKg8x4DfbrKXPb8iTOd4CFIGFQtS3LvLtL7L
	 SydD40JGVlnh+Cg8WFdPHAJCbhq3iJDvRfeff6N/3wlo8gEfH4JXop42upI9abhFdC
	 39kYMU1Im8OJvEJtMUKZqRiw8zEWmRz8bAmVCM0mbEF5HRrgzinXnlxCr2e12XuNVQ
	 F1Bd0sdvhM2Ckd7TFQRPmFAAgGm5I38zBeFPm1sl2V7C4bmREiZUkIGYt2Zt3YoMxD
	 UcjI7SJQJvF0r4J2dkkDHVv8og18X3hd5hEZ9SzfB7nURvJ7VKJ0HaJ6mVNl4R/zB7
	 7dRE+vVESs5AQ==
Message-ID: <861ecb11ea5984a25699b3055599545d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241210170953.2936724-3-claudiu.beznea.uj@bp.renesas.com>
References: <20241210170953.2936724-1-claudiu.beznea.uj@bp.renesas.com>
 <20241210170953.2936724-3-claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v4 02/24] dt-bindings: clock: versaclock3: Document
 5L35023 Versa3 clock generator
From: Stephen Boyd <sboyd@kernel.org>
Cc: claudiu.beznea@tuxon.dev, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Claudiu <claudiu.beznea@tuxon.dev>, biju.das.jz@bp.renesas.com,
 broonie@kernel.org, geert+renesas@glider.be, lgirdwood@gmail.com,
 magnus.damm@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de,
 perex@perex.cz, robh+dt@kernel.org, tiwai@suse.com
Date: Tue, 10 Dec 2024 14:52:10 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Message-ID-Hash: NC646Q7KD24NQLPZ2NERTQDZYCPI3EVE
X-Message-ID-Hash: NC646Q7KD24NQLPZ2NERTQDZYCPI3EVE
X-MailFrom: sboyd@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NC646Q7KD24NQLPZ2NERTQDZYCPI3EVE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Quoting Claudiu (2024-12-10 09:09:31)
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> There are some differences b/w 5L35023 and 5P35023 Versa3 clock
> generator variants but the same driver could be used with minimal
> adjustments. The identified differences are PLL2 Fvco, the clock sel
> bit for SE2 clock and different default values for some registers.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---

Applied to clk-next
