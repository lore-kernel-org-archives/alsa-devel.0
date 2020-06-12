Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7309C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 10:15:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FAD2074B
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 10:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="s/0RH/Is";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wg3l7CfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FAD2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A69E6166D;
	Fri, 12 Jun 2020 12:14:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A69E6166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591956937;
	bh=FSgIdeevRs5RHNGYBvTWVll0QD+ECpxCDwmuHIBybPQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s/0RH/IsoOlyOANOoA/7KSPLUFFgasetdRxsNcjgWhJYBXIZVNYWeTG/pMG40Y0r+
	 w83QqhNZHphaF0TwT/a6UwFp3iWXlIyh8zyB6epMYnAcL1vZtjwRg/a8fRMd/vxgqP
	 /dBEtfMoxYQfoZzJ+s0EgizAPPAAMq4KwHGI5NRo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 22BEDF801F7;
	Fri, 12 Jun 2020 12:14:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0EA74F8021C; Fri, 12 Jun 2020 12:14:45 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45D5CF80058
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 12:14:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45D5CF80058
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="wg3l7CfI"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4BC33206A4;
 Fri, 12 Jun 2020 10:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591956879;
 bh=FSgIdeevRs5RHNGYBvTWVll0QD+ECpxCDwmuHIBybPQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wg3l7CfI3UnuLLI+iXs5X6n49jxyMbzThRAaVhSE7qrH1llBm3aa8xbdyyHXWd1qW
 akXk16Js62DdhOlEwkfv2W5fyVC4SS5abYUelQLRBdHUpG70M0CmV9em4MF+PeGb/s
 yzQlb7oISJGeVqRkN9TgFPw/wEXCHxXdSV5FejvU=
Date: Fri, 12 Jun 2020 11:14:35 +0100
From: Mark Brown <broonie@kernel.org>
To: "Sia, Jee Heng" <jee.heng.sia@intel.com>
Subject: Re: Re: [PATCH v5 0/3] ASoC: Intel: Add KeemBay ASoC platform driver
Message-ID: <20200612101435.GB5396@sirena.org.uk>
References: <BN6PR11MB1953913840E37CCE88392A29DA810@BN6PR11MB1953.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <BN6PR11MB1953913840E37CCE88392A29DA810@BN6PR11MB1953.namprd11.prod.outlook.com>
X-Cookie: As seen on TV.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
 "Rojewski, Cezary" <cezary.rojewski@intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "tiwai@suse.com" <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2020 at 04:58:52AM +0000, Sia, Jee Heng wrote:
> Hi,
>=20
> Please merge the patches if there is no further comments.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7jVYoACgkQJNaLcl1U
h9DuNQf9FCxOC8P2NoAh/dFQScKgW9OTJWDmq2F0Ab6aSZlbSiFGBu0omg8GwhJ+
+jU2xrsUEeGKFuSeEtBw8YbSxOAEwCHQlPsI2XVw5ervDoiYV7ekoxKg8eWrtwej
rj3NIsOFt+sd74TRwgqyIb4VDFOMQWv55d0ugjXes5LIZhlRlvgphs5FhAoo3wj8
MBAo8pVY1gRxxlRqehEFNyGNhiV8Qq28X53HjMsYMaob0/4hgMzGah8WAPT5pROQ
uRQbhO4VXNtHpDYmm/dO5o09p1A+HDBjUDUUrDEfLXtC3sGMyjM0+iYAJ0m7Dd7+
Quln58Pe4F4+MjJw6lAVLHvByjVgTQ==
=p/T+
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
