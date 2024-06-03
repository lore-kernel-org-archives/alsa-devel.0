Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE54C25B75
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:23:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD19C84C;
	Mon,  3 Jun 2024 17:22:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD19C84C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1717428180;
	bh=aA3t6AtzH0dxyZQ/b6e+4u91SqW6efiyYat2JPiMyI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hCA9PXcInmv8hCE6DBBDwkNuDuWhxp8iPYQl9HkMW73MuH7uOL1N7vu/bMi0z2s7t
	 1kl8vjblASBHWVJzggSERRp25rNKKkeW7ovaZVqyZY3Ljt/GyjDYTHJpyd0FtVDmwb
	 4HT1otbru74nZsO1W3LHrqMWCxScT+XD4VTGXHlg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 732FFF80088; Mon,  3 Jun 2024 17:22:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F1A6F805A9;
	Mon,  3 Jun 2024 17:22:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 96CCCF8025A; Mon,  3 Jun 2024 17:22:25 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3D2ABF80088
	for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2024 17:22:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D2ABF80088
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=pIvjks5A
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5A48FCE0E0D;
	Mon,  3 Jun 2024 15:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28907C2BD10;
	Mon,  3 Jun 2024 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717428133;
	bh=aA3t6AtzH0dxyZQ/b6e+4u91SqW6efiyYat2JPiMyI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pIvjks5AoVluZfMA3Wk1JSJx5EKY7pa3A1J4ZhCIrg2F2O4YJaaX3Y0PEgvU/A54H
	 pN7aEdp26lB4WkY+0vcGW0ACK/XdJLtAle+GdYrKH0gpDijiwSCzHCUISPnkrf0ML4
	 S5xsR3cFB4rl7qqJqxk+AyK5FVwQAyLI7zgU1ksITHmA+ZwS4n4SgZSJRKm/Kp3swh
	 ttagu9cBARvcc/pqd8PoojnUrBkdCZmpyec0F/jkBnnvM6QNCyCOtfTtnC1Kqo5WIA
	 jaYODqMk6ZevJHHfnQPHCFLpCFehe7m/uMDWiM7ShLmIWvhXYuuZV7y4MQEJrEpIhR
	 q5Rx/dNQqGPbA==
Date: Mon, 3 Jun 2024 16:22:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] dt-bindings: sound: tlv320adc3xxx: Fix incorrect GPIO
 description
Message-ID: <d8da45ee-d996-4043-9bc9-f94df52540f6@sirena.org.uk>
References: <20240528-tlv320adc3xxx-dt-gpio-fix-v1-1-209fb2c2f86f@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QVLkXQLHvp1n2raV"
Content-Disposition: inline
In-Reply-To: <20240528-tlv320adc3xxx-dt-gpio-fix-v1-1-209fb2c2f86f@axis.com>
X-Cookie: Don't let your status become too quo!
Message-ID-Hash: UCVHBLMUPPBQERBI4ZYTD7RCELF5B2WJ
X-Message-ID-Hash: UCVHBLMUPPBQERBI4ZYTD7RCELF5B2WJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UCVHBLMUPPBQERBI4ZYTD7RCELF5B2WJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--QVLkXQLHvp1n2raV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2024 at 05:40:04PM +0200, Ricard Wanderlof wrote:
> Fix the description for the ti,dmdin-gpio1 and ti,dmclk-gpio2
> properties to correctly describe that when configured as general
> purpose outputs (ADC3XXX_GPIO_GPO), the pins are available via
> the GPIO framework.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--QVLkXQLHvp1n2raV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZd358ACgkQJNaLcl1U
h9CLzQf/b+lwQaBGqVNATDsBF2IwxA1qUDV5bLz/4HDHSc5OhqKJ0IvCZmP0ZeVb
RktIPoEpdLDxtlQZgleTML5wFRFTsQabYXOFxOihSj7l+FNAqaH8I/CeibarFAXk
+OSKfIsJADrycI7tLfOjcVcX4pmlkiNKOrfNOSOtMiEWhVjDCdPxiovYb1x01lVA
5YsXXa1vz7oLXY3WY2VaVBirsmWVN/pGQktSvSRFBb0nfzawbBJIHeMC94UQKp7F
Th+f+F7QU0cuxAONGIKXF9GGkuXL9GJ6vJzs/pfaixWv9ASwC7gye9prfpGQYVnI
9jS/EKt7f1EEQbL9pRFpm/+qc1zhPA==
=2QNh
-----END PGP SIGNATURE-----

--QVLkXQLHvp1n2raV--
