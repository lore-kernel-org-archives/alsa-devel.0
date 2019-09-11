Return-Path: <SRS0=DUcU=XG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009BBC49ED6
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:29:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9A420CC7
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hxHaGk4H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="bpBMj9Ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9A420CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DB84171B;
	Wed, 11 Sep 2019 12:29:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DB84171B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568197794;
	bh=CzTmujD3Wygxpi2ZMiqOU9Nx+nCjVqforoVveirktq4=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hxHaGk4HNHAGcIQNdhz6D7W6TgPv5/9GvgVmhWTYFDBwudk6S7bDWKEizmbR4g8eh
	 jpmw8h29eOJn1tfYwR3qXXX/BuDeBRY/DZagrns5WhHwBoEK8Z1cd2KQioGrzDRgCM
	 VX0fv1zi8llOm76XvaV9fez2dypqLZAFCl3O+DUI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 041ADF8031A;
	Wed, 11 Sep 2019 12:29:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EBE3CF80323; Wed, 11 Sep 2019 12:29:01 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63ACDF801ED
 for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2019 12:28:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63ACDF801ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="bpBMj9Ha"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zsUY1xveAuKoU/FNl+yBe1p+/oZXebowf4kLSfK3pww=; b=bpBMj9HaBL3qVQhiEb/rw8svB
 Z0YKdDSo3O9BEdZlwlljSEbW21lkpexQAnYNyzZJBrZSLLHVREEezp+7MTjrbpraQiFDEen1ICLm+
 z9mCKRpdQirm6x7tVgMRVNm7ORK6HBHeijqAXO5ZT8Th8FmJB9nhgQqO4wuJyRXEfPUvc=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1i7zrt-0007rh-Sd; Wed, 11 Sep 2019 10:28:57 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 339E0D000ED; Wed, 11 Sep 2019 11:28:57 +0100 (BST)
Date: Wed, 11 Sep 2019 11:28:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Curtis Malainey <cujomalainey@chromium.org>
Message-ID: <20190911102857.GW2036@sirena.org.uk>
References: <20190906194636.217881-1-cujomalainey@chromium.org>
 <20190906194636.217881-9-cujomalainey@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20190906194636.217881-9-cujomalainey@chromium.org>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Ben Zhang <benzh@chromium.org>, Bard Liao <bardliao@realtek.com>
Subject: Re: [alsa-devel] [RFC 08/15] ASoC: rt5677: Use delayed work for DSP
	firmware load
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
Content-Type: multipart/mixed; boundary="===============8787154072663751568=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============8787154072663751568==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8EXHJdkEfksMlRxO"
Content-Disposition: inline


--8EXHJdkEfksMlRxO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2019 at 12:46:30PM -0700, Curtis Malainey wrote:
> From: Ben Zhang <benzh@chromium.org>
>=20
> Without this patch, the DSP firmware is loaded/unloaded synchronously
> in snd_pcm_ops.open/close context. When a hotword stream is opened,
> snd_pcm_ops.open/close is called multiple times. Loading firmware

It would be better to just do this in the patch that adds the
firmware loading.

--8EXHJdkEfksMlRxO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl14zGgACgkQJNaLcl1U
h9BN7Af/QS9HzBg05wOEiPyCDGREscED1vXFaL3UvTP6wpPPiynRN3tcy6lPXu0a
lECg0CPq5h5qIyAsRcUY0gdZHkQSSztr0nLyyj7lucgCkaeAZvanSRLbpnX0EIXZ
jg9483Z5K8Lq/iCa/yL+SUIrzz+N+XJtj+h7qxIA2OBt0EOXOTFGH8rJyQPP6QaJ
XsNbALZw07fDJnnp2LnudRT8qsIbbcVmzDxkUcg8oHB0o3vMyWVYJEsMmGQ6HgCE
/gyea6Tqs2NvyoKPm0r1a26JgbNTEzF6IdDEzeKi1DHIEHJq42tN9osQ77UTIl47
sgUWx/VjEChXWsJnaRtZD69f8RuoDw==
=b7jS
-----END PGP SIGNATURE-----

--8EXHJdkEfksMlRxO--

--===============8787154072663751568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8787154072663751568==--
