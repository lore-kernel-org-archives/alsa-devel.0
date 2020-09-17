Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55687C43461
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:04:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758202083B
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Zw4KQOOq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vYQGVyKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758202083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D26F5846;
	Thu, 17 Sep 2020 15:03:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D26F5846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600347870;
	bh=Q6IpJ77FCD9H833/+eXE2yE3D58BO49AZXC7Kjdp4I4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zw4KQOOqrpS+Ya9SLRsQXLRrl05+XpG9Pv2HIbzdcQIval7oWw2+0naLSIAIg6XWE
	 JDcJTfTRh0cm+qz1ZXpNDHfKen1oiWhUMfuPGk5ejAlbzf7eLR5HCAWtVAx9oBdwsP
	 0yo5vNM1HWlfoJKwFdVMVlUlv6D+htA6uY/KytBE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 754C1F80134;
	Thu, 17 Sep 2020 15:03:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03FF0F80212; Thu, 17 Sep 2020 15:03:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0BCDF80134
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 15:03:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0BCDF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="vYQGVyKq"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6BECD2083B;
 Thu, 17 Sep 2020 13:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600347805;
 bh=Q6IpJ77FCD9H833/+eXE2yE3D58BO49AZXC7Kjdp4I4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vYQGVyKqzlRLvhGU3T+FLcyMZBl2qFEDU3MCSqL23dvTSzH2Xb6lkZyfa4degPqdT
 mzgLNEkursN/aKlHBe2FFFaNh5V2xv0lUmwP3LlizICJ7aYwsXtZkr3OiUV2TtDJIL
 qtQ+OhqWZhZkYmMcWOzfyPulF9OKSZGGKesKzxck=
Date: Thu, 17 Sep 2020 14:02:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 5/6] dt-bindings: tlv320adcx140: Add slot programming
 property
Message-ID: <20200917130236.GA2954@sirena.org.uk>
References: <20200915190606.1744-1-dmurphy@ti.com>
 <20200915190606.1744-5-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20200915190606.1744-5-dmurphy@ti.com>
X-Cookie: Don't SANFORIZE me!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 camel.guo@axis.com
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


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 15, 2020 at 02:06:05PM -0500, Dan Murphy wrote:

> +  ti,slot-mapping:
> +    type: boolean
> +    description: |
> +      Each channel can be assigned a specific TDM slot for either a left or
> +      right channel. The left channel values are from 0-31d and the right
> +      channel values are from 32-63d. If the right channel value is 32 then the
> +      right channel slot will be slot 31.
> +      The array index is sequential audio channel to be set.
> +      [ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8]
> +      If the channel is not to be used then the channel should be set to it's
> +      default value.

This is something I'd expect to be done by the machine driver rather
than in the CODEC specific DT bindings, and apart from anything else
everything involved in the DAI will need to agree on the mapping so this
doesn't look like something that should be done in a device specific
binding.

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9jXmsACgkQJNaLcl1U
h9C/Rgf+IMC1QTgLSmNF/gJuZlCcieaK8BfTxcfHEBBykWRyvmdqNW9ZPHFXODK/
scOFFkEWwz1YvqreSRdrXXUAJ7RHpUcO3KT1YKyPnRlo7m7dqiyJhePSjkG1rtPQ
1rg7EVnqS8IIKMrr5XDSeqpJrEet2KcRBJ4eqrXotx5t8s8VcK3DDDZO6UNhEyRN
8NKwX+MiUs2b2/d/xkfC3ILN/3bV7K5Mnej2bQS8kzkEArvI4DT4Hr7QtXbBkLsZ
/Vu9XuVXIitkCHq9akNFyJjevgIrMFmm4htRV95YcbfZWLF5BV7uOf5nbwokvZA9
jHGvK8hTXVdF9T/e4D/kiXEGvAJR2Q==
=usXR
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
