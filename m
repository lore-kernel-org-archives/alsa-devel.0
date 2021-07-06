Return-Path: <SRS0=47st=L6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AE5C07E96
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Jul 2021 12:36:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 540E86225E
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Jul 2021 12:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540E86225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCF9A83D;
	Tue,  6 Jul 2021 14:29:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCF9A83D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625574620;
	bh=Sut5QXr6y+C9xjy3IeaZ+BbqPrn67rDwl5hTIz19DpI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L1TA2C88Badxgj3RJn3JO5mkeP97WtPVOBuuuu+pgjprodAK0xRJ1TdUIU6itSXRw
	 TB3M0LLtXtkA6bI9vn4DcflmvBJWDJ82yKoqN7fXgtKuOnGWcfeh9NsbnGJZYpUXFZ
	 Ejsu0Te0y24Rk1pQz60QhzCxGyU46CST8iEHkHNk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 572C2F80246;
	Tue,  6 Jul 2021 14:29:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5D3FEF80249; Tue,  6 Jul 2021 14:29:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10490F8014E
 for <alsa-devel@alsa-project.org>; Tue,  6 Jul 2021 14:29:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10490F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MfeTK+TS"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9561F622F8;
 Tue,  6 Jul 2021 12:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625574556;
 bh=Sut5QXr6y+C9xjy3IeaZ+BbqPrn67rDwl5hTIz19DpI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MfeTK+TSk4iXPcoww75x6O8k4ZpyHSDTjSwjtYi9Mq18ISjNvsvh5PGzk2oUnE283
 pBwZUER+m5xVAW0cBoxwtBWflcX90aFgQdnHU1W3dfJBmQrfz30o+AudgdVzYVyLfZ
 K1ovcu7ggBHKWBfy1AKUs3TPY3tNOardF7W8eY0k5jNcM2RAPksK00Zi19GB8PLW5/
 wsY6RGYGGJVdXMu2l67coLwFSzDOxSZrms5owRNuZetmpBvm4wWWrZ3+3e3wJEiQxY
 0dGAocnZiGPPGJSL62Jqv/hLK2mvZRu5nxrlLxVrleOvYdalQlWqb1HhoK6h4ptQx8
 j/hSE4vQxZ6jA==
Date: Tue, 6 Jul 2021 13:28:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <vijendar.mukunda@amd.com>
Subject: Re: [PATCH v2] ASoC: add stop_dma_first flag to reverse the stop
 sequence
Message-ID: <20210706122844.GD4529@sirena.org.uk>
References: <20210705193620.1144-1-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <20210705193620.1144-1-vijendar.mukunda@amd.com>
X-Cookie: Some restrictions may apply.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com, amistry@google.com,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 open list <linux-kernel@vger.kernel.org>, Basavaraj.Hiregoudar@amd.com,
 Takashi Iwai <tiwai@suse.com>, Chuhong Yuan <hslester96@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, peter.ujfalusi@ti.com,
 Alexander.Deucher@amd.com, nartemiev@google.com
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


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 06, 2021 at 01:06:17AM +0530, Vijendar Mukunda wrote:

> @@ -982,6 +982,7 @@ struct snd_soc_card {
>  	unsigned int disable_route_checks:1;
>  	unsigned int probed:1;
>  	unsigned int component_chaining:1;
> +	unsigned int stop_dma_first:1;
> =20
>  	void *drvdata;
>  };

This still doesn't seem like something which should be controlled at the
card level, I'd expect it to be configured at the dai_link level.

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDkTHsACgkQJNaLcl1U
h9CbbAf+JVrUPOvyKgDMgQ69A/T7wiXFEz/9WjR1Zxoo8tKXGnUogQkoZ9ZdKXG8
FjLHNmtEOv92CiJ4ziUNH+22/erswHAKWXmGWF2k+9NKvZKlZCu6zxLrVGHaPgqA
awxZFA6k1j5NS/fLCfa9BdSo1n7XAeltqkb4YhH5kTwhUYaNiMnFTifPFeriFQLp
ASaJP9+Sh3bG2PYiDyUc+MSoIQ4Ak+QI0VAZppePeEtbvi17zoCMeXJVLkEqNBF1
Q4MQMo1VTefu/0eK3zxjeA8UmxN9uRrp5MHQ5iqjUiwsVp8bSikfX7Pj4rwlm56p
buaM9OpzPE+D4sujnw8oRB/dqAyNAA==
=7N7D
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
