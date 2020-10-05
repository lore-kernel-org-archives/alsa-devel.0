Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD53C4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:27:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5466620637
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RgDKWX47";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKTs78TR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5466620637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B102B1790;
	Mon,  5 Oct 2020 17:26:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B102B1790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601911658;
	bh=1DFlxAOneU1Q7X7FCOfNZN0wL4ZzNAHWNDg5k6DPbvI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RgDKWX47k3RaOaIi5y2bEjwC6I2y7GiOTfI26lwKllL7pxpELhIZjgYNYnazC5Zn+
	 v+059+NrZn/ccHewQXFv0EiFiAsM1+hDNJzmZ0biuePl5TlG7kIuROok/gFN4Hb4n6
	 nPQTlTY0oS5PijeED5+Gh7zDJ/8aPNmFJ6Xlpjug=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F8E8F800C9;
	Mon,  5 Oct 2020 17:26:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1625F80269; Mon,  5 Oct 2020 17:26:46 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85AF4F800C9
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 17:26:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85AF4F800C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="LKTs78TR"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EF67920637;
 Mon,  5 Oct 2020 15:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601911594;
 bh=1DFlxAOneU1Q7X7FCOfNZN0wL4ZzNAHWNDg5k6DPbvI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LKTs78TRI/ttvaaeCdTLErmQurihH/lZPa2pf/cRUYJ/NoWFTXpoeqenTFihjHDjw
 cDcWWlcfcDiaXxdXS0+mmlbURBNIbho4R6fXjY6Wtgl2QcGyAKywRKhLJas6BExYVe
 13K6pesTw94jy7i2ZnJvW5SrtsyYgk+c6alMbo58=
Date: Mon, 5 Oct 2020 16:25:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH 1/1] ASoC: cs42l51: add soft dependency declaration
Message-ID: <20201005152531.GE5139@sirena.org.uk>
References: <20201002152904.16448-1-olivier.moysan@st.com>
 <20201002154107.GC5527@sirena.org.uk>
 <4e7fb9c0-84ea-ba01-cea8-8044d6ff60de@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Content-Disposition: inline
In-Reply-To: <4e7fb9c0-84ea-ba01-cea8-8044d6ff60de@st.com>
X-Cookie: Most of your faults are not your fault.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "arnaud.patard@rtp-net.org" <arnaud.patard@rtp-net.org>
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


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 03:01:23PM +0000, Olivier MOYSAN wrote:
> On 10/2/20 5:41 PM, Mark Brown wrote:
>=20
> On Fri, Oct 02, 2020 at 05:29:04PM +0200, Olivier Moysan wrote:
>=20
>=20
> When configured as module, CS42L51 codec driver uses two modules
> snd-soc-cs42l51 and snd-soc-cs42l51-i2c.
> Add soft dependency on snd-soc-cs42l51-i2c in snd-soc-cs42l51,
> to allow smart module dependency solving.

Please fix your mail client, the formatting is completely broken -
there's nothing distinguishing quoted and new text and you've got lines
well over 80 columns.

> Doesn't the userspace tooling usually manage to figure this out from
> symbol usage?

> cs42l51.c does not use symbols from cs42l51-i2c.c, so cs42l51-i2c does no=
t appear
> as a software dependency of cs42l51, for tools such as depmod.
> (cs42l51-i2c.c uses symbols from cs42l51.c,
> so there is a dependency in this way, but this does not help here)

But that's the dependency that exists and we want - the I2C driver is
what has the bus bindings in it and will be what we decide to load to
instantiate the device, that will then pull in the core code that it
needs.

> When enabling a sound card based on cs42l51, all required modules are loa=
ded automatically,
> excepted snd-soc-cs42l51-i2c module. This one has to be inserted explicit=
ely.

Whatever is going on here this patch is not addressing it.  Most likely
some ID tables are in the wrong file.

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl97OuoACgkQJNaLcl1U
h9C2zQf+I6U/7Ee6oL1ZwLeSOSKeU3K681e5iVm0pg2A50BBNhVRhyzrxhdUeHvs
zKwL+iBsoTqtW1U1iy8atRxhgWr37zShQox1w4JCpiNxN0SdqLdtACtaHM5V5/3O
YlbH254TyscAiUEKyU4cmx3ncjyZ660doyFbdXtRGP0yJCDdLqGfC0avHkhcuRi7
hNwpL+zleSMQ4K9hDh2AC2OD+XCeEJEaW707sSrBZVBk+ZeXT3sgIk8TaUOu+vMf
vxVrOdcxo5EEVE40ZcF3KM7mlgBZ47TKgdSTIXQ12HDTiykM0MORQcElsjudCnQ8
GzkgSwHvDBwdRjhQIDKZO3VJMoLqtw==
=A6ZW
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
