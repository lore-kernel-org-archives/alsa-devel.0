Return-Path: <SRS0=g0zL=GL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F96BC433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jan 2021 10:56:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F2423977
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jan 2021 10:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F2423977
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E893168E;
	Fri,  8 Jan 2021 11:55:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E893168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610103368;
	bh=44OEuLq8rq8qx902zPtywsnxfjLSd17HpWJCsALsuoE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ee/qQiG8E4V39MelFoGXARIOUuclMjnKDDjC3C2fzq57wekq3u0yAGEI2sR3+A1lK
	 BHwqWQH2s7EQ9/+J4ImBPqXvteVmpLGTcLx2LY7fnNXWTZ1cwa7/+Ct1w5SVoOfLpE
	 vqpdf5atUEC/5LUX5gCwNjr8esD+VeNqb7vQ1S9k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96A81F80165;
	Fri,  8 Jan 2021 11:55:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C70ACF80166; Fri,  8 Jan 2021 11:55:14 +0100 (CET)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C98F2F800FD
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2021 11:55:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C98F2F800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="PrZgtF4c"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5ff83a020000>; Fri, 08 Jan 2021 02:54:58 -0800
Received: from [10.26.72.150] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 8 Jan
 2021 10:54:54 +0000
Subject: Re: [PATCH 2/2] ALSA: hda/tegra: fix tegra-hda on tegra30 soc
To: Sameer Pujar <spujar@nvidia.com>, Peter Geis <pgwipeout@gmail.com>
References: <20201225012025.507803-1-pgwipeout@gmail.com>
 <20201225012025.507803-3-pgwipeout@gmail.com>
 <0c3665b2-bac6-546a-bdd4-0ab7a90adf7c@nvidia.com>
 <CAMdYzYraT5AXzyscN3Pa+0FWZwHFsD-4ZwbA80kNxgtn7Y1PXw@mail.gmail.com>
 <b3a3ede2-22d5-b13d-f245-7c3b40ea411a@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a2c5c1d4-500b-6dad-d4ab-339154624c43@nvidia.com>
Date: Fri, 8 Jan 2021 10:54:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b3a3ede2-22d5-b13d-f245-7c3b40ea411a@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1610103298; bh=44OEuLq8rq8qx902zPtywsnxfjLSd17HpWJCsALsuoE=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=PrZgtF4czMmGEaFfElcaTYlFzdTHReGa9hnIzvZ3eZAR7j0wskwsHKRTYbeZMNOdU
 6wstL/b2qpFuk5ocXBxVPILLlkDz/9zTyV1FjEQytFxFVe5kUcu8vp4ulQzkZuRpUx
 8liMNrli47j4i75tU0A0VsimHVv3ErIRot9hGGr0kw4JKKDRGwmPcU4jVSBLnwCFph
 CXV3Ntda7tKqbvt0yV0cGlY7CceuxX3Kx8rr+dfmCkS8Euek4Y7t4fglOlZgh9Ys1u
 8rszZlujNE7Q6N17eNMKQo9omNXjC7ASaoR7mG+TefJHD+cOVqCxNwlhSLrhoq2MLa
 9Ld4KpiW5yC3Q==
Cc: alsa-devel@alsa-project.org, Prashant
 Gaikwad <pgaikwad@nvidia.com>, Mohan Kumar <mkumard@nvidia.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Thierry Reding <thierry.reding@gmail.com>,
 Ion Agorria <ion@agorria.com>, linux-tegra@vger.kernel.org,
 Peter De Schrijver <pdeschrijver@nvidia.com>
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


On 08/01/2021 08:00, Sameer Pujar wrote:

...

>>>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>>>> Tested-by: Ion Agorria <ion@agorria.com>
>>>> ---
>>>> =C2=A0=C2=A0 sound/pci/hda/hda_tegra.c | 3 +--
>>>> =C2=A0=C2=A0 1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
>>>> index 70164d1428d4..f8d61e677a09 100644
>>>> --- a/sound/pci/hda/hda_tegra.c
>>>> +++ b/sound/pci/hda/hda_tegra.c
>>>> @@ -388,8 +388,7 @@ static int hda_tegra_first_init(struct azx
>>>> *chip, struct platform_device *pdev)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * in powe=
rs of 2, next available ratio is 16 which can be
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * used as=
 a limiting factor here.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (of_device_is_compatible(np, =
"nvidia,tegra194-hda"))
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 chip->bus.core.sdo_limit =3D 16;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chip->bus.core.sdo_limit =3D 16;
>>> Future Tegra chips address this problem and hence cannot be enforced by
>>> default. May be we can have like below:
>>>
>>> if (of_device_is_compatible(np, "nvidia,tegra30-hda"))
>>> chip->bus.core.sdo_limit =3D 16;
>>>
>> It will need to be a bit more complicated than that, since the
>> tegra186 and tegra210 device trees have "nvidia,tegra30-hda" as a
>> fallback.
>> Looking at the generation map, tegra30-hda can be the fallback for the
>> broken implementation and tegra210-hda can be the fallback for the
>> working implementation.
>> Does that work for you?
>=20
> As per above explanation, it is fine to apply the workaround for
> Tegra210/186 as well. So it simplifies things for all existing chips.


FYI ... we now have minimal support for Tegra234 in upstream that should
not require this. Given that the Tegra234 device-tree does not include
support for HDA yet, I think it is fine to apply this as-is. However,
once we do add support for Tegra234 HDA, then we should ensure that this
is not applied. So that said ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

--=20
nvpublic
