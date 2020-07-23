Return-Path: <SRS0=vWr5=BC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C062C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:18:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8AB20888
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OHycVhj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8AB20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48440167B;
	Thu, 23 Jul 2020 15:17:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48440167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595510308;
	bh=lCadvjwPcne52rOQ9A8bjzSwjX8uW2CdrnY39smHQpI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OHycVhj3kDCKiMBSyfEpZ0CPsQts0g8Khw7s78feYKrcGDnMJZEcMLijayG07Mw+e
	 1Hn8HI29+0qMQvYNco627djrqOVuHhfdKlCzngDI1u2v+RU5Z77XPvPNHJNOyjjuh1
	 Uryzv3CGdqyUpa1pvUNetmhPSivtPryZndbvDwR0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3432F80212;
	Thu, 23 Jul 2020 15:17:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EDCD7F8024A; Thu, 23 Jul 2020 15:17:35 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26D3EF8011F
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2020 15:17:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26D3EF8011F
IronPort-SDR: NxMcJydoSG/JlxoLgMFvPYyWpGjSWTs755/UDp6qiqpjirpbK+TN+Ed1555Ug+191xx919gzYL
 yRFhS01xZXQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="130080613"
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; d="scan'208";a="130080613"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 06:17:25 -0700
IronPort-SDR: zbgCTcp4IHYwpFjzqAPenzobnSdjqR7FCNur+48Vt9nKvjlryi0J9tzZbQcNUZim/zBCp4RJGk
 PdPB2hRN0uxQ==
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; d="scan'208";a="284574257"
Received: from sxholi-mobl1.amr.corp.intel.com (HELO [10.254.76.108])
 ([10.254.76.108])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 06:17:24 -0700
Subject: Re: [RFC PATCH v2 2/6] ALSA: compress: add new ioctl for setting
 codec parameters
To: Vinod Koul <vkoul@kernel.org>
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
 <20200721170007.4554-3-srinivas.kandagatla@linaro.org>
 <ee2dc239-c1a7-f48f-c6f0-ec6e61ccdda6@linux.intel.com>
 <9bbfebf9-9a70-46e3-1808-413d04aa6b2c@linaro.org>
 <19cfe3fe-4b99-0976-679d-28523d7b9990@linux.intel.com>
 <20200723044734.GU12965@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8afd732a-750f-08d6-87a0-3088b4957f82@linux.intel.com>
Date: Thu, 23 Jul 2020 08:17:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723044734.GU12965@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, tiwai@suse.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, broonie@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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



On 7/22/20 11:47 PM, Vinod Koul wrote:
> On 22-07-20, 10:36, Pierre-Louis Bossart wrote:
>>
>>>>>     * and the stream properties
>>>>> + * @set_codec_params: Sets the compressed stream codec
>>>>> parameters, Optional
>>>>> + * This can be called in during gapless next track codec change
>>>>> only to set
>>>>> + * codec params
>>>>
>>>> Would it be clearer if this was called set_next_codec_params()? or
>>>> set_next_track_codec_params()?
>>>>
>>>> Having set_params() and set_codec_params() is a bit confusing since
>>>> the semantic difference is not captured in the callback name.
>>>
>>> set_next_track_codec_params seems more sensible as its next track params.
>>> Will change this in next version!
>>
>> maybe set_params() and set_next_track_params() are enough, not sure if the
>> codec reference helps?
> 
> params typically refers to whole set of compress parameters which
> includes buffer information and codec parameters, so codec reference
> would help.

then add the codec reference to both...
