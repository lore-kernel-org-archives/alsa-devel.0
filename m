Return-Path: <SRS0=rado=64=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240EAC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 14 May 2020 16:49:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4AC20675
	for <alsa-devel@archiver.kernel.org>; Thu, 14 May 2020 16:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JAKH91Lx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJrNK5O9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4AC20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB5041614;
	Thu, 14 May 2020 18:48:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB5041614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589474970;
	bh=13YkInzwmfXC+4uzSMHtTHtxogyvUnuzvUSpaRaQf+o=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JAKH91Lxx0jH46Cn96cCYZsv3FekJ0iFFB3gn5NINqKRZJbwP9O/PRC78ByJsHDdS
	 E+p/5EjiP79tXabZdcBnuWaNjD7TI7DtjQHqUFmWJ5agPijOBx1VYEDcKsGzoXZp2H
	 gveuwbm89CBfbvR1bfSIHR1FKJjGD/guecl/7+jI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66810F80101;
	Thu, 14 May 2020 18:48:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 834E0F8014C; Thu, 14 May 2020 18:48:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1637F800BD
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2020 18:48:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1637F800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="iJrNK5O9"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4BC4A2065F;
 Thu, 14 May 2020 16:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589474910;
 bh=13YkInzwmfXC+4uzSMHtTHtxogyvUnuzvUSpaRaQf+o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iJrNK5O9NGBmk6t6rSC7WEqyFG1fOoKm8+OcSJQupftkmzlhIteluJEB5LQwdY0fO
 ZIHJaxDy5hj5S17FYWM6fM/6fCxO0xYDN8U9l1/Vdgm9ZNLPgdkJq3XI+FDjcIOXWx
 95Lx82Ub54w+uY7PFfrkVcjw1DcNsnckmKEl/CIo=
Date: Thu, 14 May 2020 17:48:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Ajit Pandey <ajitp@codeaurora.org>
Subject: Re: [PATCH v2 5/7] include: dt-bindings: sound: Add sc7180-lpass
 bindings header
Message-ID: <20200514164828.GL5127@sirena.org.uk>
References: <“1586592171-31644-1-git-send-email-ajitp@codeaurora.org”>
 <1589474298-29437-1-git-send-email-ajitp@codeaurora.org>
 <1589474298-29437-6-git-send-email-ajitp@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aiCxlS1GuupXjEh3"
Content-Disposition: inline
In-Reply-To: <1589474298-29437-6-git-send-email-ajitp@codeaurora.org>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, plai@codeaurora.org, linux-kernel@vger.kernel.org,
 srinivas.kandagatla@linaro.org
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


--aiCxlS1GuupXjEh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2020 at 10:08:16PM +0530, Ajit Pandey wrote:

> +#define MI2S_PRIMARY	0
> +#define MI2S_SECONDARY	1
> +
> +#define LPASS_MCLK0	0

These look like they could use namespacing.  Is primary/secondary
perhaps something that could be a boolean property?

--aiCxlS1GuupXjEh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl69dlsACgkQJNaLcl1U
h9BZHQf+NnNftIV3+H/9OLXdIMRFWRkbvO60/+gaZMAkfPciHgKoXQwNANjs+MS6
KkCRShohQWebjaBfakB8D1jqe1Iu8mX7RJ5ZC7h9nNAtZvFCHYjyysX7T+pmmrxE
dkTnm7jCPzlqk3WNGH+eenvXfTkYKecvRlyDUgsHAE3nbwucemebf4CIs4PsjEbG
h0bKFNL2kRgr/AH9QTbSllcmDbD/V+WF0SOO5+kOixYg5lO6iHW8bW2pnh49qp/D
rDCTgGclFkQobmTltDgySlc3T2aIm838esjcculKOrQ4ZRZeYa+UdTCyo/1/UVPd
DvP3oL7jfacTv63JwDQN9IyQq/cZVw==
=lTr1
-----END PGP SIGNATURE-----

--aiCxlS1GuupXjEh3--
