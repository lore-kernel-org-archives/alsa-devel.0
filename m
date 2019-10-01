Return-Path: <SRS0=w4sP=X2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDEFC388F3
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 11:01:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79732190F
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 11:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qBxZf4Iw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79732190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59D4A166E;
	Tue,  1 Oct 2019 13:00:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59D4A166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569927692;
	bh=3+1VS7jVH8pR9BWCQJwlgCHuSFFfuA+boKw0fcuAsW0=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qBxZf4IwH4DnSvc3YnWOsodE6kMtjrE/C19SeT1EVAlDHjVfrfWqr5ZjPPiyouj8s
	 DUdP8TC07WS2VETws96bNF/fVHslpLGfSpyN89jduQLfeJqJn816Bta/A/YE43P0ed
	 sYyYM/InI47HrU7L7T0HNE7rkqEaFBJAI3N1F4go=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CC47CF804FF;
	Tue,  1 Oct 2019 13:00:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34708F80506; Tue,  1 Oct 2019 13:00:40 +0200 (CEST)
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73224F800DE
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2019 13:00:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73224F800DE
Received: from [167.98.27.226] (helo=[10.35.6.110])
 by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
 id 1iFFsz-0006lc-BL; Tue, 01 Oct 2019 12:00:05 +0100
To: Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
References: <20190930165130.10642-1-ben.dooks@codethink.co.uk>
 <20190930165130.10642-2-ben.dooks@codethink.co.uk>
 <c2a7c046-011e-437b-0f09-0853d5cf7f34@nvidia.com>
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <85bb5ec6-8928-e4ea-8ca5-3ce1afcc4324@codethink.co.uk>
Date: Tue, 1 Oct 2019 12:00:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c2a7c046-011e-437b-0f09-0853d5cf7f34@nvidia.com>
Content-Language: en-GB
Cc: linux-kernel@lists.codethink.co.uk,
 Edward Cragg <edward.cragg@codethink.co.uk>
Subject: Re: [alsa-devel] [PATCH v3 1/7] ASoC: tegra: add a TDM
	configuration callback
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

On 30/09/2019 21:46, Jon Hunter wrote:
> 
> On 30/09/2019 17:51, Ben Dooks wrote:
>> From: Edward Cragg <edward.cragg@codethink.co.uk>
>>
>> Add a callback to configure TDM settings for the Tegra30 I2S ASoC 'platform'
>> driver.
>>
>> Signed-off-by: Edward Cragg <edward.cragg@codethink.co.uk>
>> [ben.dooks@codethink.co.uk: merge fix for power management]
>> [ben.dooks@codethink.co.uk: add review change for fsync of 1 clock]
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>   sound/soc/tegra/tegra30_i2s.c | 33 +++++++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
>> index ac6983c6bd72..7f9ef6abeae2 100644
>> --- a/sound/soc/tegra/tegra30_i2s.c
>> +++ b/sound/soc/tegra/tegra30_i2s.c
>> @@ -254,6 +254,38 @@ static int tegra30_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
>>   	return 0;
>>   }
>>   
>> +/*
>> + * Set up TDM
>> + */
>> +static int tegra30_i2s_set_tdm(struct snd_soc_dai *dai,
>> +			       unsigned int tx_mask, unsigned int rx_mask,
>> +			       int slots, int slot_width)
>> +{
>> +	struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>> +	unsigned int mask, val;
>> +
>> +	dev_dbg(dai->dev, "%s: txmask=0x%08x rxmask=0x%08x slots=%d width=%d\n",
>> +		 __func__, tx_mask, rx_mask, slots, slot_width);
>> +
>> +	/* Set up slots and tx/rx masks */
>> +	mask = TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_MASK |
>> +	       TEGRA30_I2S_SLOT_CTRL_RX_SLOT_ENABLES_MASK |
>> +	       TEGRA30_I2S_SLOT_CTRL_TX_SLOT_ENABLES_MASK;
>> +
>> +	val = (tx_mask << TEGRA30_I2S_SLOT_CTRL_TX_SLOT_ENABLES_SHIFT) |
>> +	      (rx_mask << TEGRA30_I2S_SLOT_CTRL_RX_SLOT_ENABLES_SHIFT) |
>> +	      ((slots - 1) << TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_SHIFT);
> 
> I am not sure why this keeps changing. Why not set to 1 always?

This is the total number of slots, not the width of the fsync
which has been changed to 1 below this.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
