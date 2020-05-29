Return-Path: <SRS0=qQ1O=7L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816BBC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 09:46:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C372074B
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 09:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S7dbxjGb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vbo8e2T+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C372074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 36A971712;
	Fri, 29 May 2020 11:45:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 36A971712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590745563;
	bh=wetxUlZJUVdgGFsLgYSoAqWETsFjhV30MoLoXMoeHmQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S7dbxjGb409RT9q0XwvONPodJ1ElIrAM9JwTmfa1jCHpwZWkhmTgNVSPxsFrr1wj0
	 dHeLeXnLaohMJ8Dh8fD7rJBJnFqkFZI02uxbx8YuTkBPs442io8UG8MKyQfmBNY2aY
	 BUSIPV0Nzf0GmESj7NxmpkiscXD8EMHbxavjFO9o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B719CF800FF;
	Fri, 29 May 2020 11:45:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 15D0EF8014E; Fri, 29 May 2020 11:45:11 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48A5AF800FF
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2020 11:45:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48A5AF800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="vbo8e2T+"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C33812074D;
 Fri, 29 May 2020 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590745501;
 bh=wetxUlZJUVdgGFsLgYSoAqWETsFjhV30MoLoXMoeHmQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vbo8e2T+nqwIbjuaK196ZqyHe5hlo8C4/hDVFf8VAEnBNt2LyT7X1RDqC0cF1Hapz
 8Pbm3L+2NDuQLKu0FWAom47ntL2speUrpJYq1VEgeHvI1UfDmgaxcoUhLltjp4J1xb
 k1hVn6tuXyjZJoBaAVpWQ1E+rGdti7QoK/A35Ov4=
Date: Fri, 29 May 2020 10:44:58 +0100
From: Mark Brown <broonie@kernel.org>
To: zhucancan <zhucancan@vivo.com>
Subject: Re: Subject: [PATCH] ASoC: soc-pcm: fix BE dai not hw_free and
 shutdown during mixer update
Message-ID: <20200529094458.GB4610@sirena.org.uk>
References: <AJIAHAA7CLDayC1bgc0c0qq9.1.1590725427357.Hmail.zhucancan@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <AJIAHAA7CLDayC1bgc0c0qq9.1.1590725427357.Hmail.zhucancan@vivo.com>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel <alsa-devel@alsa-project.org>, trivial <trivial@kernel.org>,
 lgirdwood <lgirdwood@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 tiwai <tiwai@suse.com>, kernel <kernel@vivo.com>
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


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2020 at 12:10:26PM +0800, zhucancan wrote:

> +++ b/sound/soc/soc-pcm.c
> @@ -2730,12 +2730,12 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
>  close:
>   dpcm_be_dai_shutdown(fe, stream);
>  disconnect:
> - /* disconnect any non started BEs */
> + /* disconnect any closed BEs */

Your mailer has corrupted the patch (it looks like it replaced tabs with
spaces).

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Q2ZkACgkQJNaLcl1U
h9D60Af8CU45aZo5/PzFKojHF5n8whHD9QjKTEMtEl3rRdI3xLrFoE1Y5cVEk2jT
A2Jk7V0Q2K3/FHKZ9fysWTVeR8M7jE5yDdlNS6MSnhlkB0Ji3vxRLjQKPE+QLxFj
txyNXY/y3326skNNM7v+sSDviih7lYHvH77X1pnp4mHKXzGNSCcyPGVFjdbwEicF
2bkmwqUtkZLRXCNbHoxVt6HGhkDH+f1a7R+E+Y9JDFztH59t4sBEwL4BJxOGHrPW
ZZV7vHWPxbWDwKAG6nq3WyGZwem1zhjA1hhM9jo+7JamlfVGiFZhSvGoPxa9P0ER
6vlOIG7kPqpdbdDY9WC6hcmesfo61w==
=Strr
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
