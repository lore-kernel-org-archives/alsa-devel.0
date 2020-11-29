Return-Path: <SRS0=XhTq=FD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1945AC64E7B
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Nov 2020 17:34:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51EF62080C
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Nov 2020 17:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sFgrcLct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EF62080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E784B169B;
	Sun, 29 Nov 2020 18:33:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E784B169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606671268;
	bh=iCdtXCODLiXH7g5ruyrkVAnIpWmfoHpkXFrZaHIGxig=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sFgrcLctx1LvSDWF8Avb6/ixTf9ldVqVkSOEDbQn7RptTBK8dbriSlDnXerNYdIWS
	 A1YXWbdryo6qyBQirgk8TAnwVEqwjupi9Yo2UzNvhZzl4y8yFCSAy5HbE1EZwlW5Lg
	 r2+aYbPNMfKipkH2R4/kDmI9YzaUewhh0fsdg3ME=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71AA2F800D0;
	Sun, 29 Nov 2020 18:33:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 746BFF80168; Sun, 29 Nov 2020 18:33:35 +0100 (CET)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 737D2F800D0
 for <alsa-devel@alsa-project.org>; Sun, 29 Nov 2020 18:33:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 737D2F800D0
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ukl@pengutronix.de>)
 id 1kjQYS-0006zE-4U; Sun, 29 Nov 2020 18:32:08 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1kjQYH-0003Mg-0E; Sun, 29 Nov 2020 18:31:57 +0100
Date: Sun, 29 Nov 2020 18:31:53 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Takashi Iwai <tiwai@suse.de>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc/ps3: make system bus's remove and shutdown
 callbacks return void
Message-ID: <20201129173153.jbt3epcxnasbemir@pengutronix.de>
References: <20201126165950.2554997-1-u.kleine-koenig@pengutronix.de>
 <20201126165950.2554997-2-u.kleine-koenig@pengutronix.de>
 <s5hv9dphnoh.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q5fwi2prasbljs5f"
Content-Disposition: inline
In-Reply-To: <s5hv9dphnoh.wl-tiwai@suse.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Cc: alsa-devel@alsa-project.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Paul Mackerras <paulus@samba.org>,
 linux-scsi@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
 Jakub Kicinski <kuba@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Geoff Levand <geoff@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Jim Paris <jim@jtan.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
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


--q5fwi2prasbljs5f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Michael,

On Sat, Nov 28, 2020 at 09:48:30AM +0100, Takashi Iwai wrote:
> On Thu, 26 Nov 2020 17:59:50 +0100,
> Uwe Kleine-K=F6nig wrote:
> >=20
> > The driver core ignores the return value of struct device_driver::remove
> > because there is only little that can be done. For the shutdown callback
> > it's ps3_system_bus_shutdown() which ignores the return value.
> >=20
> > To simplify the quest to make struct device_driver::remove return void,
> > let struct ps3_system_bus_driver::remove return void, too. All users
> > already unconditionally return 0, this commit makes it obvious that
> > returning an error code is a bad idea and ensures future users behave
> > accordingly.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> For the sound bit:
> Acked-by: Takashi Iwai <tiwai@suse.de>

assuming that you are the one who will apply this patch: Note that it
depends on patch 1 that Takashi already applied to his tree. So you
either have to wait untils patch 1 appears in some tree that you merge
before applying, or you have to take patch 1, too. (With Takashi
optinally dropping it then.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--q5fwi2prasbljs5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/D2wYACgkQwfwUeK3K
7AmmxQf+IiMtqhw/kONuYhwVAdprYhlgZyY9iZSe5xHA/6/1zNmBbfhPRm6PfStb
RRMTewx97J4joVbCv7OhlZBsoA7lnpUKJD05Qt7eXIEMdnuscbTx8YZr/z94s9/Y
/ElFT8e2Wx6crnEbjWeFcYVTLkGgf1pnUhpFmTq4LwQqqV5lQWUu6JMnS8THMhay
RCwTJR+P84Nw4wv39uvWN4LFmuDeM5hjnPjoEFBbnAeUtQr62AAh7itX8pTNEyZp
t6M09QdoxpJWDPe/vRxYZSZdsuE+vXsCuMWH5Kyo0hodOX9m6JpOhsPm/YiaCK5B
IW1LSeEeHe9uPQSACw7mkNft9x6Zfg==
=TO3P
-----END PGP SIGNATURE-----

--q5fwi2prasbljs5f--
