Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2337C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 14:14:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C9C610E9
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 14:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A3C9C610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89CBC17D2;
	Wed, 15 Sep 2021 16:13:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89CBC17D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631715245;
	bh=3VliXwA8hFR5zM12Xw58dE/ygC/s5PPHveglLCGMbSc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M3WiOdwHCSOPSFxwOqFk7yh1L9Mp7JJDEHbn75T3QJXuMs8Vqrf530qCyNhEXGjVP
	 MH3D+U/fKVZYeLQe3yJIUDni4hhs8Dsf/uQADNmblXHTL3sGdboVtqYNeBbxx5qbFq
	 9kjMfQzaHK50uCe5ZK5natHUfZPAvu9GATQjRBBg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 300D0F80117;
	Wed, 15 Sep 2021 16:13:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4F64F8027C; Wed, 15 Sep 2021 16:13:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2778F80117
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 16:13:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2778F80117
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PS78lEAR"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DF0A610E9;
 Wed, 15 Sep 2021 14:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631715188;
 bh=3VliXwA8hFR5zM12Xw58dE/ygC/s5PPHveglLCGMbSc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PS78lEARdU0wIKnld6n9NNWJ1mO9jd5q8hzpG6/n6ktqhPn2qraMg7zytVGWxuPgy
 uVmKlcwND4cfAlP6sZmxExrSSNzvdzZ8jrfX2gQgQqtBoFT6iN43MEWUC/OPz0jUnS
 1WU2kademhOEO1hNplPxskA8IUPJVMqD6i3snzE2scNpB5H8lxsR1AxwnXd9zkXOT3
 /BnFpEOTPo74R4EMz50aMl/flyo1oSF2+xnjVnbui+QS3Cub2xTcGYDG+1rhTHAEwK
 BvOBW3SR9VZ7IaZZK5BnSsk5Ld/5PavxG4P3Pck1VBGr1CSPzO/VF/dhwJL+E1QeGW
 2oL6+nrM+7+Fg==
Date: Wed, 15 Sep 2021 15:12:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: Re: [PATCH v4 1/4] ASoC: rockchip: add support for i2s-tdm controller
Message-ID: <20210915141227.GD12513@sirena.org.uk>
References: <20210903231536.225540-1-frattaroli.nicolas@gmail.com>
 <20210903231536.225540-2-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Content-Disposition: inline
In-Reply-To: <20210903231536.225540-2-frattaroli.nicolas@gmail.com>
X-Cookie: The more the merrier.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-rockchip@lists.infradead.org,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org
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


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 04, 2021 at 01:15:33AM +0200, Nicolas Frattaroli wrote:
> This commit adds support for the rockchip i2s-tdm controller,
> which enables audio output on the following rockchip=20

Please for future submissions include information on what's going on
with dependencies when sending partial serieses to some maintainers -
the usual thing is to include everyone on the cover letter.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
(for the bindings)

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFB/0sACgkQJNaLcl1U
h9A4Zwf/QB3O2kBDkYXbIH/HOolQ1QepbZfvybO+g3uaV9wzSVDEm/p0cTYOKmaB
uXFMNkXLL64UsvgTw/ECheXMAzmRgW0uQhhOngfsOw2opR6QaemuYaALuqI6C2Fx
aWlRrDY7nYq9nGxwwRFYh013qTxMSPOmyUoTeTopHvwYprdt20mNhm5lwLhBKaOu
5SjkcoeJoaQih5aX5Xtm3RWYL2DNy9Wf/bLUB+FZSoGSOG2ZtKWxT5rCuZLMOXQT
3iN69D9F1JtRe+BwAiqhwazUXmfr4Zd0sDnUsWVis2Nc9V7T8J7JH/+9hekw5iPW
Y+hRZc5APTVu0HPo/3WRinjld5481Q==
=eohL
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
