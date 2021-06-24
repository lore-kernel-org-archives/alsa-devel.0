Return-Path: <SRS0=UF41=LS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D75CC48BDF
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Jun 2021 10:09:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B79D613FB
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Jun 2021 10:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B79D613FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2143B83D;
	Thu, 24 Jun 2021 12:08:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2143B83D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624529337;
	bh=a2QOqcnBAxBRYQEUUzGYao+z3AXWsARQG+nbmSkCoe8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kU2strKj56w+SJvLxx6kJJq1YHlhhhQd09i+K3kEP1G5DlTnXeYLuDTTIchqGllh6
	 +FFPS4OCandIPOd8c7jv206cU7BT3chFMDT5I/Rn4OOdNldqOFLdwyC4NkscCyfNUW
	 MLjz0NaMVQxsmjdwniLrwoN4VwqPwefrW5R1l23Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AAAAEF801F7;
	Thu, 24 Jun 2021 12:08:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B45CF8025F; Thu, 24 Jun 2021 12:08:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D06AF80137
 for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2021 12:08:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D06AF80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DrzCEGz5"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5F3D613FB;
 Thu, 24 Jun 2021 10:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624529279;
 bh=a2QOqcnBAxBRYQEUUzGYao+z3AXWsARQG+nbmSkCoe8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DrzCEGz5qxIgFvKsvMFN6YzTWqGOnZ/4xV1t875Vo0evVHwN4ELB8Ec8aciAYY5e3
 UumRlXkHgOK/Dc2iFB6yxGgQbonGj0rJNdIzeJ9nTAxqsOBFZeiqfFpSKifkWDZGnJ
 Akrxm7FVPg9eHBlOVVVj4B/KOtmg4akT5Y12V4POmSqcAAQMpJrvJaAD4sPlAIttCH
 lrhlxVg/dKXLlBewQb4+p9C+1wgtWqpoJAb1Sk7VbAaE1W7sirwz2r0IsxvpyN6lO/
 ZH/UrtOZBv1BCSeYDBkvKFvmBLqJkdvcXFYuKkXGx1EbOs9VvzNrGB2y+0djGymsGt
 vCW5ONGM58uBQ==
Date: Thu, 24 Jun 2021 11:07:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [GIT PULL] ASoC fixes for v5.13-rc7
Message-ID: <20210624100734.GA3912@sirena.org.uk>
References: <20210623170530.DFA99611C1@mail.kernel.org>
 <s5hpmwbn0o2.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <s5hpmwbn0o2.wl-tiwai@suse.de>
X-Cookie: World War III?  No thanks!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 24, 2021 at 10:10:05AM +0200, Takashi Iwai wrote:

> If you have some commits that must be inevitably in 5.13, let me know,
> then I can cherry-pick and submit to Linus.

I think these ones:

> >       ASoC: rt5645: Avoid upgrading static warnings to errors
> >       MAINTAINERS: remove Timur Tabi from Freescale SOC sound drivers

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDUWWUACgkQJNaLcl1U
h9C25Qf+NRDAOvSXrKNxHgnDPlZAyntzuxStxh/ZrzWRzldoeuJyZJ1KvRg5r3Ue
FxfHQZiJnx20IqhndqYVhrUPy8ILZIjZl78ZXipYGoxSScIk5qgNLt4ZoSmhGdnj
49JWXGkny/hjzJx5ip5+SOKkpwli8aJyavwrt8/M8G2ZWLr6XUF0MOiz1bwiu+zD
wd7NYmszhc/ezJ/5bmFAr2+aTfVERVlD8bjW+dS9+o9tHX4gP+Zymnvx8OiIZgwy
qe64z9jCOOpD12OxG9SUo0EgFhLaOrND0J1G56IKxPLluk2PO9s5W0KPmJIKJTbs
aGPpLbThiQH48YJCcnjawaZlV7l4mw==
=m3Zp
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
