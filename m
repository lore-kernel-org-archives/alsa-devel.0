Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D8EE8536F
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2026 14:05:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 37AEB601B5;
	Fri,  3 Apr 2026 16:05:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 37AEB601B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775225149;
	bh=WnsRcbM/sreWZdYlzzdKsB6ZuMxjAHje8UZ/F/ACPgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=H9H04ztnzKQQjTsxe3NiJ4I+7CaeqSvrrACn5IVzDqpxmE0KNMK12n1K4M2JqDmFT
	 oj5EJgonzarHiJuS8pVfk937rkurqGReBxqovJO9ud2J/1PWEZaNHus1PhoJHpNsK1
	 AKhuJYHB3ZhdrdKi9dU67SnKepDMVyfdilnjs49k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1272F805F4; Fri,  3 Apr 2026 16:05:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 66DCFF805EE;
	Fri,  3 Apr 2026 16:05:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E21AF8055B; Fri,  3 Apr 2026 16:05:05 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8318CF8003C
	for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2026 16:05:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8318CF8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=MlCSWYQY
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DC4C160121;
	Fri,  3 Apr 2026 14:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA5FC4CEF7;
	Fri,  3 Apr 2026 14:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775225099;
	bh=WnsRcbM/sreWZdYlzzdKsB6ZuMxjAHje8UZ/F/ACPgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlCSWYQYY9QIR0b0fCP6xMdJJfu5/VdTH7g2UP5iBanLt5fwna02v7DwwmLE+KlJB
	 OoYeDFcomg0jwbDBiDMA7U0WdJQ9ST/aYGrsC71aEGTA0S/lnlr324nbSj2o4bGEXp
	 UHPx8QlHZxydRWON2o6W+0mJLUbh7pzFL9Uf5YBeiWDHuvNkc6GKfSCBSpqAiKvvvv
	 mSj/Lg0xHi917vtbHdClpdOfILHYNDUfRaypOWN2u53cYgt1CTdD9EviNJxn5F4CU8
	 TszUrcxftrPZsXw9+gXxYzvWZ9Zr8cjXxYebcoEt1sRmNiXbcrlYx4joW1mV7DpTug
	 wVlaojl5FtqdA==
Date: Fri, 3 Apr 2026 15:04:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, tiwai@suse.de, 13916275206@139.com,
	krzk@kernel.org, alsa-devel@alsa-project.org, baojun.xu@ti.com
Subject: Re: [PATCH v1] ASoC: tas2781: Explicit association of Device, Device
 Name, and Device ID
Message-ID: <1ba70e84-49fb-4344-8280-9bf9899e46d7@sirena.org.uk>
References: <20260403054449.177-1-shenghao-ding@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bYrSaA0RwwDf3lrE"
Content-Disposition: inline
In-Reply-To: <20260403054449.177-1-shenghao-ding@ti.com>
X-Cookie: The Korean War must have been fun.
Message-ID-Hash: SC2XHSKKKSFLU7AYLYT6IRMOQFLIYQAF
X-Message-ID-Hash: SC2XHSKKKSFLU7AYLYT6IRMOQFLIYQAF
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SC2XHSKKKSFLU7AYLYT6IRMOQFLIYQAF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--bYrSaA0RwwDf3lrE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2026 at 01:44:49PM +0800, Shenghao Ding wrote:
> By correlating devices with their names and IDs, the driver becomes more
> discoverable.

This breaks an x86_64 allmodconfig build:

/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2088:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2088 |         { "TXNW2020", &tasdevice_id[TAS2020] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2088:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[0].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2089:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2089 |         { "TXNW2118", &tasdevice_id[TAS2118] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2089:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[1].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2090:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2090 |         { "TXNW2120", &tasdevice_id[TAS2120] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2090:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[2].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2091:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2091 |         { "TXNW2320", &tasdevice_id[TAS2320] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2091:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[3].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2092:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2092 |         { "TXNW2563", &tasdevice_id[TAS2563] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2092:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[4].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2093:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2093 |         { "TXNW2568", &tasdevice_id[TAS2568] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2093:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[5].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2094:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2094 |         { "TXNW2570", &tasdevice_id[TAS2570] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2094:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[6].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2095:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2095 |         { "TXNW2572", &tasdevice_id[TAS2572] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2095:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[7].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2096:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2096 |         { "TXNW2574", &tasdevice_id[TAS2574] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2096:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[8].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2097:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2097 |         { "TXNW2781", &tasdevice_id[TAS2781] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2097:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[9].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2098:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2098 |         { "TXNW5802", &tasdevice_id[TAS5802] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2098:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[10].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2099:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2099 |         { "TXNW806M", &tasdevice_id[TAS5806M] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2099:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[11].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2100:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2100 |         { "TXNW806D", &tasdevice_id[TAS5806MD] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2100:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[12].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2101:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2101 |         { "TXNW5815", &tasdevice_id[TAS5815] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2101:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[13].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2102:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2102 |         { "TXNW5822", &tasdevice_id[TAS5822] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2102:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[14].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2103:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2103 |         { "TXNW5825", &tasdevice_id[TAS5825] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2103:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[15].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2104:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2104 |         { "TXNW5827", &tasdevice_id[TAS5827] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2104:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[16].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2105:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2105 |         { "TXNW5828", &tasdevice_id[TAS5828] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2105:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[17].driver_data=E2=80=99)
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2106:23: error: initializ=
ation of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98const struct i2c=
_device_id *=E2=80=99 makes integer from pointer without a cast [-Wint-conv=
ersion]
 2106 |         { "TXNW5830", &tasdevice_id[TAS5830] },
      |                       ^
/build/stage/linux/sound/soc/codecs/tas2781-i2c.c:2106:23: note: (near init=
ialization for =E2=80=98tasdevice_acpi_match[18].driver_data=E2=80=99)

--bYrSaA0RwwDf3lrE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnPyQYACgkQJNaLcl1U
h9A+Zwf+Il2meUwPFKhNpiH2pJeaZ2OFqlVUsGBdu202vnVfiDGzAm8ypyo+OpPM
vHKliGz932UzwYr5a30Tqr2mh8upVvf8RUD1g7l56vLMRloS8Q+8JxA1iZb3KZi6
FKIemCwpxVm2iqXggpNQf+uhNBS80h3k+UYDMIiiizy4Wl2fqGG/WxFbMDJDhcYG
I1zrlVSoK8KK1WQFr4i/FB7r1nr68scyGDthALe8D2RRgaq9G+ZiqjBVftKvmrn5
94wPniCKMKVVr8dvNf4EyiinMGO/rweV/wu/0oHYXFCv1wfeh/g6JMgPPHBX7+ZE
i7zSMUGACbPMrYvrzApg54hu2u4o4w==
=Nyyb
-----END PGP SIGNATURE-----

--bYrSaA0RwwDf3lrE--
