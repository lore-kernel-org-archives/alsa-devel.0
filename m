Return-Path: <SRS0=H+KG=D4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5A9C388F9
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 12:23:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0296C2224B
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 12:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JB7oTrV5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TI9eMfHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0296C2224B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25577174E;
	Wed, 21 Oct 2020 14:22:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25577174E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603282997;
	bh=99nCYr2j7Swgvy4tfJbixXgH/wuaSOsRtyuePeIL/Fk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JB7oTrV5Sh9ROWi+a5f0/cgHibDPLwLxA/nl9HCvzpWzcBpD8b9jrxHK9y0QTToBZ
	 DpmHRJBN2ar42lMX+vfXPTef/nVOMRixzttZ7my0o02ErH7RjavgcrAxKSbqwXG3ER
	 plqoD/eg/dQ5jekQS+56FqMdmvIVf+TZHKIthb7E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC2D1F8026F;
	Wed, 21 Oct 2020 14:22:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C9446F80272; Wed, 21 Oct 2020 14:22:25 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DBC5F80253
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2020 14:22:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9DBC5F80253
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TI9eMfHa"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AF7BD2224E;
 Wed, 21 Oct 2020 12:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603282940;
 bh=99nCYr2j7Swgvy4tfJbixXgH/wuaSOsRtyuePeIL/Fk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TI9eMfHaFN3FVDSd9BcU3ZSB598ZcfKgajcVUDFfLf9MVF2JgdvbbX3DBTaVJzm7k
 +RNgxe+W5iTopXg7nWudniSxR2b2WR00NqMrM2MFgC8ZM2vqeCpGe7SR+kFKwydy3x
 GGy0rHWPis8B4IsN22oiPszkQFnhRl/p/IdQxEys=
Date: Wed, 21 Oct 2020 13:22:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [GIT PULL] ASoC updates for v5.10
Message-ID: <20201021122209.GC4497@sirena.org.uk>
References: <20201012130845.816462076C@mail.kernel.org>
 <a31e2b24-9ef4-c84f-a663-c2a44b0c8938@perex.cz>
 <20201012132857.GC4332@sirena.org.uk>
 <0cfec32c-c0b4-ddbc-6a23-f5b898966c48@perex.cz>
 <alpine.DEB.2.22.394.2010211150040.864696@eliteleevi.tm.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2010211150040.864696@eliteleevi.tm.intel.com>
X-Cookie: That does not compute.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
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


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2020 at 12:26:22PM +0300, Kai Vehmanen wrote:

> maybe bundling the warning suppression to the same patchset was not the=
=20
> best of ideas. Jaroslav is correct the warnings can unfortunately create=
=20
> real confusion as this is on a code path we run on every rt-resume, and i=
f=20
> you happen to have a system with FW that has some custom IPC types, you'l=
l=20
> get this warning constantly in dmesg.

No, and especially putting it at the end of the series - presumably it
has dependencies on the rest of it?  You should always put fixes first
in a series.

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+QJ/AACgkQJNaLcl1U
h9Bkigf9F1flDpBlaklpX0hYTufuBNJrKY3oYSzs41cnTX9CNqyMHudHBHrU/eOz
XcN0fMeKzjbN0BkcWq5XLFE8HAbODcpkFh//P8Gi6x/ANdMM0QyphcTdAcdYLtZF
2b9sEHsgUP16E6oCh1KLIwRiyL6C7IoVAXqFbcc2PgaHUavK+ik72Lz4DJfbp2IG
hvrBIVIpLqWsb579/quK+AuWJXiJN6SNVv9ipiMqs8ZTXYPHxNqjLPvrwE2kIIPo
s3+bsp4ntPdUEtsKYQOqMOy8QAvsjprD4NP8BAfu59wX4v6/gHjGSnkB/IeBwUUD
QCp71fPWnjQaH/p6SEMTmGNKM92TKw==
=E1nK
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
