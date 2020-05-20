Return-Path: <SRS0=qDfi=7C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DCFC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 13:02:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74075207D3
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 13:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PDLNEl0n";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0B/aRAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74075207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BAD91177E;
	Wed, 20 May 2020 15:01:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BAD91177E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589979752;
	bh=auuAVt4jaet44Sy5V1dm3OpzBEcqjdgi4Kuug7Hc8O8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PDLNEl0n9XV2ZvOpYQsCh2havcfh/x++Of30H6lzTnyLltNnUq89QZ+pndbIAXh2l
	 wiLG481clfHrG6E9tkhKuuQHgePx9GhVKi0hsVKt++cZCsMW22cxKwCWGumlWoyeVH
	 +sfqxKiGj7X6F+HLIumhOxl0Iby3PxPiRhdhBqtU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37A7AF801DA;
	Wed, 20 May 2020 15:01:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1020DF801F9; Wed, 20 May 2020 15:01:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24041F80132
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2020 15:01:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24041F80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="M0B/aRAd"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1DEB1207D3;
 Wed, 20 May 2020 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589979693;
 bh=auuAVt4jaet44Sy5V1dm3OpzBEcqjdgi4Kuug7Hc8O8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M0B/aRAd0wboSEWAPvY9514cfl79ITexePRxZWatpsP5WkcH6t+D2uMhshr/8AtS/
 dTPCzxYCalq7WVE2rlFWe1bQFvrLQOPOjOCcSQJUiZFWfkNUaU2r1z5jHuE1m96czc
 AlrhyEYy/grvBV/qt3BYzqGvUtHQ2+eJt37Le0Wg=
Date: Wed, 20 May 2020 14:01:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Pavel Dobias <dobias@2n.cz>
Subject: Re: [PATCH 4/6] ASoC: max9867: keep ADCs and DACs always on
Message-ID: <20200520130131.GG4823@sirena.org.uk>
References: <20200520071904.15801-1-dobias@2n.cz>
 <20200520071904.15801-4-dobias@2n.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oOB74oR0WcNeq9Zb"
Content-Disposition: inline
In-Reply-To: <20200520071904.15801-4-dobias@2n.cz>
X-Cookie: You can't get there from here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, ladis@linux-mips.org
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


--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 20, 2020 at 09:19:02AM +0200, Pavel Dobias wrote:

> Codec requires enabling of left and right ADCs in the same I2C write
> operation which isn't fullfilled when controlled from DAPM and
> causes unexpected behaviour of codec. The similar applies to DACs.
> Enable ADCs and DACs once at startup and never switch them off
> to solve the issue.

It will be normally when the two channels are updated simultaneously
though that doesn't stop the user doing something to update them
separately.  In any case this would be better handled through moving the
power control to either supply widgets or event callbacks rather than
just giving up on power control entirely.

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7FKioACgkQJNaLcl1U
h9DHWQf9F59h+ga1u4w+3ef7Eq4pSi1LlN4UJFYA3EvrRiMJ+NTP2Z+5cxnUl8r2
pkkx0bUKGsdb/Z7LhHlsUeKuP56JOGXfw53QJHD58YkVL1ItCbTxhWqwB+lJ+UoD
PuuzoBgDVbR4D/je5192nZxvPx1++hGF7+U2Fy+zK7upxWQ63W2h0BMb4JQeCcyD
vU/Oc7PsLcilwpcmC9mQgRpZ6qIEI50jJUmANo77Qtc1C9TMMamYtNR9qp9qOKEA
qK2ssavSiFanQwiP81tfDZaUf3L7ArGMI67xodRA5iS2u5WzwtwO8zgfsnzrNbeO
fd9biN/o251OwP55cfdBm7BNSpX5Jg==
=n1II
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--
