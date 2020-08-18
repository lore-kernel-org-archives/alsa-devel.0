Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFD1C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:04:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334F2206B5
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="atBRhP/x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb+VTDOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334F2206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DCD51678;
	Tue, 18 Aug 2020 17:03:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DCD51678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597763038;
	bh=/Au42xAltT4UIkIAu/0BCAbvou4lntMo5L1yDg87RPo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=atBRhP/x50Tk7MA10oyauSGNqAZxgfYzG0f6AiryeEX/4CRlg9RRcyRb0RXl+ioxe
	 dPyMQiRP4ZZkB+Yo+oxmosy/9IrNlv+q1uWbngCFOHmTs3v+IRyUo35Immi2d6FPLn
	 qzj9niCyHwf4nYlb4qH3/YexvATiP17hrmzqvJYk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D1C1F80114;
	Tue, 18 Aug 2020 17:03:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E61A2F80228; Tue, 18 Aug 2020 17:03:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB236F80104
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 17:02:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB236F80104
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Gb+VTDOy"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0F985206B5;
 Tue, 18 Aug 2020 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597762976;
 bh=/Au42xAltT4UIkIAu/0BCAbvou4lntMo5L1yDg87RPo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Gb+VTDOyjTUgtk3IQY10NgidC0k5bHEanm05OxqNw+2FD/GDTn3v6Zin6FqFGq/RO
 22eOA+toA6ryOWhnLbiKhlqe0YvhboXwQ38lMHCYKsAu/uQeEW6sUG12uftGtfp/4s
 Ov/N2VwdXqVu8XlYzXih7O7ErdO+/PnzQgZlnfDg=
Date: Tue, 18 Aug 2020 16:02:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Brent Lu <brent.lu@intel.com>
Subject: Re: [PATCH v3] ASoC: hdac_hdmi: support 'ELD' mixer
Message-ID: <20200818150225.GC5337@sirena.org.uk>
References: <20200818004413.12852-1-brent.lu@intel.com>
 <20200818143632.16539-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
In-Reply-To: <20200818143632.16539-1-brent.lu@intel.com>
X-Cookie: You're at Witt's End.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>,
 Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
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


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 18, 2020 at 10:36:32PM +0800, Brent Lu wrote:
> Add a binary mixer 'ELD' to each HDMI PCM device so user-space can
> read the ELD data of external HDMI display.

Please don't send new patches in the middle of existing threads, it
makes it hard to keep track fo what is going on.

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl877YAACgkQJNaLcl1U
h9ALXgf8COAHlHSEiVOtPyp/q80RUFjIinu+Fl/Ici/1rbVn2e6HfyoKPntkcdsN
/MnEHoNs/YceorJgRS27MLtYuH/d7UcuVoaswd52DMV3Jat2VrBE18B4y9xdLgk3
3sAlOgMpfmfvlnCGs1LMtxMjZXML3Ld8cXYAJNr4Eio1+ovXYnZ2ihNtoVXpEhMW
zC9EShuuu0FatftsHxGvHo2wpxxoEeMYSSAQY9lR9Wq1LPQRib4zRubsjsshGp/Q
i2Id2nM7bTrkSfhGtW9MXqNUr7rztZt9YyG/LkEGsUyzCZHBeYIrOKX4M9eZUQNR
epCsSSEFOadhYuaoT+z5P+pxt1CMAA==
=NwDr
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
