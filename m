Return-Path: <SRS0=ShlF=ZN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D9BC432C0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:53:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D16C020872
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VTa91OuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16C020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0071F1786;
	Thu, 21 Nov 2019 12:52:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0071F1786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574337188;
	bh=oIPm4Fr9eUp1dlwr+ofzvuZdJ024/T9l/x/7At4X5iI=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VTa91OuXgkT6uVQ4bLKW+E/6quiga7YMiRGl0cRCf2VJdvjnXM+YoBCRSM0KyI4pm
	 p6SpFcI5rczL23cKRABnWIv1p4XRt5nF3imZBQJMypHtuthM1cEyJWG6xBnodtyFX+
	 Rj4oyE90fFlWt/u9Cgl6KN1V5pzy8x73FLRAZJpk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF04CF80145;
	Thu, 21 Nov 2019 12:51:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AF2D2F80147; Thu, 21 Nov 2019 12:51:31 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 53C5AF800C1
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2019 12:51:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53C5AF800C1
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1043B328;
 Thu, 21 Nov 2019 03:51:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 816753F703;
 Thu, 21 Nov 2019 03:51:26 -0800 (PST)
Date: Thu, 21 Nov 2019 11:51:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Message-ID: <20191121115124.GA4071@sirena.org.uk>
References: <20191120174435.30920-1-perex@perex.cz>
MIME-Version: 1.0
In-Reply-To: <20191120174435.30920-1-perex@perex.cz>
X-Cookie: When in doubt, lead trump.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 1/2] ASoC: improve the DMI long card
	code in asoc-core
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
Content-Type: multipart/mixed; boundary="===============8305903661604195354=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============8305903661604195354==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 20, 2019 at 06:44:34PM +0100, Jaroslav Kysela wrote:

> -	/* make up dmi long name as: vendor.product.version.board */
> +	/* make up dmi long name as: vendor-product-version-board */

I'm worried about this from an ABI point of view with people's UCM
files.  But perhaps I'm worrying about nothing?

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3WejwACgkQJNaLcl1U
h9Ckxwf9HUs91aGJZq6v6R8eIviS5NKoXjlS8PBgoe5IzzoaWABvo/2VrAKLOkNP
/Got5e757/i7HC+L4tv8jJDL8/7exsAMGLmQr4db6geGhRTS+TkrQNtCoua65plV
EzH6Sl90FFPIZiVKXi1anKda5gohQ/iyNZH0HQqgXeFBcKBqFDgYI3840NK0bLsl
AwEjUgS+6Kwzot4xxw5UhGJAQiR9CJ7rifG9olUbQyrciuKk61EMM0pm0P9dK0CC
oGnFrnTfJow9AIl+yOUFH/q5SqaC2ZGTPVZp1cl9mwHnKaqzVivF9YcjKCAtfwSk
DDZKVrX4R+dS+p5CcVcDdzAaQvI6AA==
=zOmp
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

--===============8305903661604195354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8305903661604195354==--
