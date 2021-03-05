Return-Path: <SRS0=qX2V=ID=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5563CC433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Mar 2021 10:01:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E64164F45
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Mar 2021 10:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E64164F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3347D179F;
	Fri,  5 Mar 2021 11:01:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3347D179F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614938510;
	bh=iXAHy5BOnS3Ym4ujhlUunW7eBo1jNbrjRgnTKd3X0uU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=euzHnoG6qJ2j/3GHZH8gTFxM+EAVxskBOKMFSplXtsT2nVvYztmHD1ceIt+/BtD0p
	 pi3yVpFYB7G87Xyl7kRTjacI+FSJxfNxBnSZ2jo57nmcEqxtVysppJXoXQQepHwgxr
	 5w7khhyhRd+V7tjrJAp4Pu/sHgd9vQfJCK95Ps+w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99F2DF80257;
	Fri,  5 Mar 2021 11:00:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30333F8025E; Fri,  5 Mar 2021 11:00:58 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1BC71F800ED
 for <alsa-devel@alsa-project.org>; Fri,  5 Mar 2021 11:00:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1BC71F800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="E8//iS9K"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D775264F45;
 Fri,  5 Mar 2021 10:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614938452;
 bh=iXAHy5BOnS3Ym4ujhlUunW7eBo1jNbrjRgnTKd3X0uU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E8//iS9KRszuQYdoNhRFsVEbjtsM4GZs6tzmvt9SxnI7ScotC7kNoyfTlr3Pw1YSP
 kzGBbDcdA+V8G32mpQmg20ZAdW7d2vAe2N4YPC8WY1oUBdwO8HS/XPH6Zq0leXBr/r
 w50pFoaJsBUVSMQsTeRceFbzaP3M+FqULXtPQcphJr+cYIvR/QX0z5j8PWVydsNT8s
 WSsmsWey8EXO3Gb1e0P4YdB0kLXaIogU8aBTyFxdlIppoOKS8KBBArfgKLiHg1ZPhA
 KsQFR+gvwOTYVVpKceW6ldfQsjmOusl5S+bJtRmdFChsnIhuuNifg+0DjCe77kb14O
 VZRQj9aRCp8iw==
Date: Fri, 5 Mar 2021 09:59:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Laxminath Kasam <lkasam@codeaurora.org>
Subject: Re: [PATCH V1] Add debug print in soc-dapm
Message-ID: <20210305095943.GA4552@sirena.org.uk>
References: <1614927242-19251-1-git-send-email-lkasam@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <1614927242-19251-1-git-send-email-lkasam@codeaurora.org>
X-Cookie: Shipping not included.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, b_lkasam@codeaurora.org, tiwai@suse.com
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


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 05, 2021 at 12:24:02PM +0530, Laxminath Kasam wrote:
> Add debug print useful for issue analysis in soc-dapm.
> This print for dapm widgets useful for debugging to find
> widgets powering up and down.

There's already fairly extensive tracepoints for DAPM - this seems to
correspond to snd_soc_dapm_widget_power, though it's at the application
time rather than the queue time so we could add another tracepoint for
this if you like?  I can see that the separate tracepoint would be
useful, I mostly use the regmap tracepoints for that purpose but not
every widget has register I/O.  Tracepoints are less noisy for the
system as a whole than tracing every DAPM operation in dmesg, that tends
to irritate other users if it's left in as standard.

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBCAQ4ACgkQJNaLcl1U
h9BuUwf42rTgSMYbahQ1Ck8Fk9rXuv0aGI82BcoBl8aWhvWAEGks5zz8Cga3RrSt
mHgGVsXVkMJ1GgX6wBJdcQ3HVVoCni0G/TPOVBqkCXT2Oo6VQ/Kqr5c9X/mfQFi3
RvwU60zOIE/GN+4Cr7GKAeXCNE6PjeMIAcGbLUM4xM8upeESsBLh31BOoM3YUfM1
zW4+cXCfA9peLwzDnodC0wRxkFEefmX5RnmOgV7WQ5YPbEaxDQ/NLRr4rRRYkPad
CKI66pcKduIGPJV+TIuOWWwQ4c2lu7O8JIN9fv+Bh7U2wC56nepK7Dp+Snrcjc8H
hR6DjrSO7j3RuDTeDz6pDJsEmpOl
=oDdq
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
