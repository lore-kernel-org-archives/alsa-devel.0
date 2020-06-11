Return-Path: <SRS0=5dB9=7Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB20C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:00:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE69520656
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C0eJRTtQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PImN5EiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE69520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 842591672;
	Thu, 11 Jun 2020 10:59:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 842591672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591866017;
	bh=9zIlWq64zwy2tX0UbIM1FVGchq+4Q7MZrcRTvuYjx3Y=;
	h=Subject:From:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C0eJRTtQ58iQP0+v/ZEM8wM5NwJMoi5eFsePCyh2fN7swGTQSTreVSC26guxRAvUK
	 C6aN0EYQEaqKUevtzYe4UhBG7MbYXcinH/cLYfCa3VCt1z9WTS5+/tD3AmFOcUSHhN
	 A409R0JN9SmVQeKHF9nsVTTu2QrHsM8kRpn6Iu+4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10745F80149;
	Thu, 11 Jun 2020 10:59:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A4CC5F8028C; Thu, 11 Jun 2020 10:59:22 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D32DEF80149
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2020 10:59:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D32DEF80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PImN5EiS"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05B8xEnp035483;
 Thu, 11 Jun 2020 03:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1591865954;
 bh=ju8hW0Nntm6A5rQpyFzj3Zxbk+KibA3tjgt8DFUshd4=;
 h=Subject:From:To:CC:References:Date:In-Reply-To;
 b=PImN5EiSFTZOvESIUfpol30U/CYqfsys/aHI6yzjQ8UAehvHR7r28eRdUJ7cgtY5F
 a7no8HU0cjyqCB7E8lUoLBfELJZb7Ao2oIVOLFu89b039R60CWeg8KFhR2qfNZsJSV
 JLqiA5vhospRqrOJc0P1r1qp0PN8Fa+OPflNscY4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05B8xEkq085761
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 11 Jun 2020 03:59:14 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 11
 Jun 2020 03:59:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 11 Jun 2020 03:59:14 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05B8xCH1118378;
 Thu, 11 Jun 2020 03:59:13 -0500
Subject: Re: [PATCH v2 2/3] bindings: sound: Add documentation for TI j721e
 EVM (CPB and IVI)
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: Rob Herring <robh@kernel.org>
References: <20200512131633.32668-1-peter.ujfalusi@ti.com>
 <20200512131633.32668-3-peter.ujfalusi@ti.com>
 <20200519222132.GA488519@bogus> <65631db2-5cb2-003a-0526-65d26372616b@ti.com>
X-Pep-Version: 2.0
Message-ID: <c91d150c-ddcc-214b-0e7d-ee2318be5269@ti.com>
Date: Thu, 11 Jun 2020 11:59:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <65631db2-5cb2-003a-0526-65d26372616b@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org
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

Hi Rob,

On 20/05/2020 14.50, Peter Ujfalusi wrote:
>>> +  clocks:
>>> +    items:
>>> +      - description: PLL4 clock
>>> +      - description: PLL15 clock
>>> +      - description: McASP10 auxclk clock
>>> +      - description: PLL4_HSDIV0 parent for McASP10 auxclk (for 48KH=
z)
>>> +      - description: PLL15_HSDIV0 parent for McASP10 auxclk (for 44.=
1KHz)
>>> +      - description: AUDIO_REFCLK2 clock
>>> +      - description: PLL4_HSDIV2 parent for AUDIO_REFCLK2 clock (for=
 48KHz)
>>> +      - description: PLL15_HSDIV2 parent for AUDIO_REFCLK2 clock (fo=
r 44.1KHz)
>>
>> What h/w are these connected to?
>=20
> These clocks are internal to the SoC with the exception of AUDIO_REFCLK=
2
> which is routed to SoC pin.
>=20
>> You have no control interface here, so how do you have clocks?
>=20
> I need to control these clocks, the sound card is the user of these clo=
cks.
>=20
>> Defining parent clocks seems wrong, too. This seems to just be a=20
>> collection of clocks a driver happens to need. Really, you should be=20
>> able query possible parents and select one with the right frequency=20
>> multiple.
>=20
> The issue in hand is that I need to dynamically switch between certain
> parents of the cpb-mcasp (for McASP) and audio-refclk2 (for the codec)
> based on sampling rate of the stream.
>=20
> The McASP auxclk parent can be selected from 7 source and I must use th=
e
> two dedicated ones.
> The REFCLK2 parent can be selected from 30 source.
>=20
> It is also a limitation of the system that I can not query directly the=

> PLL4/PLL15 frequencies, I can only get the frequency on the HSDIVs, but=

> I can not get the divider on them.
> In order to handle the constraints on clocking I need to know the sourc=
e
> rate so the dividers can be taken into account. The codec is picky when=

> it comes to clocking and there is a need to switch between
> 256/512/768xFS based SCKI in order to be able to support sampling rates=
=2E
>=20
> At the moment I have fixed clocks in place for the pll4/15 with the
> rates they are configured so the dts can switch to a real clock which I=

> can use in the future.
> As things are it is unlikely that I will ever going to have access to
> them, but I wanted to avoid in the bindings:
> ti,j721e-pll4-rate =3D <1179648000>;
> ti,j721e-pll15-rate =3D <1083801600>;
>=20
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: pll4
>>> +      - const: pll15
>>> +      - const: cpb-mcasp
>>> +      - const: cpb-mcasp-48000
>>> +      - const: cpb-mcasp-44100
>>> +      - const: audio-refclk2
>>> +      - const: audio-refclk2-48000
>>> +      - const: audio-refclk2-44100

It should be better to document the refclk2 (and refclk0 for IVI) clocks
based on it's use, not source:
cpb-codec-scki (sourced from audio_refclk2)
cpb-codec-scki-48000/44100

For the IVI binding it is just s/cpb/ivi in the clock-names.

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

