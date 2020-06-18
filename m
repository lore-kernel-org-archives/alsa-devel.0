Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD61C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:02:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC44204EA
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vYl/gLok";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcuC0TFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC44204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 581391754;
	Thu, 18 Jun 2020 13:01:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 581391754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592478128;
	bh=QvA8no1TpMEdmiZ/sm5KuNeLuojuw47r6rENr5Cw9+8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vYl/gLokrpVtk2YOFbaIGV+uLgRhOZwnDuU2/5oBz6baoE0x0bXG7bVgzc6Pwve2J
	 2sYW/faVwYV/P6FD+HTrWWtyD/mmgujCw2hLJC6xYCfC+h/EBmauPqs4OyKm0gG4rM
	 cORgzPd2nt39z4gGJ/9TlYbx/wgqEW2+SNv5OjhM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B54D8F800D1;
	Thu, 18 Jun 2020 13:00:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA3BCF80162; Thu, 18 Jun 2020 13:00:30 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17727F800D1
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 13:00:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17727F800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pcuC0TFl"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EFBEB204EA;
 Thu, 18 Jun 2020 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592478025;
 bh=QvA8no1TpMEdmiZ/sm5KuNeLuojuw47r6rENr5Cw9+8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pcuC0TFlvq8aKx88UCMeFc3rKXzUVLLNyBEvCpsWnqZeoA1M8YmOjb/tXZIE0izgP
 nXXIl4qYKqeyLcjaCCuRVrpejc1Hm/59ui99dtK2/Fy9lk6DD7UfE7UsFFf/h2oKmb
 TwksHOd8UsbZNWik6LpYRpAobmBjx6J5USfHZ4tw=
Date: Thu, 18 Jun 2020 12:00:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.7 004/388] ASoC: tegra: tegra_wm8903: Support
 nvidia, headset property
Message-ID: <20200618110023.GB5789@sirena.org.uk>
References: <20200618010805.600873-1-sashal@kernel.org>
 <20200618010805.600873-4-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <20200618010805.600873-4-sashal@kernel.org>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
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


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 09:01:41PM -0400, Sasha Levin wrote:
> From: Dmitry Osipenko <digetx@gmail.com>
>=20
> [ Upstream commit 3ef9d5073b552d56bd6daf2af1e89b7e8d4df183 ]
>=20
> The microphone-jack state needs to be masked in a case of a 4-pin jack
> when microphone and ground pins are shorted. Presence of nvidia,headset
> tells that WM8903 CODEC driver should mask microphone's status if short
> circuit is detected, i.e headphones are inserted.

This is a new feature not a bugfix.

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7rSUYACgkQJNaLcl1U
h9A3vQf/WXhR7I7AHZ2vrSHUiTEBwIC375nL3wtLMM3A9X0B0jomIhmyFDZxYaNS
dw633sHw9HlgWyTTyx07S1iNlk2hHjOGMi/HzrTbSyK9zivf9QN6K8CIfNFzQn52
ynhCFORe0eQEP5gGqZF3bghKDzGSLwzYDq12GzJJPgibuoUk/nEq3hQblqQZj5ZZ
abqeBpm2aI5QAesPDCqYIFfqxo2pdhc39lSgHAw23df1mtuaKGn5MDPU6B/VDCiG
oHrUfwTkTc4HM06aKEUYnkkoY/y/2fxbI/wRmpHauweXn0PiWmUYeDtr8DrNJINh
uTQy4zb22IVORBEEJd7xHQg7TsL+Ug==
=2QST
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
