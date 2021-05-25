Return-Path: <SRS0=iQjD=KU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCBBC4707F
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 21:50:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A82613E6
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 21:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A82613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB92E16EE;
	Tue, 25 May 2021 23:49:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB92E16EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621979409;
	bh=H0WLAylnE++sXQ78iy/bAoWvJYiXz6AZuQYgf9v75cE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k6BVy8Z3NjJmI2eo+j2p/ccYn9PEwR+cOUy+zJ6zmsQeYotXRqAicovK3I31TF0dP
	 6tqoHg8voMRWisJJNnI/J/VFRpiZQkJotjzwdKQY9Hlq9nSMdSvDNujkjToq+oiTJz
	 q+yEZ/D3ireJsLi6nyx/RVBrqYgSHIh3zbAKiW1Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 442A3F80032;
	Tue, 25 May 2021 23:49:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10C35F800CB; Tue, 25 May 2021 23:49:18 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F2CCF80032
 for <alsa-devel@alsa-project.org>; Tue, 25 May 2021 23:49:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F2CCF80032
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="p2D+bXjs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h1UvXr+IRNohjqK913qBRc1ANsdAb76bs7rLunSi2xs=; b=p2D+bXjs9h/DiPW3j3QeaeX6Fi
 Eu7RY6n21Sd6xg0F1xMdF0eBRKA4iPAjQ/NqZUix/9unmc/dOQPudpdzLIr2umK8LRxyfmdL5mhdL
 vWe0o/4zRCtE0jVh5g6WsUCa0dV/rWVl9pSlg0V4TnSR0wSBR2sFBWJlwSAOCS7r2bdk=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140]
 helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <broonie@sirena.org.uk>)
 id 1llevG-005qQM-UN; Tue, 25 May 2021 21:49:11 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id C0FD7D0DECA; Tue, 25 May 2021 22:49:44 +0100 (BST)
Date: Tue, 25 May 2021 22:49:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.10 30/62] ASoC: rt5645: add error checking to
 rt5645_probe function
Message-ID: <YK1w+H70aqLGDaDl@sirena.org.uk>
References: <20210524144744.2497894-1-sashal@kernel.org>
 <20210524144744.2497894-30-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+9E0EyJd3tE2r8IF"
Content-Disposition: inline
In-Reply-To: <20210524144744.2497894-30-sashal@kernel.org>
X-Cookie: You are always busy.
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Phillip Potter <phil@philpotter.co.uk>
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


--+9E0EyJd3tE2r8IF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 24, 2021 at 10:47:11AM -0400, Sasha Levin wrote:
> From: Phillip Potter <phil@philpotter.co.uk>
>=20
> [ Upstream commit 5e70b8e22b64eed13d5bbebcb5911dae65bf8c6b ]
>=20
> Check for return value from various snd_soc_dapm_* calls, as many of
> them can return errors and this should be handled. Also, reintroduce
> the allocation failure check for rt5645->eq_param as well. Make all

Now I've looked at the patch I don't think it's appropriate for
stable, it's essentially equivalent to a patch that adds -Werror
- the changes in it are upgrading things from error messages that
would be generated by what are essentially static checks (even
though we do do them at runtime they're on hard coded strings) to
probe failures which would be a regression.  Unfortunately people
do ignore warnings like that in shipping stuff so it's possible
it's happening, we could do an audit to see if it is but it seems
like more effort than it's worth.

The only case I can think where it might help is if we're
managing to OOM during probe() but that feels very unlikely to
happen, and improved handling unlikely to make substantial
difference compared to the risk that the routing warnings are
triggering but being ignored so someone's sound stops working due
to a stable update.  Otherwise it won't do much so why risk it?

--+9E0EyJd3tE2r8IF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCtcPcACgkQJNaLcl1U
h9BhPgf/QwPQszIviJZPkEDsCrlmdi0IWBRg2sa+8dwinV4RMlV342IGAtTEZxIY
hhdgJ0BM+pCEhXHbHn1ZprphK6eEuiescflqk4RywaFM/AakFvuJRMdoazcNXkZI
zNdS1yuaimfHHJ4/HkD463ikeXEBehoH+Fkrp/6qM+lgo5UZwtZ/bG6EBpUmIClK
JGI+WZkysyx+qzoVHIF5weXw+oCkvjz/Qby83mWjK7KOM4MnB0x9PtKOyRURXrZJ
82L7/uM8heK1LujQKxr+FoVVfkdr6ymBvatZpbLYt5JlLQoT3K7PdDaPj1ULNVke
KLM9pJwHanFu9ia/yC7okZgonz1VBg==
=ygou
-----END PGP SIGNATURE-----

--+9E0EyJd3tE2r8IF--
