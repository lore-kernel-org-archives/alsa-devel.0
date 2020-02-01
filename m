Return-Path: <SRS0=WHla=3W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E2EC3524A
	for <alsa-devel@archiver.kernel.org>; Sun,  2 Feb 2020 12:01:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E7D020643
	for <alsa-devel@archiver.kernel.org>; Sun,  2 Feb 2020 12:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eWLPSd7z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="cO/wD8KU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7D020643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04F10167A;
	Sun,  2 Feb 2020 13:00:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04F10167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580644888;
	bh=sSVRJoS+vjOzj5t184mJ4xLowbmOFmwLRSN7zzbmsFM=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eWLPSd7z2yAnD0XzTNDDAKAaVRIc2ak+uWMfhv4TlFDRYKwybI/KhlpYOuN23vsPw
	 CYFMfJXQo+FLJU4J73jn568Y2N8j4HXtoKv9m65bg3w30t8e1gdt7+PQbQxqnnCqew
	 JMgfPe4gmNQzA8XL+QQZRbccod+k4spg7bXx5lhc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4778FF8015A;
	Sun,  2 Feb 2020 13:00:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48E1AF80162; Sun,  2 Feb 2020 13:00:36 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4284BF8015A
 for <alsa-devel@alsa-project.org>; Sun,  2 Feb 2020 13:00:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4284BF8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="cO/wD8KU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/8I4PJVyzRO2zKgNQXcEsMEOQYRmKEwmQb/+v3+hXck=; b=cO/wD8KUbcDx253Djn0XRFYqV
 8iCdytlEdwJ3NUWSoQWdd3Gt3nbkUEWl16iWqag5vIkEg/XoPHuEz/Lo7Zk84ICR3goILfGSOhlLu
 CsRrpJQZCNsSGNa5CAcJLS54EI8zau9xQK6Gt9RgdKw4prliZAKBar4IdVoLdgSY0I8+8=;
Received: from [151.216.144.116] (helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1iyDvT-0006pm-EH; Sun, 02 Feb 2020 12:00:31 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id BF079D00E4A; Sat,  1 Feb 2020 11:27:37 +0000 (GMT)
Date: Sat, 1 Feb 2020 11:27:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <20200201112737.GS3897@sirena.org.uk>
References: <20200131091901.13014-1-jonathanh@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20200131091901.13014-1-jonathanh@nvidia.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, stable@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Thierry Reding <thierry.reding@gmail.com>,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [alsa-devel] [PATCH] Revert "ASoC: tegra: Allow 24bit and 32bit
	samples"
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
Content-Type: multipart/mixed; boundary="===============1069964369161965379=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============1069964369161965379==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wty5iWagpjJlozQq"
Content-Disposition: inline


--Wty5iWagpjJlozQq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2020 at 09:19:01AM +0000, Jon Hunter wrote:
> Commit f3ee99087c8ca0ecfdd549ef5a94f557c42d5428 ("ASoC: tegra: Allow
> 24bit and 32bit samples") added 24-bit and 32-bit support for to the
> Tegra30 I2S driver. However, there are two additional commits that are

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--Wty5iWagpjJlozQq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl41YKgACgkQJNaLcl1U
h9C48wf/XDYc+rP2dIu/vZ21qwktMH3XJC7y6d0I2npbH96AkZTpWmJd1Xni6LMO
X9XDm6w29xXEQvMvkQ+p6n7q74ZdCwfwNgHdPujzyQNEY33uSWkQ+gFzFyDKrec7
EGgzNKoCogdGHBTu6SED3em04EGbLIulAi2qwOd5jJ8ZCXErpBqUvwvFBRx9qQmK
Fy2RivEzWysEXqYe/Icsn4wVgZ4Nm5vyNQDEDkiigGKISdDMYqS5Y3W2Yg43Mpx/
KfLeQqxI7JZ3rodqfkpksVuzzhdvT/nyWuU46TOXyri4WhQMI75HewY/ZFKzQ9R0
38NCD8W5/kRbbfv8Y8+x8j423SX3dA==
=yaIF
-----END PGP SIGNATURE-----

--Wty5iWagpjJlozQq--

--===============1069964369161965379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1069964369161965379==--
