Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE8DC7EE29
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jun 2023 10:51:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C1E92820;
	Thu,  8 Jun 2023 12:50:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C1E92820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686221506;
	bh=d9rhyteykx390amid4fogZjlw+8v7h6yhbM1lcS1kOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=sb3DHvhH199ddjoMaRlkg3ciIKBC8eFEZk+L79q3WU9nG5ioyE4o6ZpkwftGLKbZM
	 X6VVVzLalXvUMKDEf9CeMPJ2SBKmm+ujRjbfxi1AKr5QQJeTQMfI1q0q+xxC50QVd4
	 WiP3D2S8GxW0ToR+qho3XZC2X16LqPIomuanJcpk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83F1DF80520; Thu,  8 Jun 2023 12:50:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4100DF80199;
	Thu,  8 Jun 2023 12:50:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B705FF80199; Thu,  8 Jun 2023 12:50:30 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E8AC8F80130
	for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2023 12:50:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8AC8F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hzjukPe2
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 60E886137F;
	Thu,  8 Jun 2023 10:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4F0C433D2;
	Thu,  8 Jun 2023 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686221424;
	bh=d9rhyteykx390amid4fogZjlw+8v7h6yhbM1lcS1kOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzjukPe2bQ9bBS2ApgLOZLaWiDnw5W0/A/oofCoOIHTArx0SGvK8s5aUrWyKUyq4+
	 kcEMV0HT9m1Jl9tVoamHF2vujgIybo8dmRqIWNWZ2B9HBu4dGSrP3CD7HO4CQjk3C5
	 4fO95JjFdCkQH1x2kF9J16lblzD1Djo6FrgcGNs9GtghHv5fNoqsQ7NHeg9yONDbKf
	 iTuaA0ybu8wJw43cmLrXxLdnPH7kCDeSAPyEqoqg9QIXEbg3fO0SrSTrAp0kXAncdN
	 BbvtdDXz47RZLxkHyuyG6IfIKQAUHJaLracCNIHOZ9KvZAjXLwRd4kV/T1cjM76uJd
	 +++4WRCgwXgsA==
Date: Thu, 8 Jun 2023 11:50:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Walker Chen <walker.chen@starfivetech.com>
Cc: Claudiu Beznea <Claudiu.Beznea@microchip.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ASoC: starfive: Cleanup and fix error check for
 JH7110 TDM
Message-ID: <c974d0c7-b091-4d5c-b73c-1b6584eb823a@sirena.org.uk>
References: <20230607081439.1517-1-walker.chen@starfivetech.com>
 <3eb7ffc5-a16a-4ac2-93a0-260f7cb1f81c@sirena.org.uk>
 <d941ac20-e8b3-cb13-4258-3a9a86e978d3@starfivetech.com>
 <fbbc0963-fba5-4178-b886-fbb35c0c8df2@sirena.org.uk>
 <7db1d08e-8310-8876-4ed8-36d6e53ab8bf@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f2uNTG7wn7psmZdj"
Content-Disposition: inline
In-Reply-To: <7db1d08e-8310-8876-4ed8-36d6e53ab8bf@starfivetech.com>
X-Cookie: Disk crisis, please clean up!
Message-ID-Hash: 3YRR7YSZEA55MENUQDZ2CJKHBLJ562M4
X-Message-ID-Hash: 3YRR7YSZEA55MENUQDZ2CJKHBLJ562M4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3YRR7YSZEA55MENUQDZ2CJKHBLJ562M4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--f2uNTG7wn7psmZdj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 08, 2023 at 06:43:09PM +0800, Walker Chen wrote:
> On 2023/6/8 18:15, Mark Brown wrote:

> > I can't find the comments you're referring to in there.

> You should see the following comments in the link above:

> > +       #define CLKPOL_BIT              5
> > +       #define TRITXEN_BIT             4
> > +       #define ELM_BIT                 3
> > +       #define SYNCM_BIT               2
> > +       #define MS_BIT                  1

> Instead of these *_BIT defines as plain numbers you can defined them using
> BIT() macro and use macros in place instead of

The usual pattern is to have defines for both the shift and the mask,
not just one.

--f2uNTG7wn7psmZdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSBsmoACgkQJNaLcl1U
h9AaAgf/YFRMuzUXFmKWVFmW0C4MWUJR3lzyYhAx+RwVv/ootjDxlKsogcqv6mNq
8LjQpDuh+em/aq6ue26Faqn4yf8ZdyQN/kbRAAaufI8wvIoqY6ZJrkhY6J4rBt6C
BO43k/HSyKZEQpBC8KgOD68upzo5Q6k/HO2j6CtslH6E/E4xYmuWoeKeGfbeqIzj
1eyfuepNe/+l0U9YhLT63Cu/w4BhVrOvlfYVXsNP2OehKTCjjMcdRPRokv+nkx8Q
F+0YiQiSNP+kLw/B/H0tqVuPlxCaLqyiSsqFXlhf+KCkOLdSH0JTxEC/yV8dUaUp
pZYAn1LJKxiIEztZTta+TWpzvu6Cyw==
=V59r
-----END PGP SIGNATURE-----

--f2uNTG7wn7psmZdj--
