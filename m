Return-Path: <SRS0=/Ps/=6F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72085C54FC9
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 17:20:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A3F206F4
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 17:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sLW3rZEp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdmO0c28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A3F206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D26716C3;
	Tue, 21 Apr 2020 19:19:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D26716C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587489623;
	bh=jX75WsUbyBuX7mDPG2wJuZG6PvLcNk/t0JUcx7zHqwA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sLW3rZEpIWTx/DKcdD95WW+psV56dhr1VrxH2gm43pMY41T2waTRU//yDAqwcOxt2
	 viYqtIA7DQ4j2FYXT5zaZjywSu95auMRreaSC0LmYBvhR0D5cWb84JOwpFokX10sdE
	 fMhTIGPhWVmDPxyUAs5R4KleL0YoCW6jf/2ZQjz0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3B6AF80143;
	Tue, 21 Apr 2020 19:19:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC803F801EC; Tue, 21 Apr 2020 19:19:25 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D879F800FF
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2020 19:19:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D879F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="LdmO0c28"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C7FE82070B;
 Tue, 21 Apr 2020 17:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587489543;
 bh=jX75WsUbyBuX7mDPG2wJuZG6PvLcNk/t0JUcx7zHqwA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LdmO0c28NFZPb/5vkmiTmMlGrzG1RDnyltbVxvhtp6BvG5lc+CKSxFcwnyig/RfSH
 +x9JzgzY5gqzBfSzlx+Vb5wZgnvHZyZpa5ryKFJA5Bd4mpRxQ+gqoZT1UKn6c3vl6H
 R7ZAdvRBtbmyUmL9xLRzA5hXJ42eA6R9oJmiGCes=
Date: Tue, 21 Apr 2020 18:19:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] ASoC: txx9: add back the hack for a too small
 resource_size_t
Message-ID: <20200421171900.GF4540@sirena.org.uk>
References: <20200421171136.288216-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline
In-Reply-To: <20200421171136.288216-1-hch@lst.de>
X-Cookie: Non-sequiturs make me eat lampshades.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, tsbogend@alpha.franken.de,
 linux-mips@vger.kernel.org
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


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2020 at 07:11:36PM +0200, Christoph Hellwig wrote:
> Looks like I misread the Kconfig magic and this driver can be compiled
> into 32-bit kernels.  Add back the hack to extent the range of the
> resource_size_t, and include the header with the txx9-specific ioremap
> magic for that.

Acked-by: Mark Brown <broonie@kernel.org>

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6fKwMACgkQJNaLcl1U
h9DtTgf7BfvGEuEV5UX+vLAJXzbOGxkp2fia6NUiVsDU307CXn+/Mv31zV7TT/pB
8cUnYrvIzQv0LjKAGkZnjTKeBoWXy4Dvc91EHuLejmcvSUBjIxenFPIXeDgs3KE/
+OASpbRgdfonLMaULe4AZSsbLokerVIFeDihx2oQxSkpOYQFXKO0/+9m2YtwQg8a
LnG4ZAPkhJFQdYMWW01kpTxnIDz+uD0BsI+kswBa4usIuwVzJ3dBDBszGvXeb6Nt
THJoVL469sSymrANmpqH3JuaEZP1oLLtAWDhM/gPUYXY4E1bfkdbnZ+1c+xtT6mB
Bsj9erJHQglEeL0IKDWG/OL8tKsA2A==
=Nqby
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--
