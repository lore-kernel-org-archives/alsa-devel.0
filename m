Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BBBC47423
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 19:46:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD5D208A9
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 19:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="htOlgzDA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VnZsQ/Dt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD5D208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2EDE51920;
	Thu,  1 Oct 2020 21:45:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2EDE51920
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601581559;
	bh=+NitnAdq0/yPc5LB6iSNaJmRuBDydk3Liz3LI4QXm5w=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=htOlgzDAvmFGasDlp4lD08ELrnBmnmP9Htkv9XSlPYOUILNhHLxcTCRR9Rk8Ftwty
	 afcO0vjwKFDiyRCMTa5SOtmAArsjH5jTckCzsHwR2FR8mvIXSVmc3HH7mvKekUtJm3
	 TOjQ1VoWmnTbGkT5Er8gjOc7xr13VfYdCodB4kTM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F756F801DB;
	Thu,  1 Oct 2020 21:45:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF908F801F5; Thu,  1 Oct 2020 21:45:06 +0200 (CEST)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41BD7F800AB
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 21:44:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41BD7F800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="VnZsQ/Dt"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f7631ab0001>; Thu, 01 Oct 2020 12:44:43 -0700
Received: from [10.26.45.122] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 1 Oct
 2020 19:44:47 +0000
Subject: Re: [PATCH v3 10/13] ASoC: tegra: Add audio graph based card driver
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, "Sameer
 Pujar" <spujar@nvidia.com>
References: <1601573587-15288-1-git-send-email-spujar@nvidia.com>
 <1601573587-15288-11-git-send-email-spujar@nvidia.com>
 <20201001190733.GD23339@qmqm.qmqm.pl>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <85fe1be4-7b67-da99-06a5-28089f662a1d@nvidia.com>
Date: Thu, 1 Oct 2020 20:44:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001190733.GD23339@qmqm.qmqm.pl>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1601581483; bh=SzR9+Kg5ALQEhT+jW9ABsLDoFclETsOIFF0nIoKFTsA=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=VnZsQ/DtIwGXa9gGozOJfBdr/CWcgyy5AB1KaSPWc6HwRB/SLJvflJHSIqwv9WeLD
 DSm4YmBMmwFzpkqawyiIW8cTP8upzOJsLvd3GcOE+kI6+MEzAVNL9EuDX7ysk1qla2
 T/xWi2lo63yvxPkwDRSlnNV+xiykixQD62CYiG5LaQnzwzIuShDTylG/ciZZqbFPzG
 nwZuFqNQQzZV40S1nILc37TJJpze9P7fAyI8vjEbHf1y8onAKOY/OcCbIw46p+kIMR
 KaGuBnlzYFcZivHzgfCEhY4JYfXnv7sb5JszTw7DsgfQpwbTDIDxFlzRd7Xcdu4H0W
 /bK8u789odIBg==
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 atalambedu@nvidia.com, swarren@nvidia.com, kuninori.morimoto.gx@renesas.com,
 devicetree@vger.kernel.org, nicoleotsuka@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
 robh+dt@kernel.org, viswanathl@nvidia.com, sharadg@nvidia.com,
 broonie@kernel.org, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 nwartikar@nvidia.com, rlokhande@nvidia.com, mkumard@nvidia.com,
 dramesh@nvidia.com
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


On 01/10/2020 20:07, Micha=B3 Miros=B3aw wrote:
> On Thu, Oct 01, 2020 at 11:03:04PM +0530, Sameer Pujar wrote:
>> Add Tegra audio machine driver which is based on generic audio graph car=
d
>> driver. It re-uses most of the common stuff from audio graph driver and
>> uses the same DT binding. Required Tegra specific customizations are don=
e
>> in the driver.
> [...]
>> +	switch (srate) {
>> +	case 11025:
>> +	case 22050:
>> +	case 44100:
>> +	case 88200:
>> +	case 176400:
>> +		plla_out0_rate =3D chip_data->plla_out0_rates[x11_RATE];
>> +		plla_rate =3D chip_data->plla_rates[x11_RATE];
>> +		break;
>> +	case 8000:
>> +	case 16000:
>> +	case 32000:
>> +	case 48000:
>> +	case 96000:
>> +	case 192000:
> [...]
>=20
> Do you really need to enumerate the frequencies? Wouldn't just checking
> srate % 11025 be enough to divide the set in two? Or just calculating
> the PLLA base rate by multiplying?


This is quite common among other ASoC drivers from what I can see. The
PLL rate does not scale with the srate, we just use a different PLL rate
depending on if the srate is 11025 Hz or 8000 Hz based. I don't see any
need to change the above.

Cheers
Jon

--=20
nvpublic
