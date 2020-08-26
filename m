Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BB9C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:26:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1582083B
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CTpY3hLc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="udMBUUQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1582083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66AB5172F;
	Wed, 26 Aug 2020 13:25:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66AB5172F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598441185;
	bh=wFUB08BUg8SWjdZRvkVyDKbV1IBYIvlbVUh6QQnqQsE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CTpY3hLcfzz76aTL/oGrDWa4eq6i/ZvN+URuwLFTgneyB15qD0dnXIWck02kejp9W
	 +rvSyspVPuOV4PweTiry3iCTOkK/ftTxPl1lEJcpuyEymvG3sUPaGZG5zZN4CVvhIt
	 lt9q8UDPvTLCgeN6AkTQEm4TskryBJ+L9GB8LpJM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C1698F8016F;
	Wed, 26 Aug 2020 13:25:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A55ABF801D9; Wed, 26 Aug 2020 13:25:33 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4AB70F800EB
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 13:25:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4AB70F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="udMBUUQJ"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4C04420786;
 Wed, 26 Aug 2020 11:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598441126;
 bh=wFUB08BUg8SWjdZRvkVyDKbV1IBYIvlbVUh6QQnqQsE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=udMBUUQJbciMyjzDoSa4fAr30tZPobLQ9Ay97hFwAFahfGPMZxkIB0TMaV3/n9ub0
 zsOuk9pCOv7OrFUPS7yEyVuPDGxcyk+D7F2DsO8r5pMkNVSkHL3qHoh0esSk99+PUg
 PhJU7iNIou1pV5alTRgUSZMxdWQS0v3O+1sIxYO8=
Date: Wed, 26 Aug 2020 12:24:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: Re: [PATCH] ASoC: AMD: Clean kernel log from deferred probe error
 messages
Message-ID: <20200826112450.GF4965@sirena.org.uk>
References: <20200826111826.3168-1-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
Content-Disposition: inline
In-Reply-To: <20200826111826.3168-1-akshu.agrawal@amd.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 open list <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
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


--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 04:48:05PM +0530, Akshu Agrawal wrote:
> While the driver waits for DAIs to be probed and retries probing,
> avoid printing error messages.

This means that if there is a problem with deferred probe no diagnostics
will be available, there should be something at least at debug level.

--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9GRoEACgkQJNaLcl1U
h9CtQgf8DcKeUebIDKsNWTFjupmBGMJZReu7jz5tCWYwj8WPQ7y8Pw4tFaXeGvSg
L8bDD/+t/Q2pbW0CVzaij67lcMyVKPAMv6E/9+1RB3DfqjJnzK262gFy63nGS38E
YQmpDZquUgl8f+p052/S7wr7AA0aEoBbcgYM7OkwY1SZoIbRjLjF1sXKjpKult+r
EAYSjIcgr6Z0e4QAE3QYDg3Lo/x8Exe/avmm6TV3M3KzkSuXMXU2a796wVHVJXYM
guqUvzDZxjy2rMYI5jBcxbzHwXhQzhmBiAWAzFFRatPqTn9FeYJXZsc7JXxqYFO5
zgZF2XqUGNIzLZVRCOnTiA1kpH+FAg==
=ClSk
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--
