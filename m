Return-Path: <SRS0=qvmA=JD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2F7C433ED
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 16:56:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D8B613D2
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 16:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D8B613D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51777852;
	Tue,  6 Apr 2021 18:55:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51777852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617728162;
	bh=Sw9GyBcdCnp9PJNv87skGlgOmXs9sdDo3WQsQxaCC6U=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U0m6g+EdPx4L6bvtWm7IlGYnGOFv95jkRCiDbvupW/Ia2W65rtkCQf2LF3pG9Ixbi
	 xCtar5b+jFNpaP7vWm+0lXN7DrxaPN6YWr6vMagefHe8nThrHjc8OSuuCa7zK+7wai
	 LwE5aNVU7PxY52ht7g1kXAnm2jaUSsfjmarhHga8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3123F80169;
	Tue,  6 Apr 2021 18:55:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A9DDF80169; Tue,  6 Apr 2021 18:55:09 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9994EF80124
 for <alsa-devel@alsa-project.org>; Tue,  6 Apr 2021 18:55:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9994EF80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ilkuRXu/"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73B1E613AD;
 Tue,  6 Apr 2021 16:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617728098;
 bh=Sw9GyBcdCnp9PJNv87skGlgOmXs9sdDo3WQsQxaCC6U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ilkuRXu/CEuFFDuLBNEoDq6DFH9bs0rRllEIn7/Bp5h0fb3lng0dDRZjAFyoiKxN4
 Mm+WdhRowc8XSiRRo8m1SDV7B/YunuQZRkKqmo0/lu8z8a/Wi7A/D6OaNaOrMEqFpF
 0zLlhBhdnIWNCLC1/p472cOPN9pKggcrIClrkwW2aIhrRiBeuJNwrepaJ5zCenU/Hl
 roCqSIyJ0gW8kBsBPJ7xqvJvgYdo6hH1c/quZY1AWqAAzEbQK5uI+b+Kcbmsa+UUov
 2e8I7SbocwoB6HVRFeeysdhikQCjlWmFsIJemEo3Ntmoj/pAyZP12BzsiLV0lEZYTS
 uKToyFu6AvgrA==
Date: Tue, 6 Apr 2021 17:54:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: Re: [PATCH 4/4] ASoC: codecs: tlv320aic3x: add SPI support
Message-ID: <20210406165440.GN6443@sirena.org.uk>
References: <20210406142439.102396-1-jiri.prchal@aksignal.cz>
 <20210406142439.102396-5-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QGBKWVSgmlsIyJ+t"
Content-Disposition: inline
In-Reply-To: <20210406142439.102396-5-jiri.prchal@aksignal.cz>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>
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


--QGBKWVSgmlsIyJ+t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 04:24:39PM +0200, Jiri Prchal wrote:
> Added SPI support.
>=20
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
>  sound/soc/codecs/Kconfig           |  7 +++
>  sound/soc/codecs/Makefile          |  2 +
>  sound/soc/codecs/tlv320aic3x-spi.c | 76 ++++++++++++++++++++++++++++++
>  3 files changed, 85 insertions(+)
>  create mode 100644 sound/soc/codecs/tlv320aic3x-spi.c

This looks good but we should also add an update to the DT binding which
notes that SPI is also supported, right now reg is documented as being
at an I2C address.

--QGBKWVSgmlsIyJ+t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBskk8ACgkQJNaLcl1U
h9AHaQf+LF4QkMOJ0wNiGn43Oe53SU2x5ICENXwi5qRwczcVGWX5qOfqf/ILGYpk
VcD1x/dIbzss8C9kxxafOWrfPxRjYR5V3FXkZQxLwavDftQuXW+cWHLb/9wzKNHA
F2SxX5cSbRzG1prsP+LnupfYBa0CWX01Xxul9E8Kvg1Kh/zRqGy/ydKCTy3XxNTv
6rkoLDhwNpYS2p6y8gnhXXP3nVY+LRUZ2U7aUzHopcFpEKpXAyJQuceinsHDFkdV
pyxxMLy6OhYIQDw3xAdeIj3FL2BnzCPZPLMuvodNyK/PVeG2PGwLMze8v4+GCTxy
ifPd9WugzXdLr/DV1it/3bGbQFxgyw==
=y0eG
-----END PGP SIGNATURE-----

--QGBKWVSgmlsIyJ+t--
