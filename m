Return-Path: <SRS0=ZcFB=XS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4C6C4CECF
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:11:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8931420B7C
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H34wcImX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ZxXbXpw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8931420B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AE09167E;
	Mon, 23 Sep 2019 20:10:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AE09167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569262290;
	bh=fA4HjglehE2JHWUGQaa3WLOTdx+M1/B5bN+yeYKbQvc=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H34wcImXyzRXn469cBhvKljfcqp2V3J6G06QDVkfafSyYhVnCXZJXbr3UAvikjtYs
	 Oar0nKSqzSvOj4KeJJL/YL35fyRK2liFWrTnQIkKJL3pErY1Ob1y80xeByyy1Yc+Dm
	 GvtvA4g3rtQgbDEQoQDFuXUnWTm4olKifZuM2vgA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFCE2F8031A;
	Mon, 23 Sep 2019 20:10:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7B389F80213; Mon, 23 Sep 2019 20:10:36 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 40037F80213
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2019 20:10:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40037F80213
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="ZxXbXpw8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GE1YCXKg9H7SHCg6aaQopMK/gbHXXyb4D/+l87cJ6n0=; b=ZxXbXpw8pqpHhdYceRpo2h0bY
 2cp9iz4FHkdG1U/qokvAKW0FEDLCnQlGh/pz9ABI/3P+dF6NeEdkMN6spmiU0CdbHaprl7zshzhVg
 dY2UW1wJ/yk9Re5wXYZ8OoUmPbwiBlG+cmrLkYRDbIMRruUE3wWd9JCdy8/3OO/V6aeHM=;
Received: from [12.157.10.114] (helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1iCSnB-0004QG-6y; Mon, 23 Sep 2019 18:10:33 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 28FD2D01FE8; Mon, 23 Sep 2019 19:10:31 +0100 (BST)
Date: Mon, 23 Sep 2019 11:10:30 -0700
From: Mark Brown <broonie@kernel.org>
To: Taksahi Iwai <tiwai@suse.de>
Message-ID: <20190923181030.GT2036@sirena.org.uk>
MIME-Version: 1.0
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [alsa-devel] [GIT PULL] ASoC fixes for v5.4
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
Content-Type: multipart/mixed; boundary="===============2799265819538864224=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============2799265819538864224==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4TjKedF+bau4YbxU"
Content-Disposition: inline


--4TjKedF+bau4YbxU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit fca11622d600228bec405456f41590155b3a3eca:

  ASoC: sdm845: remove unneeded semicolon (2019-09-15 10:29:51 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v5.4-rc1

for you to fetch changes up to 147162f575152db80000fb3de26358264768ee9f:

  ASoC: ti: fix SND_SOC_DM365_VOICE_CODEC dependencies (2019-09-20 12:06:48 +0100)

----------------------------------------------------------------
ASoC: Fixes for v5.4

A small smattering of ASoC fixes for v5.4 - nothing too exciting
here, all small standalone things.

----------------------------------------------------------------
Arnd Bergmann (1):
      ASoC: ti: fix SND_SOC_DM365_VOICE_CODEC dependencies

Bard Liao (1):
      ASoC: core: delete component->card_list in soc_remove_component only

Bard liao (1):
      ASoC: core: use list_del_init and move it back to soc_cleanup_component

Gregory CLEMENT (1):
      ASoC: atmel_ssc_dai: Remove wrong spinlock usage

Kuninori Morimoto (1):
      ASoC: rsnd: do error check after rsnd_channel_normalization()

Mihai Serban (1):
      ASoC: fsl_sai: Fix noise when using EDMA

Peter Ujfalusi (1):
      ASoC: pcm3168a: The codec does not support S32_LE

 sound/soc/atmel/atmel_ssc_dai.c | 12 ++----------
 sound/soc/atmel/atmel_ssc_dai.h |  1 -
 sound/soc/codecs/pcm3168a.c     |  3 +--
 sound/soc/fsl/fsl_sai.c         | 15 +++++++++++++++
 sound/soc/fsl/fsl_sai.h         |  1 +
 sound/soc/sh/rcar/ssi.c         | 10 +++++-----
 sound/soc/soc-core.c            |  2 +-
 sound/soc/ti/Kconfig            | 11 +++++++++--
 8 files changed, 34 insertions(+), 21 deletions(-)

--4TjKedF+bau4YbxU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2JCpYACgkQJNaLcl1U
h9BPzAf/Qqq0e6W6L4hcMQUIKC+/4Nv/F6tipkH8FiLB2UfNJxkntDikyBQOR1MG
RV22R9/vNiNzMyny4zst9U+9OKuDhFdfcavRQV55IoT9mY+hh3GlfccO7eUzUwDV
ffU8syaN3WQ1dlkL3Hx0pGyv97mT9UQgnHzk2+CQ9eLOJgth4JnUN3dbvEwFYM6i
rM85QSnFoHMTRbvNA+Rb7IF0RHv4FEYjAyg0Ar5RH6Xp71C3crwfcU4l+1KNu3yK
VR9dg07rRb0SaVBAZWsBl3ig4Glqj0fpqFqYqanCVtFVUPI1Cpq1DWGErgBgEGEV
idy4nlWqCisBPeqFZ9rz2Yk8r8FUJw==
=JH2z
-----END PGP SIGNATURE-----

--4TjKedF+bau4YbxU--

--===============2799265819538864224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2799265819538864224==--
