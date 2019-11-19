Return-Path: <SRS0=I/J9=ZL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51551C432C0
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:42:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CB62245C
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qPcXtdbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CB62245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3FDC167B;
	Tue, 19 Nov 2019 21:41:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3FDC167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574196166;
	bh=QctDtVVgXxLrdx9HRIkWrmJ+UnTVA49RdNWYA4Ykp/0=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qPcXtdbfFFT0Bs/mT/uomyj+59S+EwXi12j2v40jbD1jaCqOJ/UhSSiSd7V3mjo3E
	 jLJ8t647T6Bm5DNg4SERzIFxmcdPkdwbxhcjj9eVYCE17eCqTp62CK35abKa/I7fYv
	 N0A0Nlwk1vkIthPvkT+Paqleki/xxg4LkCq9p6d4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 365E2F80137;
	Tue, 19 Nov 2019 21:41:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE891F80135; Tue, 19 Nov 2019 21:41:50 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id C4B24F80135
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2019 21:41:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4B24F80135
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22B1B31B;
 Tue, 19 Nov 2019 12:41:41 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83A753F6C4;
 Tue, 19 Nov 2019 12:41:40 -0800 (PST)
Date: Tue, 19 Nov 2019 20:41:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Message-ID: <20191119204138.GI3634@sirena.org.uk>
References: <20191119174933.25526-1-perex@perex.cz>
 <20191119174933.25526-2-perex@perex.cz>
 <72dfc285-70e8-706d-3018-535bda1e8630@linux.intel.com>
 <f2de9597-c9c2-7696-622b-a2bbc2c32bb7@perex.cz>
 <s5h36ejy550.wl-tiwai@suse.de>
MIME-Version: 1.0
In-Reply-To: <s5h36ejy550.wl-tiwai@suse.de>
X-Cookie: Beam me up, Scotty!  It ate my phaser!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: Intel - use control components
 to describe card config
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
Content-Type: multipart/mixed; boundary="===============8446197871711576728=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============8446197871711576728==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Encpt1P6Mxii2VuT"
Content-Disposition: inline


--Encpt1P6Mxii2VuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 19, 2019 at 09:37:15PM +0100, Takashi Iwai wrote:
> Jaroslav Kysela wrote:

> > It's not about the protocol. It's about to move this type of
> > information to another place. I can remove the ALSA version sentence
> > from the help, because it's just a hint. I would like to create ucm2
> > configurations based on this rather than the misused long card names.

> But why these are exclusive?  The current longname workaround makes
> the device appearing a bit messy, but does it conflict with the
> additional component string?

Yeah, it's not clear to me why it's a config option to enable this.  I
can see a config option to turn off the old display name if it's
particularly irritating to people but I can't see any reason not to
just provide the new stuff.

--Encpt1P6Mxii2VuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3UU4IACgkQJNaLcl1U
h9CU2wf/Y0yBdjYmnykObqTI3t5Ek8lW6HP6uWPtKRNjudvMBFxZ5Nu90oMRJx9g
p09C/xO0KcbeC01s51uMyxDKGg2EohbDgIYuOzM0BPFLlwzc0loT1wR0iXG0mMzY
odRy2Arj+9XxdMH6h0qgqNXl2scnEcoXpp0KzIRn7wHenPTsJffouZTMJWxn4sbI
8t40wRf2iyO8V0Bxoh/cygDKGEvVcIMJNVGIDFgTi1eOU77kvthwnwpT6xSU6UJC
7c89as4zHjZDbJsH7auPp6B7g83iVeI5p+7gejf+YRyt2phwt5Ce2mMR+iPJiIew
Vew/Mv7NtjNWUSzOdwJ9Cth+Iv1tgw==
=XcJ2
-----END PGP SIGNATURE-----

--Encpt1P6Mxii2VuT--

--===============8446197871711576728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8446197871711576728==--
