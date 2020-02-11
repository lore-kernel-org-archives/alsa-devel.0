Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0526C352A3
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:46:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B38720714
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WKcMGcdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B38720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F6E683B;
	Tue, 11 Feb 2020 17:45:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F6E683B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581439582;
	bh=ik2oo28LuaJMYgGcl/J5O5XApLiVe4975Twmgs752B8=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WKcMGcdTdhM0neSMZRyyMUnh3qNu/ksXvKpkpxupcLrWbvCj3BRkg5dAagSxpxl7G
	 dk8SX/f/mKDwqNwFPq6rU54Jo5/y5SwIVgD4SkTqhhw4hINpriVlRzp+arfsJvmD6U
	 6wSWSVAXxMhINWS+9/mWtVThZiBVFhJ7RY1wi0Ek=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18076F8013D;
	Tue, 11 Feb 2020 17:45:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE9A4F8013E; Tue, 11 Feb 2020 17:45:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 2B5A7F800E7
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 17:45:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B5A7F800E7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4071130E;
 Tue, 11 Feb 2020 08:45:26 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B991C3F68E;
 Tue, 11 Feb 2020 08:45:25 -0800 (PST)
Date: Tue, 11 Feb 2020 16:45:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Message-ID: <20200211164524.GN4543@sirena.org.uk>
References: <20200207091351.18133-1-geert@linux-m68k.org>
 <CAK7LNAQGcw1jbb=fWd_CbWv5hQrkqG_QFCw3uY4LXroONGM6BA@mail.gmail.com>
 <20200211161905.GM4543@sirena.org.uk>
 <CAK7LNARCr8afvs=h5-ZWVs=Bkk7PSMNvX+M_SeBSF-L99UencA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK7LNARCr8afvs=h5-ZWVs=Bkk7PSMNvX+M_SeBSF-L99UencA@mail.gmail.com>
X-Cookie: Hire the morally handicapped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [alsa-devel] [PATCH] [RFC] ASoC: Use imply for
	SND_SOC_ALL_CODECS
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
Content-Type: multipart/mixed; boundary="===============1803078380372405632=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============1803078380372405632==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YuJye9aIuN0w6xGV"
Content-Disposition: inline


--YuJye9aIuN0w6xGV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2020 at 01:38:16AM +0900, Masahiro Yamada wrote:
> On Wed, Feb 12, 2020 at 1:19 AM Mark Brown <broonie@kernel.org> wrote:

> > No it doesn't.  Those only enable user selectable options, many CODEC
> > drivers don't have user selectable options as they are selected by
> > machine drivers some of which either have more platform specific
> > dependencies that the CODEC drivers or aren't upstream.

> Maybe, can you add a prompt which is only displayed
> if COMPILE_TEST is enabled?

> For example,

> config SND_SOC_L3
>         tristate "some prompt" if COMPILE_TEST

That's effectively what this is doing, it's just making it a single
option that enables everything en masse rather than lots of per driver
options and isn't as esoteric so is easier to understand (almost all the
existing examples are Renesas specific).

--YuJye9aIuN0w6xGV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5C2iMACgkQJNaLcl1U
h9C39wf+LExhl27QS0xwjrmLu461Qr4UrkCcrNBX4/WGttFKbi2xbL1A7I8Tc9sh
eNIYtW64RUY96X6wT3BeuNRoBDHbJhm4p8j4gRhsbxtXp2nKazBcVURs/p+3ShKd
huwUYOohkLVxJOxlJ2EBV7iode/CfXYs7rfhK0SjjSqZ8edmGZvpXjZTaeWyYHwH
wYUdfWVMMAcQ5vJPGRVYrPBF7oHrjB3fyVtwNgFe7QfoEe0A5LXImI18wMztBifs
1s0gXzUdZGUpcoUXiHyd/qiq18lHGqcrEzOMqSVUyprOK4NE42dvX73LptIIZnEc
Gw9JHwmbgxgHt85hG64pBAnPJ/I7aA==
=ABsK
-----END PGP SIGNATURE-----

--YuJye9aIuN0w6xGV--

--===============1803078380372405632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1803078380372405632==--
