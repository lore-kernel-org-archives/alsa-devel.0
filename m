Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7C1EE49A5
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Aug 2023 17:36:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4ACB482C;
	Mon, 21 Aug 2023 19:35:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4ACB482C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692639385;
	bh=TIm9VtXxlIIF+26+p4kzCvEt3832dTcm44iy+s5+d+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=b0cuMEaZ7HZomBtescim2tNkexP70gdCkI+jRQZHWB3SDX2RQLcbPq4PwjZ0B1FcT
	 lxs/HgP+XcBw0Y4/hRTZeLZ/kgNaLxXV6WdWRBO2xFGl1BgdeJlbGUmVUV7DFA8vcd
	 gyV9VL+Q3rrz8ciwW4KbeN6TljQljGIbN1Hb/Yc0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2CFFBF8055A; Mon, 21 Aug 2023 19:35:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E09CAF80510;
	Mon, 21 Aug 2023 19:35:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD074F80557; Mon, 21 Aug 2023 19:35:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DF43AF80199
	for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2023 19:35:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF43AF80199
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=L3QL+Fzw
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CA281640B4;
	Mon, 21 Aug 2023 17:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B868FC433C8;
	Mon, 21 Aug 2023 17:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692639319;
	bh=TIm9VtXxlIIF+26+p4kzCvEt3832dTcm44iy+s5+d+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3QL+Fzw7Jg1X5dQhCl4G1tA+OQyxWpBiUrFeC/zy9/f9Kt9GcynUtsZ72l8WvKuG
	 aD2QTedNY6zAdXXixkl1NNMc8MVXYqzn0n/TxZAbsSdJxTeDZBxRQ9Y0d0OQmV/okT
	 zdbI3x0fA0M5NY1ZB5vSPDak0q5gUTD78nwvej1oxH0EtZAVV4hilPmq7V7B5wMWwt
	 xG5whYA+9JOjWdhlX/tFgZbTsFEASR1b2//qPcRWIYi2JeYdC0ucj1DyFTqV0cDCU3
	 0Z0Z7aeY//abt3sW7FwZY2IvHi+phN9wBpFN/WaLs0ES3QNPXtBzX6UxpgqbOtpGeM
	 AidCRQ2V2Wipw==
Received: (nullmailer pid 2006749 invoked by uid 1000);
	Mon, 21 Aug 2023 17:35:16 -0000
Date: Mon, 21 Aug 2023 12:35:16 -0500
From: Rob Herring <robh@kernel.org>
To: John Watts <contact@jookia.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 7/7] dt-bindings: sound: sun4i-i2s: Add channel-slots
 property
Message-ID: <20230821173516.GA2006019-robh@kernel.org>
References: <20230811201406.4096210-1-contact@jookia.org>
 <20230811201406.4096210-8-contact@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811201406.4096210-8-contact@jookia.org>
Message-ID-Hash: ST6JJPTZFTPIF3W6KPO3RAAAIML534WY
X-Message-ID-Hash: ST6JJPTZFTPIF3W6KPO3RAAAIML534WY
X-MailFrom: SRS0=A38r=EG=robh_at_kernel.org=rob@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ST6JJPTZFTPIF3W6KPO3RAAAIML534WY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, Aug 12, 2023 at 06:14:06AM +1000, John Watts wrote:
> The sun4i I2S controller supports mapping arbitrary TDM slots to
> each channel. Allow this to be expressed in the device tree.
> 
> This is currently only implemented in the R329 I2S variant.
> 
> Allow this to be configured using a new channel-dins property.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---
>  .../bindings/sound/allwinner,sun4i-a10-i2s.yaml           | 8 ++++++++
>  1 file changed, 8 insertions(+)

Same comments on this one.
