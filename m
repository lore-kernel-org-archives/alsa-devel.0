Return-Path: <SRS0=1Vby=4G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27BBC34026
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:48:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7FA24655
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EF6DK4uH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7FA24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92C1782A;
	Tue, 18 Feb 2020 20:47:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92C1782A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582055301;
	bh=NWb+gXUnBvpclOL5PBkpmOH+QE4UlaypuXop/MhDIHY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EF6DK4uHe9ZMR8ERIVfw7UUzchUG1ZAOp8F8W0GziZ+9shgxTuKNzGeXYjSyOf8Kr
	 JRIiLFo3ugdMY50Bv9aHaY0KIIeFrvhtrkPXtxkQIx4+OAcHJJ48b6JcurlMeiUpn0
	 QnmERBK987q0p0ACjHgr8ULBWVKtQspeZ1HmCY1o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E688FF80145;
	Tue, 18 Feb 2020 20:47:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 95BF4F80148; Tue, 18 Feb 2020 20:47:28 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id D546DF80135
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 20:47:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D546DF80135
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEB3631B;
 Tue, 18 Feb 2020 11:47:20 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7148A3F68F;
 Tue, 18 Feb 2020 11:47:20 -0800 (PST)
Date: Tue, 18 Feb 2020 19:47:18 +0000
From: Mark Brown <broonie@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v2 2/2] ASoC: tlv320adcx140: Add the tlv320adcx140 codec
 driver family
Message-ID: <20200218194718.GO4232@sirena.org.uk>
References: <20200218172140.23740-1-dmurphy@ti.com>
 <20200218172140.23740-3-dmurphy@ti.com>
 <20200218192321.GN4232@sirena.org.uk>
 <0faf0bfe-6186-59d0-e800-8523a33044dc@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jozmn01XJZjDjM3N"
Content-Disposition: inline
In-Reply-To: <0faf0bfe-6186-59d0-e800-8523a33044dc@ti.com>
X-Cookie: No alcohol, dogs or horses.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 lgirdwood@gmail.com
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


--jozmn01XJZjDjM3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2020 at 01:32:05PM -0600, Dan Murphy wrote:
> On 2/18/20 1:23 PM, Mark Brown wrote:
> > On Tue, Feb 18, 2020 at 11:21:40AM -0600, Dan Murphy wrote:

> > > +	if (unlikely(!tx_mask)) {
> > > +		dev_err(component->dev, "tx and rx masks need to be non 0\n");
> > > +		return -EINVAL;
> > > +	}

> > Do you really need the unlikely() annotation here?  This is *hopefully*
> > not a hot path.

> I was copying the code from tlv320aic3x.c as suggested by one our audio guys
> here in TI.

> I can remove it if you desire

It'd be better, they don't really help anything outside of fast paths.

--jozmn01XJZjDjM3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5MP0YACgkQJNaLcl1U
h9Dh9wf+J9qWfmd4wHvZLky/0BGP7rVl7P7KEKh++MFibZHsmMtZTT3Tct5YwT6Z
8+a1xAo5dmAz7jbvKvdmJ0+umNHxa0fOwgJusV0p5jU+BwFNNYLUsr3yTf+LRMly
AUaJ7EsuGPdyA5Z3D7KNyaiOrqiy2SCRcJdOwiJky3tIErrbDQ4b7M1ZLSnR4jW1
qyPVAXVlf9Qfy5op5Rb2auSX50TPj5jHwo2wD2ui6/jr0jFs3p1Y/DrLVBNCjeXM
sY22Sz39dw6Dtts+fpWBC+HHl4CTpMWxYah+ZIYLliMzvViKExRYy1ZWPcn1K51Q
q6y+lLbamcgW3ylYxn1BK4BJEhzMGg==
=YobV
-----END PGP SIGNATURE-----

--jozmn01XJZjDjM3N--
