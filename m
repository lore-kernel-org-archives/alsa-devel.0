Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD24C433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  9 May 2022 11:51:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C645D18BE;
	Mon,  9 May 2022 13:50:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C645D18BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652097090;
	bh=b4aTBZ4v+rVQoWlkbu6lUJp1RJHxYYLupXeHe22aK+E=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YPrSjRciqLucxkLXUe1Xv4jyaGaKvNvYEB/3fN3TFdxunk4t1ams+qcw4k+4Fg1cz
	 QYPooL13QIyYvcHp6hn9A1C4ZCtLYL9ylp1ytxFBpcWqEpHoArYf1o7oFN4rIIZu4T
	 8IaNG25GHQoEP5lfsV3gpl/vOJeF7jiHmD30mIDQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66FD0F80237;
	Mon,  9 May 2022 13:50:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA528F8025D; Mon,  9 May 2022 13:50:38 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C9B9F800D3
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2022 13:50:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C9B9F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PlNdM41f"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 566C4B81161;
 Mon,  9 May 2022 11:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D88FC385AB;
 Mon,  9 May 2022 11:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652097033;
 bh=b4aTBZ4v+rVQoWlkbu6lUJp1RJHxYYLupXeHe22aK+E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PlNdM41fWWZMMZ5VmLAz0aq7w+uOUXEjhHnW6/VgxfsZMoyrZEny2Hkk0t+Qv65VK
 Aj8zV/bpPwgdiVytEIyiebz+eM7UwsQiIejW1ruXiyORKicJHyx39i5753qVcKZKlB
 /bGzM/mn/8gwltwCt0274kMqGFL/a2QWaY1zOPYn+f5PfNRs80fuUoZb53eo0vyYUi
 SJf1xPUdJiVa5yYAvrwkBL9jW1ugsH/fByazvJobZTvXZzsrMCaCqV9ESFKrgA1Nmn
 IygHhchmdKOTVFwPQM7Vf5JivhSD2Ks2GjaxTh2CgBtZpo7rp/rteudTZB27n7F3V4
 Ciy68yOBXKDyw==
Date: Mon, 9 May 2022 12:50:27 +0100
From: Mark Brown <broonie@kernel.org>
To: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH v2] ASoC: mediatek: mt8195: Fix build warning without
 CONFIG_OF
Message-ID: <YnkAAx3VAXCMFOTn@sirena.org.uk>
References: <20220507021424.12180-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dR5KuFyvd2qk11zt"
Content-Disposition: inline
In-Reply-To: <20220507021424.12180-1-yuehaibing@huawei.com>
X-Cookie: Anger is momentary madness.
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
 tiwai@suse.com, lgirdwood@gmail.com, tzungbi@google.com,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 angelogioacchino.delregno@collabora.com
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


--dR5KuFyvd2qk11zt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 07, 2022 at 10:14:24AM +0800, YueHaibing wrote:
> sound/soc/mediatek/mt8195/mt8195-mt6359.c:1639:32: warning: =E2=80=98mt81=
95_mt6359_max98390_rt5682_card=E2=80=99 defined but not used [-Wunused-vari=
able]
>  1639 | static struct mt8195_card_data mt8195_mt6359_max98390_rt5682_card=
 =3D {
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This doesn't apply against current code, please check and resend (it
looks like you have additional patches in your tree, am doesn't know the
base SHA1s?).

--dR5KuFyvd2qk11zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ5AAIACgkQJNaLcl1U
h9CSpAf+JWlnlwHrSebKB8rGFYewj7XuvxJYOCgKGxDjC0jGkchj3AvBNkFD2Kq1
oKVPST+oVCaXX3JrpiWXMJzRjyokDkQsXjQFuQ3xOLDyuohNk/lwI6KKLk04edeh
0DIySvexNYhTyNPrP3MjLrYvb9VTLJVSiNpmkCFBjg0ZMd3mZu37nmpMwXsE0HFu
go20cHPF9WoxMI6KUBmYD2sWaVqJzwXbnZBpY0Nf+HABKDX2tnjtXNqje7eAJ8Ai
WwiEC0IYZh1tmINQ87V4TahiDHNu7Sx+gFzEL410N557iw7AR/HLjxcdpUulA1zY
CcLY4c5Cj+UjV8DRBrLtzzxzZmEzcw==
=GTnm
-----END PGP SIGNATURE-----

--dR5KuFyvd2qk11zt--
