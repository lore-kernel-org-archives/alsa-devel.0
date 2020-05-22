Return-Path: <SRS0=jkt5=7E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60418C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 15:33:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21CE206D5
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 15:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="J/P3sLLg";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtUCBcKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21CE206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E3331865;
	Fri, 22 May 2020 17:32:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E3331865
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590161617;
	bh=JEBQQ2eQrUrGYHRNQi4KtS6AnflSfvK91vimjYRIrAE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J/P3sLLgFHCqxYEjnAjPQM/frzQnTMP7AYKMKW+8P39EoiY+x0/OYL25lzqrZQ6mf
	 9sf/ejBKjVg6wEQSipz6PfljO3BV3u3G0qGv2dsii8mFLJzPidpUd00JGFife2fVZ2
	 hiDS0LuHSIXvDkC3614TcAbzMtKs1TLIgW7Uynxw=
Received: from vmi242170.contaboserver.net (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AB52FF80121;
	Fri, 22 May 2020 17:32:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26B0BF801F9; Fri, 22 May 2020 17:32:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3675DF80121
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2020 17:32:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3675DF80121
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="mtUCBcKV"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 01A8820663;
 Fri, 22 May 2020 15:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590161548;
 bh=JEBQQ2eQrUrGYHRNQi4KtS6AnflSfvK91vimjYRIrAE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mtUCBcKVq5nNoi6xL1PEqmVCenqPvMkSVibzMcIjzcnY0RJgkgGfaf/Bn4x/3P/lT
 fwbsMtwHCnTQIPPRWpSfQsv4pagsb9m3nuIYVdQYMN0I/ZeRW27omFWwtPRMncTdgJ
 RKkNZ/UnYz+9BEGvnZTp18C3Uqso6TgSYEySvSHw=
Date: Fri, 22 May 2020 16:32:25 +0100
From: Mark Brown <broonie@kernel.org>
To: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH v2] ASoC: amd: put off registering mach platform_dev to
 avoid -517 err
Message-ID: <20200522153225.GM5801@sirena.org.uk>
References: <20200522081738.11636-1-hui.wang@canonical.com>
 <20200522110811.GB5801@sirena.org.uk>
 <DM6PR12MB2633D541378EB715AC18531C97B40@DM6PR12MB2633.namprd12.prod.outlook.com>
 <20200522112228.GD5801@sirena.org.uk>
 <DM6PR12MB26337FD48A99D14814EB32F097B40@DM6PR12MB2633.namprd12.prod.outlook.com>
 <2285006c-388c-810f-c1ac-ef76ab2319bb@canonical.com>
 <0acc99c4-6fe0-b613-4af2-5439ecd8981b@canonical.com>
 <DM6PR12MB26335DA69D595C332A20779697B40@DM6PR12MB2633.namprd12.prod.outlook.com>
 <DM6PR12MB2633FECD2F752EFE8DD4A6AA97B40@DM6PR12MB2633.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Vxa5joy26gVGOrvU"
Content-Disposition: inline
In-Reply-To: <DM6PR12MB2633FECD2F752EFE8DD4A6AA97B40@DM6PR12MB2633.namprd12.prod.outlook.com>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Hui Wang <hui.wang@canonical.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
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


--Vxa5joy26gVGOrvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 22, 2020 at 03:14:21PM +0000, Mukunda, Vijendar wrote:

> I have seen sample implementation of deferred probe in one of the machine
> driver code using late_initcall() API.
> Not sure how this api really works which will resolve the modules loading sequence
> issue.

What deferred probe does is keep a list of devices that failed to bind
with a deferred probe error code then every time a device does manage to
bind it retries all those failed devices in case the new device provides
whatever was missing from one of the others.  It's a bit brute force and
ignorance but it does sort things out in the end if all the drivers are
actually there and just loaded in the wrong order.

--Vxa5joy26gVGOrvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7H8IkACgkQJNaLcl1U
h9B8kgf/UGgL9n9lI5pdIOLC/fU9u6KuNm9VeqKwBGNdrH4E11j8wn3rprLqQtCg
P/YlwxHEuKbU9IHCnLyCKfij/Uk++fTKZRvjazUjC5561B8QVeeFswRV/+u0Nfv3
dxI9aS02WdrItEUUaGpb4Nx7dssHI34BWvmUe46ZTfQvvMYgUlFY7wPe1yaxN3bm
YUAh8CbPPl3m1J6SrZacJr2BC8ptUDqyOPGuikkzlHorI6Cl7k97gs2lH9zY8Tnu
Nd8z3SH1sWI/wFxPJD1DXxil8e6uTibnI0ccWvNuEpLBGweCXKNwRFG5E9JpBkq8
WHxZEVmyG3El5LxgpFjhOiYJBicydA==
=3qVG
-----END PGP SIGNATURE-----

--Vxa5joy26gVGOrvU--
