Return-Path: <SRS0=nXTK=HZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF66C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 09:10:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D9164E58
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 09:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D9164E58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5DA9E166A;
	Tue, 23 Feb 2021 10:09:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5DA9E166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614071417;
	bh=v9oK5AYIW0bCAUYS7sfWumc+DV4BeD7IJ/ilKineoPM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KFRuPnuBoXITZr+Ma24t+oF8dqLUqddi2t7Qj8Q3PQd+UGgPw2CtHYPadTeBqXUfc
	 SWrEFKwPqdQsdMH34G5HyJ5AA31VqM6ihMbhGC8hPDtxmRXbi2fAD8H0hlkMZSvAzp
	 fj+cCfH4Dvz/3QCfOC7C20cNMKwIM8nr+XH6WRqM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 206D3F80169;
	Tue, 23 Feb 2021 10:08:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52ADFF802D2; Tue, 23 Feb 2021 10:08:36 +0100 (CET)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1511F80169
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2021 10:08:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1511F80169
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id BF5921C0B7F; Tue, 23 Feb 2021 10:08:26 +0100 (CET)
Date: Tue, 23 Feb 2021 10:08:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 0/3] HID: elan: Mute LED handling fixes and improvements
Message-ID: <20210223090825.GG9750@amd>
References: <20210221113029.103703-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="j2AXaZ4YhVcLc+PQ"
Content-Disposition: inline
In-Reply-To: <20210221113029.103703-1-hdegoede@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 alsa-devel@alsa-project.org, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org
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


--j2AXaZ4YhVcLc+PQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here is v2 of my series with mute LED handling fixes and improvements
> for the hid-elan driver.
>=20
> New in v2:
> - Add Marek Beh=FAn's Reviewed-by to all patches,thank you for all the
>   reviews Marek.
> - Improve error handling in patch 1/3 to return -EIO when ret !=3D 3 and =
>=3D 0

Series:

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
http://www.livejournal.com/~pavelmachek

--j2AXaZ4YhVcLc+PQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmA0xgkACgkQMOfwapXb+vJeEACfSNHriy6LUB+JawGv3uQFe8ut
4ckAn3oJ2ickVL3tHFHxBT+CwaHJ7S0I
=SMl5
-----END PGP SIGNATURE-----

--j2AXaZ4YhVcLc+PQ--
