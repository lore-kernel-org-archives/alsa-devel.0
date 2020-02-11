Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6980C352A3
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:20:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ACA52070A
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OviGMP1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACA52070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86266169B;
	Tue, 11 Feb 2020 17:19:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86266169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581438004;
	bh=YlOpvV3+x7Gz2JC3X8hSnBoJjkmhm9wL07cTFsfY9Z4=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OviGMP1rKSE5bcbwtIsv//Y/rztm9hHThklVyn0QJUdLXt0NtPaYua+WypNzN+0ax
	 ZaGR553FCyTPxCq8F2BkQA7dywsUetFCW6TQ/3FBFfDNHp5xi6UF6loGO6gtulSY9S
	 yiSGU8/8EsjGGTAn8l/9zKzKB2E1miDcDJoIKHHw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA8B4F8013D;
	Tue, 11 Feb 2020 17:19:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20F59F8013E; Tue, 11 Feb 2020 17:19:12 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 3DF9EF800F0
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 17:19:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3DF9EF800F0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6478830E;
 Tue, 11 Feb 2020 08:19:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDA833F68E;
 Tue, 11 Feb 2020 08:19:06 -0800 (PST)
Date: Tue, 11 Feb 2020 16:19:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Message-ID: <20200211161905.GM4543@sirena.org.uk>
References: <20200207091351.18133-1-geert@linux-m68k.org>
 <CAK7LNAQGcw1jbb=fWd_CbWv5hQrkqG_QFCw3uY4LXroONGM6BA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQGcw1jbb=fWd_CbWv5hQrkqG_QFCw3uY4LXroONGM6BA@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1185303831666513988=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============1185303831666513988==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AQYPrgrEUc/1pSX1"
Content-Disposition: inline


--AQYPrgrEUc/1pSX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2020 at 01:09:30AM +0900, Masahiro Yamada wrote:

> Why does SND_SOC_ALL_CODECS exist in the first place?
> Is this compile-test or run-test?

It's for compile coverage.

> If it is the former, allyesconfig / allmodconfig
> covers all of them.

No it doesn't.  Those only enable user selectable options, many CODEC
drivers don't have user selectable options as they are selected by
machine drivers some of which either have more platform specific
dependencies that the CODEC drivers or aren't upstream.

--AQYPrgrEUc/1pSX1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5C0/gACgkQJNaLcl1U
h9DTdQf9Gk62wuqjst/9b6n+rQ0tlvq5rLi2q9impw+CjR2IVskAK4uCiioeMyQr
XiKWja8Ip1YsZT5ZPBJLSrti3pphLOQCn52hL8FsJiOrlvork/ZdOP3ebEJnE038
1ASs3ReEJ90eNmA54QJQaC1ufL9CyxJ023osbd9dZTEJ6UNSfEEPxCBnNznINYHw
KGxkJyxzCKpyDi1Ri1VBCuIgt0phvhXeYlQDn071epm/w6RQbOknmJnHK8DKrkTh
N26AF0h8JXdOKEKalEcVgVbjNf/ZZDaWWiRh+KmmYdVCkMbtzlUP3uTMLrDTF3Vw
TD0x1ByKAWkdsVxKpKH8jw/3BfGpYQ==
=uTKZ
-----END PGP SIGNATURE-----

--AQYPrgrEUc/1pSX1--

--===============1185303831666513988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1185303831666513988==--
