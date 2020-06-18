Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CE2C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:58:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E35332085B
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="E8UtEnvk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG3hPcg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35332085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66F921742;
	Thu, 18 Jun 2020 12:57:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66F921742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592477903;
	bh=vY2sHSYgz3FSMcrfG9KrkW9kDXXo8NuTjtpQOy2E/lU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E8UtEnvkUcqxahZcAreE3bMYvTSoK83VQ9rwgrSJrvx02ATd7Rv6mq8munwmZXZuq
	 hEjZMmC2lZOhECwVJQP0h+L9b7DUyQq7JnuHOxVzxSkFzEcD0ypaHPq5Tdbi1KcFXR
	 cb4C6HIi7nwg++Q7OipuVuJhFDxfBAvlvlRcFIUY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DA35FF8010E;
	Thu, 18 Jun 2020 12:57:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3334F800D1; Thu, 18 Jun 2020 12:57:30 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4EE21F800D1
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 12:57:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4EE21F800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hG3hPcg1"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 365632085B;
 Thu, 18 Jun 2020 10:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592477844;
 bh=vY2sHSYgz3FSMcrfG9KrkW9kDXXo8NuTjtpQOy2E/lU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hG3hPcg1C8sz2kAMaDAVmjGxfJ54TyooiyfBeTKxdTtslrW228ozcyIgBnZ6XLaSX
 A4wJXR8wKV47rxN0Fgyz+fIuqydSZMcXM2xat4fEJ+jNjzq1KbqrIKLOSpgpvRuQ/1
 6MGpBbPkMZnN9J3urbv1bFZtfrvHjGPznDLmeMfw=
Date: Thu, 18 Jun 2020 11:57:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 1/2] dt-bindings: tas2562: Add firmware support for
 tas2563
Message-ID: <20200618105722.GA5789@sirena.org.uk>
References: <20200609172841.22541-2-dmurphy@ti.com>
 <20200609173143.GN4583@sirena.org.uk>
 <bb7cff87-f814-1b37-c9eb-e68919e3c077@ti.com>
 <20200609175852.GQ4583@sirena.org.uk>
 <414a2d73-6d09-1e76-59c8-4943c0e8f720@ti.com>
 <20200609184734.GS4583@sirena.org.uk>
 <014b85b5-677b-569a-4eb2-74526d3f00bc@ti.com>
 <20200610102920.GC5005@sirena.org.uk>
 <84a6dd5f-cc3e-adb4-ae94-b4fe389adfd9@ti.com>
 <20200617220459.GA2884884@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20200617220459.GA2884884@bogus>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
 Dan Murphy <dmurphy@ti.com>
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


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 04:04:59PM -0600, Rob Herring wrote:

> Given bus numbering may not be constant, that seems like not the best=20
> way to match up devices. I'd assume that userspace needs some way to=20
> identify which instance is which already, so maybe there's other data=20
> you can use already.

There isn't really, you're putting stuff in the DT for that - usually as
part of the card binding.  I guess we could use that string rather than
the dev_name().

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7rSJEACgkQJNaLcl1U
h9AibAf/ZmP/R1X+W0rdK+oILKnjLxOdozk0Sprm6q6LHFutWUM6iachMjh1+7jW
N/B9nHZSkHAjtocF5Xlfzt/K1jS/mNa4c0DVBmnBALam88CbZshWAG7lwMZhkf40
DgLtkfZfyNCxFgd5/bTBcOZXnxLcWm1YHj45Pv/iOHtEhRDJ3UNmE5jry4DwjwSV
YVl4a1Jjaoth+Xgy3THO6M8DAv5PXlHT3ysJSOLY4rkrXlqQPdu8ylpqe8tymPng
Jv2FZWels3v9S+wWYj3OPbs2TkiTQE+Y34YaaxkTtz3FA4YktesN3F9mGUjE81jW
yEMbgNDVy1xaeFNm7q9geJCHfGdyvQ==
=DzpG
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
