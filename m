Return-Path: <SRS0=xcY/=3T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7557DC33C9E
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:04:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3ED420702
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HG1rKoap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3ED420702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40485850;
	Thu, 30 Jan 2020 14:03:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40485850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580389468;
	bh=kyjVEKmh8PmRU2ar+UvPMFTeo0cXxJvKHJIBMIxilTs=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HG1rKoapqMN4mzl/TQiO+FqeNzo9eqM+bsyy19Xb51qxOBTKevTwDEbdAp8dG5Koj
	 KwfNbachAjTFe4aGd2zsaGg5FEaymsE2h/yLcCWBUaf96X5OJQLNygQVxVSIKUTiRu
	 gO/hCG3lK8W96vr/FbL2xepgfEEbDHpgQ1VzndZQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4813F800F1;
	Thu, 30 Jan 2020 14:03:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C7C6F8014B; Thu, 30 Jan 2020 14:03:36 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id A43BCF80082
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2020 14:03:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A43BCF80082
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B2EE328;
 Thu, 30 Jan 2020 05:03:30 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D4B73F68E;
 Thu, 30 Jan 2020 05:03:29 -0800 (PST)
Date: Thu, 30 Jan 2020 13:03:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
Message-ID: <20200130130328.GB6682@sirena.org.uk>
References: <20200129220726.31792-1-pierre-louis.bossart@linux.intel.com>
 <20200129220726.31792-6-pierre-louis.bossart@linux.intel.com>
 <2c982980-32f2-60a4-a384-7b767fafab66@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <2c982980-32f2-60a4-a384-7b767fafab66@linux.intel.com>
X-Cookie: Positively no smoking.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 5/9] ASoC: SOF: Move DSP power state
 transitions to platform-specific ops
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
Content-Type: multipart/mixed; boundary="===============5707361555911957989=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============5707361555911957989==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2020 at 08:47:28AM +0100, Amadeusz S=C5=82awi=C5=84ski wrot=
e:
>=20
>=20
> On 1/29/2020 11:07 PM, Pierre-Louis Bossart wrote:
> > From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> >=20
> > The DSP device substates such as D0I0/D0I3
> > are platform-specific. Therefore, the d0_substate
> > field of struct snd_sof_dev is replaced
> > with the dsp_power_state field which represents the current
> > state of the DSP. This field holds both the device state
> > and the platform-specific substate values.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4y1B8ACgkQJNaLcl1U
h9AVLQf/ShR1MsgXUkvCniEZrDGxaqeOM+B+1moj6Yq8qjUoVNq+dvYa2otESFR2
dPW+/cVWofS7I1QeGaPMmoninW3wDi5yg+yUU2Y5yCOxn7TTpORvax4VOK5mQYSd
MTpIYDT2dq+tduZljMO7JBuZBRNhF1Rk8eoW712ksRv7SW20kETfgD0mEbkfU/Wt
X0B8E8Fv+nNFcgR4oiURtHNCi/xud24m8xtV/M5F7zJwrkN5n3nGepz0IPkgZygL
WyH3Wyiog608Z7k4qUrLeEhNiSKaqQFI1GUMriZavNW4/XrD0QaiT2Dgv5MI4nVL
tkyMuTgQxX81CMk1UclAaMy2SNcmTQ==
=Bm+L
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--

--===============5707361555911957989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5707361555911957989==--
