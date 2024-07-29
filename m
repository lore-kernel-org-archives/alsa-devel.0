Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A69C3DA61
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:42:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42DD8E82;
	Mon, 29 Jul 2024 17:42:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42DD8E82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722267755;
	bh=HqkjoguZvqsKPeQskLKsPhwwJrvtg3CvezSRwjNzBws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KBgvA90ZcT1cPK+MiqwsEDvGM+hRs2ICY2nOxt0u1C9VT82OQV2w5C8Eb+jWDknIa
	 XgsdNl7rl/9PmA4/io52qToB9XbSNw8bTN7TxzpFLA5LubjCoQljq7YFGyAKD1qxOW
	 H1tLNXn24P5JLJPbZBUHobzQptx8bHFHBFah9s+g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CF450F805B6; Mon, 29 Jul 2024 17:42:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5002FF805B5;
	Mon, 29 Jul 2024 17:42:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57045F80269; Mon, 29 Jul 2024 17:35:19 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8D1C8F802DB
	for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2024 17:29:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D1C8F802DB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=O835ec6e
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DBF1661B13;
	Mon, 29 Jul 2024 15:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E4BC32786;
	Mon, 29 Jul 2024 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722266942;
	bh=HqkjoguZvqsKPeQskLKsPhwwJrvtg3CvezSRwjNzBws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O835ec6eJaDgRRqJR5TsUi/ibb7o8jjFGVntcxx6cOdHy75Fs1xm48CJFucmRnZFf
	 HG93JYpoIqtCTzqlpM7SBwg4++uhVy5YCk0hpzkoz6yOv4spu4kYGTS5mHk2p5UzUW
	 svG2EtDnLTM1oS2HeikUj9xQPzjmoDejAmDkLKgh6SMeCJ1FMzN9zL8umauPy9NVcp
	 +dX/cdEn84vpOylMy5wXer0T/L6YgucTgJ7wfpTkuqZkr5pFZTkpIKdhdrYiZkDd5i
	 0viI2rnol21t6NduTcBa6nVQe9F058PEwbQqtKpAc1FbnUPwyFIObVhVhm3yFpaYAX
	 oXG+XE19kyIYA==
Date: Mon, 29 Jul 2024 16:28:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH v1] ASoC: meson: axg-fifo: set option to use raw spinlock
Message-ID: <7dfdade5-3a57-4883-bfac-067c50ec0ffb@sirena.org.uk>
References: <20240729131652.3012327-1-avkrasnov@salutedevices.com>
 <1ja5i0wags.fsf@starbuckisacylon.baylibre.com>
 <2b16b95e-196e-4d8a-98c3-3be568cdd18a@sirena.org.uk>
 <1j5xsow839.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RyUOgkh7sxl4UhKN"
Content-Disposition: inline
In-Reply-To: <1j5xsow839.fsf@starbuckisacylon.baylibre.com>
X-Cookie: List was current at time of printing.
Message-ID-Hash: UN7JXQZ3LLMINDYGN3ORYGCQRCKKLTQG
X-Message-ID-Hash: UN7JXQZ3LLMINDYGN3ORYGCQRCKKLTQG
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UN7JXQZ3LLMINDYGN3ORYGCQRCKKLTQG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--RyUOgkh7sxl4UhKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2024 at 05:06:50PM +0200, Jerome Brunet wrote:
> On Mon 29 Jul 2024 at 15:44, Mark Brown <broonie@kernel.org> wrote:

> > I don't recall this coming up much TBH.  It may be that people just set
> > raw spinlocks when they need it, or that there's not many people using
> > relevant devices with RT kernels.

> I have not been playing much with RT TBH, but AFAIK, with RT irq
> handlers are threaded unless IRQF_NO_THREAD is set. In this case,
> something preemptible in the handler should not be a problem.

> The axg-fifo drivers do not have IRQF_NO_THREAD so something is a bit
> unclear here.

Yeah, it's definitely likely to happen all the time for people using RT
with relevant devices.  I'm not sure I have a good sense of if it's
likely to be a nasty surprise to switch raw spinlocks on by default when
it's currently controllable, I'd expect it'll generally be fine but it's
possibly a bit rude to any users that don't use interrupts...

--RyUOgkh7sxl4UhKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmantTgACgkQJNaLcl1U
h9C44Af9HvsmmLk0VmGmh8xg7Qy0Az4bExNuz32UcirchZh1/10ZgzU4P5Z9JMdF
vpHcBjvsrLKNbqzxKAgQEBwkF0DoasgukZsKqYtM+7egDiXPN6KKvM0Uq1f2ZkNY
EhJatJ5UkZHE0Jku8I0eRLkaGi8ERu23A/HkUDa/jZ65v2iUMMxeoFh/D2MxpKU5
VXbuPlITsDbMqXMqfNfUBCT/h1jnSTWPI2bZ/WYky5GEUMfeN9ur4hEkIa+H+qBV
nvMo2aV08EjX0tZ+ZjRmt11xAXhg7CC/2y9/7gqzlZailMmIlrdtL+7fr0DTkIe8
VNsHlUV0/kkcM6F7UijIgO5lQ8Z4nw==
=Q7xF
-----END PGP SIGNATURE-----

--RyUOgkh7sxl4UhKN--
