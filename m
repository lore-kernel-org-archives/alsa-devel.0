Return-Path: <SRS0=iKRb=DH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B4CC4727E
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:17:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96BDC2076E
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="J5OJr/Wi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yvvCKGaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BDC2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D4A9017D4;
	Wed, 30 Sep 2020 14:17:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D4A9017D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601468272;
	bh=6LXq8gQ1YOm/ULhKrDEsjuVBjE+t/GvywlEKlPJeIwQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J5OJr/Wi4oYSIk+vFvQU2cOciAJOqKA5rONxteqdlg3B+9ew98zDmgjEbpKq5wlSn
	 /4AjH4Qh5MJsJIK04cXbWI50v4bQGHc8W5UMfwDIQJo0YG5rnKCvNgVjv3w1Mk/QIL
	 3+T7qFKmF7w4k1KkxAXtV8VrfhMbse4+l+29X/cQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 585E9F801D8;
	Wed, 30 Sep 2020 14:17:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4BDAF801ED; Wed, 30 Sep 2020 14:17:00 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73A23F800DF
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2020 14:16:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73A23F800DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="yvvCKGaQ"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3F1E12071E;
 Wed, 30 Sep 2020 12:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601468211;
 bh=6LXq8gQ1YOm/ULhKrDEsjuVBjE+t/GvywlEKlPJeIwQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yvvCKGaQPY/0J9zohn6rjekHLo3V4n5o5xuCmbyd0fGBwVaPl4VVDTUiKMJWiD5nw
 Yi/ioiuVWJUBokdZ1dXniV6YUJ2HVrOk7/nbHR9SWTj6Wuh1wC5P5kbCgQQ+wO/zG4
 9nTGgR/3TmrP6B/MmA5JrS8yjbx1H4tNupEZR6Cg=
Date: Wed, 30 Sep 2020 13:15:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] regmap: add support to
 regmap_field_bulk_alloc/free apis
Message-ID: <20200930121552.GH4974@sirena.org.uk>
References: <20200925164856.10315-1-srinivas.kandagatla@linaro.org>
 <20200925164856.10315-2-srinivas.kandagatla@linaro.org>
 <20200930115915.GB1611809@kroah.com>
 <20200930120849.GG4974@sirena.org.uk>
 <20200930121100.GA1616135@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uAgJxtfIS94j9H4T"
Content-Disposition: inline
In-Reply-To: <20200930121100.GA1616135@kroah.com>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, srivasam@codeaurora.org, lgirdwood@gmail.com,
 rafael@kernel.org, linux-kernel@vger.kernel.org, tiwai@suse.com,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, rohitkr@codeaurora.org
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


--uAgJxtfIS94j9H4T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2020 at 02:11:00PM +0200, Greg KH wrote:
> On Wed, Sep 30, 2020 at 01:08:49PM +0100, Mark Brown wrote:

> > We have managed versions of the other regmap allocation functions, it
> > makes sense for consistency to have managed versions of these too.  I
> > think there's a meaningful difference between a simple and expected
> > wrapper like these and infrastructure which hasn't been proved out by
> > users.

> Ok, do you think these are really needed?

> A review would be nice :)

I applied this patch the other day - ea470b82f205fc in -next.

--uAgJxtfIS94j9H4T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl90dvgACgkQJNaLcl1U
h9CIIAf+JybWoPGkKVaBPJiSpiAgkz7QPd60n/DEPROggQpFDdDWfwq5e8bPqYt3
OHGCWnf2/3iU0Y0+FmsjaqXKsYk/7rbhSiuVZvu+AM567pkO24IOHVT1CywN8uUY
PoWIC7Ndu0ojMJI3sr29AucRDUCUKhqVd9slHbFQWTWuFuLBoEFgZAFXgg3jvFuD
CLEYenylSDz1eBjwZ+1a6ypyy7TafJ6SyKvrdEAO1+8sIIs3jmxhXJIBb3kM9Mf5
zqV741lUEZwJKE0OqkEfObPPt68GeEqTyIYGbvrLQ2Wi/5yCkgoh0gzYdx+pbbNz
nyjOcXsojBy33jlbYpegPM9lpHgPPA==
=4nBl
-----END PGP SIGNATURE-----

--uAgJxtfIS94j9H4T--
