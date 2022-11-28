Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8971C43217
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Nov 2022 13:35:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D9F216AB;
	Mon, 28 Nov 2022 14:34:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D9F216AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669642528;
	bh=6ZyoE61TU6oOaDkCB796SpvFg4qPHeIhaVpyfOHlwng=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GL2YQ5/Q3JNdXSgOpeKZ32nnpKRKJRo6DT5kdTPM1w5YGOuOUBzzazmjgK1KvAMll
	 yzOlA2iechmfm6thwoCIs7TN0OqAZ8llyALncPn4DUOZBEbUJvfk8Nr/m2vGgpK8JH
	 OVwUIV9uLYt4RMtPZrNgk2t75gcAaT+Yd24fJoaU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B965EF801D8;
	Mon, 28 Nov 2022 14:34:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5993EF8020D; Mon, 28 Nov 2022 14:34:36 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7407F8016E
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2022 14:34:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7407F8016E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HnGFuAvr"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E4ADD61018;
 Mon, 28 Nov 2022 13:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338E6C433C1;
 Mon, 28 Nov 2022 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669642467;
 bh=6ZyoE61TU6oOaDkCB796SpvFg4qPHeIhaVpyfOHlwng=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HnGFuAvrwQanpdHYFHp1Z8ly5ChADa7N19NtPaqRgL0JXq2wyj2idESDwAVskm7JZ
 xO6M2XGDQtyeZQvJ6kfQ4+G35OpL8xjL0qbzoRaHHefC4aq3pmSixrGSNRfJGM78NE
 h0xoGGry9xCZn3cmOYqcqPR4C4DKph5p63KbH66PyEJdS3xLa2jY0iFRYOAOxslqEN
 I6IfBd5VRrQL55KcYV/ZbwncDmW2Zbe1qibzaObdHznFt3LPNEEKfq9J4tEnVeuxL3
 tx75jYutMgYkkYJU9iqlwT9TpUnKACzMJmc1fy6S2T472PbQQ8kLOO7TTuwRUk0Hy+
 by2DR0Y3BAqHQ==
Date: Mon, 28 Nov 2022 13:34:21 +0000
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8173: Enable IRQ when pdata is ready
Message-ID: <Y4S43XjRyrdm4Tha@sirena.org.uk>
References: <20221128-mt8173-afe-v1-0-70728221628f@chromium.org>
 <a214fe55-fb5e-04b8-348b-895902470b18@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mXbGyhu5lsnY5RXX"
Content-Disposition: inline
In-Reply-To: <a214fe55-fb5e-04b8-348b-895902470b18@collabora.com>
X-Cookie: In the next world, you're on your own.
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-mediatek@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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


--mXbGyhu5lsnY5RXX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 28, 2022 at 02:17:53PM +0100, AngeloGioacchino Del Regno wrote:

> This commit needs a Fixes tag, as this is indeed a fix.... kexec isn't anything
> new, so all kernel versions are affected by this bug.

Fixes tags are a nice to have, they're not 100% a requirement - they're
a lot more useful when they're fixing a bug that was introduced rather
than just something that never worked.

--mXbGyhu5lsnY5RXX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOEuN0ACgkQJNaLcl1U
h9BVzwf/W/HVqeLRVgVFl3uE+TfDAXzjIy9TDRW7DrWbkN7i2uH7bVGlYEoAecj8
VJD5KtVKChD32froEJ2N+lbaEjonWwUDQyB8tP9yNe/jXjqwUqROmAoUlLKYaGuL
vZZw8pKHpTo/UXf497QSCSARIrRu6fCZcCbFPrj9QUKsvXjJoLCgqgNcVlz/u0gG
uI14fz9Jw/YZUYuD6ESLnwFQqjgWQ0jBP0R/FeW0B0juWdoo6n83K98EC3Zv5FWW
u0RTdWzRWf/wnMuQE0pdt+Dc9qdygMXbmEO1oz8axtoxac0VlMXVSR85yzZ75Y60
cb2bOJZXHcYZZSz2WkiFVLOLZiCpdg==
=G3Pk
-----END PGP SIGNATURE-----

--mXbGyhu5lsnY5RXX--
