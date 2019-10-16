Return-Path: <SRS0=FfYG=YJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2D9C4360C
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:05:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE34218DE
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="f0p1RQe0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKslahbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE34218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A994845;
	Wed, 16 Oct 2019 10:04:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A994845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571213121;
	bh=V+VF5Wdilr8d3p3jE95TQoVXGAVRRLEvo4cMEmYDe0o=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f0p1RQe0yk+gWQtPr8derar4BLfc9FXZOQ3gAt77IOTISJuWsX1xkPmeFT6SJm4Zp
	 /4hDHioD2g/omFmJ+/w0lWQGO19JRfA0XRJ/vDgqmbjBJB2KomDJkRprx0mggzz8w2
	 a/ed1FdhrPB04LA3urUsiNqnHnfogab9WlpAYb8c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75273F80323;
	Wed, 16 Oct 2019 10:04:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8F51EF80362; Wed, 16 Oct 2019 10:04:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F3B18F80322
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2019 10:04:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3B18F80322
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="EKslahbu"
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8CAA12168B;
 Wed, 16 Oct 2019 08:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571213063;
 bh=rReuVb132ii3iV3YvU4PNL9utgLRGUbc4m/9hSBbvoo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EKslahbuYYEfHHiHvt1LJUtrJWPfqhT+U1un2c0j+oyJD91TSdrEHjpXKqUUdPIJJ
 mgavniH/wVMdLjNQLohrfunzsw+5485YLEid7Go0xRWtGD7O6wnaocKqQUEKalZxdD
 IBQ8K1DJ/CSH4iz7+Qrrmxnjfi0bKsbH9cBkhfAM=
Date: Wed, 16 Oct 2019 10:04:20 +0200
From: Maxime Ripard <mripard@kernel.org>
To: codekipper@gmail.com
Message-ID: <20191016080420.4cbxn2hdt3wwtrhl@gilmour>
References: <20191016070740.121435-1-codekipper@gmail.com>
 <20191016070740.121435-2-codekipper@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191016070740.121435-2-codekipper@gmail.com>
User-Agent: NeoMutt/20180716
Cc: alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, be17068@iperbole.bo.it,
 wens@csie.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH v6 1/7] ASoC: sun4i-i2s: Move channel
	select offset
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
Content-Type: multipart/mixed; boundary="===============7464683333154098808=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============7464683333154098808==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7ms26mvxh6nbjd52"
Content-Disposition: inline


--7ms26mvxh6nbjd52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2019 at 09:07:34AM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> On the newer SoCs the offset is used to set the mode of the
> connection. As it is to be used elsewhere then it makes sense
> to move it to the main structure.

Elsewhere where, and to do what?

Maxime

--7ms26mvxh6nbjd52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXabPBAAKCRDj7w1vZxhR
xWfVAP9ZDeCUM6YB6ieMATn24AtmYaqNFpUuWyfe7WmRM0R1qAEAkXYiT7NBO4dm
xSC0H+a6BM1oFgGWjOiNULlLMAySTQ4=
=HbkX
-----END PGP SIGNATURE-----

--7ms26mvxh6nbjd52--

--===============7464683333154098808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7464683333154098808==--
