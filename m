Return-Path: <SRS0=sDoq=M5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0F1C4338F
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Aug 2021 00:47:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7CDA611ED
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Aug 2021 00:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A7CDA611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6044C1714;
	Fri,  6 Aug 2021 02:46:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6044C1714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628210836;
	bh=TeFmqVyGxWQDZ/rgW2rRFKouG7Wsb42tgFD6/C9/vmc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qw9GgokrukanpErATUSDrxl4Uuo63BlCU6gYlzbMyM2i5+/l2tIiISyPB+y3/SDWv
	 lOjqoGjU+KxiE4FSdDGvOD8XzL9bpjyhtrIqJC/sr0JhIugAIgj/0y2nj91hqxy9CF
	 Sl14GzpCe3s4ynq5CWP4hqD+MRt06/6fzd00u2U0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AE473F8016D;
	Fri,  6 Aug 2021 02:46:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A89BF8027C; Fri,  6 Aug 2021 02:46:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4093FF8014D
 for <alsa-devel@alsa-project.org>; Fri,  6 Aug 2021 02:46:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4093FF8014D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DklIGuS4"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 068F160725;
 Fri,  6 Aug 2021 00:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628210775;
 bh=TeFmqVyGxWQDZ/rgW2rRFKouG7Wsb42tgFD6/C9/vmc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DklIGuS4Il4+uh6iQTqCRxNxSixSuTjIfWH0IqYatKkzbYvxwtYlwocJB5+Opegjx
 PB70yEBYyy8T2FdiOhCQ9HKSsbZloqheprxDWwr2oKKFZ0VVkgA/ReIm3pGdDygrIz
 /hGwk7dqiJMZayWwolfFPzkoUXQAbv8opd2VvN1Opf/vtZhgs4XgnIM7cS7dcnXvha
 PbWFHUP6NJKA6bFBInBf7ylmFalolscI6j48x2q+1LaR3e3hm74p1G7gU44E+NNmh8
 0ikkMoDeLyjmV1XCbR2CMFhNhhrikTlonZBtAzgR/CgOwFxzvbXqlzjyCYgBFySTQB
 zAlpyUzIzEM2w==
Date: Fri, 6 Aug 2021 01:45:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH 1/8] ASoC: cs42l42: PLL must be running when changing
 MCLK_SRC_SEL
Message-ID: <20210806004558.GT26252@sirena.org.uk>
References: <20210805161111.10410-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X9hp/qFlD/MyfJCu"
Content-Disposition: inline
In-Reply-To: <20210805161111.10410-1-rf@opensource.cirrus.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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


--X9hp/qFlD/MyfJCu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 05, 2021 at 05:11:04PM +0100, Richard Fitzgerald wrote:
> Both SCLK and PLL clocks must be running to drive the glitch-free mux
> behind MCLK_SRC_SEL and complete the switchover.

Please provide a cover letter for serieses, it helps give an overview of
what's going on and is useful for tooling.

--X9hp/qFlD/MyfJCu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEMhkYACgkQJNaLcl1U
h9AIpAf+Jth8Ifl65n0DvVX24GXQht7YbCgxmupcceczqyDoODTp2w3y6sEREHP2
g1bFpkb10yaqxBupQtWVw9Gzv7QGsciHzJZuGmhnXJUQNs5l5laDsxZg5R62OLTU
B1A9CsgwRROsDHkZwxFK8CWBTmsLFlrnNonuMHcEDRmQzbtzBolgQ9wNiMoeRlc8
GCUPpxXOdGCprUvH24StHM6+ERFL7UrfAX6inxG29aoa5fa4dwV7cosTXLNxoYD+
dIRZ6GMa4dezT6nUFeK1ehUpLOPGheuf1SdA6mxLiIqWHu+8nfcMgBEENOXoGWIs
t1pQjT8w8mpARqdWF0eOxNd7KS8d3w==
=kbc2
-----END PGP SIGNATURE-----

--X9hp/qFlD/MyfJCu--
