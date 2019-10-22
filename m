Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F33CA9EA0
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:02:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB0B21872
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LAJT4W5L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="W+2QpW5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB0B21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 243081675;
	Tue, 22 Oct 2019 21:01:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 243081675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571770941;
	bh=HgwNrBnT43GmBd/V0dTDZ0dycZyv9RIF2ePjj+y/CsE=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LAJT4W5LMVGEnjaV/CwyNIMj6PRIrO2g9rHSatqvVKYO7LsWq1KmnL50nVA5SNPEA
	 3zFXDocdThKKhgMQxDfY6Blfgt02M9a5nlmtYTU+F1hW7uW01XTsZ+WmQrGISaW2cE
	 hFzlVlFK0yMz+QQU4+5EL9L4uyYAoj5Ow1HJw4R8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 235BAF802FB;
	Tue, 22 Oct 2019 21:01:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 444CFF8031A; Tue, 22 Oct 2019 21:01:27 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E2D3F80112
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 21:01:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E2D3F80112
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="W+2QpW5H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gz1z5nvs4Z3gc3OCKFOoQz/3SXJmBxl+hcNm3i+3dOo=; b=W+2QpW5H+IE4pnFi2tYem4uMN
 0WJkF7YnfsNzB7+1yUWcDolCSQHp5z//RYdOVoG7UFO/UWbPBFGcDHEEp3e9uMIGtE+P6So/EE0mM
 /nolDLS4zduAK7jfNTHKVGXQGR6ouG3ClyoS1BN+q7d1b5i106UGtr7viMRit90s9eVMw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iMzPG-0007Ht-W7; Tue, 22 Oct 2019 19:01:23 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 683ED2743259; Tue, 22 Oct 2019 20:01:22 +0100 (BST)
Date: Tue, 22 Oct 2019 20:01:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Curtis Malainey <cujomalainey@google.com>
Message-ID: <20191022190122.GA5554@sirena.co.uk>
References: <20191018200449.141123-1-cujomalainey@chromium.org>
 <20191018200449.141123-3-cujomalainey@chromium.org>
 <20191022161342.GI5554@sirena.co.uk>
 <CAOReqxiMMWjCnTS=bVBs-tvtfz1GSaHsoBf3PFFvpv000aPyOQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOReqxiMMWjCnTS=bVBs-tvtfz1GSaHsoBf3PFFvpv000aPyOQ@mail.gmail.com>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>,
 ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>,
 Bard Liao <bardliao@realtek.com>, Curtis Malainey <cujomalainey@chromium.org>
Subject: Re: [alsa-devel] [PATCH v2 02/12] ASoC: rt5677: Load firmware via
 SPI using delayed work
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
Content-Type: multipart/mixed; boundary="===============1639952295554450635=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============1639952295554450635==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z83JOb+Pp/DrQW9p"
Content-Disposition: inline


--Z83JOb+Pp/DrQW9p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 22, 2019 at 11:28:53AM -0700, Curtis Malainey wrote:

> You are right, I forgot to add that to the dapm paths, got distracted
> by the race conditions I was fixing. I am thinking the best route is a
> mux object that the driver turns on but has its route selected by
> userspace to the various DMICs. Would that suffice?

I *think* so - basically anything that just describes the DSP part of it
and leaves it up to userspace how to route the audio into the DSP.

--Z83JOb+Pp/DrQW9p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vUgEACgkQJNaLcl1U
h9Cf2Af+NKdPkigksZnNb33R8HHUYeitMxpaNvyB7fvTW70kNh7n8ZzmZ7OM3/Lp
iRTHUsTdhJn8A0+geJrCZ+fmxy62EODGB69dYGj3QdgCKRvxYHumT2Ah9IXArsmB
eimrOV4Ypv+cPKDRQIyN1sBfopcsdx1S+Ix5QGvJyjd2TDq6xxdedpq5wH2NhKj+
gpLEToGVvVxxeS/gs7LqUg0sO1HcERVo6iUo4sens6Cg/vf3Nys2ooCxjDoa9j37
45cYBWctqd8rbRHb4hxX/l+81bTnuZ7R7RDIiJFPKptdCYaHIHSYatk9ZRan3cRq
LWv9ManXLnq0rZPa90lxZo4CECbHww==
=k/pK
-----END PGP SIGNATURE-----

--Z83JOb+Pp/DrQW9p--

--===============1639952295554450635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1639952295554450635==--
