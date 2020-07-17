Return-Path: <SRS0=vkql=A4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B24C433EA
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:23:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3572F20734
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gowmYZTM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfEOvqoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3572F20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE84F886;
	Fri, 17 Jul 2020 13:22:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE84F886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594984987;
	bh=4Ytl/sJApXV4/rt16Tz5YqZRmbwVqcvOPJ+WrmLBSIw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gowmYZTM4QCXPYbo9XaHReUgeUwhebpedI5Edji963MrzWsNbnY89zywAuhR4o0us
	 1hqyUkKI1V/3rifOL6AwY41SnFn9ItLfmxaIuCB+FUM5Q+XPqFl0FG3cg4waaMeUJ9
	 P9Kvv+YavjMOwQB555/T6pkME9xcpmrVReQMmfjQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5634DF8014E;
	Fri, 17 Jul 2020 13:22:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0F676F80217; Fri, 17 Jul 2020 13:22:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3307BF80110
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2020 13:22:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3307BF80110
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AfEOvqoS"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2B94320734;
 Fri, 17 Jul 2020 11:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594984927;
 bh=4Ytl/sJApXV4/rt16Tz5YqZRmbwVqcvOPJ+WrmLBSIw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AfEOvqoSmBqSuZ3IGZrCNgaEKKyAJrLH9mU99LQvawWDxFCaTs78HCYeflnfPK61R
 tJqGICRWpojrt4iXZhd8qKRhlYtLUGmPmXBEK+GAU3j/Kvof1igZFdi0/lE21Q0eL2
 lZT/XLVFvff+JAIz+bdonDDX9JyTGaCqUDa72oro=
Date: Fri, 17 Jul 2020 12:21:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH v3 0/1] ASoC: fsl_asrc: always select different clocks
Message-ID: <20200717112156.GA4316@sirena.org.uk>
References: <20200716232000.GA27246@Asurada-Nvidia>
 <20200717103857.31877-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20200717103857.31877-1-arnaud.ferraris@collabora.com>
X-Cookie: No other warranty expressed or implied.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Nicolin Chen <nicoleotsuka@gmail.com>, kernel@collabora.com,
 Shengjiu Wang <shengjiu.wang@gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 12:38:56PM +0200, Arnaud Ferraris wrote:
> This patch fixes the automatic clock selection so it always selects
> distinct input and output clocks.

Please don't send new patches in reply to old ones, it buries things and
makes it hard to keep track of what the current version of a series
looks like.  Just send new versions as a completely new thread.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8RidAACgkQJNaLcl1U
h9BABgf+McXrUIeMmHD9s/UnkWkyNJ4PKl5NQIIRBqxooaMsMM8EleOfLVIvm21q
gpXLvv741e7NL5slM0lyEmbPOGkrOlQtAXqQRfjXrE058oe69xfZc81UBJyY/qGs
6FHaHrv/I7t8Qi/P4omXIkWV7o8dYepW8bqoGmGaj+sWokZRH/2t+RtUhIqWGL/T
h2GOGFLnNU62s0KhCin26ASw2lf+Yn7aiVPylMz985lOH+eRL6hCaCnWFEeeoeyC
Ik2ICPmAdoqofYG6Nh1Su1w4hZC6gAhh8VheBeHjWoK5+6rJcRZ+uB1cWwSl458n
kGpe9Jse9m2ZILav2E4WlGb5ncO4JA==
=UqXD
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
