Return-Path: <SRS0=O8MK=6T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7E9C47254
	for <alsa-devel@archiver.kernel.org>; Tue,  5 May 2020 11:53:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E96206A4
	for <alsa-devel@archiver.kernel.org>; Tue,  5 May 2020 11:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ad2wOcpD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIK7FXRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E96206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1EC8D1744;
	Tue,  5 May 2020 13:52:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1EC8D1744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588679599;
	bh=+W25fWjjIElfaFBfwXQQ4/jdiZqC9/tRp6Gt1kz/k0c=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ad2wOcpDFQ1KoycATRDaLdhxF/eRy9J2Y+DCkMcKATJu8oBp5vRyR7t4BM6OXmYKi
	 8rvmdFRI5NJemyf+s6p97J3uRiApqaG+I/QFD4xyX+PDJWpIZvpbKmw4v7vcMSXIMt
	 wO8rmPPnC2M96yCD6w6mkQGoh08Mrp9QjtHGxiwc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2507F80162;
	Tue,  5 May 2020 13:52:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4224DF80246; Tue,  5 May 2020 13:52:14 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5ED9BF80162
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2020 13:52:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5ED9BF80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XIK7FXRV"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 14A52206A4;
 Tue,  5 May 2020 11:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588679526;
 bh=+W25fWjjIElfaFBfwXQQ4/jdiZqC9/tRp6Gt1kz/k0c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XIK7FXRVr+hksOuJLHiSX61NBHds4hEmdl3b6bVZr+2T0Odto68Xjp1cdmcGXcBk+
 f4tTzVtPvZ1dbqx4Gt9GZC7wbtYHTDjPEFUNgEH1M99Ibbsiz4ZbYtD5VOXfYMtPqS
 inN2bdaQ31jL1rH3voc6ww5AQl7L3g8dY2TIGWp0=
Date: Tue, 5 May 2020 12:52:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: Re: [PATCH] ASoC: amd :High hw_level while simultaneous capture
Message-ID: <20200505115203.GE5377@sirena.org.uk>
References: <20200505114023.251409-1-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q8BnQc91gJZX4vDc"
Content-Disposition: inline
In-Reply-To: <20200505114023.251409-1-akshu.agrawal@amd.com>
X-Cookie: Poverty begins at home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
 Colin Ian King <colin.king@canonical.com>
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


--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2020 at 05:10:20PM +0530, Akshu Agrawal wrote:

> cat /proc/asound/card2/pcm?c/sub0/status
>=20
> Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati=
@amd.com>

Also if you're sending a patch for someone else you need to add your
Signed-off-by - see submitting-patches.rst for details on what that is
and why it's important.

--Q8BnQc91gJZX4vDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6xU2IACgkQJNaLcl1U
h9BubQf/YxQpGN3BHlleYVroHYHD02IOy8p8FiYMC3hCjAnNObrEiroZgbZq2RYJ
Vt6M2KV9oaznpgZ6/SNA9vA92wThkG1lcM6hVLSp1cJkZT1Bgi2WLgTDABLCLaQH
fi1BdFpI5iVVxw4esxje/8XbgDBxm1ZYq8TtpzhOf1TG+NOPJFDmeNRTFzcQsaxw
RosxqdVYSZYi/HulUtfIgIM+7iIdtloGI9sd01+0DyzDClOTmrcs3fvX7YhjVqGG
GHeZe1omLbID68vrv/NuHRCk5Gi1p+glD76TePZidcbIWCcgKcfWijTVWOtsF4ia
Yr7IE2bKGihz+gKSIoNyCq/3LuS4Sg==
=04SK
-----END PGP SIGNATURE-----

--Q8BnQc91gJZX4vDc--
