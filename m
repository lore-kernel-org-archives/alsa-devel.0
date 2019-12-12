Return-Path: <SRS0=r47B=2C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC8DC43603
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:27:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCBF21655
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I/cgnUMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCBF21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32984851;
	Thu, 12 Dec 2019 15:26:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32984851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576160837;
	bh=M4JR2ojsDf7QfqYaV5kvtFhftt2V1h1V7jfy0Hyk4b4=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I/cgnUMzyjPRL9BLZs/6FCNR2/dLQS/KciLYTYUY8kJDZLVWQTHDYT3Qj0ea7yGpm
	 D70u4dbosNV4zeLFuC+9Z+/zUYR0jPttm9sXuSTKHpbIhPuJzc/0wXgXgHrHeIgC3x
	 81HZeX3KfmupFnAHAAmNDQrPeofBktw3+cIk6lzk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3EAEAF802A0;
	Thu, 12 Dec 2019 15:19:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16C6AF8020C; Thu, 12 Dec 2019 11:57:59 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5C00F80139
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2019 11:57:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5C00F80139
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6CFDAAEC1;
 Thu, 12 Dec 2019 10:57:56 +0000 (UTC)
Message-ID: <9f0d4eb964f3f18ff18c0c2697ff1a681639ce58.camel@suse.de>
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Date: Thu, 12 Dec 2019 11:57:55 +0100
In-Reply-To: <20191210141356.18074-5-tiwai@suse.de>
References: <20191210141356.18074-1-tiwai@suse.de>
 <20191210141356.18074-5-tiwai@suse.de>
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 12 Dec 2019 15:19:28 +0100
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com
Subject: Re: [alsa-devel] [PATCH for-5.6 4/4] staging: bcm2835-audio: Drop
 superfluous ioctl PCM ops
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
Content-Type: multipart/mixed; boundary="===============2536916971930924552=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============2536916971930924552==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-g0TJqR5cdhbPOzOoFy6+"


--=-g0TJqR5cdhbPOzOoFy6+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-12-10 at 15:13 +0100, Takashi Iwai wrote:
> PCM core deals the empty ioctl field now as default.
> Let's kill the redundant lines.
>=20
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!


--=-g0TJqR5cdhbPOzOoFy6+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3yHTMACgkQlfZmHno8
x/4wugf+NmAk0UkDbFiLmoISfbHMhP+QF9xsW4TglreylmVopMkzBgb7rGFwpf+c
lYB4ggdHpr4CfCZlYS4C5eKUa6KxCs4cqhQgkJqWkMrSQ3xNWzyrblVr7uA+yz17
3HtdAB6wE83Hh7zrJgvcQPASSXlziK2JryotwDHjpqGixTRAYmAIueTMIiP8j/+Y
SWzx6QZY4CduTjIYjDgOIE+12GB2w4NJ/n4UCJ0nBXF4jth6FE6VbqPqQ2zylgYJ
W/XW/w3yJ1ebgDRmriOGNS2vBG/L8ASuiI4RnnXWa1jLMd75IPnGBAgvIOCRnkQk
NKRgdGsILjMZhoEISnha3z3jvYUmTQ==
=IRls
-----END PGP SIGNATURE-----

--=-g0TJqR5cdhbPOzOoFy6+--


--===============2536916971930924552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2536916971930924552==--

