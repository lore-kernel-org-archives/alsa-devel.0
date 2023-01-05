Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5FCC3DA7D
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Jan 2023 11:47:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A04D3092;
	Thu,  5 Jan 2023 12:46:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A04D3092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672919230;
	bh=Cik1RDuh83X3oFwc9w6B7VB1PTN9Hd7TIFEd95DW/3w=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=gONnwo9EZTe6RC6jQdPzeSeW4Emel6nqo2+PoDQ20hHBFIwYE9ogJmTXx8MITDYTS
	 3+lFbdKEz72wsHVkdkAY/q6SVmmbb2SuZAOmfecq5JX09s2sKTMuGMfUkmAmQJ5+tB
	 q9Cnc6iHcbSco8RGaBQDip9YZaSPTaS32KhXyZcM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A86D3F804AD;
	Thu,  5 Jan 2023 12:46:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07439F800C0; Thu,  5 Jan 2023 12:46:18 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF216F800C0
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2023 12:46:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF216F800C0
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=OG2WD/ou
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6480DB81A84;
 Thu,  5 Jan 2023 11:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA372C433D2;
 Thu,  5 Jan 2023 11:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672919171;
 bh=Cik1RDuh83X3oFwc9w6B7VB1PTN9Hd7TIFEd95DW/3w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OG2WD/oueUO8uQD+sD1XijfTHFL/AWRDuHyAfd8ePct23bIa9t2iyTq0Nfo69pGIH
 fbDe/1hEn7NkLwN5AVXUVG8bs9+INhDGc13idZtfrGU7Hqgxc3suxIslqmkCrSoCCn
 i1z8G54FHRDYpkq5zb5jJAL5sDupe/nzL8GxQoPo9l0aOnDkbNe/w8/N1BIUWMWJih
 cNY89Xm8t+miYCoqjoBnTTGPTEOAvs5/vfgVGxeY+wyz1+sNhx0wVDyYd1C1LZB0ZC
 NVIIHYgtxI2Jo05pFApewre4NvjFUIxAvS7/jU648OiDbkgRXR3/bhpIAtFbhTbOiN
 fOE+Mm3S2eW5g==
Date: Thu, 5 Jan 2023 11:46:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/5] ASoC: Intel: bytcht_cx2072x: Replace open coded
 acpi_dev_put()
Message-ID: <Y7a4fVwa9WlYJHS4@sirena.org.uk>
References: <Y7WtywhUZCTx3akM@smile.fi.intel.com>
 <Y7W0VOJKlMtaIp13@sirena.org.uk>
 <Y7XLo8febtiSLGAD@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6clIRmAMq5MhY13B"
Content-Disposition: inline
In-Reply-To: <Y7XLo8febtiSLGAD@smile.fi.intel.com>
X-Cookie: Surprise due today.  Also the rent.
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--6clIRmAMq5MhY13B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 04, 2023 at 08:55:31PM +0200, Andy Shevchenko wrote:

> P.S. Tell me if I need to resend with tags applied this time?

No.

--6clIRmAMq5MhY13B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO2uHwACgkQJNaLcl1U
h9B+EAf+I/vPfWxJqkCwPWOm+sJxBlPlaeU6T8geBRQao86QUWShHa3hclugSHnN
LKmbfMhvQga/7WQmaGdd3mHqQb9Km4WQX/vM2hLgdSNgXBIPgbZCWFyOXCK9E41q
J66eg5UqNMFsOAjZS+s4Rr3FLSZPwtbH3uINMhZjo2arW7Cq++iuGrTTlGkjUhtB
cUc12EWyJu3j5Xlqa0sVURmWQtugXLKQZ89lCah04CIkcZGub8KaMwu4qucv2G7a
Kv9k98lkKpwS5JBgFPPuBjzxBI4/pgRkaefuOlDvUcFj+RuGs+7137xofH1fJbnA
AVd6iKKPJezBiTRteFXR8LmFuv2OqA==
=TXc/
-----END PGP SIGNATURE-----

--6clIRmAMq5MhY13B--
