Return-Path: <SRS0=JTem=5M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481A3C2D0E5
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:43:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19DA206F2
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Vqqz4Hs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19DA206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F298166C;
	Fri, 27 Mar 2020 19:42:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F298166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585334593;
	bh=jRqYwa8WiY9pwq/ighDCB6+Bf2OvWGRXTQZeWeDn8UQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vqqz4Hs46bnzSxeTprwnSsdDGTahRMViuzL+YPwEeVztSmIYjT4jGpgoLzMtPvAZU
	 aFqRQ7AGjQrrqrxLxmqOe4aE4JKCF85rFkOWD6oFZRqNw2WwBFbxJxUa5+7Zkfk1ks
	 NXCjZQYOD4Q3bVrKBB1Docsw+0Qw1KYRlwJMb4w0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 784FCF802DB;
	Fri, 27 Mar 2020 19:38:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8978CF802C3; Fri, 27 Mar 2020 19:38:23 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB3D7F802C3
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 19:38:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB3D7F802C3
IronPort-SDR: YIrUrSWSwMmPiVuEjAa5X6Z5t0M2ySHqN7DZCgJ+kOGvp/WcYvfZmDJFzNnOXCZXNwk3aq02JW
 1vrIJuum4Vmw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 11:38:19 -0700
IronPort-SDR: C8nWv0BcPbGPL9xQmwc3Fd6K0d8Ve0/Ot3+5WPunwWP9JDyuK9CI6afQ8sx7mYNhnNjk3oKiCW
 CQ0B+rj+EUqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; d="scan'208";a="239174094"
Received: from mvargasp-mobl.amr.corp.intel.com (HELO [10.134.103.63])
 ([10.134.103.63])
 by fmsmga007.fm.intel.com with ESMTP; 27 Mar 2020 11:38:18 -0700
Subject: Re: [alsa-devel] [PATCH v3 5/8] ASoC: soc-pcm: call
 snd_soc_dai_startup()/shutdown() once
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <87d0anceze.wl-kuninori.morimoto.gx@renesas.com>
 <875zgfcey5.wl-kuninori.morimoto.gx@renesas.com>
 <54b81b41-f4cf-c28c-0ec5-363e2c62796b@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <df297c98-74a4-fe61-9c61-563a5bae2615@linux.intel.com>
Date: Fri, 27 Mar 2020 13:38:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <54b81b41-f4cf-c28c-0ec5-363e2c62796b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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


>>   static inline void *snd_soc_dai_get_dma_data(const struct 
>> snd_soc_dai *dai,
>> diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
>> index 51031e33..73a8293 100644
>> --- a/sound/soc/soc-dai.c
>> +++ b/sound/soc/soc-dai.c
>> @@ -295,17 +295,24 @@ int snd_soc_dai_startup(struct snd_soc_dai *dai,
>>   {
>>       int ret = 0;
>> -    if (dai->driver->ops->startup)
>> +    if (!dai->started &&
>> +        dai->driver->ops->startup)
>>           ret = dai->driver->ops->startup(substream, dai);
>> +    if (ret == 0)
>> +        dai->started = 1;
>> +
>>       return ret;
>>   }
> 
> Hi,
> 
> the above change breaks simultaneous playback and capture on single DAI 
> in more complicated use cases. With above change when one runs playback 
> first, startup callback is skipped when running capture while playback 
> is still running.

Should the 'started' bitfield should be an array for capture and 
playback cases respectively? e.g.

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 78bac995db15..d4825b82c7a3 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -351,7 +351,7 @@ struct snd_soc_dai {

         /* bit field */
         unsigned int probed:1;
-       unsigned int started:1;
+       unsigned int started[SNDRV_PCM_STREAM_LAST + 1];
  };

  static inline struct snd_soc_pcm_stream *
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 19142f6e533c..8f3cad8db89a 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -295,12 +295,12 @@ int snd_soc_dai_startup(struct snd_soc_dai *dai,
  {
         int ret = 0;

-       if (!dai->started &&
+       if (!dai->started[substream->stream] &&
             dai->driver->ops->startup)
                 ret = dai->driver->ops->startup(substream, dai);

         if (ret == 0)
-               dai->started = 1;
+               dai->started[substream->stream] = 1;

         return ret;
  }
@@ -308,11 +308,11 @@ int snd_soc_dai_startup(struct snd_soc_dai *dai,
  void snd_soc_dai_shutdown(struct snd_soc_dai *dai,
                          struct snd_pcm_substream *substream)
  {
-       if (dai->started &&
+       if (dai->started[substream->stream] &&
             dai->driver->ops->shutdown)
                 dai->driver->ops->shutdown(substream, dai);

-       dai->started = 0;
+       dai->started[substream->stream] = 0;
  }

  int snd_soc_dai_prepare(struct snd_soc_dai *dai,
