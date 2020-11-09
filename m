Return-Path: <SRS0=odsy=EP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34706C56201
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2020 20:32:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C40D20781
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2020 20:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HvFeH2Lx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wh5VIjuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C40D20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3C8B1689;
	Mon,  9 Nov 2020 21:31:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3C8B1689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604953930;
	bh=WpFd5x2PVkqV7vYXRYyparKv1eINTXPsG4jy37yaFpU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HvFeH2LxxnJbHsBEfknAPRP+jtPRon0FsPCpNVA9Kkai2YRREYQdePfx6gGCFoQ2a
	 G8rgibEstPH3eUq2PLXzUQFSvQoVftXCSpu2m3yR0/WwUPficLMf2eSpFgY3kNtqjw
	 Smsi93VD8M7kfEBoKN5rfIFwSPni8iCAOk33OCqE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B9A2F800EA;
	Mon,  9 Nov 2020 21:31:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97651F8020C; Mon,  9 Nov 2020 21:31:17 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35B3FF800EA
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2020 21:31:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35B3FF800EA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="wh5VIjuF"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D842020665;
 Mon,  9 Nov 2020 20:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604953869;
 bh=WpFd5x2PVkqV7vYXRYyparKv1eINTXPsG4jy37yaFpU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wh5VIjuF6TiKs5MpLhMrI7Wkt6O7vubtpQcIHxDWBDsNKlWG6fBJiVjXVmmgNXlmd
 pWyhgaW201K03LR2NjrIk6vOgP1ul1WtBkQ+fu3A5VYq7MWAVRyX8AR+OMoB1Fe6ul
 JNwhioj4AOMKoI2Rfd6w1jcRz+Ox8gLaAnBRw4QY=
Date: Mon, 9 Nov 2020 20:30:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH v5 0/7] Audio Graph Updates
Message-ID: <20201109203055.GN6380@sirena.org.uk>
References: <1604329814-24779-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VnOTrGv5LmZxna7m"
Content-Disposition: inline
In-Reply-To: <1604329814-24779-1-git-send-email-spujar@nvidia.com>
X-Cookie: This fortune is false.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, sharadg@nvidia.com,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, jonathanh@nvidia.com
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


--VnOTrGv5LmZxna7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 02, 2020 at 08:40:07PM +0530, Sameer Pujar wrote:
> This series is a prepraration for using generic graph driver for Tegra210
> audio. Tegra audio graph series will be sent in a separate series because
> it has some dependency over other series for documentation work. This
> series can focus on the generic ASoC driver updates. Below are the summary
> of changes done.

Morimoto-san, are you OK with these?

--VnOTrGv5LmZxna7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+ppv4ACgkQJNaLcl1U
h9C7igf/ehUdhv8FtDIM9U/QT/43VbP+1JshhwP6YHiYh2LU7owvxb5luCEdePnf
GdsbHaQR1BNNk3Yh7xOoBUQumC00jJ8kFojRMDWyPnrAvLyhrL64vlJrcaXfGEJ8
RwKJrfgPlsKLuVHTMYhGAVX7i3aNMjzvhgw0QrDAy94YSbuf9Fo5YwEWGdhj1V/h
GOFhPE8TTWeCvFAlF2ByWIdpJXV2pyu46KAAXwhTHkbAY/4xQjUF6KbJN1GsYXMZ
XlIQeiGpIO1sdyr6HJTpgDH6CtPWR4i6Ayk9zrIm/7u783ja9WcKtO3vZcm1TeeX
rcYhN/zsPUPkOdPzbqLFU31oCmiHWA==
=6ntz
-----END PGP SIGNATURE-----

--VnOTrGv5LmZxna7m--
