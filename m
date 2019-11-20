Return-Path: <SRS0=+StP=ZM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1940C432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:21:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D81208A1
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EsryMmZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D81208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 118E8175E;
	Wed, 20 Nov 2019 19:20:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 118E8175E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574274077;
	bh=RrcorPWd2F/NCJrYCzH4qWiF3nvIP+bFL9rY2yHjEII=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EsryMmZz5sgJ7Kru9nC4UqZDq97w17W+tl/lR/NEWqQpDtatgn1mAguPVGVkZIAtj
	 DnEsnUrd3hr7C5qb8XpqGKhUyatZ2xlqrjKsVRqhoqtIP2r4KRcrLbvkTCMbyQylBD
	 t3NELJSWOZbbBU/mmozyp/jR6t1XJC+HasYbyHA0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93C35F8014A;
	Wed, 20 Nov 2019 19:19:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56867F8014B; Wed, 20 Nov 2019 19:19:54 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 9ED42F80140
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 19:19:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9ED42F80140
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EB121FB;
 Wed, 20 Nov 2019 10:19:49 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F4CA3F6C4;
 Wed, 20 Nov 2019 10:19:48 -0800 (PST)
Date: Wed, 20 Nov 2019 18:19:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Message-ID: <20191120181946.GC5705@sirena.org.uk>
References: <ef29c9d6-b359-a9df-f8fa-d547b02bc8d2@perex.cz>
MIME-Version: 1.0
In-Reply-To: <ef29c9d6-b359-a9df-f8fa-d547b02bc8d2@perex.cz>
X-Cookie: Best if used before date on carton.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] ASoC, DMI and UCM
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
Content-Type: multipart/mixed; boundary="===============6052389297413013206=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============6052389297413013206==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 20, 2019 at 11:04:38AM +0100, Jaroslav Kysela wrote:

> 	I would like to discuss the way we use DMI information for the board
> identification in ASoC for the user space (long card name). It's a bit
> redundant information, because DMI is already exposed through
> /sys/class/dmi/id/ to the user space nowadays.

> 	My idea is to add 'DMI:sysfs' ctl info component string for the appropriate
> ASoC driver to detect the existence of this dmi interface. Then I can add
> the sysfs support to the ucm2 conditions.

I'm not clear what adding the component string does here - is the
intention just to say that the card is built in to the machine and hence
DMI can be used?  If that is the case something more generic that'd also
work with other firmware interfaces might be good.

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3Vg8IACgkQJNaLcl1U
h9AgkQf9GgcJ9UkZ4igOGCkzb1u5alyWmG9lUYoZaDoSVAVsZB1hBrlFVYN1N9KR
yqDLC5DJFOF1Ya0V3iPSWBgeJGgskqBh6xiKG+cs+XpauY01eMnvoVtedrfN8zvG
QmJ6O4bs+rhWfDZdHmQw2NPSoiG6oIfy7N+JcsplAnXihIDzcqVIuGFZm+wCfShw
MKx2cK4XmM84Z18TV3ZzfL1H2weSpn7R82hN4mVGqEno+QefuhQASqorjkETLZOM
Gu6IheaaNmC33QPxqPea+pfUxylI21ZLLWEFoWxL3O6KFJzB6mX2YUxK5ikOsfVR
cicwpGJn9xZYGJO1VwrsVX1a6+gyqA==
=hTYO
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--

--===============6052389297413013206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6052389297413013206==--
