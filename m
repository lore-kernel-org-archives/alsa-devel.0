Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C1DC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:50:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9722C205CB
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="f4Xb3bKn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfSQJv6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9722C205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F08F21661;
	Mon,  3 Aug 2020 12:49:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F08F21661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596451838;
	bh=QTMJcWeRqJNrTu8rV1h8eq6JOS0FnmgVGXEA+Q8jJfI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f4Xb3bKn21pO1LSJRDIq7O/N/oyS2sXWZNmWuQJ1NKpeNYRKC9n+89MoqiqcZD15N
	 WB2VetN4hEJ7h3iylrJ8FgmMCAwCa+zht7z7duKeXta2OjPZEaNsJkXIRVI2k/tRKQ
	 IZAChHTRuUPiWBUrGW+4HzGxT2tDhBxExyDpURpc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A24FAF80218;
	Mon,  3 Aug 2020 12:49:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3F0DF8023E; Mon,  3 Aug 2020 12:49:46 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3ACCF801F7
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 12:49:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3ACCF801F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RfSQJv6G"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B70E92076C;
 Mon,  3 Aug 2020 10:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596451778;
 bh=QTMJcWeRqJNrTu8rV1h8eq6JOS0FnmgVGXEA+Q8jJfI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RfSQJv6GsL9/a/72gR3unX/IVsfSZwgKZRc5o/nt40fMoaKCnRe+8/JuAU3G26KBd
 WnSrIchAn0cOgAjfFBDDivGM4i5IHJlquK38t9IXL4Dr0uBy/BKpvDGdH0cidMAY5d
 DWJhSfDXPUgkoA3y6i/GEJfZQ04fIWP0dFQnpVlw=
Date: Mon, 3 Aug 2020 11:49:17 +0100
From: Mark Brown <broonie@kernel.org>
To: "Sit, Michael Wei Hong" <michael.wei.hong.sit@intel.com>
Subject: Re: [PATCH 4/4] dt-bindings: sound: intel,keembay-i2s: Add
 channel-max property
Message-ID: <20200803104917.GB4502@sirena.org.uk>
References: <20200730055319.1522-1-michael.wei.hong.sit@intel.com>
 <20200730055319.1522-5-michael.wei.hong.sit@intel.com>
 <20200730112948.GB5055@sirena.org.uk>
 <BYAPR11MB3046DD82FAC2B5C672FC85B29D4D0@BYAPR11MB3046.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3046DD82FAC2B5C672FC85B29D4D0@BYAPR11MB3046.namprd11.prod.outlook.com>
X-Cookie: They just buzzed and buzzed...buzzed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "pierre-louis.bossart@linux.intel.com"
 <pierre-louis.bossart@linux.intel.com>, "Rojewski,
 Cezary" <cezary.rojewski@intel.com>, "Shevchenko,
 Andriy" <andriy.shevchenko@intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sia,
 Jee Heng" <jee.heng.sia@intel.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>
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


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2020 at 01:59:10AM +0000, Sit, Michael Wei Hong wrote:
> > On Thu, Jul 30, 2020 at 01:53:19PM +0800, Michael Sit Wei Hong wrote:

> > > Add a property that configures the interface to the desired max number
> > > of capture channels. The platform may have multiple interfaces with
> > > different number of capture channels.

> > Why?  None of the other platforms which support many channels need
> > this defining and the constraint code and/or machine driver would
> > normally be where this would be handled.

> The platform uses the audio-graph-card to create the dai-links, and doesn't use a specific machine driver code.

The audio-graph-card is very flexible and if it doesn't support
something which it is useful to configure per platform then that's the
place to add the extension, not some DAI specific driver.

> The platform also has 2 different interfaces which have different supported max-channels.
> Using this value in the device-tree to determine the maximum supported channel of the interface.

These should have different compatible strings, there are likely further
differences between them (even if they are not currently documented).

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8n66wACgkQJNaLcl1U
h9ALQAf9HfxHGB8XeLst/mh2fOhtr1yVsAd8WXEHrSudrQOlyYBzG2fNLPwZ7IYx
t7Vr4LUZJayOPI2Oxco5600ylNuZBCFcEmLF31R3qNU0gCWE1E/b6Mgd9qUa6JNV
8deUQ+zYU34Zf0De5W58FDMEfowviGgcwkogl3S31tCw3WhKol3+eQmCSSNy8B5E
Xa81QGHHVKdmeelpH8TXXxnRkousz5C6kGLVWiYgapUynXcXfiGlsr7EHGcJy+rW
HvohLRUcuC12znXHaSW42bIu4UpLWMftwAU4hrCa1wagRChIQolVHnGHY9WDdN9t
aJhyfkHe+V1skbxHYAO9tba7clxDnQ==
=rGjT
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
