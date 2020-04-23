Return-Path: <SRS0=JLiH=6H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F75DC54FCB
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:50:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C73320728
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hIF6+YL+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvr+wOAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C73320728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDF1F168F;
	Thu, 23 Apr 2020 15:49:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDF1F168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587649828;
	bh=L5kU010tRLvlDykx2R2LNiOC7P2uliyNrRS983QiysA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hIF6+YL+SESJ9PsDeacDGJNnB01dgJoiOpyVxB5JcqL5kRLdeE9AWoZSrlgTzPoby
	 qz0X+H6j2seEleVX/NdzWYTodvoqL3yCjqbt4HYPv6zcBZXH5tkcSiNql+OtMiJvPr
	 Ia0uLFegS5Imq59tBsk6217FM9/pkV3jsoD4SgRE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63B31F8014A;
	Thu, 23 Apr 2020 15:49:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EC9FBF801EC; Thu, 23 Apr 2020 15:49:34 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4973EF800F2
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2020 15:49:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4973EF800F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qvr+wOAn"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0F87D20728;
 Thu, 23 Apr 2020 13:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587649767;
 bh=L5kU010tRLvlDykx2R2LNiOC7P2uliyNrRS983QiysA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qvr+wOAne/Dt5gCDxSwumAQtaM06h6Rcx2mWfPYuxyWvAg3INOrC9pI0TVoGhWBJ3
 jkiC3PBLU2ox2NIZk0eLhWl5o06CytG87FVIoGtj8Hb6SQ5VaJo5kYvFjWZZJvLkJI
 yoTLzM0JfEldXK7OyD+07JPX6BdYQbwWSboj1+44=
Date: Thu, 23 Apr 2020 14:49:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Rong Chen <rong.a.chen@intel.com>
Subject: Re: [PATCH] ASoC: soc-compress: avoid false-positive Wuninitialized
 warning
Message-ID: <20200423134924.GA53068@sirena.org.uk>
References: <202004201540.vYPhhYMs%lkp@intel.com>
 <20200422073543.1671-1-rong.a.chen@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20200422073543.1671-1-rong.a.chen@intel.com>
X-Cookie: Must be under 48 inches in height.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, kbuild test robot <lkp@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>
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


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 03:35:43PM +0800, Rong Chen wrote:
> gcc-6.5 and earlier show a new warning:
>=20
> sound/soc/soc-compress.c: In function =E2=80=98soc_compr_open=E2=80=99:
> sound/soc/soc-compress.c:75:28: warning: =E2=80=98component=E2=80=99 is u=
sed uninitialized in this function [-Wuninitialized]
>   struct snd_soc_component *component, *save =3D NULL;
>                               ^~~~~~~~~

> Simplest fix is to initialize it to avoid the warning.

This doesn't apply against current code, please check and resend.  TBH
I'm not 100% sure the benefit here is worth it, this is a very old
compiler and it seems like a bug in the compiler.

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6hnOQACgkQJNaLcl1U
h9B11gf+Oc9Yy/dxZEWmYZXf4NvQ//qzlH4elElRYAl5NqjfV3NVh5GQmoZRnerX
uA8j0Nkb9lM/Tw+mpj7W4YYu8seuBqFolV94YnsPGnlsVcePMlFZuZGcAeeMQ3QW
3oMOcmp8EqlC2jtKTK4apSqOqJSnJdhRWRcGl/4KiFAodJ12bRASMJIKONxVDfT9
tRqC7l4xmIoblzQ58tocFy6cTZMFzC9Rtx90T/3QFMVaDICCWEU0AwKmUqLeWxXW
d3dbyaDaabfmjbSFGAdUY5/mEAiJZN3g9MgJUcxTdtuXZcW+Dw3+ERCmS5XHIeVd
75wiLWNECNnXTUKVn6QWhSJjEDdEgQ==
=IV9o
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
