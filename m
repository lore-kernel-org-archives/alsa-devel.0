Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B3EC433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:04:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2728C20678
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DYyPaTHR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xHKT7Drk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2728C20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D604828;
	Mon,  3 Aug 2020 14:03:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D604828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596456240;
	bh=CneQNL6X7rEIQQpMno9uuJlEYQlUyUWuYUL8p9m5E+U=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DYyPaTHRMDSfC47twRbT9Db6N+17UMSABE6Mwk6iK4SGEyqSoB8tyseU5JP6CkW2C
	 BKbSnclIHaQxYpihLou6nF5xr4Eb5MDAo8tiIhU8L46BT5la9/kz0F7Q+adAnflv0O
	 1YoFIotUDR0NjNXcHQ6SbUytcutgbrHbGHxVg5Tw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24410F801F7;
	Mon,  3 Aug 2020 14:03:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A236F80218; Mon,  3 Aug 2020 14:03:08 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4148DF800BD
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 14:03:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4148DF800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="xHKT7Drk"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 09C5A20678;
 Mon,  3 Aug 2020 12:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596456179;
 bh=CneQNL6X7rEIQQpMno9uuJlEYQlUyUWuYUL8p9m5E+U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xHKT7DrkbmdEpU3NkgxUEGpBBKzKq4zB0vMkrDTdkMwNlxVQ5LxbexAZhu9XxuiyG
 JtqwBU2DVNNMB9rSyjGPe/AXl3tJiEPm1n3orA9tnMTO1UlVunDcY/nlLrQ89SyzON
 EHJVjhm0aiJVLyWEW6kmVZKcTX99iwlmuKcmBp7Q=
Date: Mon, 3 Aug 2020 13:02:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: wm8962: Do not remove ADDITIONAL_CONTROL_4 from
 readable register list
Message-ID: <20200803120238.GD4502@sirena.org.uk>
References: <20200803115233.19034-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline
In-Reply-To: <20200803115233.19034-1-festevam@gmail.com>
X-Cookie: They just buzzed and buzzed...buzzed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: shengjiu.wang@nxp.com, ckeepax@opensource.cirrus.com,
 alsa-devel@alsa-project.org
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


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2020 at 08:52:33AM -0300, Fabio Estevam wrote:

> This change was sent as a comment below the --- line when submitting
> commit 658bb297e393 ("ASoC: wm8962: Do not access WM8962_GPIO_BASE"), so
> it was not supposed to get merged.

That doesn't work with the tools - obviously the actual patch is also
below the --- line and the patch format allows for arbatrary comments
around patch blocks so as far as software is concerned this is just part
of the patch.

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8n/N4ACgkQJNaLcl1U
h9AZtgf/ZFOQWi4J4etlxtUiqLlSA79qU9np7tcFs7ZJDJcxQpJlev6zDJq6EKLk
Ibqktuj+tUKJUgwaQgXrL1IckfhNgOIp4OA1AuQcqXGy+MaSjDIZ4W/1X/KSMqJC
G4reOMYZsnbM9fyUkT1p5zDwx0JwNjpmMwZIT4GwcDH9CT8fq3JBM0Xmx52SoU2p
h8YhwhaUh5vnMqfxnh6AoYE1PAzZmDdlSYzHprIsxQxQpacWMkgQpOiAqrxv/plQ
MMRf20y+HGaUG6wxM0Y/nKVCX3Xa+c5/uZ1Th2QhN6K8FhpXPzrEKQNy/ZdHQ1lH
orQ4obxJ34heT1IxcxRrwncU1MhDIg==
=8zto
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
