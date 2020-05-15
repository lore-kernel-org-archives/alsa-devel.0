Return-Path: <SRS0=wzGW=65=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFE1C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 12:30:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625FA20709
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 12:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nPK8buF3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0zrjkXD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625FA20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F33C1655;
	Fri, 15 May 2020 14:30:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F33C1655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589545857;
	bh=TSw0eQ4WFON1EfGnsaXykmfInnksvvWfn5CeBUYDKZ8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nPK8buF357GTuHj8e13wQg9ZZ1EbC7rz0mfv6kU0X4L5iABDGSG4xqJfeTYMboWyY
	 U6UL1dRaGprcmH6vyik+/AFxWZXl9bg7vGcdCxUbBfKl+XLbcgHHKA9RPfKjC+cy7a
	 TF6/KcGtaCnJmjRCN5jngfj/au5Y2c3p03QX7y7g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E62EAF800E3;
	Fri, 15 May 2020 14:30:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 113AAF80247; Fri, 15 May 2020 14:30:00 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 054B5F80101
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2020 14:29:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 054B5F80101
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="0zrjkXD5"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D5F1C20709;
 Fri, 15 May 2020 12:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589545791;
 bh=TSw0eQ4WFON1EfGnsaXykmfInnksvvWfn5CeBUYDKZ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0zrjkXD5prKmI21EFxcPboIH8No7ixNf15Rsmdnc2qtfHdsB/Hp0ApaqPdfJYJi81
 6dNOLkRVMEi53mRtc+X0lelK5wpjUInjMNu6VJS3Sypur771BaG9XXE6emWPQfPcM3
 Dvh1O3AFYAGqoE+WXqTPU6yT1aYhcQjX8HFTzhVc=
Date: Fri, 15 May 2020 13:29:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [V5 PATCH 2/2] ASoC: max98390: Added Amplifier Driver
Message-ID: <20200515122948.GD5066@sirena.org.uk>
References: <20200515070742.14151-1-steves.lee@maximintegrated.com>
 <CAJKOXPf-Q-e_K-puR-N2NRwQCmaKD=EczzON4rBymvV2CyoiTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Content-Disposition: inline
In-Reply-To: <CAJKOXPf-Q-e_K-puR-N2NRwQCmaKD=EczzON4rBymvV2CyoiTg@mail.gmail.com>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, ryan.lee.maxim@gmail.com,
 ckeepax@opensource.cirrus.com, ryans.lee@maximintegrated.com,
 lgirdwood@gmail.com, steves.lee@maximintegrated.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Steve Lee <steves.lee.maxim@gmail.com>, tiwai@suse.com, geert@linux-m68k.org,
 dmurphy@ti.com, shumingf@realtek.com, srinivas.kandagatla@linaro.org,
 nuno.sa@analog.com, rf@opensource.wolfsonmicro.com
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


--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2020 at 10:42:24AM +0200, Krzysztof Kozlowski wrote:

> Your "From" address still does not match the Signed-off-by. Set the
> author of commit to the signed-off person.

git commit --amend --author='foo <foo@example.com>'

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6+izwACgkQJNaLcl1U
h9CR8gf+O5UGnkbhnV4MHHRYgchqTnJBXc/DysgCP0lEx+qj2ycTVhqvpCK0662l
RTBrIQ7JkSbGhHji7PzXkwjd/R8mr9eFuyxA7SkHzzR3q+cdChWg8kkKthwpp0FT
3LZItFkIDVziTwPVtZH0WYQLbAeesYTeGHg46c6WiZScn0IOUclODGkOs6lhXVBT
HctDZoXRtP8muMUOwEmaprVOdJXM6rlJNUS1uYJVBSSuN7gvyKhkmDkX0En/l0IC
u5UJacONloOu5ZYcutPJM/oqanR7dLkRX34VKru20jaXUYXvrO+P1lwtcfFeT10D
rvWdiGqqPMdak6i5Ej4HnPpXNvup1w==
=UNQm
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--
