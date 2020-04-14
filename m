Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC488C2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:38:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64223206D5
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="skMTZpWJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dx7zmByF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64223206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD70B169D;
	Tue, 14 Apr 2020 13:37:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD70B169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586864286;
	bh=rBfPN/ao44IgV8u6nut9I0cnbZOEwRrUEaznfJbJcEs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=skMTZpWJE1hXg8L5DjwC6ObTqYhbDQV22eEvUatulGavs+H9MiHJzRCLZqVSMp0p3
	 NiGCF0HLP6bO92ygbLsjMJEWYT+y48EbFk5zBkhRTJgJE0RMjJ9nr2kv6DNc1EVYdY
	 R6awJSV/izCnIvMXKJqphthib4Xras9SYCJz4C28=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF3BEF8016F;
	Tue, 14 Apr 2020 13:36:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD21EF8021E; Tue, 14 Apr 2020 13:36:42 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 128D5F80115
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 13:36:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 128D5F80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Dx7zmByF"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 13A042072D;
 Tue, 14 Apr 2020 11:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586864197;
 bh=rBfPN/ao44IgV8u6nut9I0cnbZOEwRrUEaznfJbJcEs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dx7zmByFwnWZhiXSn0JMjnlzaVgVG94arpZwp8n3bJcUozE2n5gxsVc7/P7aK8zf+
 XsIILNNT3HUMpZlY3ZE/+OOV9Kp0lV3/4YkwS4y/OTTBm+xrDpD+OGlTT6AeEjWu1z
 AWMhZ6sbqEvWEYTpVIIH0G9/ifA+dnWi1zI3aRrc=
Date: Tue, 14 Apr 2020 12:36:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Philipp Puschmann <p.puschmann@pironex.de>
Subject: Re: [PATCH] ASoC: tas571x: disable regulators on failed probe
Message-ID: <20200414113635.GD5412@sirena.org.uk>
References: <20200414112754.3365406-1-p.puschmann@pironex.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
In-Reply-To: <20200414112754.3365406-1-p.puschmann@pironex.de>
X-Cookie: I've only got 12 cards.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, tglx@linutronix.de, cernekee@chromium.org,
 nhuck@google.com
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


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2020 at 01:27:54PM +0200, Philipp Puschmann wrote:
> If probe fails after enabling the regulators regulator_put is called for
> each supply without having them disabled before. This produces some
> warnings like
>=20
> WARNING: CPU: 0 PID: 90 at drivers/regulator/core.c:2044 _regulator_put.p=
art.0+0x154/0x15c
> [<c010f7a8>] (unwind_backtrace) from [<c010c544>] (show_stack+0x10/0x14)
> [<c010c544>] (show_stack) from [<c012b640>] (__warn+0xd0/0xf4)
> [<c012b640>] (__warn) from [<c012b9b4>] (warn_slowpath_fmt+0x64/0xc4)
> [<c012b9b4>] (warn_slowpath_fmt) from [<c04c4064>] (_regulator_put.part.0=
+0x154/0x15c)

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6VoEIACgkQJNaLcl1U
h9Bo0Af+IXKF1Q32vmdETtU29TWHcGhIhdcsD7Z71zelETh1yMnDCbxnSv+CocWU
qZBG45EmfRWXLQAmNIKdHXKoCy5MwpQ/5pr2MszFdOB5Z2NwsDCn02ohUqguX8z/
EjJWqkpINlYhE4wAr+6oBrl2Vqjre/lFhZ+vhh2SHzQue4kQeNqajDUDzMnlUSJV
XMIL+u15zTB3c7TmvxmTp5cm8scjEDyVXCNZE6WFTB3irUtIkklfcNQwM3ykAXo0
tmkGH4cImu+dHNW7fw3HUhcGJMS+go2RmSuVeOdU0bkvmfvfw4MRnZoIr+Do3Dv3
cZNfkS8B8z6UwsNQNqES/11xfjt/fA==
=WKEJ
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
