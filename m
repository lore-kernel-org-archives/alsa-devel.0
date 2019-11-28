Return-Path: <SRS0=87PQ=ZU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0876C432C0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Nov 2019 12:12:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01056217C3
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Nov 2019 12:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GPVOyDQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01056217C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F98A16DB;
	Thu, 28 Nov 2019 13:11:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F98A16DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574943147;
	bh=6IqIWgA1GK68RdRkPgZ6Kc39YV1Lii30JgZRSshZ+PI=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GPVOyDQ6/1RWhyfDpjXrgoDRBYGXl/w8u0994PBC65rUfqO7YjXbLGFlBp/i6j0S/
	 fqR4jApS120APeUaL5zoF4Ayvl84ILO9ejn/79ZDXRrQJyB5B7tvnaWAFIz+7eaDQ+
	 nqIeRZleKQkMOt6gY0ld3Qx7f1WufLkF8FeDTt9Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F10D3F80106;
	Thu, 28 Nov 2019 13:11:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 675ECF80149; Thu, 28 Nov 2019 13:11:35 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 01D7BF800CB
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2019 13:11:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01D7BF800CB
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D810C30E;
 Thu, 28 Nov 2019 04:11:30 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 559613F6C4;
 Thu, 28 Nov 2019 04:11:30 -0800 (PST)
Date: Thu, 28 Nov 2019 12:11:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <20191128121128.GA4210@sirena.org.uk>
References: <20191128093955.29567-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
In-Reply-To: <20191128093955.29567-1-nikita.yoush@cogentembedded.com>
X-Cookie: Do not dry clean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 "Andrew F. Davis" <afd@ti.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: tlv320aic31xx: Add HP output driver
 pop reduction controls
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
Content-Type: multipart/mixed; boundary="===============3648984455837880798=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============3648984455837880798==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2019 at 12:39:55PM +0300, Nikita Yushchenko wrote:

> +static const char * const hp_poweron_time_text[] = {
> +	"0us", "15.3us", "153us", "1.53ms", "15.3ms", "76.2ms",
> +	"153ms", "304ms", "610ms", "1.22s", "3.04s", "6.1s" };
> +
> +static SOC_ENUM_SINGLE_DECL(hp_poweron_time_enum, AIC31XX_HPPOP, 3,
> +	hp_poweron_time_text);
> +
> +static const char * const hp_rampup_step_text[] = {
> +	"0ms", "0.98ms", "1.95ms", "3.9ms" };
> +
> +static SOC_ENUM_SINGLE_DECL(hp_rampup_step_enum, AIC31XX_HPPOP, 1,
> +	hp_rampup_step_text);

I'm not seeing any integration with DAPM here, I'd expect to see that so
we don't cut off the start of audio especially with the longer times
available (which I'm frankly not sure are seriously usable).

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3fuW8ACgkQJNaLcl1U
h9D+5Qf/QFKjJasickPKQCEdE/PrbvW/Mm+6dtmuvmnV9hvdQeCMwT37eyE3TFlE
+hlqcPYoBxVuscGPCTbS+PgplsAB7++PcLBp1gQwcrU3FGg/kbOQiF0AeV/8456X
hJD1fdSlIMnzV5QXMbKz0iAO6G2uxLJUHreXOGybQS3PYvFFplPs/2Sog4GIcnWt
94QrFkgRVccIIjVDCbisZngy1WK919xWYrQDCdg/MGKJiCKENfqUuwKSck6Cy+Z6
GDMCaDw9PNCCfeYW27GIt1DKqrdcL97+J29WsXqTxqth8WOwEM/UmpuMtvhX2nip
/4l2Iu4vwMmdpgsGwcLLJs+pPbi4Lg==
=bIgM
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--

--===============3648984455837880798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3648984455837880798==--
