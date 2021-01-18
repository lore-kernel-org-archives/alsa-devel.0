Return-Path: <SRS0=81m9=GZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66406C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 07:56:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A288B22D57
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 07:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A288B22D57
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aarsen.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AEEB11AB0;
	Fri, 22 Jan 2021 08:55:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AEEB11AB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611302195;
	bh=PtSdG393ExF9uq/KBHEWGe3PkHKpgqBNEtjY8p02bYs=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Refi1RygA4cxllzTnDQQM5RsbWv+6L+qpu/WGjoDonIDDW6FiFTa4Myaik3O+Q7/e
	 pTaf7gPgTxmSWiN1qJfHa24EB8cOQ2O/2ztav3MxPRLCGLOYi04MgK2za2Jzx7iRHH
	 aNFzDxRwrae8FV37qYFpPh1j+JfonK9p7iAbi3/Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3EF05F8015B;
	Fri, 22 Jan 2021 08:54:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C660EF8016E; Mon, 18 Jan 2021 21:03:03 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5110EF800C0
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 21:02:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5110EF800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=aarsen.me header.i=@aarsen.me
 header.b="uxKI2kJm"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4DKN4d0MxTzQlJG
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 21:02:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aarsen.me; s=MBO0001; 
 t=1611000175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=PtSdG393ExF9uq/KBHEWGe3PkHKpgqBNEtjY8p02bYs=;
 b=uxKI2kJmi6bUSMQ5Wq+ryMRGKdt6tmQgzKR9hbWHWX39ScXFEIpRHtyRcWkzCjTQzb7Kzv
 Ecy74RniG9PMMLUS6ItcD+k9Hj/FLcP9u+Aif6jcvrcwLk+S5e1ijZCc9QEHls04MomyC2
 JUolUpCf3O9UvqFnp4sAonUVQZTizpvcjd1AKClW8iyli1XTzEuyYmaTkOfvk+67dSbz03
 wdC0AWthcb7nSd4hAZGYy16Timqb+fdO9EFAFGHZN4y2PYTR8fnFKK49vhZ4/dNtOfzkOY
 K7u2wXPBNhCFDQL62vZflNJtZdCP5QTCv91b5neOKODf6k6Ock3Ek6Oo/51Bfw==
Received: from smtp2.mailbox.org ([80.241.60.241])
 by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de
 [80.241.56.125]) (amavisd-new, port 10030)
 with ESMTP id enAt_Y4ogAx2 for <alsa-devel@alsa-project.org>;
 Mon, 18 Jan 2021 21:02:54 +0100 (CET)
Date: Mon, 18 Jan 2021 21:02:50 +0100
From: Arsen =?utf-8?Q?Arsenovi=C4=87?= <arsen@aarsen.me>
To: alsa-devel@alsa-project.org
Subject: snd_pcm_extplug_callback_t transfer callback and buffering
Message-ID: <20210118200250.k47zbepilkcebxly@bstg>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xf3qabk4v32fwnis"
Content-Disposition: inline
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -5.46 / 15.00 / 15.00
X-Rspamd-Queue-Id: 162C217C4
X-Rspamd-UID: bd702a
X-Mailman-Approved-At: Fri, 22 Jan 2021 08:54:42 +0100
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


--xf3qabk4v32fwnis
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I am writing an external noise cancellation plugin for ALSA, based on rnnoi=
se,
but I've hit a bit of a roadblock: rnnoise processes chunks of 480 floats a=
t a
time and does no buffering, but alsa expects the transfer callback to take =
all
the data from the input and put it onto the output, with no way to signal t=
hat
any buffering is or should be happening.

I have tried to return a multiple of 480 from the transfer callback and kee=
p a
buffer with the leftover data, to be prepended to the next payload, but it
looks like ALSA will, when a plugin returns too little data, just send back=
 the
same non-processed data in a new call, which breaks this idea.

Any way I can work around these limitations?

Another solution could be for external plugins to report the amount they
consumed and output, rather than a single number for both, but I am not awa=
re
of how to do that.

--=20
Arsen Arsenovi=C4=87

--xf3qabk4v32fwnis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEN603JsCUe+6MiEcuSj/KZcFT9D4FAmAF6WoACgkQSj/KZcFT
9D71Ygf9Hic5xnswqxigWPQyFI7aS/ZVdKWAZhQZ93h52/d7IsosSY7D2j7DbmxQ
F2fSWnAWaX66ZJG7pvVZzUgof8R3IkrDBpho1Nd8iNmBgJkyXz5dRq3hOWdkxVgc
gMdTwiIvZya+x3yDb3tCXafgroKDJZnhq1VtwRVcST0RpASsP5G4x0LfxktLlq6m
OUSl2NkmBl+uBg0DPcbjhvHcLljvzazf86dSSfthw3QHi+WuysX9qXjM68azKA66
GMIPpjKUlvyo+DfVbIB121PnQ/5f8PbOEqyTWkKnxjClqA4DwPSnImsbPJiYjcah
mimIwrUh368/xGeI0B4tUUoYBlfEPg==
=Ms/Y
-----END PGP SIGNATURE-----

--xf3qabk4v32fwnis--
