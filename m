Return-Path: <SRS0=+eNr=5T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4129CC2BA17
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:27:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF752078C
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="T/koZZXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF752078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 140641672;
	Fri,  3 Apr 2020 13:26:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 140641672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585913231;
	bh=hy39/mXyTlHyPBD2lvWPXHKPLO9ijSTcRTh5KomcjoE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T/koZZXA/IS6mnGUyuF21xN6qExcWimyLw3Ux1k2G34bUV30EI15/Pr82qxeZoGXc
	 VQoZrPfdR90vBjysW7Eh1eUo7dfYLBXR7JlvAyI/PPQQwJ4p+0zjzLuNIvLofV6jII
	 hvCCQ6Id1diSIhcRNPchlMDIyjjOknexUzorp4tc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 92933F8014B;
	Fri,  3 Apr 2020 13:26:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D943F8014C; Fri,  3 Apr 2020 13:26:18 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 61EF6F800C2;
 Fri,  3 Apr 2020 13:26:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61EF6F800C2
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2E3630E;
 Fri,  3 Apr 2020 04:26:11 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 760A33F68F;
 Fri,  3 Apr 2020 04:26:11 -0700 (PDT)
Date: Fri, 3 Apr 2020 12:26:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH v2 00/12] [RESEND] ASoC: SOF DSP virtualisation
Message-ID: <20200403112609.GD4286@sirena.org.uk>
References: <20200403091406.22381-1-guennadi.liakhovetski@linux.intel.com>
 <20200403092842.GB4286@sirena.org.uk>
 <20200403110404.GA23734@ubuntu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
In-Reply-To: <20200403110404.GA23734@ubuntu>
X-Cookie: Use other side for additional listings.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2020 at 01:04:05PM +0200, Guennadi Liakhovetski wrote:
> On Fri, Apr 03, 2020 at 10:28:42AM +0100, Mark Brown wrote:

> > I've asked a couple of times for documentation of the protocol here but
> > don't think I've seen anything yet?

> Sorry, we were thinking about the best way to reply. I think Liam will=20
> provide more procise information. The API we are using is the same as=20
> what is already used by SOF to communicate with the DSP firmware. With=20
> VirtIO we re-use the same IPC messages as those, used with the DSP,=20
> they are just transmitted over Virtual Queues. Additionally to existing=
=20

Quickly scanning through the code it's explicitly talking about things
like back ends and front ends...  In any case talking to virtualization
people they strongly recommend that any new virtio stuff should be
documented up front.

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6HHVEACgkQJNaLcl1U
h9AkYwf9G7ItLMpOWRr1djkujJy2h1pPqeAXZVGmfRwlNwGGfDftuWU4jm/TqFv/
LQa3YeCSoS3EPOBBlRCVl/wWIjGvLDEIs2evXL/7m3uDu3PTuDxevDtxd0xZZLHL
ROSt9NjecZRaeZh+LFVtzN/1QfnEOs6oheQRnZYCok/imRHb8529GuaYXuvMBS7V
dKZIcPB+fguoygeFvT9BxMhj+/heAFTzP3PudPdSG6vqgHZW839UflvaGdw1fO1G
9XcXfi6XMOGv4/YUNotcl098bnX9cvM+b5QKG3r23YuHeZvNfEP8IZLXZDKFN512
cWA24+Vv/yV/5++JrqRMkNFugv/cEw==
=hBVq
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
