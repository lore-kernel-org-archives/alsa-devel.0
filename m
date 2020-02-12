Return-Path: <SRS0=nhcg=4A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E78C2BA83
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:00:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54872073C
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Kg5oJb7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54872073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0AEDA166C;
	Wed, 12 Feb 2020 12:59:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0AEDA166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581508814;
	bh=RAyZV8KoW2D3+EZHbiUvfzB0t3HfKUUg43f1+HN9vuY=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kg5oJb7lgALYhsur/QhV5BIOMAO3HCqJaDY+ydfQ9QEdDlP95HKbLRagp9Cxne3Nd
	 4UOH9Cn9bwsK0fTzuUm/nAl2ORuSBug87UqtDQgNdCVFKApdLk73s9mNCOSgfx4+A7
	 p5tsMXKPBg/1zcI37zfkxHZky274Th2h3LvTnl+s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DB01F8014F;
	Wed, 12 Feb 2020 12:59:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B55FF80157; Wed, 12 Feb 2020 12:59:22 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id E92A8F800E7
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2020 12:59:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E92A8F800E7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B358A30E;
 Wed, 12 Feb 2020 03:59:17 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37AB13F6CF;
 Wed, 12 Feb 2020 03:59:17 -0800 (PST)
Date: Wed, 12 Feb 2020 11:59:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Message-ID: <20200212115915.GC4028@sirena.org.uk>
References: <1581322611-25695-1-git-send-email-brent.lu@intel.com>
 <AM6PR10MB2263F302A86B17C95B16361280190@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <SN6PR11MB26702B2E7E5F705425517F4897180@SN6PR11MB2670.namprd11.prod.outlook.com>
 <855c88fb-4438-aefb-ac9b-a9a5a2dc8caa@linux.intel.com>
 <CAFQqKeWHDyyd_YBBaD6P2sCL5OCNEsiUU6B7eUwtiLv8GZU0yg@mail.gmail.com>
 <2eeca7fe-aec9-c680-5d61-930de18b952b@linux.intel.com>
 <CAFQqKeXK3OG7KXaHGUuC75sxWrdf11xJooC7XsDCOyd6KUgPTQ@mail.gmail.com>
 <c9dbcdd8-b943-94a6-581f-7bbebe8c6d25@linux.intel.com>
 <AM6PR10MB22630C79D08CE74878A6A096801B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
In-Reply-To: <AM6PR10MB22630C79D08CE74878A6A096801B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Support Opensource <Support.Opensource@diasemi.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sridharan,
 Ranjani" <ranjani.sridharan@intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, "Chiang, Mac" <mac.chiang@intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, "Lu,
 Brent" <brent.lu@intel.com>, "cychiang@google.com" <cychiang@google.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: da7219: check SRM lock in trigger
 callback
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
Content-Type: multipart/mixed; boundary="===============4443036295175269361=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============4443036295175269361==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2020 at 10:16:54AM +0000, Adam Thomson wrote:

> So far I've not found a way in the codec driver to be able to get around this.
> I spent a very long time with Sathya in the early days (Apollo Lake) looking at
> options but nothing would fit which is why I have the solution that's in place
> right now. We could probably reduce the number of rechecks before timeout in the
> driver but that's really just papering over the crack and there's still the
> possibility of noise later when SRM finally does lock.

This really needs the componentisation refactoring I think, that way we
can annotate individual devices and links with what they need rather
than essentially guessing about what works most of the time which is
more or less what we do at the minute.  Like you say as things are at
the minute there's a lot of crack papering going on.

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5D6JMACgkQJNaLcl1U
h9DlEAf/fBK6srxM34hrUWp+RSB46rzwi3VulG9ye6DrZYE18FThapihpLCSCPw5
UUFuOf2G/w+8hcwf22J0gh7LZky8ReBsMWiFahKijYInxiEB6ioRdgKj6o+XoSR3
K5f7JP8QGkbkclgTpjytuIFWw6C32pGyojS2pL82ZUbbhRXPik9NWAp+UOXTWp4Y
7nAT+kvot9ixAECLYwT3mhXYRtouMUU1jXD9nlDMoViI5AC5+OKfItlBpL/Pu1+k
5a8bFXfRuhRqXN0zubbL7gfS81FyYS1PLZ2dWFWR9hEFSHJrblGW5dFLQw1hiie/
1U75ZlU+4ns6rHFlV8jHNTRK3XUH+w==
=V8px
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--

--===============4443036295175269361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4443036295175269361==--
