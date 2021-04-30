Return-Path: <SRS0=h5q8=J3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A262C433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Apr 2021 18:02:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3966C613B0
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Apr 2021 18:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3966C613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F4311689;
	Fri, 30 Apr 2021 20:01:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F4311689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619805765;
	bh=eAR+xhSb4s1B6tCxGTMHtsSZAg/KO8Jwq88qvH4ZTp8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cZujLfgJ6oVN5ciSLD0sDGHziF3EWGfKGfg1Q+DExDDL3TUCBB2Ezi6If13zqzt74
	 qPaWosxMTwCoBTjMbfdrngY+LZ8RkO6iVVl+yTnQp0OTC14gK/T8R86QbPyNb9Ect5
	 DewQm8SbXusdzt+mgieJRdhmt8JKJFdn/Q9VG56s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26A6DF80165;
	Fri, 30 Apr 2021 20:01:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94109F8016C; Fri, 30 Apr 2021 20:01:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81AABF800E4
 for <alsa-devel@alsa-project.org>; Fri, 30 Apr 2021 20:01:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81AABF800E4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qKNqRBSj"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B74761481;
 Fri, 30 Apr 2021 18:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619805706;
 bh=eAR+xhSb4s1B6tCxGTMHtsSZAg/KO8Jwq88qvH4ZTp8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qKNqRBSj+/r0FDGLc2d69LiF2DFZqQauXAdXy9SdqQEYwxmZqpw+3XJXKYMQZ/ZH3
 BxWoBtiwTQQy+EmRt3UD0JBitAVtncgXxz+Sj5Pd2+AXcaXK3MwStyefBESjl5hXWq
 PeOWDUvvVzU6azXxZFAbynK+gkjVzq5NpNYuhMwr/ISGFXgR7C/TAOcFmh8ud8/qXp
 LPCRYapq8jAW5CItPAkivs9yFLckysKCpiKwhjTUcT19+NNfHS0EE5+83BKdIpj3Ga
 YhfXTv7icmPhuPs2EO7Fg+2TJAHwDcfMYyKx87Q9BzMrZADld0nuDLufOHTg0zgt8S
 wcFf+GvpRO5+w==
Date: Fri, 30 Apr 2021 19:01:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
Message-ID: <20210430180114.GF5981@sirena.org.uk>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <CAHp75VeiHsk15QoG3X-OV8V8jqzCNeKkif9V=cx4nvKVHaKbKA@mail.gmail.com>
 <20210427143457.GI4605@sirena.org.uk>
 <YIglWpz8lSidXmDd@smile.fi.intel.com>
 <CAHp75VfBSjHP1LJZJTdwXzGuE2YjxdW6r7Zf6ofHsquJBPMyWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Content-Disposition: inline
In-Reply-To: <CAHp75VfBSjHP1LJZJTdwXzGuE2YjxdW6r7Zf6ofHsquJBPMyWA@mail.gmail.com>
X-Cookie: QOTD:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi <linux-spi@vger.kernel.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
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


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 30, 2021 at 07:29:48PM +0300, Andy Shevchenko wrote:

> One item is still unclear to me. I noticed that you started already
> applying patches for-next release cycle (if I understood it
> correctly). Hence the question should or shouldn't I resend this

No I haven't, I'm only applying things to for-5.13.  I've not even
created for-5.14 yet, that will only get created once -rc1 is out and
nothing for it is fixed yet.  If I look at it and find an issue I will
tell you, if I've not said anything and I've got through my first batch
of v5.14 stuff it's gone AWOL and you should resend.

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCMRekACgkQJNaLcl1U
h9DGsQgAga0H+vmLX/93TTc/hepJINQX8s8kTSyvJCoOO+q1rlf0udjdUvQLrQqO
wA+VsJ+h72RIEmIAKdPbHMBR16N/e9kYvWb7edSIhgIAbJTYCfra8ie835Ab+HJ/
940AfNU6jFC4k1Ot4g9TkvjcL3mFjN4NYoUdFJTiLK7huhacheX8gmCF5XmrlwAZ
w3CMCpuWocOWji2MO/w+m+2yjTelU6sQPnlT4Hfnk6l+eNJF8WcRNNM1OlX9kciX
47Ja6kMLll/XX7kQsXJ3dz86Fv5Bz8jmQMynPS3fMe1cGS69+sxfa1ubiSRxs9gI
+YfKmy1ffamHjymkV8jSY/vN2Ud0cQ==
=FhSI
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--
