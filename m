Return-Path: <SRS0=mh1Z=PJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ED4C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Oct 2021 18:39:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898E960D07
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Oct 2021 18:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 898E960D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4BFE1669;
	Thu, 21 Oct 2021 20:38:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4BFE1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634841560;
	bh=wQanfugjr1Cc5GVAd94MHuVuAtGH/DrzWNC+qLvDCOA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=piq70RsmCY/W0uIjSQsuKHVVuhxhG0m8VbwxI8hJ3L0lODxgNnG3j5Y1mUWpwIgaw
	 OeoPobMQc8eWYi5E6bPZITBrDfR+1aLmLTow/7jAul6GLBFH/oiizyntYuB3WYnupE
	 5PDePd099f7Ob+hACltT6gb9TNUZIzCr6LJMP5KU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66666F801DB;
	Thu, 21 Oct 2021 20:38:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F1F3F80240; Thu, 21 Oct 2021 20:38:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68E40F80155
 for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2021 20:38:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68E40F80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="T6d8LfKI"
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED92160D07;
 Thu, 21 Oct 2021 18:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634841491;
 bh=wQanfugjr1Cc5GVAd94MHuVuAtGH/DrzWNC+qLvDCOA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T6d8LfKIKgpQLOUmqPYC/ahW5VVyQuKc+IbK4TNCThhbC9TE/AqtTpXHVMv8yqmVQ
 qJoF3TOMFepda5SIWaOLJLkM9EjybDLNPViqk77kerIfQPXaFfUwNsJtAVqgUt+zcQ
 uTqWnk8w9UoVRKo9s8+C/Cxl6n0wmh45S1fXFh4jTnPch2GThHdth8+ohG0Meh5gfe
 ysp4qfWcWDyr/ua9gBVrsESWAh8Z5ZPS3XnrePVwGjE2j14V4VZbMAcS4X+IUzI/sd
 fvF8KSNoqZTC56wJ67OkcbpM+QUayEu8LtbWKpr44m2/Akfwh8Cqr+vTJinIFrVmnC
 j/XpGtf6+jyYw==
Date: Thu, 21 Oct 2021 19:38:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ASoC: cs42l51: improve error handling in cs42l51_remove()
Message-ID: <YXGzkNEUpil9lsdh@sirena.org.uk>
References: <20211021103627.70975-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TxqpMZSHqcQbxsZD"
Content-Disposition: inline
In-Reply-To: <20211021103627.70975-1-u.kleine-koenig@pengutronix.de>
X-Cookie: I program, therefore I am.
Cc: alsa-devel@alsa-project.org, David Rhodes <david.rhodes@cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de,
 James Schulman <james.schulman@cirrus.com>
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


--TxqpMZSHqcQbxsZD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 21, 2021 at 12:36:27PM +0200, Uwe Kleine-K=F6nig wrote:

> a bit unsure if regulator_bulk_force_disable() is indeed the right
> function here, its documentation specifies a different usecase.

> My motivation for this change was to make it obvious in
> cs42l51_i2c_remove() that there is no error to handle to eventually make
> i2c remove callbacks return void, too.

It would be better to just ignore the errors on disable.  Realistically
you'd have to really be trying to trigger an error here and it's most
likely that the system is in enough trouble if one is triggered that
it's just not worrying about.  I'm not sure how likely it is that anyone
would ever remove one of these devices in production though.

--TxqpMZSHqcQbxsZD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFxs5AACgkQJNaLcl1U
h9CAQgf+PHXcaiI3Vn8jGM60RNC89pWKo4TsqavSzE3+HQ+SQT5PMhyfkZiZjIyt
CWamR84dhyT2u5ECwwxSqtAkvXwDtSwmHH2yDxOH2Vj/tTThvaFiprsg1KmBBj7B
02CQMgJMS1/NF8V/v0t1MDwQB0T0dQ63SYx89y02lqCLb3itERPn0+FjSsEHkH7+
wCOEUhrsQO8/Lihmvka5QsVTPlk6bZsSVVZTMUfnrUA88LSl1XauAvW+UFy0ZQSx
7kwiXONcVoulGgSc562d777hxZYROSFP7Z3PUWQ6IvDpUJWobvBFtdF+o/ITGfX5
EUd7WdB2tMLGc0NWIgwtDP1jTCfcPA==
=sH/t
-----END PGP SIGNATURE-----

--TxqpMZSHqcQbxsZD--
