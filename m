Return-Path: <SRS0=adxF=2N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B30EC2D0C0
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Dec 2019 17:19:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F1020715
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Dec 2019 17:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RAWTOrgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F1020715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ethgen.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FCAC1682;
	Mon, 23 Dec 2019 18:18:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FCAC1682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577121537;
	bh=fuz1KKa31+Sc+/Q/2PIvEidiIchQJmrs5wg87J4RChU=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RAWTOrgZAEIVZd4A1fFQ63+nC9aTadFRqB6/cEhabCHLy3L5BhPkMd+Pp3PQ5ObEl
	 Oo43p4EXbsCEbchtx3JYCW9U+f0KHS27TKuGTzFb9f1aoG8X6qGbq7GF5C5e7jFTwD
	 FjJfXq/Z7fsvnQ4y2NItL9LBrKkIiw4Lv8OUncno=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B0DFF80087;
	Mon, 23 Dec 2019 18:18:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1EDCCF80130; Mon, 23 Dec 2019 18:18:05 +0100 (CET)
Received: from tschil.ethgen.ch (tschil.ethgen.ch [5.9.7.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E7BFF800E8
 for <alsa-devel@alsa-project.org>; Mon, 23 Dec 2019 18:18:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E7BFF800E8
Received: from [192.168.42.10] (helo=chua)
 by tschil.ethgen.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <klaus@chua>)
 id 1ijRLE-0001tn-HN; Mon, 23 Dec 2019 18:18:00 +0100
Received: from klaus by chua with local (Exim 4.92.2)
 (envelope-from <klaus@chua>)
 id 1ijRLl-0004h4-SH; Mon, 23 Dec 2019 18:18:33 +0100
Date: Mon, 23 Dec 2019 18:18:33 +0100
From: Klaus Ethgen <Klaus@ethgen.ch>
To: Takashi Iwai <tiwai@suse.de>
Message-ID: <20191223171833.GA17053@chua>
References: <20191207200643.GA10092@ikki.ethgen.ch>
 <s5h4kybciir.wl-tiwai@suse.de>
 <20191208173127.GE4433@ikki.ethgen.ch>
 <s5hmuc2asa7.wl-tiwai@suse.de>
 <20191209085716.GA12935@ikki.ethgen.ch>
 <s5h4ky9hmro.wl-tiwai@suse.de>
 <20191210143245.GA30160@ikki.ethgen.ch>
 <s5ho8wgw8an.wl-tiwai@suse.de>
 <20191210151036.GB23758@ikki.ethgen.ch>
 <s5hfthsw6mo.wl-tiwai@suse.de>
MIME-Version: 1.0
In-Reply-To: <s5hfthsw6mo.wl-tiwai@suse.de>
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] CPU hook snd_hda_intel
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
Content-Type: multipart/mixed; boundary="===============5817823157614913008=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============5817823157614913008==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi Takashi,

Am Di den 10. Dez 2019 um 16:19 schrieb Takashi Iwai:
> Could you try the patch below in addition to the previous one?
> The similar trick was applied to the recent Intel chips for the
> unreliable communications, and the same might work for older chips,
> too.

This patch seemed to have fixed the issue. I didn't see the problem
again since.

Regards
   Klaus
-- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAABCgAdFiEE2oNkebTd5YKFiBG5fue2cNoeGfgFAl4A9uQACgkQfue2cNoe
GfjdDQv+K1h/Os4rMVWWTU56xrcow87XbxLiHltaRisdLM7cNx0kgm99VPzDcUNx
0X/a1jefpd418joHmeJsa083oT5er5k3WK/Av6GXQyD3ZIsXnqN9h4oYv5z6XYen
uUn02Lz3VZZEpGFZscashSXF42rq9YyKacTAId4vsf3542IWcN/TTU+kW0pNS7Rw
st+5fBvPHwRPjYRnIrXyS37UWX0g/edLva94KncJEqibZYP+JbXuOwCGDgmmvUEG
oEnBzu1LD0MoRtMG/yrD3GmVUREityqw3LVbTz9S5nsWVcpK6ORQnRvJypW0Fd4n
mPeti1/ioSajaJ8uNwCPgLUVeg4Ywxc5R8UJmxDoI83pF8Pbf7LT89TGfSDCFcwf
0EgKNewhNT3B80q5n7S8LBP30G3r0z43+dN1ktZ0p/yGzWHxD3sC0/7Jmfl3taO3
L0R+AD0UN59XsqtqM0BsEhQveWcjSP0vlb5xrNXhc0tBW7QXRpQIxSSGqElZO6yp
oswRvhRl
=rm3h
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

--===============5817823157614913008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5817823157614913008==--
