Return-Path: <SRS0=nXTK=HZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF7DC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 09:04:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA2264E4B
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 09:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA2264E4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 486D91668;
	Tue, 23 Feb 2021 10:03:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 486D91668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614071086;
	bh=aJj5PSO1F2c06mc+IRHaML/7vpyv2wRsDqfDbiIgNTk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AJ9V89rD/xC3wM3bZ/hQSM2byGCeRZjEYbbaXqGpQw8qhtIy0/xjTHleTZf/3wkwS
	 JecHfhBfkH/eAWfG1+XGkROPpbcxcrxmIEM20vvwDgIK9Rmafq7+qCgYoflD4BbyFr
	 eozjaXPZHmawTPA3kjKjs9CPKK3ov5a21Vugi+SU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A964EF8016D;
	Tue, 23 Feb 2021 10:03:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9EC5F8016D; Tue, 23 Feb 2021 10:03:52 +0100 (CET)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7904F800B4
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2021 10:03:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7904F800B4
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 28C731C0B7F; Tue, 23 Feb 2021 10:03:39 +0100 (CET)
Date: Tue, 23 Feb 2021 10:03:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 4/7] HID: lenovo: Remove lenovo_led_brightness_get()
Message-ID: <20210223090338.GD9750@amd>
References: <20210221112005.102116-1-hdegoede@redhat.com>
 <20210221112005.102116-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Content-Disposition: inline
In-Reply-To: <20210221112005.102116-5-hdegoede@redhat.com>
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


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2021-02-21 12:20:02, Hans de Goede wrote:
> The led_classdev already contains a cached value of the last set
> brightness, the brightness_get callback is only meant for LED drivers
> which can read back the actual / current brightness from the hardware.
>=20
> Since lenovo_led_brightness_get() just returns the last set value
> it does not add any functionality, so we can just remove it.
>=20
> Reviewed-by: Marek Beh=FAn <kabel@kernel.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
http://www.livejournal.com/~pavelmachek

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmA0xOoACgkQMOfwapXb+vI2YQCffXWN1Q76lOUIi4u3BzFXtjsS
ssIAoMIrCl+41jFRTKAuYJVV1dCnMTCS
=LKiG
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--
