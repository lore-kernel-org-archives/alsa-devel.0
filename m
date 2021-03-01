Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8F1C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 18:58:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE46B600EF
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 18:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE46B600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 821811668;
	Mon,  1 Mar 2021 19:57:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 821811668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614625083;
	bh=lLXrk2RMsQaibLDznXzbUuYoL0i+kUjIXiRwT/6T3UM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eeWKHOL0t2MbOEV/PE+ttqanGqv8hpO4DLVUwU6JsquDF/aE1/Pse82E6v9SxfHhX
	 LcVbFpmodsqN7pjU4fJpMfqwWYEaRy3tt3S2lP07cbFuDG+NujigzVA7x2l2l1E9mx
	 wJhcsNinIRK3FS8QRaz02kpF5POHRtaSnfsfN1Rg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02325F80257;
	Mon,  1 Mar 2021 19:57:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5386CF8025E; Mon,  1 Mar 2021 19:57:11 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB6CDF80150
 for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2021 19:57:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB6CDF80150
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jVQDBK41"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28ABA60241;
 Mon,  1 Mar 2021 18:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614625023;
 bh=lLXrk2RMsQaibLDznXzbUuYoL0i+kUjIXiRwT/6T3UM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jVQDBK41zRKrdP8iXV5AvW0Nr/HPu7mvxo1TaIrqoOuWC2dhiAML1DTtOHStbdhhh
 s8Tr6TjzUTnafiPCBtDfRtjy38ES/gZMcBBachYHeKDzD3fJ2BR+dCVSXPLYzwY1jK
 E0YC/5oE/9puOwQ36I57ZqBoWT97atXpV/V8qSJ2cTZayz3sELmcXFaUqIE2F9z41d
 tETrMGIzNyWFBWkNEaAh7NfzJyGLuJNKUmXliHb9gueIK5EsV2ka+6/aWyWptCd7qX
 z4hJsCyNqH85rXXnnbXjx/HtAcIb4bE7hsWF4GG3Rj7OYsxt+T7hxA8/Jjg8jBrZ5O
 IeXRj4ZBZYG1Q==
Date: Mon, 1 Mar 2021 18:55:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/5] ASoC: rt5640: Add emulated 'DAC1 Playback Switch'
 control
Message-ID: <20210301185557.GG4628@sirena.org.uk>
References: <20210226143817.84287-1-hdegoede@redhat.com>
 <20210226143817.84287-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+1TulI7fc0PCHNy3"
Content-Disposition: inline
In-Reply-To: <20210226143817.84287-4-hdegoede@redhat.com>
X-Cookie: Body by Nautilus, Brain by Mattel.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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


--+1TulI7fc0PCHNy3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2021 at 03:38:15PM +0100, Hans de Goede wrote:
> When using AIF1 the 'DAC1 Playback Volume' control will be used as the
> PlaybackMasterElem in UCM.
>=20
> We need a matching 'DAC1 Playback Switch' for 2 reasons:
>=20
> 1. To be able to truely fully mute the output (the softest volume setting
>    is not fully muted).
> 2. For reliable output-mute LED control.
>=20
> The path from the IF1_DAC data input to the 'Stereo DAC MIXL' /
> 'Stereo DAC MIXR' digital mixer has a 'DAC MIXL' / 'DAC MIXR' digital
> mixer with IF1_DAC data as one of its inputs direclty after the
> 'DAC1 Playback Volume' control.
>=20
> This commit adds an emulated "DAC1 Playback Switch" control by:

This feels icky, it seems like if userspace needs to stitch together a
stereo mute control that doesn't already exist in the hardware from
existing mono controls then UCM ought to have support for figuring that
out anyway or if we *must* bodge this in the kernel there should be some
generic way of doing it rather than open coding in drivers.

It also makes the whole mute LED thing feel a lot messier even for
existing systems than you seemed to be suggesting in the other thread.
This device has two I2S interfaces, two DACs (only one of which seems to
be affected by this control), and it appears that there's bypass path
=66rom the ADC to DAC1 which won't be muted by the newly added mute switch
here so this reliable mute control won't be entirely reliable.  There
look to also be some analogue bypass paths, I didn't fully check.  One
could equally argue that a software defined mute control should be
muting all the analogue outputs, it'd certainly seem more robust.

--+1TulI7fc0PCHNy3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA9OLwACgkQJNaLcl1U
h9BwGgf/WxjTU8wI1hS4j9bgXLXBr5tehE2fuoxMftK2u3Czn2r62fJdaZadrQDE
KCZXT2+Z1G2Jysu25E4XrCmGcRPhyzELCTyN3Y492gLhwhtP6zhG1kMa1yQfXkNZ
G+XombZk4EilhCSsfByG8SHYP4EjN1OpVlSUb4S0FXMuw+IhDTLJylRdE8C0/UiA
QBvdL5cXktva9R4TLRCuXGYEhZDImDh1RAM93XlLHXkE4lmrq6+FYwCL2ml98xq3
wJWB0rz4PG22orfhr/O2m0L6o+dV9tjpZlOr34BS6v5Om4al/CpQWD18SbO0HJ0A
FZ5dDnuyJh5vrEyXFWp7t9sj5LeFtg==
=kywF
-----END PGP SIGNATURE-----

--+1TulI7fc0PCHNy3--
