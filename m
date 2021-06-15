Return-Path: <SRS0=yBFe=LJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB8BC48BDF
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 12:07:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE5361441
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 12:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE5361441
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EBF11676;
	Tue, 15 Jun 2021 14:06:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EBF11676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623758848;
	bh=fhDS/z4Zrcya8Fk8rpZowzYUOPJAu2JwmGFwld4+L1M=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vM9NWe3kwgyjPisyXirH/iMb/XRlhY8WWK57p7BrfD/cKyIo+9xz41Y5SrBG0OYqr
	 1PFTrzYHgzPJQE0ovgg0HAYWXRfAdmRoXtF/3LKVWoiO1V/nyN75xaCB9TjQRmv4Tw
	 d0na1aD5sUBafM2aKbgJGWPBO5CmocQBOwDL0Jt4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA7B6F80113;
	Tue, 15 Jun 2021 14:06:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6ECD7F80171; Tue, 15 Jun 2021 14:06:36 +0200 (CEST)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B5F8F8016C
 for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2021 14:06:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B5F8F8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de
 header.b="wePmA+OF"
Received: from [10.88.0.186]
 (dslb-084-062-104-230.084.062.pools.vodafone-ip.de [84.62.104.230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: ch@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 21FAD81249;
 Tue, 15 Jun 2021 14:06:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1623758791;
 bh=dWaYxNZ7Ro9xr/pNtB1Q08hiDs2nyh+0Dls0ENGlbRs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=wePmA+OF/i3IITNVBaahj2vBUdygQswycdQHdo6wNsv8QQZOdoVDbVNIIXS1IaTSp
 unfn5UOCllYXnrLUjilB5CUonIU5saosGc1hLsvxCnvUrbhG8R0sqd3qeV9a1XX2Xr
 kBvCYBvb8dESS22C4IRoBLQO/whP9JkvmnYvngCutMkgmECxP2qRqDTXa3VWiq/Y3x
 irnq3zwamU9psotPDU91/0s5/d5hjW42HQV51N9UpMGDwocKDP2xU7bS8RLAtXdHjl
 1tbiGHIvB2Xnvww7SPiP8DknBA1JvkO6ma04M1h7oaTpkfDSIwab41Dwkq/jvQ6YoB
 g3r1+yRIZZUng==
Subject: Re: [PATCH 1/3] ASoC: tlv320aic32x4: prepare driver for different
 device variants
To: Mark Brown <broonie@kernel.org>
References: <20210615094933.3076392-1-ch@denx.de>
 <20210615094933.3076392-2-ch@denx.de> <20210615115438.GD5149@sirena.org.uk>
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
Message-ID: <32b82dae-45ea-c6d4-77b7-c8a234cbf803@denx.de>
Date: Tue, 15 Jun 2021 14:06:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210615115438.GD5149@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Cc: Marek Vasut <marex@denx.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Sia Jee Heng <jee.heng.sia@intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Annaliese McDermond <nh6z@nh6z.net>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
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

Hi Mark,

On 2021-06-15 13:54, Mark Brown wrote:
> On Tue, Jun 15, 2021 at 11:49:30AM +0200, Claudius Heine wrote:
> 
>> With this change it will be possible to add different code paths for
>> similar devices.
> 
>>   static const struct i2c_device_id aic32x4_i2c_id[] = {
>> -	{ "tlv320aic32x4", 0 },
>> -	{ "tlv320aic32x6", 1 },
>> +	{ "tlv320aic32x4", (kernel_ulong_t)AIC32X4_TYPE_AIC32X4 },
>> +	{ "tlv320aic32x6", (kernel_ulong_t)AIC32X4_TYPE_AIC32X6 },
>>   	{ /* sentinel */ }
> 
> It appears that the device already supports multiple variants?

Those values aren't used anywhere as far as I can see.

regards,
Claudius
