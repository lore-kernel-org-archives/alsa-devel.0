Return-Path: <SRS0=qvmA=JD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9C7C433ED
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 12:01:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA30B613B8
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 12:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA30B613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E9DCA15F9;
	Tue,  6 Apr 2021 14:00:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E9DCA15F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617710482;
	bh=cdW5qw0Ks0bLWIfm6aqp0yF2XGIsidVU5DgpGeZHLV0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DM/SjQBG93RLpYlQBYsdAOgI6DmoxUFvHGN/7mEipBCwmVjsfhMnXziiWsK8ZtR2h
	 9qTLwCmm81p7dEnJhpTmfiF9KVGPNtUSXlDfsWfYjaq8sI/lfV67CBRMh45VXN8L5G
	 eZCGwgyQQUxxLJxZP9Xg32Y3x5xmCvlzCoTW3ftM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 720AAF800E3;
	Tue,  6 Apr 2021 14:00:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92E7FF8020B; Tue,  6 Apr 2021 14:00:30 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE49BF800E3
 for <alsa-devel@alsa-project.org>; Tue,  6 Apr 2021 14:00:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE49BF800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fcEwG6Lu"
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB86B611AF;
 Tue,  6 Apr 2021 12:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617710421;
 bh=cdW5qw0Ks0bLWIfm6aqp0yF2XGIsidVU5DgpGeZHLV0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fcEwG6LuqhJx6di968JhtI1c2ZBrGfPs/n7d075B2QNp3TlJBeUzrUe90Meg99fNK
 4bqHhwPRj0j0/uSFR4f4yQrDgcu4ZZEGYzb0oWNYQApFF22R49je97UI3Jk+kTqc8L
 znzkQujUQm9BOCLKAmeUiORYFPV9EytJzljHeeRt7dv07+vzXvY0fdYyaltiyxywWU
 syUU7+fWJZhG9prRlSupmpfq38X7RI7xwAAOQrlG54gINaScgWM2H5/xWx9GQmn6UW
 jsyenmI6DyRmEpY4+/vZr+Lv5tt0G0Kxa0PitXqcL4JRTcsZD13pwNYT79Z6KEF/G3
 fBhJYI4JG6JFw==
Date: Tue, 6 Apr 2021 13:00:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: Re: [PATCH 1/5] SOC Codecs: TLV320AIC3X add SPI: move thinks to
 header file
Message-ID: <20210406120004.GE6443@sirena.org.uk>
References: <20210406105018.59463-1-jiri.prchal@aksignal.cz>
 <20210406105018.59463-2-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jTMWTj4UTAEmbWeb"
Content-Disposition: inline
In-Reply-To: <20210406105018.59463-2-jiri.prchal@aksignal.cz>
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


--jTMWTj4UTAEmbWeb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 12:50:14PM +0200, Jiri Prchal wrote:
> Move shered definitions and defines to header file.
>=20
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
>  sound/soc/codecs/tlv320aic3x.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

This isn't moving things, this is copying the definitions into the
header file without removing the original copies.  There's also typos in
the subject and commit log.

--jTMWTj4UTAEmbWeb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBsTUMACgkQJNaLcl1U
h9Dmjgf+OLYoSekFalHAvYObROwcu6LORU0nTufLgaIbuiXkHS0u5YmUTntBc6vn
aRgrIHAD4PmlF5XhXN2/tv60ih3cRGzNxfSXcN3/wfjegDYY6ae9gOfjfgYkm87X
af2JiwsmKwSL3fGXljWF1qengRRlaNRW0PEw+Q0o7W7rMl0wn6+oWqV7r5MSYePm
ANhVlgJeqP4wrcescJXHp52LCDbULA2uQBDs40A4Q/SrD9s0YIHtmQlU/TSyV0VX
puDQfCTr1jSWgxbN4P/ACHG5105wSSQIQzPCyrHnbZY+FyLfmYqNoYWlB7OkhNsO
Mx1Dmh7bd8OQ9IS2yDjIppmWu4jRXg==
=t387
-----END PGP SIGNATURE-----

--jTMWTj4UTAEmbWeb--
