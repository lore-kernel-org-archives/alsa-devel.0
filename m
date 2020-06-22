Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C112C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:05:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8408C20732
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h2Q3FA0K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLSiwOPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8408C20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03A5B16AB;
	Mon, 22 Jun 2020 14:04:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03A5B16AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592827508;
	bh=OtCXs6qM/P9EkBQOGbFbsuL3yixXLWMZlDM2pS2KULw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h2Q3FA0KPGUm5Auzv4P2GyzzzPx5TQDgsfIvAezAwOtu1gql7l3uK+shvIg/AOcki
	 /LPRCPJjKuaVgMVtRY1wG5bDClRYtsyLNH2rD03NOw+Ayg8LpGj/OmuBfJPUvNqO02
	 1yhJpcyeeT/BFXCu788lBkJ9ZeQ6lV7ONYwlHLrg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EC2FF801DB;
	Mon, 22 Jun 2020 14:04:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72085F8010D; Mon, 22 Jun 2020 14:04:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2BE3F8010D
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 14:04:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2BE3F8010D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lLSiwOPq"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 12E432071A;
 Mon, 22 Jun 2020 12:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592827451;
 bh=OtCXs6qM/P9EkBQOGbFbsuL3yixXLWMZlDM2pS2KULw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lLSiwOPq3kFltNjGmVtUTR8bqdRAZLMPunIKPq/ormr3CcYLEKhYqR99c7sOWbm6j
 QGDp3guukz+KDDmVFZZbM801EPjtvCQJHQ1Jn22iv/gzYz0+zqTS2g6Agann7ySK64
 D7rgZz7rr4H84BwzotL1cGZN6bQDlsmoSWEjnkqs=
Date: Mon, 22 Jun 2020 13:04:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Pantelis Antoniou <pantelis.antoniou@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: sound: Device tree bindings for the
 apq8039 sound complex
Message-ID: <20200622120409.GD4560@sirena.org.uk>
References: <20200619193831.12528-1-pantelis.antoniou@linaro.org>
 <20200619193831.12528-2-pantelis.antoniou@linaro.org>
 <20200619214126.GA1251@gerhold.net>
 <2070B433-83E0-4ACE-A470-36401934FC5A@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Content-Disposition: inline
In-Reply-To: <2070B433-83E0-4ACE-A470-36401934FC5A@linaro.org>
X-Cookie: laser, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Stephan Gerhold <stephan@gerhold.net>, linux-arm-msm@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Matthew Porter <mporter@konsulko.com>, Shawn Guo <shawn.guo@linaro.org>
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


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 02:34:23PM +0300, Pantelis Antoniou wrote:

> > This looks much like a replacement for ALSA UCM and userspace audio jack
> > detection coded into the device tree.

> I wouldn=E2=80=99t call it a replacement exactly. It=E2=80=99s merely a w=
ay to bundle all
> of this information about codec glue in the kernel (where it should belon=
g IMO).

No, you're encoding use case decisions into the DT here - for example
your example will break use cases like ring tones and shutter sounds
which should play through both speaker and headphones.  It's also
setting volumes which may be inappropriate or may be not and interferes
with userspace using those same physical volume controls.

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7wnjgACgkQJNaLcl1U
h9Dz/Af/ajnJ98C2qreuaWAPQ8PgLd/GE3P0ukq/sBXHzyMUg16weomHiWdIrtEZ
/78/EQEqwb8rigyHLVLC7P/BBmLH2XqpNu0tB0hhv4iN5ywyvri2U6LbDUIlSdKM
VieAO/eLiOmM7lC34jf5n6JJllQJGAFQlsJMeSdsBMim/xILhPXPAZ8Vw10PakkK
VWBCA2z5kQLlqU7R/90f9HqXaQFegxQJzJN4otivtTr0bNq3fYVnjs/l8cGoIM78
hHTm7Gg5dIPxG6u5SL+s6073hlMRzS1NOPCjz/9nuJgNV49BR9kvHT25GE2wPmLP
Pbq2xpkHMsSQSpnRaK81eKX9f3gp1Q==
=IFZO
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
