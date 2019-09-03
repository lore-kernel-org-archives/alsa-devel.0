Return-Path: <SRS0=Sdsu=W6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E48C3A5A2
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:52:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016E022CED
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AkXJvKKZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="OSASgU51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016E022CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F4481699;
	Tue,  3 Sep 2019 19:51:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F4481699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567533134;
	bh=jV4+foI6HyMTg6yCDztHzCfEi+FregsgE1zKpLA6eyI=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AkXJvKKZ2A5xJVFE2vTpliJPAlXXiSxHdZ/HtozzbB7aJUHZl1cXbeqdtY0q7fSe8
	 xNjtSqwSmu6mQnO2KgxZGMbtwQOdkMR/DJ4p/G2KFlzEQnb3LL/JfRoBWDC1fAcQCh
	 6kzKuGAIc/HaIEWHslKGKV7LQ/tZq9e0l4FEl/0I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D89E9F803D7;
	Tue,  3 Sep 2019 19:51:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C2F7F8045F; Tue,  3 Sep 2019 19:51:23 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01410F8011E
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2019 19:51:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01410F8011E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="OSASgU51"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q+SSachjWA+Ai0Gxoedo/qepaIg7P6HJ+wtQ+NCC7h0=; b=OSASgU51aH12qz68XtyFQLmMq
 VCwvaPvO7gx+BqoWuPjKJO21eOZtixoM8GxA2GK/1bAZ0Bd9QJE6pEiOXwih1a7AMlNlNbdzypMmd
 9UTNwdL58acDqL49tMIjpxYADq1DbMoSy7Zumv2g8bF0f6th1uZ/PlCIke01D9i1gWnws=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1i5CxW-0000um-9x; Tue, 03 Sep 2019 17:51:14 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 9C5612740A97; Tue,  3 Sep 2019 18:51:13 +0100 (BST)
Date: Tue, 3 Sep 2019 18:51:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Message-ID: <20190903175113.GA5914@sirena.co.uk>
References: <87o907eby5.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
In-Reply-To: <87o907eby5.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Join the march to save individuality!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: add comment to jack at
 soc_remove_component()
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
Content-Type: multipart/mixed; boundary="===============1247551739906508531=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============1247551739906508531==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2019 at 09:30:04AM +0900, Kuninori Morimoto wrote:
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Basically, driver which setups snd_soc_component_set_jack() need
> to release it by themselves. But, as framework level robustness,
> soc_remove_component() also releases it.
>=20
> To avoid code reader confuse, this patch makes it clarify.
>=20
> This patch makes it clarify.

This doesn't apply against current code, please check and resend.

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1uqBAACgkQJNaLcl1U
h9CbDQf+KUaKyg8eaR8tYze96mkoMo3lONfxjfQw638ceBSepgWq7DbbXBVN6gBy
y4I2G7LfP6A/FqoOp/u1yLMCw2/K5qz7Zv93mtrz/ly909nzhRIPx4rX8SbDCgvW
vz2qjlPpRTHZTuM0+2G0XKsHRx4RLty7DYJEoVo+qc2Oh7lFS4qeMQWSgDn9Y5+5
z40z1cQUwdqxnaqBfDl3/28RoB6v7PDpuF0l61Kyauj+0URdaocyACzRnhL/Jpbi
kXrTQL3guqhUXuZ+baNY83mXCp8sOwYhv+FKZ1rTSaN2ga75OxC4xDOgxSBodv6+
HGjHGP8nsXaXKdb5b2Rl1tpdblNDpQ==
=kNzK
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--

--===============1247551739906508531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1247551739906508531==--
