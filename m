Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39519C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 17:52:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9A8611CA
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 17:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B9A8611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48E3A1750;
	Wed, 15 Sep 2021 19:52:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48E3A1750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631728374;
	bh=pXP1fjveJS/FXQBwzAO790XqBMxtFxbpynde6ei+XQ8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZdPAgeJzsSxjXEl6u2AkYHUh/wEeODKI0oKGvoNYccjzIP4NDN8sR1ILAHGJm1J9B
	 paO0RujhPy6a1xDq07rGEBZZDTUSnA1Fy75KjzNOIiErVR8htuQhfJH7RX3i+9kJ4A
	 OoxXnrBPlCugsgjxG4eB+t9QMhfPXOdI+bzvFg2E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CABE6F80227;
	Wed, 15 Sep 2021 19:52:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9186BF8027C; Wed, 15 Sep 2021 19:52:01 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2F42F800EF
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 19:51:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2F42F800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GOXOhqNE"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9ADF60E8B;
 Wed, 15 Sep 2021 17:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631728310;
 bh=pXP1fjveJS/FXQBwzAO790XqBMxtFxbpynde6ei+XQ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GOXOhqNEZYiIF0ZlEKGHxZUoQiBazvqiEBfQ6husdFKxtFunHGCBRFoHKwGyIoNo2
 1Rq4D2ey3KtKm/BjqiRJ7SP42Lhda3wl5IIuHPxUhgCl7NzFO52Q48865vmLnA6j6P
 dC3paaw6wKyxEt2kUz5XFAoyRAn9YM5sIdFog6fjIA4m2noD5RxbKtbXvNu4/AxwgM
 2ox6E1lok44F5ZRB1Op8Z3koHVWUH7AD6qkCPCOWmvQ90YLY9EdnC42EQTMQCtSLSu
 BU00JH99QHpO0VW1cR0rHEdH51dLF9IC8SDORxUSgQbg202z2t9wuICb56KqEdLFgS
 wUBfW88gtNfWw==
Date: Wed, 15 Sep 2021 18:51:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: Convert to new style DAI format definitions
Message-ID: <20210915175108.GE12513@sirena.org.uk>
References: <20210915173535.37794-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
Content-Disposition: inline
In-Reply-To: <20210915173535.37794-1-broonie@kernel.org>
X-Cookie: The more the merrier.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org
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


--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 15, 2021 at 06:35:35PM +0100, Mark Brown wrote:
> Convert the AMD machine drivers to use the new style defines for clocking
> in DAI formats.

Sigh, missed putting one conversion in this commit - rebased properly
locally.

--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFCMosACgkQJNaLcl1U
h9DhMAf8Cz98/IIIxkfpB4/a8EQFQU5uoC4Df55/y0JHEWl1gnDs8XGfG5AgVWj5
iaaL1yN72YYmgAVomWjYj51UrMu9MJoqe+UfHMKTIeveffZKQaMCuDgRFj+KY9YE
GpMmwtAEr3MYdhGzDvFsxd6/iv92hcILD7phVyDPfW/saCVzUgXRijpgRUn0HJwd
9PIQm/Ai53cl5Wg5abbkyb4c5TV1gkB7McWj8gPI6W1Zys2nITlqdZW0pfgvKcpJ
lHLJ2BVJlv+ABZT3a6gBHD3AKpG9yP5XB0dv4XoibflAzv8FS1KS5S3OPg7Nf7yN
Soox6z1qVm8qVher/GAG5x1CFG6B0g==
=fU0V
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--
