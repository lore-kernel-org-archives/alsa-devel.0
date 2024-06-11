Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65AFC25B76
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Jun 2024 10:40:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA51B1629;
	Tue, 11 Jun 2024 12:39:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA51B1629
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718102407;
	bh=48QYdfypmjq2I+QLwjJDC0+p53AFnmSrM5vjdg5plFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KFjG3CTePc2ZXNlLqerF585HaBiv3wHsWEaKXY2Du0pDes+wdvGJMmR/pDoYtmtD2
	 /1mgaavxSzPOEDOiFFRcIfYMXNkjCKrypDplace4vad3eejiMvRqZ1wdaawlQmJUNM
	 JOoX2GNSNFPaHv5l9P0OxNdN17ZZA0gnV9jOkAL4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B64D9F805B1; Tue, 11 Jun 2024 12:39:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 52EA4F805AF;
	Tue, 11 Jun 2024 12:39:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7175F8057A; Tue, 11 Jun 2024 12:39:22 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5CCFFF8010C
	for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2024 12:39:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5CCFFF8010C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XjPFo+Si
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A131CCE1A8F;
	Tue, 11 Jun 2024 10:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D08BC2BD10;
	Tue, 11 Jun 2024 10:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718102356;
	bh=48QYdfypmjq2I+QLwjJDC0+p53AFnmSrM5vjdg5plFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XjPFo+SiEAm33bKHZdR9iuweZnZ2aj6cxv5hKjUdp2BH9FaBF68enEWGF9xXrQJ7n
	 2vjEGYoiTUd6xZvBjaIXHrCNc9UK92PN9yKShbbpbCIpMtg2tRnUyqoiKdiqcnIvb+
	 f/bU2XIXsIgFtWt1reDzv+ZRi+Q1anlnmqCqlmz7nxpOAR7JgWMUPWA8lWArSauHZH
	 vs9zAp4gEI9i3arrLtcMj3GyyCMyaz0AZhrMw2nvFeDqqRCmbikshLFXqybQkfZ0e1
	 Wi6XpN02fFvFO8+U70U5YAjO3Bl7MBk0jYjH2rp26r5PWyxnYofB6y2euhBRNPrzKx
	 zePYONOgIOCZg==
Date: Tue, 11 Jun 2024 11:39:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jai Luthra <j-luthra@ti.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, Devarsh Thakkar <devarsht@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH v2 1/2] ALSA: dmaengine: Synchronize dma channel in
 prepare()
Message-ID: <ZmgpUFy5-_5n_zyd@finisterre.sirena.org.uk>
References: <20240610-asoc_next-v2-0-b52aaf5d67c4@ti.com>
 <20240610-asoc_next-v2-1-b52aaf5d67c4@ti.com>
 <3557bd0f-86b4-4dce-90dd-59303f4f1154@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0TfXp5NDpMNDG3Z7"
Content-Disposition: inline
In-Reply-To: <3557bd0f-86b4-4dce-90dd-59303f4f1154@metafoo.de>
X-Cookie: Your love life will be... interesting.
Message-ID-Hash: 4JX2DICC3BYHQ4BARJEEPFAENKRI62HB
X-Message-ID-Hash: 4JX2DICC3BYHQ4BARJEEPFAENKRI62HB
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4JX2DICC3BYHQ4BARJEEPFAENKRI62HB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--0TfXp5NDpMNDG3Z7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 10, 2024 at 05:45:52PM -0700, Lars-Peter Clausen wrote:
> On 6/10/24 03:56, Jai Luthra wrote:

> > Sometimes the stream may be stopped due to XRUN events, in which case
> > the userspace can call snd_pcm_drop() and snd_pcm_prepare() to stop and
> > start the stream again.

> > In these cases, we must wait for the DMA channel to synchronize before
> > marking the stream as prepared for playback, as the DMA channel gets
> > stopped by snd_pcm_drop() without any synchronization.

> We should really implement the sync_stop() PCM callback and let the ALSA
> core let care of the sync.

Good point, that's a better idea.

--0TfXp5NDpMNDG3Z7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZoKU8ACgkQJNaLcl1U
h9BedQf+LgwsDPZ2r9hVlvRNDyt6JZgIXzyPghbWNXb2jndRsTN0kXDZlyMRdPtN
iljCdWcV193flVjp3ZMX7IsVtIEDiMtwNuspJjIU2nXEqEgQE4FcfSkLv5Q8uIcQ
jSp1zqxvo8AFrEKQrySdNdc5iysKN265nBFq3Q7KfAVvpndZL1ZYnCbJ738EoNhx
3RgYTlvAuOIoux34F/bXbrYPsEfQseB6Z9JvxvwtKoVDcDUcTUkQv2mwlN6zzqwO
Vk8fk1bIjPmf304blTqV3T53LPtTTOQvRIFu1xeFI61zpMRRq79wIHSSBUtiaxcs
Ijdg6xeeM0a9FfxfcH5bm3UKiRhKdA==
=pWL3
-----END PGP SIGNATURE-----

--0TfXp5NDpMNDG3Z7--
