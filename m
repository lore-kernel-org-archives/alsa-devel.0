Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9019EC43331
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 19:51:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC18021655
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 19:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="psCfLGsq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="SyjN+ChH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC18021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A499167C;
	Mon, 11 Nov 2019 20:50:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A499167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573501860;
	bh=jMIAo9px/qNa0KpFReHEs1RMIRnHcCVJNXUrKRTi8RE=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=psCfLGsq/99vctEgNyf8EVQ7pd2QLoBX654Txiuh5aKY3ZHqwC10Ez7g4asri86qG
	 va7B5FTFzieoxjWhLw1pmYycpuk4aT8+6qt0ACdIOaLqGjkqJfmdcsHRuVS/33/sKa
	 ibiddIj+udwwt3v/GgKjft8fth8g6TtV0gNWHeXM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B77FAF805FF;
	Mon, 11 Nov 2019 20:49:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7B9F4F80600; Mon, 11 Nov 2019 20:49:38 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E04CF80275
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 20:49:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E04CF80275
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="SyjN+ChH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dtnQhrLcA6Dn/As/OrO/10b7sB82SnSNakaXENAloVA=; b=SyjN+ChHN2juaWY5YQMiuX1aY
 CeTEXEVFxbd3BfGyS2eX3JJHU9fiJeljPYjWVUQJBKVgzRaKSboR06/IsP1GqMOQe31TD/owVChN6
 ESS8tp6sqJOuMosq+s5h3Dk/bEbtYxZzvT27Jgj1OcCFU5cWnEfresi1FQaZDEkVg6whg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iUFgs-0005OG-J2; Mon, 11 Nov 2019 19:49:34 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id D949927429EB; Mon, 11 Nov 2019 19:49:33 +0000 (GMT)
Date: Mon, 11 Nov 2019 19:49:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Jacob Rasmussen <jacobraz@chromium.org>
Message-ID: <20191111194933.GF4264@sirena.co.uk>
References: <20191111185957.217244-1-jacobraz@google.com>
 <20191111194427.GA29859@sirena.co.uk>
MIME-Version: 1.0
In-Reply-To: <20191111194427.GA29859@sirena.co.uk>
X-Cookie: A lie in time saves nine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 Jacob Rasmussen <jacobraz@google.com>, Takashi Iwai <tiwai@suse.com>,
 Ross Zwisler <zwisler@google.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt5645: Fixed buddy jack support.
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
Content-Type: multipart/mixed; boundary="===============9020923108745598163=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============9020923108745598163==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UBnjLfzoMQYIXCvq"
Content-Disposition: inline


--UBnjLfzoMQYIXCvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 11, 2019 at 07:44:27PM +0000, Mark Brown wrote:
> On Mon, Nov 11, 2019 at 11:59:57AM -0700, Jacob Rasmussen wrote:
> > The headphone jack on buddy was broken with the following commit:
> > commit 6b5da66322c5 ("ASoC: rt5645: read jd1_1 status for jd
> > detection").

> This commit has been in mainline for a while but this doesn't apply
> against my fixes branch, I'll apply against -next but it'll need some
> work backporting to make it back as a fix.

Sorry, the issue with applying wasn't due to conflicts - I've applied as
a fix now.

--UBnjLfzoMQYIXCvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3Ju0wACgkQJNaLcl1U
h9DX3gf/YtrShJZsOudaKwwQ17lvSz66qAmyxXjzitTuvQlr3QLrHHScvgxbiYjt
ho0/Rdk87BVNkBKuBxeLGTmZAQquQbGx6hg+TqnnCbLGp102236hpCifnPgTb6/9
RQP+qeg7Q6/R1uvMBcjm0Ad7P0/CtloH7sfgkXgCZEH+Awb8woNiwJKcqyxG20wy
+bZlT1VTFSnLlN2reOnU1ksrc/DU2b5JKtFY8/yod4gz8CRhYYWEg52ogltOGlX3
sLbpmqiEIo0W6UErhdpkAlH34otteeKR/V0ogDnPJeN7GMGDSHPk1vpI8SWuEnzE
f8RVcTvbcGqBgR/q89Wn5/MeiRxCMQ==
=WROu
-----END PGP SIGNATURE-----

--UBnjLfzoMQYIXCvq--

--===============9020923108745598163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============9020923108745598163==--
