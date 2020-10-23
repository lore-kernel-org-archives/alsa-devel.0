Return-Path: <SRS0=Lvkp=D6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F0AC5517A
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:03:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC4720882
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LejUEcUP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwezQFVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC4720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B01C17B7;
	Fri, 23 Oct 2020 22:02:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B01C17B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603483421;
	bh=hDOEzAxi95sem2PmS9KZVDmchKA6xtzm/88DXdUooiw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LejUEcUP2SNOOuhsQbhcfOjSDcZihwKQDcOMbhIDcf6nT3+KrUQU5a3s5u+RQ/v+m
	 H3ewSm8+RKbCUy7VqFu4+WLK5EC5OL/HrFGwNfwwR/CalOj97r33nqBHsYUjEEKkCa
	 9GkD2fWLy5rrQVeTFw/4s8a63F5cIPDz+r8SlnVk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D826F80245;
	Fri, 23 Oct 2020 22:02:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3CC31F8025A; Fri, 23 Oct 2020 22:02:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B1F8F80245
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2020 22:02:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B1F8F80245
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FwezQFVQ"
Received: from localhost (p5b35db11.dip0.t-ipconnect.de [91.53.219.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5C6F920FC3;
 Fri, 23 Oct 2020 20:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603483359;
 bh=hDOEzAxi95sem2PmS9KZVDmchKA6xtzm/88DXdUooiw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FwezQFVQVyDr5A2On7/Xianed48bAS8BClnsEKjQEF5rFTdB9bUDAX6dKigGf5+nf
 O1HXQYVc63Ei0vCbEEJLiEdAjto/zryJzDpjbX3j/y/gi9DjHDpww6Ffgd4jFETEaq
 WlepcR46MPw5EswUs8/ag1N8myRCHuScU/nqODuM=
Date: Fri, 23 Oct 2020 22:02:35 +0200
From: Wolfram Sang <wsa@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: More whitespace clean-ups in schema files
Message-ID: <20201023200235.GA4473@kunai>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pm@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
References: <20201023192258.3126047-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20201023192258.3126047-1-robh@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2020 at 02:22:58PM -0500, Rob Herring wrote:
> Clean-up incorrect indentation, extra spaces, and missing EOF newline in
> schema files. Most of the clean-ups are for list indentation which
> should always be 2 spaces more than the preceding keyword.
>=20
> Found with yamllint (now integrated into the checks).
>=20
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-serial@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Wolfram Sang <wsa@kernel.org> # for I2C


--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl+TNtcACgkQFA3kzBSg
KbZOdBAAkqpJEFfYvRRb1SGSzO/gUrubqUMa8fIlI3uJkjT7IeUC5fnw0hLY1MxJ
Cbfd4NNRvkk6E9yKwFo8kApquTQGdGpwcO9r0CiBa7hkbQgUbDKVvtBmjGSslFWs
0j0Vo+YnXMNHy5/Wm1f9ZJLUUiE+VZgFJcq4A4Vu4caF03uI0DUINEIYkllpitlB
2df2t4pMA5Hzy9BXd2LvhDIDp1CkyWqQ8gXiQ39xE3IzqU6PHe5g9nb0d2HH41Jf
qdI7CqNt+W1d20gSUA6xr2LesbmR0ZxdJ2Vhl99IiUR3VLXWvq4nuF3Y+12pYZoW
DJNroSrxWH8330Lhgqz/KWtZ/6XThDblaU0vXoP5svYMsCfaobu+g6mgRFCzVBRB
YFhUS0I8Vl5IxMWXjodFn2QtX8Ojc4Ip3DchF4Q2fYqkU8JGm1viFZb7OyCzMCok
1eBcR34Ba2ssrW98znmk7am1PSWWp8/X4odPTQBGamLSeq3iYKSZCCUPnTvR4RJu
4C19OWsUy3ILh65y/6CquGIbEVQP+HtACQlEU3JWsBSPfT+wfdazF8sZkTo1keoZ
tQxJw0DPlBMo5id9L9vahqoV8J7pncnzOonWyFr0AgHQ3V9DJV1ggVC/qD0rXEyx
jrzs0Ye/zKGIorZ8jxV6ggh/XpRNjEgM1g/5l+LT1mb7cY593Ao=
=P6je
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
