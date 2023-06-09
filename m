Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC744C7EE25
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Jun 2023 13:15:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDFD16C1;
	Fri,  9 Jun 2023 15:14:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDFD16C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686316505;
	bh=+VnayFfSog80+SfcQLo/aN70B9IZ1fltmM/q3daEanM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=E7V9IzM88abvMU+vORlLvYMysPndgyTbJE3OpOOA422CUboY+HGwF1OeJn/3mHHlg
	 7r7DlQC1RLjm8PKPfleAiD2DR6WZyTOiOzLXZpEtBkESZALELr1Zrql/KZKDRyZjlu
	 +QGle9vd2jOS+3HKh6Pk9dYAahwBdFADO1aJo058=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A9F9F8016C; Fri,  9 Jun 2023 15:13:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B9402F804DA;
	Fri,  9 Jun 2023 15:13:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CDCEBF80199; Fri,  9 Jun 2023 15:13:46 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id ABB90F800C8
	for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2023 15:13:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ABB90F800C8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dppehOEh
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6BCB7657BD;
	Fri,  9 Jun 2023 13:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544B0C433D2;
	Fri,  9 Jun 2023 13:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686316419;
	bh=+VnayFfSog80+SfcQLo/aN70B9IZ1fltmM/q3daEanM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dppehOEhULYKtwlDBGDRMNHBFog+6wpSloX5J3u84l6PXjS+h5MUrwCY+547JOwuS
	 PV2o0Iv66CQiiSjzeEJBaWci6rGHnjq1AvRDuym+sTyFQnR69Qj3u64dP8VcHEotb2
	 PRoz42M2TXbV900kSGSy36CsvHLAXUcB+heFkimtEC53B/8XCxYGAu5iqJ7Xd7cdzm
	 ganV6GdFDAqDiSh0Y+IFgQJ7JEsntuiongiRPT/Oc7yLNTIRf0dTVYCWkZxmb2oCik
	 vSUZRLh9u/vVyhrWYkqKH9INxkO53NY7kz265tIHXZnHcQckhmVi4p+Pc1MhtLuOfW
	 zBYZY9GF+vNEw==
Date: Fri, 9 Jun 2023 14:13:34 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>, Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] Revert "ASoC: mediatek: mt8192-mt6359: Remove " Jack"
 from Headphone pin name"
Message-ID: <57a02e71-06f7-402b-9ec8-def5020d5ea0@sirena.org.uk>
References: <20230608221050.217968-1-nfraprado@collabora.com>
 <abe6e5f5-7373-44fc-90b6-2c01b1f1e96e@sirena.org.uk>
 <ef54367a-a4f5-45af-aff1-08513c75c63c@notapiano>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E8+wg9sr5mfw0F8n"
Content-Disposition: inline
In-Reply-To: <ef54367a-a4f5-45af-aff1-08513c75c63c@notapiano>
X-Cookie: Tom's hungry, time to eat lunch.
Message-ID-Hash: OLWLS2PZBEXPE6WRA7VGEAC5RY22YRZ3
X-Message-ID-Hash: OLWLS2PZBEXPE6WRA7VGEAC5RY22YRZ3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OLWLS2PZBEXPE6WRA7VGEAC5RY22YRZ3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--E8+wg9sr5mfw0F8n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2023 at 09:08:47AM -0400, N=EDcolas F. R. A. Prado wrote:
> On Fri, Jun 09, 2023 at 10:39:25AM +0100, Mark Brown wrote:

> > Please submit patches using subject lines reflecting the style for the
> > subsystem, this makes it easier for people to identify relevant patches.
> > Look at what existing commits in the area you're changing are doing and
> > make sure your subject lines visually resemble what they're doing.
> > There's no need to resubmit to fix this alone.

> just for my own reference in the future, what exactly should have been do=
ne
> differently in this commit? Are the subject line and commit reference in =
the
> message generated by 'git revert' no good? Or is this message from a bot =
that
> can't handle revert commits?

Yes, what git revert generates by default are no good and you should
edit it to look like a normal commit message with a standard subject
line and standard way of referencing other commits.

--E8+wg9sr5mfw0F8n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSDJX0ACgkQJNaLcl1U
h9BY4wf/dGzg2Cru1Lxw8y9ddzXRSKRzYVlr6E4w9UIYuIwjnMAYZBK7vSyJgd6r
Gbzug4aC6m8b04va9StPFEbF8FIlHMfhWV1Y6QDUUfbQW8Y3SXPKcCP2M8UBWzLH
8fwIxMZbPMCuuOWEMqAepvYpaC6TIj8aVbjnkhQdGaU969ZeuYN5U69QkpcwdMTj
1V4lkpFZw9bvlQelnboCzPBT4NDs0erRd0YVuST0S1RuEAFJaBnVri1BK4Dv8wYH
yauo8qrsKtx9ILr/FvS1HiWpDZpToon33JoolQprrUvKdn6PAAXWcWWhY1BUZVsG
bfvz8rHv3tufHWywiMHCIh83cxLEXA==
=DCBe
-----END PGP SIGNATURE-----

--E8+wg9sr5mfw0F8n--
