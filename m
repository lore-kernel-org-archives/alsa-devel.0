Return-Path: <SRS0=cpJH=YO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28488CA9EAF
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:20:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A85920873
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IsjCWmpP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mBLChD9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A85920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7C119F6;
	Mon, 21 Oct 2019 21:19:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7C119F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571685615;
	bh=GSZtQd0XxIeTRAxxuCkdMcmLhPT8soklZ1/IbD3SbWQ=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IsjCWmpPgF/V4NBz6+l2YjttjucvTqYqvbQJnUEErEF9I2nupggOz2hUpOenS2wVd
	 ykbBPol9JiZ4TJy1yTNdUyIrYdUJd3GXnrI8K9XY5OsPPXSAFab9UhTLXT1EMoiz+C
	 2dhMt0ti2an65N2UHsq9kCBIfAqX0gpog7S4Qb2Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 419BEF80321;
	Mon, 21 Oct 2019 21:19:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3769AF80368; Mon, 21 Oct 2019 21:19:23 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF172F80112
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2019 21:19:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF172F80112
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="mBLChD9P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=brqHLSqW034xUjg25k96LodDI1WD7RVmXUV/2qyESS8=; b=mBLChD9PsMfgYTGwhVgyGlTK4
 XDOFrB4bUzi2YqZdkidvvj4WhFCmpmvKG0hDHVfdwGbtF6fY1yuRSSb2kOaH6my7yXxjvG1OtaJPu
 QONo4v9CNc9p4W/Bz2Pg0Fbq0pn9kEP+Mi3vA5LZ0l0fIRzXIFfcZZ0/IAmUrOunhAA84=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iMdD0-0004in-2j; Mon, 21 Oct 2019 19:19:14 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 910CF274301C; Mon, 21 Oct 2019 20:19:13 +0100 (BST)
Date: Mon, 21 Oct 2019 20:19:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Message-ID: <20191021191913.GI4691@sirena.co.uk>
References: <201910110016.g5AIyc2E%lkp@intel.com>
 <f6f9a0a1-2a24-300d-ef15-eb3f678f2f63@ti.com>
MIME-Version: 1.0
In-Reply-To: <f6f9a0a1-2a24-300d-ef15-eb3f678f2f63@ti.com>
X-Cookie: Why are you so hard to ignore?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, kbuild test robot <lkp@intel.com>,
 kbuild-all@01.org
Subject: Re: [alsa-devel] [asoc:for-5.5 122/122]
 sound/soc/codecs/tas2562.c:195:14: sparse: sparse: restricted
 snd_pcm_format_t degrades to integer
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
Content-Type: multipart/mixed; boundary="===============8108567882362069855=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============8108567882362069855==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BWWlCdgt6QLN7tv3"
Content-Disposition: inline


--BWWlCdgt6QLN7tv3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2019 at 07:13:38AM -0500, Dan Murphy wrote:
> On 10/10/19 11:41 AM, kbuild test robot wrote:

> >     190	static int tas2562_set_bitwidth(struct tas2562_data *tas2562, i=
nt bitwidth)

> The only fix I can see here is to change bitwidth to snd_pcm_format_t as

> But that still gives this sparse warning.=A0 The way the code below is
> written=A0 to be consistent throughout the drivers so are these warnings =
false
> positives?

I think so, yes.  Or at least I can't see any sensible way to stop this
anyway.

--BWWlCdgt6QLN7tv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2uBLAACgkQJNaLcl1U
h9DUrgf/eyj3S/jItbvdnLw4GBBWhs6veLOW2LrptEdoaNy7YgzV8PkkJ63BPF0O
u+8VdeGBvqHZopzMtRyN8a6XlVOt5nZGICeiLecGAb94BqFONwvd4qKUfIDtuipo
1C3Ly38LFqi7X25UK6xREYa5vt7/+Yqs3FWg8SMdyzHSoesAx4gZvLB7f2s93sQR
kX9Ynt4zNInp7fxNVoS+1RucHU4NytG/vyS+zY/28PXgmP49tfLby5vk38QANjoV
fQUYUEobKXzXdHDCShjF1Cf86DPtKuBwkuqvArua4NVA0akz+bz7WCuZ1mWsIp+b
hSLSU4qziaFAZLxyaHEvQ2ch/w017g==
=DdKw
-----END PGP SIGNATURE-----

--BWWlCdgt6QLN7tv3--

--===============8108567882362069855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8108567882362069855==--
