Return-Path: <SRS0=SJ4a=XT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FDCC432C1
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 19:41:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3EB214AF
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 19:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="acNMdzXB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="L7sv3ort"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3EB214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7FFB16AB;
	Tue, 24 Sep 2019 21:40:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7FFB16AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569354071;
	bh=B3leKNhkT9n4WzO5ofkc6NpN+hx7qiqtraDb0gxcEps=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=acNMdzXBGgCuI958ySXuB3JmnMs5IgErarKCJn6AANcQwkQU4D+mtQHv0QsiWKBMo
	 YJt3XX3u8TLxU63OhIQTcZieuKOMiVxeJztxSypD2rWRX6jaIgRhmBO3OQfKQHt6o6
	 0dQlaB6QZCD2XFEQnDYnS9jK+dVpjQ5w1JoWbPbs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59917F803F4;
	Tue, 24 Sep 2019 21:40:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2E64F8045F; Tue, 24 Sep 2019 21:40:18 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49909F80213
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2019 21:40:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49909F80213
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="L7sv3ort"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UGNKVgdUYFuUTNImfTBx8QxhgqabS2KIbpEW//nqZec=; b=L7sv3ortMC8kayPdRoCh+yJsI
 Jcz0STOUGTdD3GRlZC+1xUq0sSjaeZ4hPXdvQzue2GdhbtmljTODzdQ/jxGkwOaXZss6J7HXud4jV
 mSVfGQUAhIVBO28iBz1sNsKOMqw5XjZfTrQfovvtMZM2AvjfD7k+++dpr/VGKfV6+wA6g=;
Received: from [12.157.10.118] (helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1iCqfW-00031g-Kb; Tue, 24 Sep 2019 19:40:14 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id F0FA4D02FC7; Tue, 24 Sep 2019 20:40:12 +0100 (BST)
Date: Tue, 24 Sep 2019 12:40:12 -0700
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <20190924194012.GE2036@sirena.org.uk>
References: <20190924114146.8116-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
In-Reply-To: <20190924114146.8116-1-peter.ujfalusi@ti.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 kuninori.morimoto.gx@renesas.com
Subject: Re: [alsa-devel] [RFC] ASoC: soc-pcm: Use different sequence for
 start/stop trigger
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
Content-Type: multipart/mixed; boundary="===============0572192279330517910=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============0572192279330517910==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JbaLeU65fPBt7QWN"
Content-Disposition: inline


--JbaLeU65fPBt7QWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2019 at 02:41:46PM +0300, Peter Ujfalusi wrote:

> It can only fixed by using different sequence within trigger for 'stop' a=
nd
> 'start':
> case SNDRV_PCM_TRIGGER_START:
> case SNDRV_PCM_TRIGGER_RESUME:
> case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> 	Start DMA first followed by CPU DAI (currently used sequence)
>=20
> case SNDRV_PCM_TRIGGER_STOP:
> case SNDRV_PCM_TRIGGER_SUSPEND:
> case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> 	Stop CPU DAI first followed by DMA

Yeah, this makes sense I think.

> If I think about the issue, I'm not sure why it was not noticed before as=
 the
> behavior makes sense:
> we stop the DMA first then we stop the CPU DAI. If between the DMA stop a=
nd DAI
> stop we would need a sample in the DAI (which is still running) then for =
sure we
> will underrun in the HW (or overrun in case of capture).

There are a bunch of systems where the trigger only actually does
anything with one or the other of the IPs and the startup for the
other is handled by a hardware signal so the ordering doesn't
really matter for them.

> Not sure if anyone else have seen such underrun/overrun when stopping a s=
tream,
> but the fact that I have seen it with both UDMA+PDMA and EDMA on different
> platforms makes me wonder if the issue can be seen on other platforms as =
well.

I'd guess so, especially with smaller buffers.

--JbaLeU65fPBt7QWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2KcRwACgkQJNaLcl1U
h9CIKQgAgWyJx+xgH6Sau77Ufvf82sj7VsCvlo9uFcM+YZWt4q29iIs8QYuf4Jtx
NfMmYwEwB7EoCERv26/0AG0sP7WJFJc75gwGBJPMhTzWXEkOyk/+AuaoMLrppoSA
DQOfR3Pxz9fxxUS2bwstRrtNUffoJGKfcNlNHrM/lJIq2oBanAxMEnkPIxUBrVZF
FT+fcn1yaiApsFjpiAFd+ffc5vVb0zli4wpnpuVDqmT1A8KrIRrIpV3eonfWAJZN
3Pe+LVnS5O3P1k4gnI3XdYgJ510+tVc29myWyUC8pQHYvHftpfMGRcxxJUGg0KlQ
6VgOzc4qZDaid//UhHr8wyCVqHeJYA==
=Vvfy
-----END PGP SIGNATURE-----

--JbaLeU65fPBt7QWN--

--===============0572192279330517910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0572192279330517910==--
