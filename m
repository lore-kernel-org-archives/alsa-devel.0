Return-Path: <SRS0=2x8D=I4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CF0C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 15:36:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056A7619CF
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 15:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056A7619CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C675167A;
	Tue, 30 Mar 2021 17:35:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C675167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617118604;
	bh=nMNslYbP7bsoxUxRERQoAOXe4dowyalkqJZsnQN81Uk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eiDj1j3PF5qriNN4Lkk150/VjVx03WZLN1jjS+lYWIQ/RKC/nVFlSnSlP/4kqe9Fq
	 kYIIMJdt3cZ82aJOnGVUiByzPH74wwtrfrTs2yRsTNYWdM/Qj/RgMIFvTR4sbRpCLh
	 W12nsPtdDvOVNcvKsIhQT82dyPv0XBODg6fpMTWo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D14B6F80141;
	Tue, 30 Mar 2021 17:35:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4386DF800B9; Tue, 30 Mar 2021 17:35:52 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9ED3DF800B9
 for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2021 17:35:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9ED3DF800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="m+KJceb+"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7738619A7;
 Tue, 30 Mar 2021 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617118545;
 bh=nMNslYbP7bsoxUxRERQoAOXe4dowyalkqJZsnQN81Uk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m+KJceb+4H44bWJcmqmsx8kpjhc0T+EFlJeJuTwyk2s+ML8d8mWeJt+GpP1agJZL+
 54k8PHVJlw6HVPBNX61mb+yHGQlQVWwGcdmrWa5iT09GRbvJOc4TRGHRgj1q4kEkQc
 GvZP7xqE3SULPPZNK+DTG6mb4tjre8Y7H/T9C/4QKoYygZZfnS2aMeBfJYa6pk2g0s
 xHyfPzWyRgFFRQ1ILIVTVxVy8PXDlBTMECNrKLqtz7s/zSSLxvnJ7pkaDmqmblrGaT
 9y2g3BfhOM/vBG3ano+5tVksJ6JOh1uHxJR9G5SpmbA9Mc5bGRBM2PgFQwH6qKDWLr
 1bcYGwdtds7zg==
Date: Tue, 30 Mar 2021 16:35:34 +0100
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: Add support for ALC1015P codec in acp3x
 machine driver
Message-ID: <20210330153534.GF4976@sirena.org.uk>
References: <1617095628-8324-1-git-send-email-Vijendar.Mukunda@amd.com>
 <82817878-a30d-2b0c-07f8-48bcca3ebc80@linux.intel.com>
 <a55c7a75-22ab-31fc-81b3-ed8fa24027f4@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
Content-Disposition: inline
In-Reply-To: <a55c7a75-22ab-31fc-81b3-ed8fa24027f4@amd.com>
X-Cookie: Memory fault - where am I?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org,
 Sunil-kumar.Dommati@amd.com, kent_chen@realtek.com,
 Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
 Tzung-Bi Shih <tzungbi@google.com>, open list <linux-kernel@vger.kernel.org>,
 Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com,
 Arnd Bergmann <arnd@arndb.de>, shumingf@realtek.com, flove@realtek.com,
 Akshu Agrawal <akshu.agrawal@amd.com>
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


--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 30, 2021 at 09:12:11PM +0530, Mukunda,Vijendar wrote:
> On 3/30/21 7:52 PM, Pierre-Louis Bossart wrote:

> > > =A0 static const struct acpi_device_id acp3x_audio_acpi_match[] =3D {
> > > =A0=A0=A0=A0=A0 { "AMDI5682", (unsigned long)&acp3x_5682},
> > > =A0=A0=A0=A0=A0 { "AMDI1015", (unsigned long)&acp3x_1015},
> > > +=A0=A0=A0 { "AMDP1015", (unsigned long)&acp3x_1015p},

> > This isn't a valid ACPI ID. AMDP does not exist in

=2E..

> > There was a similar issue with Intel platforms using this part, we had
> > to use a different HID.

> Is it okay if i use "AMDI1016" for ALC1015P?

That's valid, though obviously you might regret that later on if someone
releases a CODEC with a 1016 name (equally well ACPI being what it is
there's no good options for naming).

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBjRUUACgkQJNaLcl1U
h9BCzQf/StVuObimo3H3q9bs6c5tTcFh1Iy8jt/jk6W6jV3j7f5XUhNvmMHqCFWy
e7siS5UjGpCDRbZDIC+QnNZvt3t5krLRijboULo8jAreEkMisQLv6X3nNKoXMSmY
wnSrnJpzwIFKcqUrCeLejk8KAgtvHwxKFQc5u7MEXrDQCCzgIU809WbtgmpPd+VV
mwpyT59KIHjzrSJPZ+29Oco3XFm7YM22pLs0RBNki3OnG4jWy9wJu6Ppk/47RQIo
iilrSirO96NhP2w6T/dDxf1x0fo9aa7Exbd7kYvV05PZBPXJq2cVUR+LIqc26o/y
+wCtkJBgWlnyqlLNavuKel4pWEgeZw==
=LM1I
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--
