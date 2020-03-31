Return-Path: <SRS0=BIX5=5Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9F9C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:53:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1A820848
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GAD4z6p2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1A820848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=flatmax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A038D86F;
	Tue, 31 Mar 2020 13:52:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A038D86F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585655602;
	bh=KNKWejapKLE0KFqV9Eo8yhrRafvvMtl1tvP0/l0z4i0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GAD4z6p2O4zl+3w8JqpHDqFWn+YbFTWVPGkz6I0S4blk8KD6O+oT/uebtg+OohrUr
	 NGJglnAguo7M2coIwiIEyZ1DqO+P7Z4og9eGAUySa/3rV/j8aSf849HhQwcIEzkv9a
	 e4LymSRfVN4jMZmRtAkQ6QUMdBZknEMIX5/sEhYQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C271F80140;
	Tue, 31 Mar 2020 13:52:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1BC82F80146; Tue, 31 Mar 2020 13:52:29 +0200 (CEST)
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51DEEF8010D
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2020 13:52:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51DEEF8010D
Received: from 41.68.233.220.static.exetel.com.au ([220.233.68.41]
 helo=[192.168.1.50])
 by mx.flatmax.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <flatmax@flatmax.org>)
 id 1jJFRJ-0004IL-Dp; Tue, 31 Mar 2020 22:52:17 +1100
Subject: Re: [PATCH] ASoC: snd_soc_dai_set_fmt add substream independence.
To: Mark Brown <broonie@kernel.org>
References: <20200328015831.6230-1-flatmax@flatmax.org>
 <20200330103213.GA4792@sirena.org.uk>
 <3c00bf93-04a8-04af-e0b5-d0f76f5dbb06@flatmax.org>
 <20200330163142.GI4792@sirena.org.uk>
 <98c3a94a-9020-9a34-7bdf-0ce504573f79@flatmax.org>
 <20200331111348.GA4802@sirena.org.uk>
From: Matt Flax <flatmax@flatmax.org>
Message-ID: <b09ca467-ac7a-d3b3-c76e-cd76aa70050d@flatmax.org>
Date: Tue, 31 Mar 2020 22:52:17 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331111348.GA4802@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com
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


On 31/3/20 10:13 pm, Mark Brown wrote:
> On Tue, Mar 31, 2020 at 06:40:26PM +1100, Matt Flax wrote:

>>> No, my advice is to go down that route if you are doing this.  I'm just
>>> not convinced that it's going to work reliably since this all sounds
>>> rather shaky.
>> OK - I can try to go down that route. However I would like to confirm that
>> having a codec to codec link doesn't require the original codec or CPU
>> drivers to have separate DAIs for playback and capture ? In my case both the
>> CPU and Codec drivers have single DAIs for both streams.
> OK, that probably won't help then :/


OK - well, the codec approach was worth a try. My concerns with the 
codec API is that it chews resources and clock cycles - if it is 
possible to work around it, then it is a good idea.

I feel that the best way to reduce resource consumption, complexity and 
overhead is to allow link formats to be defined based on the stream 
direction.

I can see why we would want different DAIs if the sample rate is 
asymmetric, however for word alignment perhaps we should let the stream 
direction seep into the snd_soc_dai opertions. These days CPU and Codec 
designers seem to treat both streams independently, which is why their 
registers can be independently configured.


thanks for the discussion

Matt

