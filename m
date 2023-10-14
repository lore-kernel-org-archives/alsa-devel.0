Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F88CCDB465
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Oct 2023 12:25:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B26A850;
	Sat, 14 Oct 2023 14:24:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B26A850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697286304;
	bh=mJXnSOc18nbOJeO8PXpqww6MjeT6PjIoWfB6gEXfym8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=oYlEq3SCVPFBr+1mvEYarMgceF1kNEW8f/Kb7JvimsoU+6/sD8MPlrvthHxPuWgH1
	 f0wVbcDBsSSpJ9y0IKGNPQS6I7Taf/PoYyFjhxh4MdKJXqbNK+EQfQAJu8EUUSsQ3a
	 Jcn50gqeQw5h2UlN6HJX8f1XEWpAga72ctSq+y/g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 91F20F8027B; Sat, 14 Oct 2023 14:23:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 334FBF802BE;
	Sat, 14 Oct 2023 14:23:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89025F802BE; Sat, 14 Oct 2023 14:23:32 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::227])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 41C7DF8015B
	for <alsa-devel@alsa-project.org>; Sat, 14 Oct 2023 14:23:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41C7DF8015B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=paTNTZK2
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E7B320009;
	Sat, 14 Oct 2023 12:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697286206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4PnKGHKrBZ0yORVg2xj3dm8E1SmEj+8SqdJOwV/d30=;
	b=paTNTZK2mut+6sDu5aatyQmlcUuWMcmPzzoKCIPkOobhAT1dsw9pzSW5K5KCErPmUVtn/S
	p5csf0+1CPC0pEhm3b8hhsGYv4BU1crcVY+wr7WVM0wo8b5d9FHXxRejumARvEVWp4aQtt
	BZwYjJdiusXuI4L6EyKtR3gctAqEKG8/PKwhd5d8ZMMJtY1XulYbptly3Y9B/uj+OYJCqP
	pl2/pbReP4hqNbR+UoFGrJ5wi7uv2cvOdgM+qf14mz/Wh5JxrVgNZO4+eWDgrZyo5/7bmv
	LgF+64Hi0ioNq6t6elDUe0kci//orZKn/SSn2luy1xSYrn2FOXSfsOlNo1ufdA==
Date: Sat, 14 Oct 2023 14:23:22 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Thierry
 Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Rob Herring
 <robh@kernel.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Wang Yufen
 <wangyufen@huawei.com>, Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Astrid Rost <astrid.rost@axis.com>, Robert
 Hancock <robert.hancock@calian.com>, Sameer Pujar <spujar@nvidia.com>,
 alsa-devel@alsa-project.org, kernel@pengutronix.de,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH 4/7] ASoC: simple-card-utils: Make simple_util_remove()
 return void
Message-ID: <20231014142322.30039db9@bootlin.com>
In-Reply-To: <20231013221945.1489203-13-u.kleine-koenig@pengutronix.de>
References: <20231013221945.1489203-9-u.kleine-koenig@pengutronix.de>
	<20231013221945.1489203-13-u.kleine-koenig@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
Message-ID-Hash: AHBARBLB6I3ADDPIAPDREG4DY6L4F677
X-Message-ID-Hash: AHBARBLB6I3ADDPIAPDREG4DY6L4F677
X-MailFrom: herve.codina@bootlin.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AHBARBLB6I3ADDPIAPDREG4DY6L4F677/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 14 Oct 2023 00:19:50 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code.  However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> simple_util_remove() returned zero unconditionally. Make it return void
> instead and convert all users to struct platform_device::remove_new().
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
