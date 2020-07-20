Return-Path: <SRS0=gPEE=A7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05951C433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:52:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A902070A
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S4uzwWC6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGQYcTtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A902070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E20D083B;
	Mon, 20 Jul 2020 13:51:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E20D083B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595245939;
	bh=uh6pZqT3gGRXM43/NRvvGhsCkxMMMKqxuy1Sr8oz9Iw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S4uzwWC6NyZKAdcBqO6AhK9iuRBz7vPqdVnAwyCudaYBmpRHamHJAB6z4l/dWEq7L
	 w2GHpMhPDIEYkJmiF+JzYDKrXVO8I+zS7jDPSGA3gByVTOedFKNohJopqRVdrLTyGp
	 HkNq71hYge4x+uZIbHKnVkLmvK4RlwdpUf19Eaz0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 662A6F800C1;
	Mon, 20 Jul 2020 13:51:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B7F2F800F5; Mon, 20 Jul 2020 13:51:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 27072F800C1
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2020 13:51:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27072F800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pGQYcTtW"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 179F82070A;
 Mon, 20 Jul 2020 11:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595245877;
 bh=uh6pZqT3gGRXM43/NRvvGhsCkxMMMKqxuy1Sr8oz9Iw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pGQYcTtWGaaC8v4tkZFLhux4Xgtv8kFWgmoG1vk9whlZ7vUXK4N8+3Z8vLQpz7MCT
 SroLs8o8Lf+ykRX81gSZOsodbqkRHacbIz/vnr14T9qB25PbgmNqoMFD3x6t1ksHmi
 dd7Z0qAkhFyJ5gd/a7Ag5gbaV9EZo6ydtccaTaKQ=
Date: Mon, 20 Jul 2020 12:51:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 6/6] ASoC: Intel: common: change match table ehl-rt5660
Message-ID: <20200720115105.GB4601@sirena.org.uk>
References: <20200717211337.31956-1-pierre-louis.bossart@linux.intel.com>
 <20200717211337.31956-7-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <20200717211337.31956-7-pierre-louis.bossart@linux.intel.com>
X-Cookie: Be different: conform.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, Libin Yang <libin.yang@intel.com>,
 alsa-devel@alsa-project.org, Bard Liao <yung-chuan.liao@linux.intel.com>
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


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 04:13:37PM -0500, Pierre-Louis Bossart wrote:
> From: Libin Yang <libin.yang@intel.com>
>=20
> This configuration is for EHL with the RT5660 codec. RT5660
> should use "10EC5660" ID instead of "INTC1027".

This seems like it should have gone out as a bug fix?

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8VhSgACgkQJNaLcl1U
h9D7UAf/XQ4aTe67SjTuNTc6tzfD4+nGdnUvy1yASxamAskzh34Dq1GU0/SxqX4I
wjKrTyNUmqV+lSc2F+dD26YcdVBpbBCFWfze3hy2w0Da51rIiHHIRszNKbhFFLVn
poc6+llGU7x1Gwt/e9/l+FRjGTQQrIyvx/EWFQ2lsQAqpoLZoOqDYhV8kYdXzhKw
ZC4oM70VcBk2LBNyhS2SBOFl4AKYgYWWlikb+HZ9m4Hm4EMNOxxtoDEYxaV/4TUD
44MsQCjdhLZnAUahZHRH/6SY11WL8M73MHapKfd3jdHPclRbAVS6k2lo0/Gi6xEP
UNOPA9He0D+L0O15b5AEuYmkMtV5jg==
=lIY7
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
