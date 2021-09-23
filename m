Return-Path: <SRS0=SwAr=ON=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BECC4332F
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Sep 2021 13:01:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6794261216
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Sep 2021 13:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6794261216
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCFB8828;
	Thu, 23 Sep 2021 15:00:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCFB8828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632402090;
	bh=fGEoaDo7vw9f6+0xsvocoZKzu6a2InGqpKWGBhYmcbs=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JfYAfpMCPex5d783qLgHRRIMS3h6UIm91F7tzcool4HXbW9xytLg0aXo/K8lXJYfi
	 tnv9y9FIawMtp5XEDcS4N6zmsaQvbXrk8Dvg1FOGez1wSgEyhk5kctKpfNPftouFJB
	 wsIB0Z9bU1F4fJy03zYBZB58GEDjej6EdYDvYlnA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D424F8025F;
	Thu, 23 Sep 2021 15:00:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D65ECF80268; Thu, 23 Sep 2021 15:00:38 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB097F8013F
 for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2021 15:00:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB097F8013F
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="221946833"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="221946833"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 06:00:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="474841488"
Received: from mmocanu-mobl1.ger.corp.intel.com (HELO [10.249.36.33])
 ([10.249.36.33])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 06:00:27 -0700
Message-ID: <ab4ea50f-9149-3468-ce2b-7cd421095b40@linux.intel.com>
Date: Thu, 23 Sep 2021 16:00:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 10/12] ASoC: SOF: Intel: hda: make sure DAI widget is
 set up before IPC
Content-Language: en-US
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org
References: <20210917143659.401102-1-daniel.baluta@oss.nxp.com>
 <20210917143659.401102-11-daniel.baluta@oss.nxp.com>
 <203bf6cd-6407-f01d-52c3-e399d06cb3f6@linux.intel.com>
 <b90eff84-b56c-7764-a5bb-f1e07db57cc3@linux.intel.com>
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <b90eff84-b56c-7764-a5bb-f1e07db57cc3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 lgirdwood@gmail.com, daniel.baluta@nxp.com
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



On 23/09/2021 15:58, Pierre-Louis Bossart wrote:
> 
>>> +static struct sof_ipc_dai_config *hda_dai_update_config(struct snd_soc_dapm_widget *w,
>>> +							int channel)
>>>  {
>>> +	struct snd_sof_widget *swidget = w->dobj.private;
>>>  	struct sof_ipc_dai_config *config;
>>>  	struct snd_sof_dai *sof_dai;
>>> -	struct sof_ipc_reply reply;
>>> -	int ret = 0;
>>>  
>>> -	list_for_each_entry(sof_dai, &hda_stream->sdev->dai_list, list) {
>>> -		if (!sof_dai->cpu_dai_name)
>>> -			continue;
>>> +	if (!swidget) {
>>> +		dev_err(swidget->scomp->dev, "error: No private data for widget %s\n", w->name);
>>
>> NULL pointer dereference, just return NULL without the print. The caller
>> is printing anyways.
> 
> yes good catch, we need a v3 with the fixes suggested by Peter in
> https://github.com/thesofproject/linux/pull/3171/ applied.

Only the second patch in the PR is applicable for upstream, but it
should be squashed in for v3.

-- 
Péter
