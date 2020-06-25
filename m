Return-Path: <SRS0=XzTt=AG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64258C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:12:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E286B206FA
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ryNrX/p3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0Kqk8PEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E286B206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BB1518BD;
	Thu, 25 Jun 2020 13:11:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BB1518BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593083568;
	bh=Xk7Z1hzEAFQ/oa/0BTgtTJ/M3KM81AcaoJUjPINXEoI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ryNrX/p3QKOtwFuhiUYRM0yPIntn5eyEOeGTqlyKwqNKH5uZ+NEQFcfTzw3i8atRz
	 sW/VMBSRzekOa6i0B7x9RL9xzcikAdr8dl2ym16H1yrwVJKr+kWWtixkXRRuISfb8J
	 afD5KCLHnNmO0Ahka0V6ZLYtNy+yEsBd2SRAH0aE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D32E9F80218;
	Thu, 25 Jun 2020 13:11:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B00A3F80234; Thu, 25 Jun 2020 13:11:55 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83610F800B2
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 13:11:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83610F800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="0Kqk8PEs"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 758AF206FA;
 Thu, 25 Jun 2020 11:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593083505;
 bh=Xk7Z1hzEAFQ/oa/0BTgtTJ/M3KM81AcaoJUjPINXEoI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0Kqk8PEs+pcuRdInt+xzLxrhrW8CACYxRWM56DKkpFWdfCKCuARqlKjoYbKYZ5Wga
 CivqY8Dcj4xUyXBo2Hu8gieDdGr09DuMC3hZZycN7rrypNtoQaXMHspvvUWyvp15gP
 8BqqmTWSR9l2RCHoBiYTiYZBc4Q3CWxX2+qrBFOE=
Date: Thu, 25 Jun 2020 12:11:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH V3] ASoC: amd: add logic to check dmic hardware runtime
Message-ID: <20200625111142.GA5686@sirena.org.uk>
References: <1593025336-21482-1-git-send-email-Vijendar.Mukunda@amd.com>
 <94c72bc7-6448-6d6f-d59d-4d6b30d20107@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <94c72bc7-6448-6d6f-d59d-4d6b30d20107@perex.cz>
X-Cookie: One organism, one vote.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Alexander.Deucher@amd.com, hui.wang@canonical.com,
 alsa-devel@alsa-project.org, Virendra-Pratap.Arya@amd.com,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>
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


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2020 at 08:55:45PM +0200, Jaroslav Kysela wrote:
> Dne 24. 06. 20 v 21:02 Vijendar Mukunda napsal(a):
> > Add logic to check DMIC hardware exists or not on
> > the platform at runtime.
> >=20
> > Add module param for overriding DMIC hardware check
> > at runtime.
> >=20
> > Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>=20
> Reviewed-by: Jaroslav Kysela <perex@perex.cz>

As documented in submitting-patches.rst please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl70hmsACgkQJNaLcl1U
h9C4fwf/aLFj16IQtEyLnZdfB5JUABxqHKYFFan4DrhVkhQ2UNsi2rtLmxHB9uX4
JYf1zgApKxw+4pit2oJSLYgirE36Vn0XnXZHkzsG6eXpMxs9cwW4lIRQz3sM8gke
wAY7RriX/cydN63On4hp1z251KYRwWhvnf+PM5tTp4PMeW6LlbsHQf+Bv/NJMx4u
r4XwkoJ6MtgS3v8yyPA+J84eMu7KAmertycIuNqfSq3E9kLdgPdaawczgfZIlUpf
AdBX8xK8/V9oyZJRMLjOF679OZ9csXTruI2vbuwe3BRKzF8wuvK0mrKbipMI33kz
chgXaHjw2TraxcN82MpHxPPk35ksvg==
=qP7y
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
