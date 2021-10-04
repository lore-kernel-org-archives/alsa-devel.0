Return-Path: <SRS0=RGWB=OY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E49C433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 12:59:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1265861A78
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 12:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1265861A78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B53F31688;
	Mon,  4 Oct 2021 14:58:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B53F31688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633352348;
	bh=MqJcKmpJBZxYnuOMxcI+OAOFxQC7RN9GvMIgXjLKBMI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bczu2PmNMCDNEx1Ne3W5QwQqTUwTJ5TvNzeOxISOkEu4ZqGYA0ez8r75vuABljg++
	 Nl0jaRehTn7Jc8d9WXf/32qOkmBOG4uuQZkTXAfwrHZyhJnDT25EzFPB0Wk208vBnp
	 7BKNGRG096XsVtHJSoMmM/rwcNB1nzi44uwoz178=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F984F80229;
	Mon,  4 Oct 2021 14:58:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 272C2F80240; Mon,  4 Oct 2021 14:58:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85429F800BA
 for <alsa-devel@alsa-project.org>; Mon,  4 Oct 2021 14:58:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85429F800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XjRR9lGG"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 547A061872;
 Mon,  4 Oct 2021 12:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633352288;
 bh=MqJcKmpJBZxYnuOMxcI+OAOFxQC7RN9GvMIgXjLKBMI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XjRR9lGGV0YuB9MUBUOiSyXbfw/+o8idThLUF8vmy+yz+MJX5t2CRECSJzkoq214c
 OnU6ejWw/pmky5/BIWle6oBCQ5KKn1nCu4lD5/GfSoxNYygQisL1m8ypV5K4sY7HYQ
 mNROQDPGDYBGmJwG3Bc/Dq4UVcauq72+HDjxN8LWUjJCFa1XO+mm9D4XI6XE1EHCIj
 uOHUB4gZkhKo6ZTrs0a/M/0ECT2VG6X2DltOGN1Sp7ob9Tsje5FlTFLRmBRKrmK71x
 y1OusRazP5Il7ckxFiNzvrxap6udvAFvyYHvfjg5XKzQ2VG5fcaARRR0JA4bOJxE+q
 uUO+Y1Q4kcYzg==
Date: Mon, 4 Oct 2021 13:58:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: DAPM PIN switches do not update in alsamixer when changed
 through UCM profile
Message-ID: <YVr6Xkm0tm0IghON@sirena.org.uk>
References: <b8cf9bb0-bad1-26a0-0806-0a7c66b228d0@redhat.com>
 <s5hv92ego8y.wl-tiwai@suse.de>
 <8e0a6491-bc87-0f9a-099f-3baff1fc0e0d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gbfi9HYTdvx/28OO"
Content-Disposition: inline
In-Reply-To: <8e0a6491-bc87-0f9a-099f-3baff1fc0e0d@redhat.com>
X-Cookie: If it heals good, say it.
Cc: Takashi Iwai <tiwai@suse.de>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.com>
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


--Gbfi9HYTdvx/28OO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 03, 2021 at 06:32:13PM +0200, Hans de Goede wrote:
> On 10/3/21 4:46 PM, Takashi Iwai wrote:

> But it does not work for the "Headphone" and "Line Out" switches,
> these are actually hooked up to jack-detect, so I guess that the
> jack-detection is already flipping them and then when the UCM
> profile changes them it is a no-op causing the UCM setting of
> the control to not cause an event because it is not a change.

It's not meaningful or sensible to have a pin switch and jack detection
connected to the same pin, any machine driver doing that is buggy.  It's
unclear how the two would be supposed to interact and there's nothing
that makes an effort to keep them in sync.  Either jack detection should
be disconnected from DAPM and userspace responsible for managing the
paths via the pin switches or the pin switches should be removed.

--Gbfi9HYTdvx/28OO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFa+l0ACgkQJNaLcl1U
h9A5Twf/fFbQm4adkEjJE+4D2OGMRAAuUWT94GC8xA3MyZoOS+qzKUaEJqoIoffO
+wuDWOKrPgWXolQ5VHuNOQ74i4c8llLGYkGRsv4UXkxkSmTdQNZCoFjFJ2uZnXeb
tuA7xtERBn2VGwjMLs2+WJJGwZGCvnBbNGyhGysEX3/AppKdn06usgs/AoDA2TKi
EC/cbKjpgK+/1P53l5ZjWqT+PcnSxRs5guJGwGhBzR+c4hipXjv/rw6zwx/nkj3c
4f7YTeTvldFd4C1li2EHwty5tXan4yHjlfqhwgT+SEBNTtG++KzKcMONmbGZupl1
/cEeT0Z7B4nnz5lfw0O2EdTPmQvCVQ==
=qSqX
-----END PGP SIGNATURE-----

--Gbfi9HYTdvx/28OO--
