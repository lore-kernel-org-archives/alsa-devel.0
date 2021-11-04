Return-Path: <SRS0=uvWr=PX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C3EC433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Nov 2021 05:44:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42CB611AE
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Nov 2021 05:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A42CB611AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thevertigo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EC181663;
	Thu,  4 Nov 2021 06:43:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EC181663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636004647;
	bh=QJObl9vjLaJwL56mVU5hRRVRSxNMVXn28SP6+xltz8s=;
	h=Subject:From:To:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OSFs1iuc4M6aaxDqoyCnC7NjPUa+Aa9G4jZdPeq/TJSNmAZ4TuI33pCS4Gtqkzg6E
	 5HMWaG89AZTS10qXFlW2MdBDF6bLjUthseG8K3enoCgQXNVYdpgV4QkBMumRXQ8tCu
	 Ha6ZP9jWG4FSTwGtzwsKscqaPk+kj+NZUH+oQdeU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7430AF80229;
	Thu,  4 Nov 2021 06:43:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 744C1F8025D; Thu,  4 Nov 2021 06:43:14 +0100 (CET)
Received: from dormouse.elm.relay.mailchannels.net
 (dormouse.elm.relay.mailchannels.net [23.83.212.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1647EF80224
 for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2021 06:43:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1647EF80224
Authentication-Results: alsa1.perex.cz;
 dkim=fail reason="signature verification failed" (1024-bit key)
 header.d=thevertigo.com header.i=@thevertigo.com header.b="LNI83mIT"
X-Sender-Id: dreamhost|x-authsender|kip@thevertigo.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 2E068341C6E
 for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2021 05:43:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a300.dreamhost.com
 (100-96-99-51.trex.outbound.svc.cluster.local [100.96.99.51])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 8C641341920
 for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2021 05:42:59 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|kip@thevertigo.com
Received: from pdx1-sub0-mail-a300.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.96.99.51 (trex/6.4.3); Thu, 04 Nov 2021 05:43:00 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kip@thevertigo.com
X-MailChannels-Auth-Id: dreamhost
X-Chief-Shelf: 2fdcd3f14bed0294_1636004579952_3622384728
X-MC-Loop-Signature: 1636004579952:10242966
X-MC-Ingress-Time: 1636004579952
Received: from kip-desktop.kip-router (unknown [192.252.230.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 (Authenticated sender: kip@thevertigo.com)
 by pdx1-sub0-mail-a300.dreamhost.com (Postfix) with ESMTPSA id 4HlCGW1wzsz1Y2
 for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2021 22:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=thevertigo.com;
 s=thevertigo.com; t=1636004579; bh=QsEDegmANdRQDrUGbedliNKwnjk=;
 h=Subject:From:To:Date:Content-Type;
 b=LNI83mIT1EsQtxPSsl+orDqqSWPtjJQy+2JGCpn7IWquxhs+eI4NWu+y6EoJVQWGW
 GgwnMZKrtA3ynBn6IV3k16CIzoo0OAbTcLjNndbtae+svB+FPhtFjDSekw+8+OoAtr
 D40EzQWSvUQ/c/O918B6ig80OusM9Uuw0qeDE0Wg=
Message-ID: <6116d22081022202aa82374c7b6c5acb270c3636.camel@thevertigo.com>
Subject: USB audio on riscv64
From: Kip Warner <kip@thevertigo.com>
To: alsa-devel@alsa-project.org
Date: Wed, 03 Nov 2021 22:42:58 -0700
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-6TWOyAlemzWLLxjDGu/O"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
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


--=-6TWOyAlemzWLLxjDGu/O
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey list,

Apologies for double posting on alsa-user@lists.sourceforge.net as
well. Someone suggested this might be more appropriate for the
developer mailing list.

I am doing some development on riscv64 using a SiFive Unmatched
development board. It has only one PCI express slot which I intend to
use for a VGA, but it has a number of USB ports.

Is anyone aware of any USB audio devices that are known to work, or
likely to work, with ALSA on riscv64?

I would have thought any device using the generic USB audio module
would have worked. But when I went to plug in a small USB speaker, I
see it show up on the bus and yet `aplay -l` shows no devices.

Yours truly,

--=20
Kip Warner -- Senior Software Engineer
OpenPGP=C2=A0signed/encrypted mail preferred
https://www.thevertigo.com

--=-6TWOyAlemzWLLxjDGu/O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEaUi0dj/qpTzsKe4xRLRlxF7U4wQFAmGDcuIACgkQRLRlxF7U
4wRZrA/8DjH4m/BowLxkt4osh7u1LPxl2LbLhPHKxtjrFpIUNFMGbk3SjXIN0uFK
RFnWCGnJx/wjMJBVFJ5NVft8zok0YAVJAakB6KQcUAyWULrllkHpI1+DMOGjJaD+
JBgArXlKiUeUbCvV3q1E2V/ShQlsgQBowlrETTaGNbXY/Pm2Lu7bKpWTehGzOcUF
Q4T9eiTlJ0DHpEkfZSGxf9YWilCKua6KIiLKIlOYBhCoU+YpDzORzgIBJwDIW25y
UBXcpnUMUuxMTji++SXRUZLRe8imESKPhMQ2SS+FgqqT3/2LOQ7iAf21SjvQiaAx
8NOyjjtqaIjboFN84VhUCIxXUSmHIfKuTXvkuvfsK5pOUYrGEycCCFd/wn4Xj2IE
6CbMMqFqfzlvemiLmRJ15TCgh7QsGo9TjlfY3oz4v1iOOv8QICf26GhHddF0fjjv
43RJq3nZfQ/dmn0/j4fwI6UGz1HAHupZkKL9aPGBk3cnoq7dmGHKHKNiZEDPwdCf
RBOXommzliiKwTp0h10r9CK9LDxelADqVSgYNp8t8H1a9xkjtP0A9C+czyIQvmzY
sfu9boEWXYjkncb8kK58CIDfWl7hd2TxqXO+z5BAVPz77OGn3S31WfGQ1k5pHGgP
VZTRbFZyOXGNrQHhwqTvlrGLD5pyF3LpuQ2rr09J4n+OcWexJDY=
=c/Dw
-----END PGP SIGNATURE-----

--=-6TWOyAlemzWLLxjDGu/O--

