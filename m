Return-Path: <SRS0=iKRb=DH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732F5C4727E
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:10:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79D42076E
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Pnd46hsF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoqqiXYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79D42076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39E0C17C5;
	Wed, 30 Sep 2020 14:10:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39E0C17C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601467856;
	bh=1GTC8SRCnNrTosWqqklpAjzX1/ju1u6RMterROWEPhM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pnd46hsFc/7ZCuyjzdiKm/K/ugKvlrtAWwHLH8DPvnQOqw81z7DFUd4E+u2O+k4Iz
	 gFRgVPZDTMsdK9erlc7DKS+wndEIYZBn9jv9AJOPfkCQr1DJOP5LR3Vn/o+RLi9iE+
	 fnaSjAUbzV49IyqcPq9HhUnXrqC2D/4Y/wbJzeRI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D51CF801ED;
	Wed, 30 Sep 2020 14:10:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 683DAF801F9; Wed, 30 Sep 2020 14:10:02 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86229F80110
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2020 14:09:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86229F80110
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SoqqiXYY"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3F6072076B;
 Wed, 30 Sep 2020 12:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601467788;
 bh=1GTC8SRCnNrTosWqqklpAjzX1/ju1u6RMterROWEPhM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SoqqiXYYtCbZwLv4CBr6ywp70susjjkAUuCRez4RifJf9NOx43xODsr4FFvhprY8w
 lspN1oYnnMMrdX5SmSKCgxUH4oKweQRBBPjFQq8qxuq62RG9Tn+xRNHpBhRcYY5+ZZ
 ZkQrBxFE+djGs0NuF0qGLuRjhzr2t27n26maZdD4=
Date: Wed, 30 Sep 2020 13:08:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] regmap: add support to
 regmap_field_bulk_alloc/free apis
Message-ID: <20200930120849.GG4974@sirena.org.uk>
References: <20200925164856.10315-1-srinivas.kandagatla@linaro.org>
 <20200925164856.10315-2-srinivas.kandagatla@linaro.org>
 <20200930115915.GB1611809@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sClP8c1IaQxyux9v"
Content-Disposition: inline
In-Reply-To: <20200930115915.GB1611809@kroah.com>
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


--sClP8c1IaQxyux9v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 01:59:15PM +0200, Greg KH wrote:
> On Fri, Sep 25, 2020 at 05:48:55PM +0100, Srinivas Kandagatla wrote:

> > +int devm_regmap_field_bulk_alloc(struct device *dev, struct regmap *re=
gmap,
> > +				 struct regmap_field **field,
> > +				 struct reg_field *reg_field, int num_fields);
> > +void devm_regmap_field_bulk_free(struct device *dev,
> > +				 struct regmap_field *field);
> > +
>=20
> You only have a patch that uses these last two functions, so why add all
> 4?  We don't add infrastructure to the kernel without users.

We have managed versions of the other regmap allocation functions, it
makes sense for consistency to have managed versions of these too.  I
think there's a meaningful difference between a simple and expected
wrapper like these and infrastructure which hasn't been proved out by
users.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--sClP8c1IaQxyux9v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl90dVEACgkQJNaLcl1U
h9DqdAf/UwybsAE2LFW9S9QqUszk6U+MXn6TU63FjYLKKYN8rOlIXL/H0VTyKO9D
SXNaLaMKOXyfzUoyYJ53fGbGGBMJ8EiNVusJGslDmGdr7kvIS7t65hkk0Jp5eiRc
By20kZf/SWuk1ZHXyXKPUCZcBebj3bHxLkZkhsA4X89FXELPFc6NlzYbZrUF4MXg
mMqyYwJXfU16KZYKoZ1yWz7SOoRTra3ytNhk/z/nEFpXqgwfQwL3CaSVubGanNkw
AjX61+6+Qmh/K6MuXqnj6DxdmxdxqdgwXqKleDOkGbBPV9ExnQH9gcdswvqcxwB2
NhCtpDOmDdsXMWFKgJBsKLSNefUrQQ==
=QsFr
-----END PGP SIGNATURE-----

--sClP8c1IaQxyux9v--
