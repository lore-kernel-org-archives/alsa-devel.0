Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0495BC11D2F
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:08:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823A520838
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pml8yZoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823A520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3E01166F;
	Mon, 24 Feb 2020 18:07:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3E01166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582564111;
	bh=sYQ+udyDfpCYQOde5eyNwJYZWDs2CE9nxqxpICnRaIo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pml8yZoQlXP0yn+INmTNIDdRXAn3teHv6YhEw4+sjfQn1ioim3fHRcmz7ujXeG+lu
	 5CQqhTyEor3gsq45cfkIlDQnVmu2GJDdAnWDpIEWUhRcg1O9aGceXwnpQy++cKKXyG
	 TNi0jjHd2zc8oMuh6l8T8Lc6gS+mr4D40Ck7lSzc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D677CF8025E;
	Mon, 24 Feb 2020 18:06:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB0C9F80213; Mon, 24 Feb 2020 18:06:00 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1222CF80137
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 18:05:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1222CF80137
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 09:05:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; d="scan'208";a="230713397"
Received: from rjgardn2-mobl1.amr.corp.intel.com (HELO [10.254.182.151])
 ([10.254.182.151])
 by orsmga008.jf.intel.com with ESMTP; 24 Feb 2020 09:05:54 -0800
Subject: Re: [PATCH] ASoC: soc-pcm: fix state tracking error in
 snd_soc_component_open/close()
To: Dmitry Osipenko <digetx@gmail.com>, Mark Brown <broonie@kernel.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20200220094955.16968-1-kai.vehmanen@linux.intel.com>
 <20200224120157.GF6215@sirena.org.uk>
 <a435d244-573a-4e57-362d-08b7e4a6d012@gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <59c8b078-f18f-1959-ccc7-b14674134daf@linux.intel.com>
Date: Mon, 24 Feb 2020 11:05:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a435d244-573a-4e57-362d-08b7e4a6d012@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, ranjani.sridharan@linux.intel.com,
 kuninori.morimoto.gx@renesas.com
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



On 2/24/20 9:47 AM, Dmitry Osipenko wrote:
> 24.02.2020 15:01, Mark Brown пишет:
>> On Thu, Feb 20, 2020 at 11:49:55AM +0200, Kai Vehmanen wrote:
>>> ASoC component open/close and snd_soc_component_module_get/put are called
>>> independently for each component-substream pair, so the logic added in
>>> commit dd03907bf129 ("ASoC: soc-pcm: call snd_soc_component_open/close()
>>> once") was not sufficient and led to PCM playback and module unload errors.
>>>
>>> Implement handling of failures directly in soc_pcm_components_open(),
>>> so that any successfully opened components are closed upon error with
>>> other components. This allows to clean up error handling in
>>> soc_pcm_open() without adding more state tracking.
>>
>> Do people have thoughts on this?  I do like this approach but can't
>> really test effectively myself.
>>
> 
> I haven't tried to review this patch, but it works fine on NVIDIA Tegra:
> 
> Tested-by: Dmitry Osipenko <digetx@gmail.com>

LGTM - I believe Kai tested for Intel platforms.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Note that the code could be simplified further with a 
for_each_rtd_components_rollback() macro, and we could also simplify the 
hw_free code below - the use of the 'last' pointer is not really 
necessary since we already have an index. That's for another cleanup though.

static int soc_pcm_components_hw_free(struct snd_pcm_substream *substream,
				      struct snd_soc_component *last)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct snd_soc_component *component;
	int i, r, ret = 0;

	for_each_rtd_components(rtd, i, component) {
		if (component == last)
			break;
