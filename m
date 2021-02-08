Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21879C433E9
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 11:13:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1EA64E50
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 11:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1EA64E50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC93184B;
	Mon,  8 Feb 2021 12:12:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC93184B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612782795;
	bh=WRC7z+SYjbQG2Wzg3Q0nX3aiFOW+SApQa+A8fRUwYuA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vr+7+7nN+SJNUk92Oe76GTnfxg+ARgafPWRaIImOau7qbXCEPUDFZDP4cvLStdOdb
	 Bs1DtQvznrzSHYPxUdumF3PinXB9c271288YF6wRLcdWHA09/rVp3qrZeK/9L0egsB
	 YJmywNM3K6Cu8rRXauzC6jgIEZQtSPinA8fM0+5s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B623F80165;
	Mon,  8 Feb 2021 12:12:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48DFCF80169; Mon,  8 Feb 2021 12:12:20 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE629F80114
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2021 12:12:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE629F80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fS/UPHbr"
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD26B64E30;
 Mon,  8 Feb 2021 11:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612782732;
 bh=WRC7z+SYjbQG2Wzg3Q0nX3aiFOW+SApQa+A8fRUwYuA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fS/UPHbrPQjgua4j6ySB/XZqmw0I6irzYDt6Z1NJceYSIqi0riQVVDfjkD7tp6iBQ
 3LRoLR1RCo/ydPwst/lPDKrzFRlCtyDCpqCyvpB91rZBqCG35vIKzK16pa4Neb3Nqo
 ISx77MQ3IQnwJqN7M/ANEmSCFI34wSkrRocAfSIBDNrGUkdGbZvySObBl/8OjewX+s
 FjIzOLX3FvtBqWUwdw9K/EULeOk63guWr0fzNf0S2VKCmif0hgYC1/NzVSN81lIBRD
 AJLkWaW6Y6o682xn6svY6jK00DUZEkdPGxKyswOoTEImJvB3kkGI5P7lqWdGjqu54A
 xk1DOiU+AMiXw==
Date: Mon, 8 Feb 2021 11:11:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v2 0/3] ALSA: hda: add link_power op to hdac_bus_ops
Message-ID: <20210208111120.GB8645@sirena.org.uk>
References: <20210205184630.1938761-1-kai.vehmanen@linux.intel.com>
 <s5hblcx1j09.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <s5hblcx1j09.wl-tiwai@suse.de>
X-Cookie: You will triumph over your enemy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 06, 2021 at 01:24:38PM +0100, Takashi Iwai wrote:
> Kai Vehmanen wrote:

> > Kai Vehmanen (3):
> >   ALSA: hda: add link_power op to hdac_bus_ops
> >   ASoC: SOF: Intel: hda: use hdac_ext fine-grained link management
> >   ASoC: SOF: Intel: hda: release display power at link_power

> The patch set looks good to me.  If Mark can give an ack, I'll merge
> them through my tree later.

Yeah, looks good to me too

Acked-by: Mark Brown <broonie@kernel.org>

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAhHFcACgkQJNaLcl1U
h9D/GQf+OoaWwg+t1EziTfCtNFWDaOHjxIp1juMD9ZwaSWAvqbc2P+i8UyIyHdE5
n8iZ9RCzuQ4A6o7S+TBTA5ARDcYi64qPmooxfiiQkv9/YsBJ2uRepI+bE1Pmbat5
FyLeWlmfhzvocB0F6Hk5OUWh+a8UcJKvwQ/2O6oCR72/+MqmYO2vSsqQHYLMYqWF
zzb0HfRiqAPqz+FoTm+ugpcKaHWh8mX+5JJHJU/h5Ep1Wsu9zjTr4G05ELm4mWEu
pzWcY6FZ/dU8BzI40MWs20Q++FRraownZzY/cEuG8B0poqjY/r5WODdof80Sj6UA
yfoFcud8lMrTXrdYK2y9U1yVjSynnA==
=DlY6
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
