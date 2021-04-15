Return-Path: <SRS0=rm39=JM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC94BC433ED
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 16:08:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04546115B
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 16:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04546115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C660165D;
	Thu, 15 Apr 2021 18:07:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C660165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618502886;
	bh=Uh51sV8OtB6aj1nI8W5IiochchK7Dk7TXKBRjrahNgU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OrLsXYS5a3xUUV72vIcj2mbM4oaKG+we9pMjsP+pImRS61vKFP736fw/In8p3zT+d
	 PdoSc7HniLkifwlFSFCde9VW5vOjqDydkV4/GGLhYSz/bcjOeeft44u0HVHg90vVkw
	 V1yJMTarUSa9yINA9GelcNr68L4uK+9q1kYBCYOg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DEEDDF80128;
	Thu, 15 Apr 2021 18:07:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6E4AF8022B; Thu, 15 Apr 2021 18:07:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86E46F80128
 for <alsa-devel@alsa-project.org>; Thu, 15 Apr 2021 18:07:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86E46F80128
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GGtkIgMX"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E79BB610F7;
 Thu, 15 Apr 2021 16:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618502829;
 bh=Uh51sV8OtB6aj1nI8W5IiochchK7Dk7TXKBRjrahNgU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GGtkIgMXEDdLxtPShoyIWGeUYFZremhB9JLV0Y92QsHVlKGJZpyiTMD9cpqFsnTZy
 R/8bzDCMQcP8dli0csBu40zaVKXvKEqwugiHj5oHguu+ajF/m1Tbg/pI5jS0M3tMyB
 0rNv2U53pJErpqdihCFwEd5OIKVnI7KlzmJ176DbRGhSMwhnBTQTOs0hkfm3JGohOX
 UQGQokPArAGMho6PppQUJRa6RfuoBH5pBuif24bB/pFKRBVMKXPLq6wUeIZU6EYsBt
 v186bNONEQbQh6ip/mv6mgO+sydPtPFLYyNZELFwnvpbwhRDkOxFG1w59037gGjMLx
 pVmmSsUTnGMxQ==
Date: Thu, 15 Apr 2021 17:06:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: use current DAI config during resume
Message-ID: <20210415160646.GG5514@sirena.org.uk>
References: <20210414165926.1875465-1-ranjani.sridharan@linux.intel.com>
 <20210415155309.GA48833@sirena.org.uk>
 <718ff501-df0d-93ff-5626-a190bf0bb05a@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Content-Disposition: inline
In-Reply-To: <718ff501-df0d-93ff-5626-a190bf0bb05a@linux.intel.com>
X-Cookie: VMS must die!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 15, 2021 at 11:04:36AM -0500, Pierre-Louis Bossart wrote:
> On 4/15/21 10:53 AM, Mark Brown wrote:

> > > Fixes: a1e1f10a6ed6 ("ASoC: SOF: match SSP config with pcm hw params")

> > I don't seem to have that commit.

> I think it should be:

> Fixes: c943a586f6e49 ("ASoC: SOF: match SSP config with pcm hw params")

> I can re-send if needed

Oh, probably yes - please resend.

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB4ZJUACgkQJNaLcl1U
h9Dp5Qf/XwOOT1d5VH2eBWPd9twCgtVy24I/VsuJB1xtgOViJl0Zf0d+BsyfW0Oo
lKeRTlV+rATVEPt+H5JewGs1h9/1V/bTtQeJOBZEo7U4oBmnYABcMmwRIQL57HkV
gPuUUhMkaIm+muPx/oSQSU0YcJvdIoZw6jWS7J6ehm1IQTVNeQ069wAErM5iVYUf
N1HsJ8y6nHQH+TkxO8e3tew+Tv7mWRzkpaIPyv9GDTWUPrF9GvGqOficxnIuSKQK
DhbpXLRvpBIhhmFYgx3ld6YLiFYuBvsuk62xCsPXnP3hGCRS9Ie95T7jSoJJlLzK
2zIQfkCk3rmT8H7J+U/KP1XR1wiupg==
=71uZ
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--
