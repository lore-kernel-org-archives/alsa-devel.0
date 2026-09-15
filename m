Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0D2C88E77
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:54:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 576AA601EF;
	Tue, 15 Sep 2026 20:54:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 576AA601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789498458;
	bh=sdsbEFsssWzRsphZE7H3Fpxb+1wQm7XXnSOm/1wxa2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PP4ufehAbe9p6BODApgunnKwzaOGQaHZu0ItfH38faF6fbCxaXyLq2QP/8l0S89qo
	 o2Xg+ApNGpztnnmWdWvMrF6PpgOrl8I2/nweTzcWmsZ3sB1J/Vx8FZe0VItGQQliFH
	 A/UxcKqzoGWxeDZshSyRunRy9qS3l1MUls80wRu8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2E146F805F4; Tue, 15 Sep 2026 20:53:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A345CF805F8;
	Tue, 15 Sep 2026 20:53:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DAEE3F80588; Tue, 15 Sep 2026 20:53:37 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789498417;
	b=RGrO+Jfypocl46IetBIoaxDNPiyPooDvi9VWWgzIHTYDeNWZ1SFUCsYcy6tkbL4b0ff5
	 Q5RQxNR8M7dvriAhsUQuFLxHVKl2xf87kJX9wZjF7safiPpTqrQvd3TZxhjic2umEGpop
	 csoSEoYdFXGsRat4PGAhc9wcU9+BTvLZJ4ZyKS6LXLPMIxsIEGKXS/NXd942HLtCRAlgr
	 OKn5NFdHmZaf1m8ZE1YNpaP6JUaPEdk0iNxOECDq3ZRqbr/K5JUR7dOQo9+MhKwurog6Q
	 BJdaN1I+6Y13CjwAuWYehc9i/MA54tHs64Ly5/edm/+yRLRSo1Uyro1s2gc3ZLxKbrg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789498417;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=sdsbEFsssWzRsphZE7H3Fpxb+1wQm7XXnSOm/1wxa2E=;
	b=jQv73dbpFpV3Si3ZOnXlWeE3x88ICEF2w2YyRdrqGFXS7pR7C1dJaD3KbqbKN3GQ5qHf
	 8QB44m+noo3IAcnDruld0d2izUaa4kmy+JtP0l68nIfEbx9hsRXoXUNW/4xIXZw4Viepq
	 XjYmNHKeWTwkEZIZ65uabTSnYiVuekMIpInvdWGW3w/YS/8vmThGVkP8n6HPJUVBkcyk5
	 Cuf3vuJTNZmnVJciXvRuq3rOKZxPFY+T4jIcfNUXCaQhx9Yu6qOcqLOCmOTZWqEkPu16U
	 unGlu6T9kR+oWQ8Ss7ZDP6fY5J4OoZYnG900IaYqVM77FSniMofWeNVn8perde1ub9g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ad3xzv5k;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 084FFF80423
	for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2026 20:53:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 084FFF80423
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ad3xzv5k
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 808EE41877;
	Tue, 15 Sep 2026 18:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D981F00893;
	Tue, 15 Sep 2026 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789498413;
	bh=UFz2xTqyV2U6wfcs/i9b3YVTZ8YTwk7BzSeH8eOOjLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ad3xzv5kIRyrCADPmet22+fj+2ISqrCrDr5m31Ba/PcUnEYlOfx32rLqdpJHhz+eO
	 Yi2Jh0x9slMUyWy+OIFBuU47emq0P+Xc2o6Q2Z6lRy24AnNQVit+QYhz4wq1d+DkWu
	 bb4p1mUlCBfPqUA8K00tTNell0dBAK0TbDoOkNZUS7BkbCQSTqfy1LXXtm8nL1z/uf
	 1eKnPvNCefHbGo1l6a6j5j+ZU2o2RJ0e+XNfMXQRLxXAzNvWs0oQNKA16Jx07sNb3U
	 ognu484HQKt6mAOuW2OoGm4sGdcVAtEW89AuaTXw1ZBe6a+W16/EnilN/cJYN7MKx8
	 MPJyaEy44lh8g==
Date: Tue, 15 Sep 2026 19:53:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, shenghao-ding@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	k-yi@ti.com, henry.lo@ti.com, robinchen@ti.com, niranjan.hy@ti.com,
	pin-hao.huang@hp.com, Syed.SabaKareem@amd.com
Subject: Re: [PATCH v4] ASoC: tas2783-sdw: add firmware download status check
Message-ID: <ed7fd58d-e36d-4d40-afda-fb9937ed1e5f@sirena.org.uk>
References: <20260915035223.1518-1-baojun.xu@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pCJcuhKfiYZaJZ3I"
Content-Disposition: inline
In-Reply-To: <20260915035223.1518-1-baojun.xu@ti.com>
X-Cookie: Void where prohibited by law.
Message-ID-Hash: AE7DCR5VYJPDS2NTZI5XNZX7PLW24XHL
X-Message-ID-Hash: AE7DCR5VYJPDS2NTZI5XNZX7PLW24XHL
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AE7DCR5VYJPDS2NTZI5XNZX7PLW24XHL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--pCJcuhKfiYZaJZ3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 15, 2026 at 11:52:23AM +0800, Baojun Xu wrote:
> Currently, the firmware download is unnecessarily triggered on every
> system resume from suspend, causing significant wake-up latency. However,
> this step is redundant if the AMP remains powered on.

> -	tas_dev->fw_dl_success = false;
> +	regmap_read(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 7), &val);
> +	/* Check if the AMP is in reset status. */
> +	if (val == 0x20) {
> +		tas_dev->fw_dl_success = false;

Don't we also need to set the flag to true if we're skipping download,
what'll happen if we get here if the firmware was downloaded prior to
the driver starting (eg, you can probably trigger that with a bind/unbind)?

--pCJcuhKfiYZaJZ3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqplCcACgkQJNaLcl1U
h9BAKAf7B64HpvTg8P8ErHFv0eDDiBJO00Ta4EUvgOzDvIImM3RRbxEu9b7oSUvL
beaFxVa25q36Nfm/+WwGfk4IzOV4NgbieJePGrDFAXNCMi+9b60/yx8uhZzrPEJm
iD22VMhvMgHCVfvZJ7WhYN385Yvt+yrqnGoFvTgdXhLF1jsjIu94yhexqcu4vYko
YUAkLzHnIz9meIYvH3xvUX8RyUozTdO2uE9FYHXpMKHFBjVjIiSyvhibYEHhhJw6
uw0Ihl/0ZhLsqEz3Z//swUR5l1wAV1F1w2nHz8ifwPZDIAEscMcUXBz/NuDTVdZV
JycYnQQREcemniKKvVaWBjIg5HcOhg==
=zuyA
-----END PGP SIGNATURE-----

--pCJcuhKfiYZaJZ3I--
