Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9B2C35671
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:02:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC03720828
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Wdv3DGYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC03720828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 349E71673;
	Mon, 24 Feb 2020 13:02:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 349E71673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582545776;
	bh=J+pbnicZ2KwaAGCE+UgX1IMO29EfZK6RTfNlcliW3nA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wdv3DGYiCioNY+yDDGJ3nmxZq0EmkrS2SVUExpW/IqdUR2fTElKHzgof08FnoP+Y+
	 Hx4C+amyPixV7eOVyx6lHRw+l1aHFnWcEOroLqnU6QwyR5k07YH7hyMpN69fNPx737
	 M9m6p9Hb+i+oJKkplCaQu0fbGPlazEOcJJjueCwc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B06AF8014D;
	Mon, 24 Feb 2020 13:02:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 538D0F8014E; Mon, 24 Feb 2020 13:02:04 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 65ACCF800C6
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 13:02:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65ACCF800C6
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5572A30E;
 Mon, 24 Feb 2020 04:01:59 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDA633F534;
 Mon, 24 Feb 2020 04:01:58 -0800 (PST)
Date: Mon, 24 Feb 2020 12:01:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ASoC: soc-pcm: fix state tracking error in
 snd_soc_component_open/close()
Message-ID: <20200224120157.GF6215@sirena.org.uk>
References: <20200220094955.16968-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline
In-Reply-To: <20200220094955.16968-1-kai.vehmanen@linux.intel.com>
X-Cookie: How you look depends on where you go.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, ranjani.sridharan@linux.intel.com,
 digetx@gmail.com, kuninori.morimoto.gx@renesas.com,
 pierre-louis.bossart@linux.intel.com
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


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2020 at 11:49:55AM +0200, Kai Vehmanen wrote:
> ASoC component open/close and snd_soc_component_module_get/put are called
> independently for each component-substream pair, so the logic added in
> commit dd03907bf129 ("ASoC: soc-pcm: call snd_soc_component_open/close()
> once") was not sufficient and led to PCM playback and module unload error=
s.
>=20
> Implement handling of failures directly in soc_pcm_components_open(),
> so that any successfully opened components are closed upon error with
> other components. This allows to clean up error handling in
> soc_pcm_open() without adding more state tracking.

Do people have thoughts on this?  I do like this approach but can't
really test effectively myself.

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5TuzQACgkQJNaLcl1U
h9A+tAf9EdkKSaPXcik+qhSQzku8/Iw24EHmoSW7PbcU6t/4tHHw9e1VNBntCmdm
Ob1GgBCECEE98u/Ih/twhEha5n2CLsbyg4OL1SqQoVgP8wiPwIMvzHgQDqYuUN1K
KU/hQh3+wTaq0+Q6i2bt4Cjv+giJJLgywTG4VDdvfe0eyY87QxsvAlqfCYYUOf2n
tIfWny1s2LmGVf/1X7rJQsaMw9tTaZkWbt1YAWe06bdlCDwUWvQWP9jVt3Au7+Vj
4uE3O1ZJLaqeeh0Rz2uDei+OOYtejrFiTsQUNKlq+YRiWOdKopGm/J6cQR8DXGwW
cPCXulxQr5zXX1eJ01OHhDl4EBCwIQ==
=XU7w
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
