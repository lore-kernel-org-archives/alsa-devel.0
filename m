Return-Path: <SRS0=ShlF=ZN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3245C432C0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:12:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2C12089F
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pTHDYqhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2C12089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62E181766;
	Thu, 21 Nov 2019 13:11:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62E181766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574338355;
	bh=aBt8ooNtHo7yT5mQWRdwc8m0VQUNqF3fsywrOlgyDok=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pTHDYqhJsLKfAtG4QFsfSZxJutSN3Z6wCq6wLewg29B4pDwJGEFdJMvIf5FkxCnn9
	 ggzFRIizROwQHoz2WLJcx1A4l+Y9o7xLswdfo9lQP+z/zqNUTG4KCSSoIv7B407jMx
	 5ykihEPOJYomKfKeSVQYplwrTwYtG4eCLHpU6gs0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF3E9F80145;
	Thu, 21 Nov 2019 13:11:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AFBCAF80146; Thu, 21 Nov 2019 13:11:43 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 51BB4F800F0
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2019 13:11:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51BB4F800F0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD655328;
 Thu, 21 Nov 2019 04:11:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B6FC3F703;
 Thu, 21 Nov 2019 04:11:38 -0800 (PST)
Date: Thu, 21 Nov 2019 12:11:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Message-ID: <20191121121136.GB4071@sirena.org.uk>
References: <20191120174435.30920-1-perex@perex.cz>
 <20191121115124.GA4071@sirena.org.uk>
 <7a527497-6132-c1df-d083-6cd27361eb08@perex.cz>
MIME-Version: 1.0
In-Reply-To: <7a527497-6132-c1df-d083-6cd27361eb08@perex.cz>
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
Content-Type: multipart/mixed; boundary="===============4220369229724339670=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============4220369229724339670==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2019 at 01:02:38PM +0100, Jaroslav Kysela wrote:
> Dne 21. 11. 19 v 12:51 Mark Brown napsal(a):
> > On Wed, Nov 20, 2019 at 06:44:34PM +0100, Jaroslav Kysela wrote:

> > > -	/* make up dmi long name as: vendor.product.version.board */
> > > +	/* make up dmi long name as: vendor-product-version-board */

> > I'm worried about this from an ABI point of view with people's UCM
> > files.  But perhaps I'm worrying about nothing?

>   this is just the C comment fix. The long name is already in
> vendor-product-version-board - no dots as delimiters (but does are allowed
> in the fields like version strings). This code improvement does not change
> the format of the generated long name string from the DMI information.

Ah, it looked from my initial scan like it was being changed as a result
of the factoring out of the append code.

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3WfvcACgkQJNaLcl1U
h9AnAQf/Q28saI/oWHoPQGZXRvisdTSPEi0zrybEZFJVqedibtaCUobZCyBN071q
ZEsLt0cq/B/pvn294BTYlLqKnc1oh6m+s0o7gc+q8hbiSRrLQ/9dkxeUVIYVHzRq
SVlUIw3WjkQTXnZCLEwmO4VFA1z0cMqTXGis6P+TzAh0VLVmRfVdxY4UAw2twYi6
9qqK8KGpyxkHS0/QyH3WxhpIuCyM/WLTIgXMWuwBx5c6K8GpBuLe22jlkQN8AvwS
lnrOQONkinI5dZDIttFF//CPbMBMu8mguq77VN6dEnMZgNkUtE4Tehr8E+oUXYWC
NtjhWuUJSCOhsxjxSF9J5wzl9LVZ5w==
=KM+O
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--

--===============4220369229724339670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4220369229724339670==--
