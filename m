Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B20AC05027
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Jan 2023 08:02:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 179A784C;
	Thu, 26 Jan 2023 09:01:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 179A784C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674720161;
	bh=ezg2eabCWSVB4l7XhnzfHs+x1Vn9MQYl2SLTazGntOk=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=D2xW3VOVrxWV+fjtGTwwjowQgWkq9liUarBkmFQsRab17KogZ1jYFkgvzRU4fEbC3
	 PsrpfIERuUQjbZf6FeJ36dB4X4wauoqZm5POCWb7nY/Fy5PwhMhD+IMsLcBLlipdf4
	 IStCy/SgajrHGD2qNgsvkbOAinqG8jLlH+cdYxUw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11839F805F2;
	Thu, 26 Jan 2023 08:55:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B3A7F80424; Wed, 25 Jan 2023 12:41:52 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D876F80163
 for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2023 12:41:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D876F80163
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uU/+AR2C
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E166C614D4;
 Wed, 25 Jan 2023 11:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1CFC4339B;
 Wed, 25 Jan 2023 11:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674646908;
 bh=ezg2eabCWSVB4l7XhnzfHs+x1Vn9MQYl2SLTazGntOk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uU/+AR2CwjeymulismW9BMOZiWHGFUxIhzBe/aKJI2+1c1gGId0ABjLtUTu03obBG
 0TFOLM7sjKuh6JqE19PasKUw/fvnXB7YE0xCaFg5WiyMAIKVkKtlhBM5bqlPOX0vF2
 jqOIv4Lzg2mbrHyFDTB/sT/C2DMoFJbEIIYrevZ3CAW7a2KiT9E0Re7km+4HgBgIOT
 zZP2aSxEMoUywBiSAljmGYeT2e7Ev0v8lhU58lq5FU2XR7xxT3c3QzPrbzSP8csD9I
 Q2YYEKrr+65C+KSNc3vZRbtDtiQJKw0dwU6Ei7YFxw7oqI2CdfL95Y8MAebk/UDJgf
 Dh8XnNgakkOTQ==
Date: Wed, 25 Jan 2023 11:41:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Add missing
 (unevaluated|additional)Properties on child node schemas
Message-ID: <Y9EVexQ3yAN1n1NF@sirena.org.uk>
References: <20230124230228.372305-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j0ZYRAV1FZ0iGu90"
Content-Disposition: inline
In-Reply-To: <20230124230228.372305-1-robh@kernel.org>
X-Cookie: Serving suggestion.
X-Mailman-Approved-At: Thu, 26 Jan 2023 08:55:02 +0100
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
 linux-mtd@lists.infradead.org, Lee Jones <lee@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 David Airlie <airlied@gmail.com>, Marc Zyngier <maz@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Jassi Brar <jassisinghbrar@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 linux-spi@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Richard Weinberger <richard@nod.at>, openbmc@lists.ozlabs.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--j0ZYRAV1FZ0iGu90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2023 at 05:02:28PM -0600, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present.
>=20
> Add unevaluatedProperties or additionalProperties as appropriate, and
> then add any missing properties flagged by the addition.

Acked-by: Mark Brown <broonie@kernel.org>

--j0ZYRAV1FZ0iGu90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPRFXoACgkQJNaLcl1U
h9DUcAf7Btv4DlmnSpwnSwLLZLZjLHnfTWVpZJ81qaPCs4SvmkBNiQxX1s9Vld21
8O/QaZxTRJp7+kru4tljDPFtPWIPRvcqVwgCtUoOJ2AIEKapcFBMVIh7nidnnNjs
+LXDzG2e4va5huH2/ghU9TQwULN6X3M3UY8y/sq604qT0koHoN9zoZo5idZF7BSQ
/GVeXQzXzB3UgOLv0hHuuQ9sD8QDIHfNn7ThUEPWhDwvinpB7VqkiIOD8nrr9mhr
AdbkpaWOi2iv3A5BgxyGFDMufybabjkqztUT54muSHZDxbCjU7vUe/fyyK1NEQGa
sgZbeoPjsTAlgN0ytBYi1aQSUR2wLw==
=DSza
-----END PGP SIGNATURE-----

--j0ZYRAV1FZ0iGu90--
