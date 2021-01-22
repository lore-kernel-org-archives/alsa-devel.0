Return-Path: <SRS0=81m9=GZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013F5C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 09:20:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C42239D1
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 09:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C42239D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B61EF1ACD;
	Fri, 22 Jan 2021 10:19:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B61EF1ACD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611307249;
	bh=Fz2SdsRmzyg/R2X1FlxG9bQZ+ajptlq0wR7ERPzwqDc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OdgJ8vfeAijCvexhdIVj0qqTWfyNy8KhtsZIVNA2mhJ9vfZnfrAefrjOFQazEHik6
	 lDoNEJJTpZCG4CiDCGfvVIKk86b3QkQA4vSRn/UnGMQ+7gDSdtLg7LQv5oeT5xTnrf
	 19pgD7lgmwgcywV/roaU4Qq8Oskia134DwlLL0PM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37C1FF80166;
	Fri, 22 Jan 2021 10:19:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7481CF8016E; Fri, 22 Jan 2021 09:54:00 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DBBB5F8015B
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 09:53:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBBB5F8015B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ddZNA3M6"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 576F220739;
 Fri, 22 Jan 2021 08:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611305631;
 bh=Fz2SdsRmzyg/R2X1FlxG9bQZ+ajptlq0wR7ERPzwqDc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ddZNA3M6UjNKCbv2ln05xi74+gg8RxPyfmTwHQ4mUmmkjwJ9S9/sn0rRIy3ApJYra
 ofdkWNtzHT0/iNjwUZK2whof89UzJC4pL+jhDlg2zofzNVukbVCGpITfv4dRSH/NP+
 Vljz4p4ya+TFxfBBgfNn7l16vKcvpy85i80JNbTCcKiLpQnkq2hhXjk5a4bFmW6INV
 djOy8m4qPjMvnzIVJvaQcwI+tPU6Vw+ZXR4jezPjuaA6S/H0iY30pf7MLs8p7yjxK+
 R37SCiknKGV/Du5Z6/rAraxkbZZzlhu5BiY1umPObLP6MEingJjnI2C2JBYNfkRqlq
 PS2UjRs5P+fWQ==
Date: Fri, 22 Jan 2021 09:53:48 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH v1 2/2] isa: Make the remove callback for isa drivers
 return void
Message-ID: <20210122085348.GB858@kunai>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Pau Oliva Fora <pof@eslack.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Hannes Reinecke <hare@suse.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Finn Thain <fthain@telegraphics.com.au>,
 Michael Schmitz <schmitzmic@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
 linux-media@vger.kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20210121204812.402589-1-uwe@kleine-koenig.org>
 <20210121204812.402589-3-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <20210121204812.402589-3-uwe@kleine-koenig.org>
X-Mailman-Approved-At: Fri, 22 Jan 2021 10:19:58 +0100
Cc: alsa-devel@alsa-project.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Finn Thain <fthain@telegraphics.com.au>, Hannes Reinecke <hare@suse.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, linux-scsi@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Matthew Wilcox <willy@infradead.org>,
 linux-input@vger.kernel.org, Pau Oliva Fora <pof@eslack.org>,
 Jakub Kicinski <kuba@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>,
 linux-media@vger.kernel.org, linux-watchdog@vger.kernel.org,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 William Breathitt Gray <vilhelm.gray@gmail.com>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Michael Schmitz <schmitzmic@gmail.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, linux-i2c@vger.kernel.org
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


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2021 at 09:48:12PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> The driver core ignores the return value of the remove callback, so
> don't give isa drivers the chance to provide a value.
>=20
> Adapt all isa_drivers with a remove callbacks accordingly; they all
> return 0 unconditionally anyhow.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>

Acked-by: Wolfram Sang <wsa@kernel.org> # for I2C


--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmAKkpwACgkQFA3kzBSg
KbYioA//frCM2vGMNRb9m2Wz+bP5qkNSp3R5QbWC14WxE8ZsbjcOun8Op9VX023l
cmNSjxAFJ7nXTQgZYnrdfSo5+ZegXPapPa6zwpSF29HDrvoDmo7yHCVnrhSp+ko2
nauFE8d5U2LLJftrZ29QteTfvmBQn0RFdsO2NFFwCo9bVZd5UfwxinwQk3ncG4Fs
7th2N/Hwnb0Xb5NswrpHEeknQCVuYZdOx3bo21TQ/eImBBwT6iKExwzBYN+YX/Uw
AckTF0es+DatjTNiFBLvNHSDf0/bjroW+oIsZeu6Wz5G73yBqWiJmyhNLR4XxRJf
RgkOj9UvQsNAZhA/hKbFjtT0sv9yXYm4pe76+47Aw5YxnN5WQIAtBV0tsd5Dfs4Q
FCOIHYbsR8lchLm/HGG4D9L0w5fUgQ3TzaOUaWUQ3sjeHvpTGSH7JJCblU3FXlFB
N3Cn6HcfRTe7Izg9jH6lkYmaDvwsshB3VjK/uiegjLZPkN/EPGkNdwRnDId4zk/7
/Zgb5gYeLzQzXlxJM+WFgTS4aLLGg6UGxgl6PUHeSUXKdxoo9pjk7LtfRVpb+mHu
LHt7KzZLjCHrntyYHaXrxSHcjQZzxr8pGnPl+bfMjlpKpkbMBIyfncncJUiDz6cy
DuITnJtHM/j/zc6ciV1UPNWiF9bIu1ga6GdKu9/UEMlvE7xkgXs=
=0OvQ
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
