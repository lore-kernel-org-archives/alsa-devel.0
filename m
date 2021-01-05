Return-Path: <SRS0=jAxA=GI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7502C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Jan 2021 15:43:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D79622582
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Jan 2021 15:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D79622582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D8A5828;
	Tue,  5 Jan 2021 16:42:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D8A5828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609861376;
	bh=YVYnQNFEzRFvxyLCEcOfDR+ath/2Dj7FHszGqVFkAqc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eQpnp9zsMOpAJKZ30TGLP8pWwjfsrixF0saNOI46Vlv7gt5zPjoqHjJe2gDpLhCQI
	 DdaApiyIHIEz+N/rlvQUIWysWprdZpfLpQCDTKqlmnuK9a8+L6Ws8f2/75b0PikanX
	 DUhUu5k1aWeoIJXVCMai3abq3jClRd90n9D5N8bs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3EF2F801F5;
	Tue,  5 Jan 2021 16:42:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79B89F80258; Tue,  5 Jan 2021 16:41:57 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7301DF800FD
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2021 16:41:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7301DF800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ixWNPW2H"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A5DF22B49;
 Tue,  5 Jan 2021 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609861309;
 bh=YVYnQNFEzRFvxyLCEcOfDR+ath/2Dj7FHszGqVFkAqc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ixWNPW2H9qYOs0veIyEwAtaqxau7WaNytE2KdomQSLpwvmGNewC62GY6pgNAVPXvs
 02tlN57rW9Ive5NyCOcWm1SkqKFRvJHm+YnpvOAsga1eU2U9SqtNyhGa/5WT8JGfa1
 OdjnErdhBLb4C2NlCMj3Ulyij0yDPvIiSExMwXnOMulD3Q+vWG80vQABR7UgN5HzGh
 YMS+GQgtSjuS3Gj7xyradKWMgWPHQDB59RTbUDI0SNwye6jfIl9ckDvLQ9TSQxn3be
 RAV4uuXrKHTDc6vVI+DNzj2khHtB/9ab4E1eDFnhTuOAScBFSLacrVIscb55wNmIbF
 2Cx163DaQchTw==
Date: Tue, 5 Jan 2021 15:41:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Gyeongtaek Lee <gt82.lee@samsung.com>
Subject: Re: [PATCH v3 1/1] ASoC: dpcm: acquire dpcm_lock in dpcm_do_trigger()
Message-ID: <20210105154122.GA15214@sirena.org.uk>
References: <CGME20201228112316epcas2p3b726099ef37e66e63d1134923e791906@epcas2p3.samsung.com>
 <1891546521.01609157881415.JavaMail.epsvc@epcpadp4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <1891546521.01609157881415.JavaMail.epsvc@epcpadp4>
X-Cookie: I'm shaving!!  I'M SHAVING!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, khw0178.kim@samsung.com,
 'Kuninori Morimoto' <kuninori.morimoto.gx@renesas.com>,
 'Takashi Iwai' <tiwai@suse.de>, lgirdwood@gmail.com,
 'Pierre-Louis Bossart' <pierre-louis.bossart@linux.intel.com>,
 kimty@samsung.com, donggyun.ko@samsung.com, hmseo@samsung.com,
 cpgs@samsung.com, s47.kang@samsung.com, pilsun.jang@samsung.com,
 tkjung@samsung.com
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


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 28, 2020 at 08:23:16PM +0900, Gyeongtaek Lee wrote:
> If stop by underrun and DPCM BE disconnection is run simultaneously,
> data abort can be occurred by the sequence below.

This doesn't apply against current code, please check and resend.

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/0iKEACgkQJNaLcl1U
h9DgIgf9HzFgZyH1AmpZZKr72z//hlKRu4Qr2oPg10sCVQ3i1Tp+75i59mj4vX2b
Jsz1zeAPcEo1+a+eqQn/a3q4Lin597lA3mqqa79wmv1S6qG7N5JDgmP9WGA1CGAr
udK0TCfgCXf2G7sQBIiEibJJcNlkKKspZ7Fhn4kQY5pfBI1m2+QN4Fjhv3cX2wec
GLUatNY6bhS/+M76M8UYuClcSpdWYG8dru0oHY14XbMia88x8gH4j64muY+MnX+X
smwcqU/+CrLKDhsaOwSK/grneN3zxdr826J4Shlx8HX4HRyUC19Qlzf/NYgRTWWS
XAnsyiPwd+ltNiFNCSVQQ2Q71TUc4w==
=4D6b
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
