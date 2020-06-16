Return-Path: <SRS0=xZai=75=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08515C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:07:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560E720C09
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aXbTnmF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560E720C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4BF49F6;
	Tue, 16 Jun 2020 19:06:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4BF49F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592327218;
	bh=PEiitzhkXvQRtpjJGcQJp4+7k8BfP7slpbKD6H8OR9c=;
	h=Subject:From:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aXbTnmF8rz3xm96ND3DkM/prifnWEPcKK76OWl180sy950m5fDMqO9eHQaclCVPuR
	 cU+pbah1GwSV4Rw4SfTsNV13MlspAdH9tGd0b+sqqYfV/r7kUaEv+13+PxgnWPCmXe
	 MZpfRWlTCLLJkGitfGFp5PD9zR5FvA9owy+d7bXc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 385F7F80114;
	Tue, 16 Jun 2020 19:06:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81B5DF8022B; Tue, 16 Jun 2020 19:06:05 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48C5BF80114
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 19:05:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48C5BF80114
IronPort-SDR: p2GAybJXAGVwTlWkwwOEJYKhKJLc81nk4NiCmAc4UhT74qVHN4a8khgSkb8qDMvBRQozNwdVk7
 Vv35IAMOlspg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2020 10:05:51 -0700
IronPort-SDR: jDFS05R8GHjHzmulgS0PjuD2McGa/nmsp1T7zm6zpt5+0G6/BOLaEQgQAsIZkaqCLXrtkkeeKy
 MetgQhNchXCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; d="scan'208";a="298980271"
Received: from nafrose-mobl.amr.corp.intel.com (HELO [10.254.107.226])
 ([10.254.107.226])
 by fmsmga004.fm.intel.com with ESMTP; 16 Jun 2020 10:05:50 -0700
Subject: Re: [PATCH 1/4] ASoC: soc-pcm: dpcm: fix playback/capture checks
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: Stephan Gerhold <stephan@gerhold.net>
References: <20200608194415.4663-1-pierre-louis.bossart@linux.intel.com>
 <20200608194415.4663-2-pierre-louis.bossart@linux.intel.com>
 <20200616085409.GA110999@gerhold.net> <20200616090210.GA111206@gerhold.net>
 <254a667e-fa49-240a-6386-7e82df8e5c35@linux.intel.com>
 <20200616145251.GO4447@sirena.org.uk>
 <af973f45-59b9-ecff-7d78-97d8352ed072@linux.intel.com>
 <20200616155544.GA8891@gerhold.net>
 <7cbc9233-e5f2-03e0-5659-cf22dea75e53@linux.intel.com>
Message-ID: <45d43cc9-be22-a7d2-1628-3fb30232bd7c@linux.intel.com>
Date: Tue, 16 Jun 2020 12:05:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7cbc9233-e5f2-03e0-5659-cf22dea75e53@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, tiwai@suse.de,
 Daniel Baluta <daniel.baluta@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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




>>> simple-card.c and audio-graph-card do hard-code but that's done with 
>>> C in
>>> the driver:
>>>
>>>     ret = asoc_simple_parse_daifmt(dev, cpu_ep, codec_ep,
>>>                        NULL, &dai_link->dai_fmt);
>>>     if (ret < 0)
>>>         goto out_put_node;
>>>
>>>     dai_link->dpcm_playback        = 1;
>>>     dai_link->dpcm_capture        = 1;
>>>
>>>
>>> that that should be fixed based on the DAI format used in that 
>>> dai_link - in
>>> other words we can make sure the capabilities of the dailink are aligned
>>> with the dais while parsing the DT blobs.
>>
>> But how do you know which capabilities to set? The device tree doesn't
>> tells us that. We could add some code to look up the snd_soc_dai_driver
>> early, based on the references in the device tree (basically something
>> like snd_soc_of_get_dai_name(), see
>>    
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/soc-core.c#n2988) 
>>
>>
>> At least to me that function doesn't exactly look trivial though,
>> and that's just to properly fill in the dpcm_playback/capture
>> parameters. Essentially those parameters only complicate the current
>> device tree use case,  where you want the DAI link to be for both
>> playback/capture, but restricted to the capabilities of the DAI.
>>
>> Just wondering if setting up dpcm_playback/capture properly is worth it
>> at all in this case. This isn't necessary for the non-DPCM case either,
>> there we automatically set it based on the DAI capabilities.
> 
> We can add a simple loop for each direction that relies on
> snd_soc_dai_stream_valid() to identify if each DAI is capable of doing 
> playback/capture.

see below completely untested diff to show what I had in mind: we 
already make use of snd_soc_dai_stream_valid() in other parts of the 
core so we should be able to determine dpcm_playback/capture based on 
the same information already used.

diff --git a/sound/soc/generic/audio-graph-card.c 
b/sound/soc/generic/audio-graph-card.c
index 9ad35d9940fe..4c67f1f65eb4 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -215,7 +215,9 @@ static int graph_dai_link_of_dpcm(struct 
asoc_simple_priv *priv,
         struct asoc_simple_dai *dai;
         struct snd_soc_dai_link_component *cpus = dai_link->cpus;
         struct snd_soc_dai_link_component *codecs = dai_link->codecs;
+       int stream;
         int ret;
+       int i;

         /* Do it all CPU endpoint, and 1st Codec endpoint */
         if (!li->cpu && dup_codec)
@@ -317,8 +319,34 @@ static int graph_dai_link_of_dpcm(struct 
asoc_simple_priv *priv,
         if (ret < 0)
                 goto out_put_node;

-       dai_link->dpcm_playback         = 1;
-       dai_link->dpcm_capture          = 1;
+       for_each_pcm_streams(stream) {
+               struct snd_soc_dai_link_component *cpu;
+               struct snd_soc_dai_link_component *codec;
+               struct snd_soc_dai *d;
+               bool dpcm_direction = true;
+
+               for_each_link_cpus(dai_link, i, cpu) {
+                       d = snd_soc_find_dai(cpu);
+                       if (!d || !snd_soc_dai_stream_valid(d, stream)) {
+                               dpcm_direction = false;
+                               break;
+                       }
+               }
+               for_each_link_codecs(dai_link, i, codec) {
+                       d = snd_soc_find_dai(codec);
+                       if (!d || !snd_soc_dai_stream_valid(d, stream)) {
+                               dpcm_direction = false;
+                               break;
+                       }
+               }
+               if (dpcm_direction) {
+                       if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+                               dai_link->dpcm_playback = 1;
+                       if (stream == SNDRV_PCM_STREAM_CAPTURE)
+                               dai_link->dpcm_capture = 1;
+               }
+       }
+
         dai_link->ops                   = &graph_ops;
         dai_link->init                  = asoc_simple_dai_init;


