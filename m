Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EC8C54E41
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Mar 2024 21:24:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88438839;
	Mon,  4 Mar 2024 22:24:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88438839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1709587474;
	bh=+gUB2nWCe3zphOjc+pmzQ5Q5rOQZz0olG0tvT77kJco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aHi48K5tgU5CnTvP3C+BCk6XVXS4MPrjn73IFmlCPBlviBQo69PWnCS8ReBZasnEA
	 7INN6gAza+46N7RQBe9HLRjquRGMIwEHV82FlALloiltNSubwCIiub4KfmezosTbAW
	 rfIBN5ICttao6Q4vwJdB4sfzgqPOS/w5mb2wYrpk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2BDFCF805AD; Mon,  4 Mar 2024 22:23:55 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B35C7F805A9;
	Mon,  4 Mar 2024 22:23:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4AA20F8024E; Mon,  4 Mar 2024 22:23:49 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 10F6DF80088
	for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2024 22:23:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10F6DF80088
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HDrcYYhx
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ACB1361028;
	Mon,  4 Mar 2024 21:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F45EC433C7;
	Mon,  4 Mar 2024 21:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709587423;
	bh=+gUB2nWCe3zphOjc+pmzQ5Q5rOQZz0olG0tvT77kJco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDrcYYhxvTNoholGErkepUWKZHefrx7y+HP5+C8YjOAMQ5DHlfbTKvEv0Q/WbVdPY
	 yuzS0vmE+A/nSHZ6wtm2C+uWRynWoPipByPI7jzgBRnU1qqCNNFrJmoDBzCk1ZhGl4
	 vzYTbE/WfSAc3zacv8VCaS/Lhzs3OmK8puluh6oxipY/RbzUQr3U+h4/kU8/PXsuC3
	 JVf/lRMr/gy/9HpKWgWOii/HtdognveZCfjhNZVLU0iummeQNWDzgk0iykLoBvnmEH
	 skeNqMJfMvaMci8meMNfjanhT1A0eOb78+TF2dKVYV1TbPLIUsvXKBaec67+U0WtR1
	 coZCi4SNTmVSQ==
Date: Mon, 4 Mar 2024 21:23:38 +0000
From: Mark Brown <broonie@kernel.org>
To: cujomalainey@chromium.org
Cc: alsa-devel@alsa-project.org, Akshu Agrawal <akshu.agrawal@amd.com>,
	Karthik Ramasubramanian <kramasub@google.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] ASoC: da7219: read fmw property to get mclk for non-dts
 systems
Message-ID: <fcd7d8d8-3e71-4c43-b5e8-075369b4b9ec@sirena.org.uk>
References: <20240304211444.1031693-1-cujomalainey@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nTqdX9MwmtbHCBNF"
Content-Disposition: inline
In-Reply-To: <20240304211444.1031693-1-cujomalainey@chromium.org>
X-Cookie: He who hesitates is last.
Message-ID-Hash: APLA2OQ4NA7FY7WTV34UWJSC56MSRJAO
X-Message-ID-Hash: APLA2OQ4NA7FY7WTV34UWJSC56MSRJAO
X-MailFrom: broonie@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/APLA2OQ4NA7FY7WTV34UWJSC56MSRJAO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--nTqdX9MwmtbHCBNF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 04, 2024 at 01:14:43PM -0800, cujomalainey@chromium.org wrote:

> Non-dts based systems can use ACPI DSDT to pass on the mclk
> to da7219.
> This enables da7219 mclk to be linked to system clock.
> Enable/Disable of the mclk is already handled in the codec so
> platform drivers don't have to explicitly do handling of mclk.

...

> +	device_property_read_string(dev, "dlg,mclk-name", &pdata->mclk_name);
> +

...

> -	da7219->mclk = clk_get(component->dev, "mclk");
> +	if (da7219->pdata->mclk_name)
> +		da7219->mclk = clk_get(NULL, da7219->pdata->mclk_name);
> +	if (!da7219->mclk)
> +		da7219->mclk = clk_get(component->dev, "mclk");

I would never have guessed from the changelog that what this change
actually does is provide a mechanism for overriding the name we use to
request the MCLK.  I had thought this was adding clock handling to a
driver that had none.  The changelog should say what the change is
doing.

Having a firmware property for this is obviously broken for DT systems,
this should be limited to ACPI systems if it's going to be there at all.
It would be nicer if it were implementeded by having some ACPI specific
code link whatever the configured clock name is to "mclk" - I don't know
if the clock API has an equivalent to regulator_register_supply_alias()
but that's the sort of thing I'm thinking of.

--nTqdX9MwmtbHCBNF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXmO9kACgkQJNaLcl1U
h9DFXAf/V2F9fH0cqUciNfEyWUVRMKgdOkj1X7JVVZ/VZzS+ZBDLT0xAsM5I/+FQ
+ESXAOHQ2sHe9Dtg4d378XcckbAGGo8aJS7ktqAnxB6dCuwMHqyHPIyAfB3+bUxu
p2nCPnYFnj9q0lJ1DTtKNEzDleLo5IKvPJxGfcyp1yCCpSEpfj7L2DqCi/R5vXWl
i87YY7AnQ6w9uHyhtTKq6PTPGDKkokMU5n5zDr+LlgeanV030fZ3WShBOhbyFP22
WZIWx403bvzCIVkP0QiY9bebMJE9rf8oxLBti+4jCy0gnji9oT5gfqegL8/qJ28z
SUpapfvOB+n3meR8nbCaNw9o0tKwGA==
=M2Ps
-----END PGP SIGNATURE-----

--nTqdX9MwmtbHCBNF--
