Return-Path: <SRS0=PUtL=XN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99903C4CEC4
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:31:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20BF121924
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MEjwW7Am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BF121924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C67C1671;
	Wed, 18 Sep 2019 13:31:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C67C1671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568806316;
	bh=RwkZm3oSjn2vS12FQ8M5lE/BzallBvKiVPdFBfXDfCo=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MEjwW7AmnAaCZwO2noJF7dBfd/dFSogxWu5sAQh+2bfWH/i9N63uePacsVLFcN4Eh
	 BVotRO5iHD13YMl0aYMCi1jh70Yxqy5LtroOSZUsDBpjkZpuCgC5Bot7VNlZgHYExF
	 1pyOeAWK3xmBu5gnyr/Ar6It8rknEOfLslnMNCRo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC21EF804FF;
	Wed, 18 Sep 2019 13:31:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F9AAF80506; Wed, 18 Sep 2019 13:31:04 +0200 (CEST)
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6DF0F800C1
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2019 13:31:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6DF0F800C1
Received: from [78.40.148.177] (helo=localhost)
 by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
 id 1iAYAj-0000Uz-Rb; Wed, 18 Sep 2019 12:30:58 +0100
MIME-Version: 1.0
Date: Wed, 18 Sep 2019 12:30:57 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <d79b8148-797b-08b2-09e7-71c11d9acd53@nvidia.com>
References: <20190917181233.534-1-ben.dooks@codethink.co.uk>
 <20190917181233.534-7-ben.dooks@codethink.co.uk>
 <d79b8148-797b-08b2-09e7-71c11d9acd53@nvidia.com>
Message-ID: <75547a2534804b5992ba1bd3984c96a8@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
User-Agent: Roundcube Webmail/1.3.10
Cc: linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 linux-tegra@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 6/8] ASoC: tegra: set i2s_offset to 0 for
	tdm
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 2019-09-18 10:02, Jon Hunter wrote:
> On 17/09/2019 19:12, Ben Dooks wrote:
>> Set the offset to 0 for TDM mode, as per the current setup.
>> 
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>  sound/soc/tegra/tegra30_i2s.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/sound/soc/tegra/tegra30_i2s.c 
>> b/sound/soc/tegra/tegra30_i2s.c
>> index d75ce12fe177..3efef87ed8d8 100644
>> --- a/sound/soc/tegra/tegra30_i2s.c
>> +++ b/sound/soc/tegra/tegra30_i2s.c
>> @@ -206,8 +206,11 @@ static int tegra30_i2s_hw_params(struct 
>> snd_pcm_substream *substream,
>> 
>>  	i2s->soc_data->set_audio_cif(i2s->regmap, reg, &cif_conf);
>> 
>> -	val = (1 << TEGRA30_I2S_OFFSET_RX_DATA_OFFSET_SHIFT) |
>> -	      (1 << TEGRA30_I2S_OFFSET_TX_DATA_OFFSET_SHIFT);
>> +	if (i2s->is_tdm)
>> +		val = 0;
>> +	else
>> +		val = (1 << TEGRA30_I2S_OFFSET_RX_DATA_OFFSET_SHIFT) |
>> +		      (1 << TEGRA30_I2S_OFFSET_TX_DATA_OFFSET_SHIFT);
>>  	regmap_write(i2s->regmap, TEGRA30_I2S_OFFSET, val);
>> 
>>  	return 0;
> 
> Please move this code into tegra30_i2s_set_fmt() as it only needs to be
> set once.
> 
> BTW, if you refer to the following I2S driver for Tegra210, you will 
> see
> how I think that we should handle this ...

Ok, thanks.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
