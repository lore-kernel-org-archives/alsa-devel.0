Return-Path: <SRS0=OXo6=44=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E0AC10F27
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:17:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA34C20873
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c8nWkp28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA34C20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38A8D828;
	Wed, 11 Mar 2020 13:16:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38A8D828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583929038;
	bh=s9jAmAndjMu27OMqaJA8ULwBk+kbwRx2llC5ie6/sxE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c8nWkp28A7EYa2AgiNssN8TjOpIZZfRQKABcrsYGPrhbLEzMyoIQEKplB6ueD6yl8
	 dICIVu+d1TRJ+bVCLqwpEso380ZFFBdLN9pWYWYyLGmAZc3GG6p8rRE4OogOhVQdkd
	 tMyAkpSx633hKdCE4JRwXcKiQCpNz93qf7/Xe9rw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8718F801A3;
	Wed, 11 Mar 2020 13:16:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85DB9F801EB; Wed, 11 Mar 2020 13:16:26 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id A5CD5F80141;
 Wed, 11 Mar 2020 13:16:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5CD5F80141
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 518F41FB;
 Wed, 11 Mar 2020 05:16:19 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA3923F6CF;
 Wed, 11 Mar 2020 05:16:18 -0700 (PDT)
Date: Wed, 11 Mar 2020 12:16:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/3] [RESEND] ASoC: SOF: preparatory patches
Message-ID: <20200311121617.GC5411@sirena.org.uk>
References: <20200309170749.32313-1-guennadi.liakhovetski@linux.intel.com>
 <9cfc4182-1f22-9f28-52d8-f8aac1f7bc0b@linux.intel.com>
 <20200310125055.GF4106@sirena.org.uk>
 <5cdea070-d8ad-9f23-c3f2-b3638e127f7d@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <5cdea070-d8ad-9f23-c3f2-b3638e127f7d@linux.intel.com>
X-Cookie: I'm a Lisp variable -- bind me!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
 sound-open-firmware@alsa-project.org
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


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2020 at 03:13:12PM -0500, Pierre-Louis Bossart wrote:
> On 3/10/20 7:50 AM, Mark Brown wrote:

> > How does this relate to the virtio audio spec that's currently under
> > review?  It looks to be doing something much lower level than that.

> Mark, to avoid any ambiguity, what 'virtio audio spec that's currently under
> review' are you referring to?

https://lists.oasis-open.org/archives/virtio-dev/202003/msg00045.html

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5o1pAACgkQJNaLcl1U
h9D5gAf/bc33SMbPd0e2ZHolCH0AS9hg3UHTzQ8fHHzBQ0a2oe/71nh6XzqI5/BW
n6ok9tatNWIk6SKemLvFBLOekonVG14a6NXdnCGLHZ4Go6RzsNDloFWD4yLJrT9l
YvBatRtZbmWkKCs+Ph0qUNIJYzKsM2XnM7Gktg6RhYhpv4li3xmfh9iKugrstDI2
ljPs1fheSCz2GpSnGimtZ3rtQ1XFfcBaMj2gzVFR/QK5zGX7A9EPdfGoWpoUmwgG
3hmiY2xCOTpELXKn9TrFpy60uZLxOd8qOlI0r5EiqwdPOE4Kt0oQpALnHWJA/1Bd
n5/Cv2RHP+dBWJcqerVaZ4nHXC1FnQ==
=YLo4
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
