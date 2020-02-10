Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B50AC352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:51:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA8920714
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cUMI7YaF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=serbinski.com header.i=@serbinski.com header.b="yFuXwYDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA8920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=serbinski.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3154B1607;
	Mon, 10 Feb 2020 15:50:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3154B1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581346283;
	bh=yP6Tti5bfmPoc6wLyccAwd/OQzA+Hh9syFSxEr3FhkM=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cUMI7YaFx9XMiBVovdveVMWvIa72dSDoE7phtMETFT11bILO0KjMvotGYgZPvqFg3
	 Si9lrxL0y+ueSaRcaAq3dkDeFYeYWTVhPqfRSR9JfzXd4baMop02aUsocUaw+4uwJM
	 iiUO/rwUu5vRqvOFWYYt5o+3Boihkd+9Td+l4bls=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A1A1DF80158;
	Mon, 10 Feb 2020 15:50:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08ABAF8019B; Mon, 10 Feb 2020 15:50:29 +0100 (CET)
Received: from mail.serbinski.com (mail.serbinski.com [162.218.126.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08A61F8014F
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 15:50:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08A61F8014F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=serbinski.com header.i=@serbinski.com
 header.b="yFuXwYDd"
Received: from localhost (unknown [127.0.0.1])
 by mail.serbinski.com (Postfix) with ESMTP id 06191D006F9;
 Mon, 10 Feb 2020 14:50:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at serbinski.com
Received: from mail.serbinski.com ([127.0.0.1])
 by localhost (mail.serbinski.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4SG34I_usFwg; Mon, 10 Feb 2020 09:50:17 -0500 (EST)
Received: from mail.serbinski.com (localhost [127.0.0.1])
 by mail.serbinski.com (Postfix) with ESMTP id 4D479D00693;
 Mon, 10 Feb 2020 09:50:17 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.serbinski.com 4D479D00693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serbinski.com;
 s=default; t=1581346217;
 bh=AM31Nu9OJOn3Ets32wl1am+N+bfHUPcUFazJCovf5Vw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=yFuXwYDdU7nP2Y6H636YQuCZ0iVIhRD8IXev+Cd1kaanj+pniISRIwhHjXMarSrpD
 NTzrKINGDWQ3cyAS2G04cXl/akvTvU2Sibu2lyJbBX/dB24cVSSV45r/XPm8ZBc69s
 i6Vw61cavVG6khsGcgUzp/2Jewf2eF7sj5HM5u4E=
MIME-Version: 1.0
Date: Mon, 10 Feb 2020 09:50:17 -0500
From: Adam Serbinski <adam@serbinski.com>
To: Mark Brown <broonie@kernel.org>
In-Reply-To: <20200210133143.GG7685@sirena.org.uk>
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200209154748.3015-1-adam@serbinski.com>
 <20200209154748.3015-3-adam@serbinski.com>
 <20200210133143.GG7685@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4-beta
Message-ID: <4df03448f7919187a8a056d3f10415ab@serbinski.com>
X-Sender: adam@serbinski.com
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v2 2/8] ASoC: qdsp6: q6afe: add support to
	pcm ports
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

On 2020-02-10 08:31, Mark Brown wrote:
> On Sun, Feb 09, 2020 at 10:47:42AM -0500, Adam Serbinski wrote:
> 
>> 
>> +#define AFE_API_VERSION_PCM_CONFIG	0x1
>> +/* Enumeration for the auxiliary PCM synchronization signal
>> + * provided by an external source.
>> + */
>> +
>> +#define AFE_PORT_PCM_SYNC_SRC_EXTERNAL 0x0
>> +/*	Enumeration for the auxiliary PCM synchronization signal
>> + * provided by an internal source.
>> + */
> 
> This is a *weird* commenting style for these #defines and it's not
> consistent within the block, I'm seeing at least 3 different styles.

I will clean up the commenting.


>> +	default:
>> +		break;
>> +	}
> 
> Why is this not returning an error on unsupported values?

Only to be consistent with the pre-existing implementation for i2s 
ports.
I will add an error return.

> 
>> +
>> +	switch (cfg->sample_rate) {
>> +	case 8000:
>> +		pcfg->pcm_cfg.frame_setting = AFE_PORT_PCM_BITS_PER_FRAME_128;
>> +		break;
>> +	case 16000:
>> +		pcfg->pcm_cfg.frame_setting = AFE_PORT_PCM_BITS_PER_FRAME_64;
>> +		break;
>> +	}
> 
> Same here.

I will also add the error return here.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
