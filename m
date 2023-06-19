Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6A9EB64D9
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jun 2023 11:22:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E61AA4A;
	Mon, 19 Jun 2023 13:21:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E61AA4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687173735;
	bh=TCyP3MTK9D8/2GgV8QtO5pJImHNQEoTXD9BrcpmOPeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=le2YFiKuTITCFIQfqE0HP/PknYw4cJ6nCm3PgbcW75WrRd8ZmgQ38kKopQWkHA7Fy
	 saESTMWckHVoWnQsgG8vuJN0sMAxbW0/XF6uewi9tp67/2oxBnApJEl8rl4JbjjyIq
	 n7VUyCFsdyOWKo5UzKQFGByXOvKV9jNv3A932vIk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1D4D4F80217; Mon, 19 Jun 2023 13:20:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FB01F80217;
	Mon, 19 Jun 2023 13:20:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51196F80217; Mon, 19 Jun 2023 13:20:54 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 81686F80130
	for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2023 13:20:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81686F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=EeN13VgC
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1135560B04;
	Mon, 19 Jun 2023 11:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A417C433C9;
	Mon, 19 Jun 2023 11:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687173645;
	bh=TCyP3MTK9D8/2GgV8QtO5pJImHNQEoTXD9BrcpmOPeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EeN13VgCF7HvQLeN8f3NVM2QepW/cThlIGx6tTXmWV3CvQITV7FMDjf4WnW8kBJL8
	 hfPmb0f7IFPXPytBrqVR2jcjxvA4GfC16k3MnX5qy+QwZK0Fd3hos+4Skl4lYjNMC8
	 90tXi+BRaqVDnwbsuxvd17HBj6UbRP/8DywVVqy02PHyRbfmZ5I8uSaluKxvI6x0Qh
	 IhS9aMBTMmFa7PiVBAvhdPVNOdumKKpEWJW4cuPRfLhtcwvJm5Rmrkb2BCylvA0ren
	 4JZSE9sedpOpucIyL0HGiE+J+a81RVwdxsmC9U1xZYXBuUEo0hNM9IrKqdfNduPq5N
	 fCejfIFAbg1Qg==
Date: Mon, 19 Jun 2023 12:20:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: YingKun Meng <mengyingkun@loongson.cn>, lgirdwood@gmail.com,
	krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
	loongson-kernel@lists.loongnix.cn,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Dan Carpenter <error27@gmail.com>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v4 1/3] ASoC: Add support for Loongson I2S controller
Message-ID: <ad4722ec-0fa2-4bb2-879b-47bcbd96bb0d@sirena.org.uk>
References: <20230615122718.3412942-1-mengyingkun@loongson.cn>
 <cf2f3bc9-3141-8d7b-b57d-73eac70a21d2@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="srSkMy3jZsgNxOgV"
Content-Disposition: inline
In-Reply-To: <cf2f3bc9-3141-8d7b-b57d-73eac70a21d2@oracle.com>
X-Cookie: Prevent forest fires.
Message-ID-Hash: JMH4FONLWPALJSO27VZQMRJWKSIY3XXL
X-Message-ID-Hash: JMH4FONLWPALJSO27VZQMRJWKSIY3XXL
X-MailFrom: broonie@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JMH4FONLWPALJSO27VZQMRJWKSIY3XXL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--srSkMy3jZsgNxOgV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2023 at 01:41:48AM +0530, Harshit Mogalapalli wrote:
> Hi YingKun,
>=20
> On 15/06/23 5:57 pm, YingKun Meng wrote:
> > From: Yingkun Meng <mengyingkun@loongson.cn>
> >=20
> > Loongson I2S controller is found on 7axxx/2kxxx chips from loongson,
> > it is a PCI device with two private DMA controllers, one for playback,
> > the other for capture.
> >=20
> > The driver supports the use of DTS or ACPI to describe device resources.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--srSkMy3jZsgNxOgV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSQOgcACgkQJNaLcl1U
h9CWMQf+Ici0ppIkITqxxvXumQa86CMD72Cxfz+kO2FGvaIcayPescQ3j/43UKIb
AjvqoIA3Y6nX4w0WbkTr0pBPhV0jAxNHrv7Pc+wAEDdu8FEpFR/UXPllUwVusGqf
cm51zP1Z/xPr3LluBa0J5y5gWcf1X5iXe3tEWVlSp+09cs0yPkaS8BNU6nk9rn2J
yzbB1623/h0RJPrAG/6x71iHnOTyK+ebyLyRTNRfNOdii503bKf2BIClwLp6Zsqu
BOIMPbFpZQUWgRamCUxpBi+evdWmu0xIxTDzOsY5gQKfRib+4Ey538+NSEp0Qaoy
MoNr1GOae9rRO2D9WqCiQygvSudLeQ==
=C+Ao
-----END PGP SIGNATURE-----

--srSkMy3jZsgNxOgV--
