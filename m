Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FD9C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Mar 2022 13:58:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63E89166F;
	Fri, 25 Mar 2022 14:57:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63E89166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648216685;
	bh=Yok8IySePES7GFEb7QlYbVFKQbSvbM5xHMo/W3KrAq8=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZXKLpXR2KTT8AYs9qScudBy+NnxiPG5EKaduhE3ODZAZIB2eEQmw1W86cC7o/lH+o
	 0UIMkiR9pAhSSd+QNc75DxHLgoQEjflo/K0oQgtNGoXaxpoSwHPsTt26cP1o7BkJas
	 OLmRjKJ/94f+6JJ6DPAPpbynd90gxKzL6loDBBaQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2731F800F4;
	Fri, 25 Mar 2022 14:57:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22D32F80115; Fri, 25 Mar 2022 14:57:13 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15927F80115
 for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2022 14:56:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15927F80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="cDEsB6HT"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: adalessandro) with ESMTPSA id 7BF251F462D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1648216618;
 bh=Yok8IySePES7GFEb7QlYbVFKQbSvbM5xHMo/W3KrAq8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cDEsB6HTdtC52vnOaCKRXIafRpo7nxqy/2Oa0yrR4JXs9qtk/T8396sW+rAyfBxaw
 mYwB3sGaJfCApzeUrgW+8vTivI92GxysMcYC2LPSzev7/rZ3phzhXe9lPSnx+gGMOu
 cbnpJa+lUFw+4qyK4J52LCBcv6MohniLreUx2pqmESFXAPALS/yWqhMMsllKYUD/js
 uECfcs9tGxleYYheriFqEFGDh9npoooDm1o4YPNZ2SSEOu5y/KCgzuhuxvdcqxeJvx
 zBFDoD77T8V4WLbIoCtGJLzwmMOihpzQTkpKe0EMfBJOuSLdTpzu1uepku7r6jRACp
 p/ZMZUIeXu6zw==
Message-ID: <d9f14221-b0ad-9853-e9c8-a35d9111549b@collabora.com>
Date: Fri, 25 Mar 2022 10:56:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4] arm64: dts: imx8mn-bsh-smm-s2pro: Add tlv320aic31xx
 audio card node
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
References: <20220323135601.42435-1-ariel.dalessandro@collabora.com>
 <CAOMZO5D4_WboF4S0dgSLD1m15a13c2irK2yjDV4C77_Wb15=2w@mail.gmail.com>
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <CAOMZO5D4_WboF4S0dgSLD1m15a13c2irK2yjDV4C77_Wb15=2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

Hi Fabio,

On 3/25/22 10:49, Fabio Estevam wrote:
> On Wed, Mar 23, 2022 at 10:56 AM Ariel D'Alessandro
> <ariel.dalessandro@collabora.com> wrote:
>>
>> BSH SystemMaster (SMM) S2 PRO board comes with an audio card based on
>> tlv320aic31xx family codec.
>>
>> The audio card exposes two playback devices, one of them using the EASRC
>> (Enhanced Asynchronous Sample Rate Converter) module. Note that this
>> would require SDMA and EASRC firmware in order to work.
>>
>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>> ---
> 
> What are the changes in v4?

* Fixed the sound-tlv320aic31xx audio-codec property to point to the
right codec node <&tlv320dac3101>

* Reordered properties in tlv320dac3101, and removed clock-names property.

> 
> I see you removed 'clock-names' so this looks good:

Indeed.

> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks!
