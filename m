Return-Path: <SRS0=grW5=HG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A4BC433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 14:07:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96CC64DDE
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 14:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96CC64DDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4AF9516DB;
	Thu,  4 Feb 2021 15:06:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4AF9516DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612447625;
	bh=WTpwmaKEsOmopPWlV5aFCRgW07zNI0+llSoe3KrdjNU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nd/zsk9JmdHmc8qW9G392IrYJW7sYyS3nyRIy0bqeeMkgTlb2Q4NY//h3dX4VfEvy
	 ft3TfXgrFAoGg3YVxr33enpeUnv6l8KbebSCedNm8qaPu9QogEdAqV/F0rs77f3t3r
	 ktiydJrIr3wkOo2ktY93OPbbUa49gJ5OSc/sX8OA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E86A7F8023E;
	Thu,  4 Feb 2021 15:06:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DA68F80254; Thu,  4 Feb 2021 15:06:12 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14B39F80152
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2021 15:06:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14B39F80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="k+52rSFl"
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECE1B64F53;
 Thu,  4 Feb 2021 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612447564;
 bh=WTpwmaKEsOmopPWlV5aFCRgW07zNI0+llSoe3KrdjNU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k+52rSFlPrnt3pGAvXLfrIbKUDVaWXqEOiuZe6BU24JGEjVozqFRgcyuCuCXfBY9d
 Kh1DRlYizwCufebQleqDSfodBkX5WYZmYw0T/5poz7mfDI3wkduPE13YpZ5/PVGMTd
 TeEZrGOqjZfm+mLhryIEVAVtPzFEb/R5TLp3yY3JP9fWMFCvZTADV38eRJNfpAR7Kt
 7qiM3L4GVIPF8tUHGU1HbsiW8JCQjxAO7mm5aiqNEnx5UfQPgNpLlD+LeXWSakK9ky
 aOAAqkbbK6Icoirek6meFxZtmvXfmA2TocE/NaclCw0FAQX9eyDuy4ohTyhjAOWuMZ
 gQrBjSZAcAmkQ==
Date: Thu, 4 Feb 2021 14:05:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 4/5] ASoC: Intel: Add DMI quirk table to
 soc_intel_is_byt_cr()
Message-ID: <20210204140515.GC4288@sirena.org.uk>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <20210120214957.140232-5-hdegoede@redhat.com>
 <20210204135616.GL2789116@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <20210204135616.GL2789116@dell>
X-Cookie: Truth can wait
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
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


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 04, 2021 at 01:56:16PM +0000, Lee Jones wrote:

> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>

> Applied, thanks.

While we we were just having a discussion about what to do about this
stuff...

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAb/xoACgkQJNaLcl1U
h9C3yAf9GvUSrNJ8yyv9kq8xIU5ckUwLeA4UL1g+1mugCDM1+SgPzSN6dZAl39kn
qWBsGN3BdkVWPaXZySyXkNsTQGEHte6PHH1Losn4w6p3AhTioLlODamNzDQs/aws
lTCwVMCY9cpZQIgBRlL/OGwsJU+wFKHNS4vHKKk/roLHElduYoDKXfyElKHBCv/G
rltkUuNYI/JbZM3ise5Gq9571O0filPGDe+LE97LIRlHWH3acn+3JFqrLRN8o4Tm
WOrjgdKppQyuXX8IzKyzgqaZVD6Gm0qVLRFruNtIcuCsoIXB9OkUnaa57YbeDs7s
PgzTpMX50XN/tIcK/4YBNxPsWL9h6Q==
=Rlvb
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
