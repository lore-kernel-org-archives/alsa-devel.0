Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6230C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jun 2022 11:25:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16AC41753;
	Wed,  8 Jun 2022 13:25:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16AC41753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654687550;
	bh=gxuRxmn8LltL6EShbwujtTGcPs590C9dPrlLHgw8yFA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tMyocqtiPPay+GF2gOttlM2qmMmbSFGuJFJfxF43zV5IkB+6iQKVtNkntLFminFOp
	 /mvHqdGU/UO7KM/T5znOY6wRWgWFeTHt0rFGGk4FD4nVaFfiaCBgNXYHBBrhY++h/v
	 7ZoZ3zmEuT4MQXSMTnKX3ib9UJZdPmBIsri3Iaoo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5894F80245;
	Wed,  8 Jun 2022 13:24:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 341E4F8024C; Wed,  8 Jun 2022 13:24:57 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 40448F800C7
 for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2022 13:24:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40448F800C7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="J0+PV/9e"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B5B97616C3;
 Wed,  8 Jun 2022 11:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EFAC34116;
 Wed,  8 Jun 2022 11:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654687490;
 bh=gxuRxmn8LltL6EShbwujtTGcPs590C9dPrlLHgw8yFA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J0+PV/9eBcimatHw1QFoUGvheIowOl9qq2FFyDOD3cBHqgEbBeyHUC+D8j0XdXd2m
 A4Oh7V1PRqZmIqrvBAK8ejapVyycZ/IKBraDQYigEjf6T/CqPLsNezjNag0ZfqtTty
 aIjaUe6Uj9XoGrW5cL3sQQ29XZL8QxiNYNyBZ+LYg7KdZKdnYHLZCtM0J2OyYGwm7w
 w7Tw2ky3wrcHAwtFIzPFBc0eTDadiv1XVUTxNAD9L+EkZRnvFv8+8wYwRaGrDTlIC+
 GrMAk0Ju6QNB2YQaNUnm8z0+OWcmZvkbNZAObcbgx7Ui2cCkJ9VmwAqK442Yuxkblg
 27fSaQaECCi5Q==
Date: Wed, 8 Jun 2022 12:24:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [PATCH v6 2/8] ASoC: mediatek: mt8186: add platform driver
Message-ID: <YqCG+9YkuXsDeh/I@sirena.org.uk>
References: <20220607142046.28060-1-jiaxin.yu@mediatek.com>
 <20220607142046.28060-3-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ETWoB/2pglKUOdqk"
Content-Disposition: inline
In-Reply-To: <20220607142046.28060-3-jiaxin.yu@mediatek.com>
X-Cookie: Never give an inch!
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, tzungbi@google.com,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 matthias.bgg@gmail.com, aaronyu@google.com, julianbraha@gmail.com,
 linux-arm-kernel@lists.infradead.org, angelogioacchino.delregno@collabora.com
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


--ETWoB/2pglKUOdqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 07, 2022 at 10:20:40PM +0800, Jiaxin Yu wrote:

> +obj-$(CONFIG_SND_SOC_MT8186) += snd-soc-mt8186-afe.o
> +obj-$(CONFIG_SND_SOC_MT8186_MT6366_DA7219_MAX98357) += mt8186-mt6366-da7219-max98357.o
> +obj-$(CONFIG_SND_SOC_MT8186_MT6366_RT1019_RT5682S) += mt8186-mt6366-rt1019-rt5682s.o

This breaks bisection - these drivers are being added to the build here
but the relevant source files aren't added until later on in the series
so the commits in between won't build when the relevant Kconfig options
are selected.  The Makefile and Kconfig updates should be moved into the
driver patches.

--ETWoB/2pglKUOdqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKghvsACgkQJNaLcl1U
h9B4mwf9HGDlHmNk1TjFP832KkIO385bqzgKxTOtgibu1i5TUutnTN3f36lv+FUc
IIi+QaUpFHyArXuTY9vK8ucB4JU4Lv2uPXSngImJwTCIFhcOxgnKymFYhrTXoyPN
Vjd45Su/+rD0FtSZfyoltQ55n/InkmXhSSM+YnPdAef1fyyRneTXE/XQUf9jGacR
hIxq2HvnVFk/ts/N6U29ebBTDjISvCax0YUBBhbw494r1QTKFMSRIdSZ9ETOQeep
WtxnWuVmFNm8WhWK5Fgl2cSCI+NmJ1XvlwJSUsTTf6ogdifjwYF+PyzlqEaVpddT
0HyYM/5R86UhVW1MY9AqJ1yR4Wg8Wg==
=2c29
-----END PGP SIGNATURE-----

--ETWoB/2pglKUOdqk--
