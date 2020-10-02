Return-Path: <SRS0=qvVP=DJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DFBC4363C
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:43:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA0B92074B
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sLgDNV5k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vlFOtcqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0B92074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3359E1F07;
	Fri,  2 Oct 2020 17:42:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3359E1F07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601653390;
	bh=v5iehWcOX0VLo1AP99P9bUun2tqq3LWKlFh9oC0pM6A=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sLgDNV5kF37Z7RLCBNZ7nnzbVIna67qXSagcvlZWtpxQrIvBw+oQstZVK/bLCVyju
	 mCSjnxt/HOu8hvuC7Y9uuF0RuMEZO+uCMhZNQeQ812Bz06ToujTLAohxrGSyT7EoJY
	 //JLa/cEdHIbvWd7BKOrgjP7sfGXwfSxzaQtPnec=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AED85F801ED;
	Fri,  2 Oct 2020 17:42:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9AD7F801F9; Fri,  2 Oct 2020 17:42:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9589F800AB
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2020 17:42:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9589F800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="vlFOtcqO"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E3CF02074B;
 Fri,  2 Oct 2020 15:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601653327;
 bh=v5iehWcOX0VLo1AP99P9bUun2tqq3LWKlFh9oC0pM6A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vlFOtcqOxfyc22WCafJBSQo1lA+ZbQIvpliVp5g+LacQS99cqT50bn3+vFDF+rpbf
 9O0c5qNtP/fwlvgZ9oVP7lGlhLbedjAsUNUFgwBzyndZI4MgINYQI4itJqbXsFbSBC
 77+q/QTtoD8VTqtvt7RQsUcbtA/ANEIvZN+tL8ic=
Date: Fri, 2 Oct 2020 16:41:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Olivier Moysan <olivier.moysan@st.com>
Subject: Re: [PATCH 1/1] ASoC: cs42l51: add soft dependency declaration
Message-ID: <20201002154107.GC5527@sirena.org.uk>
References: <20201002152904.16448-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <20201002152904.16448-1-olivier.moysan@st.com>
X-Cookie: Words must be weighed, not counted.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, alexandre.torgue@st.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 arnaud.patard@rtp-net.org
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


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 02, 2020 at 05:29:04PM +0200, Olivier Moysan wrote:
> When configured as module, CS42L51 codec driver uses two modules
> snd-soc-cs42l51 and snd-soc-cs42l51-i2c.
> Add soft dependency on snd-soc-cs42l51-i2c in snd-soc-cs42l51,
> to allow smart module dependency solving.

Doesn't the userspace tooling usually manage to figure this out from
symbol usage?

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl93ShIACgkQJNaLcl1U
h9AfMgf/bO5iRl+FHKAa69Dt5NyALR5rJ9EhOt2FrK6Ql/DPOjT4GJE2wWdt/fKD
H9c2EU6rY0lAp4X7M5PNZJrq4gOcyWdGaHfIOfXBf2qiEzN3L6AvX6iA5oBi1s3O
eECGQmaRqcwv/nSuoOnzpkoKyywBq9+o9lkHWu1jBg7uhYU1kjp4kJmifrl1aeFU
QrxFCjLwGSjmNFfm7v3N/33M/aNRwvhyrG9ct+19u1GabgzXBQpLqVj/7Qf1R4Ab
4Wx8zbP9UI9kW+NLwFewr2wDMP4+WC86biyvT8yU2RYGfxzU3l5U6GtawF+TDhpR
yBPJ2eIvTmHz66uX7dvMIHlzF2V+GA==
=ioD8
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
