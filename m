Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBC6CA9EA0
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:54:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83E66214B2
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="O+9g7wIk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ia/5C3N3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E66214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF9841673;
	Tue, 22 Oct 2019 18:36:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF9841673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571762246;
	bh=EM7xyTYfDlcwurSP5nbut7hi49nrhP1akwaY6wKxYFc=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O+9g7wIk3dKbJBltpu9GdrtyXk3333XuREOQnD76hjUxCXixWuSAkzy86MlNFMmKF
	 vrKNhbGBqEc8PdvYOeWkvDuR1J95ktuLzM0/icDo6wgF6HLnMmJ25I5e12+Wz9mH/o
	 AfU8LjYyVVJ4thEeZouES3kxtVj2l6YhH30YMb2I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EC1BF800C0;
	Tue, 22 Oct 2019 18:36:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C91D5F80367; Tue, 22 Oct 2019 18:36:34 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B8E6F800C0
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 18:36:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B8E6F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="ia/5C3N3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S/esUTBYamlcxz3Whaq0woZLlNP3iaXMA8TIzAQGBtw=; b=ia/5C3N3W+S0YfYt+SiP7qOld
 5+pUuj4E9vXIyBNKazhIMwPcC3hq95hhRUMW24Bhfkbz72K3vEr+XA0KX3Cqgb0zMcjA4u2HptcXH
 Sl8w/veGjSWiO9q3bne+UkNMhv6RAwq6AiEWd6ZNDZgmdLqfV29LnJQTRg0h0NdtQE31E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iMx95-00072W-LJ; Tue, 22 Oct 2019 16:36:31 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 1CC282743259; Tue, 22 Oct 2019 17:36:31 +0100 (BST)
Date: Tue, 22 Oct 2019 17:36:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191022163631.GM5554@sirena.co.uk>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-7-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20191018154201.1276638-7-arnd@arndb.de>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>, Daniel Mack <daniel@zonque.org>,
 Tomas Cech <sleep_walker@suse.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Sergey Lapin <slapin@ossfans.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH 07/46] ARM: pxa: move mach/sound.h to
	linux/platform_data/
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
Content-Type: multipart/mixed; boundary="===============2431484755536549753=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============2431484755536549753==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rf72Gf+bfLC8kxKs"
Content-Disposition: inline


--rf72Gf+bfLC8kxKs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:22PM +0200, Arnd Bergmann wrote:
> This is a basically a platform_data file, so move it out of
> the mach/* header directory.

Acked-by: Mark Brown <broonie@kernel.org>

--rf72Gf+bfLC8kxKs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vMA4ACgkQJNaLcl1U
h9DD0Qf/XFq0y8LkZDw6GMJf6uYL0f9DnkhueciiDL3lQZLVGGLGG0w3sLQP+jLB
ZGN/SkLyBGD6hh6+tjvQy+TF/NKDP9pOeE1dlhIgxF0QN+W6ibzgedNiEPH6s1iX
oIBME7P/1t0C7nBaWub8M1tyGB230oQjR53ZuffTkLuAOoc/cSwvoRVlMIVSv6eX
NvfDalLQj/XXrxckoMezJpqY8u/xnDIpoEhgv+8fYut+YcUoqu+iotI0w0Q+Z+Q0
iWLWZUSOp/o9GGrv4HXL5GO+ZZtndgGHpdJQiWWmhhmdcevxRJLnKb3qQfA3ANKz
E+OHIQhbeAd6ToUgNYi9U9j7Y1Evww==
=l9b9
-----END PGP SIGNATURE-----

--rf72Gf+bfLC8kxKs--

--===============2431484755536549753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2431484755536549753==--
