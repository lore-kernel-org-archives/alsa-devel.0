Return-Path: <SRS0=IN0D=YE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E6FECE58C
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:03:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73CCD20640
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MlnvIyHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CCD20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52AFF1612;
	Fri, 11 Oct 2019 16:02:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52AFF1612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570802591;
	bh=mmpsrH95EV79FitU8cSk5pulZBFyIZisSVztcrDmgb8=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MlnvIyHqdj0FROYz37qSVaWBYB653kF+/vS9SnXe8DBheH0g4Tzb0SpBOIvhc1R5l
	 ylds4VWbbu8qhb5llqGejlbtJPTNqGqq0JxvFwtMtOhgJa3EDtEDE4qB1OC2gC6AQV
	 cmMiYrmWKppIMehuSUYdlaxlFi4zY344UUoRA9vU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96F87F802BD;
	Fri, 11 Oct 2019 16:02:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1904F802FB; Fri, 11 Oct 2019 16:02:18 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 878BBF80113
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2019 16:02:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 878BBF80113
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Oct 2019 07:02:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; d="scan'208";a="188326721"
Received: from hmmanuel-mobl.amr.corp.intel.com (HELO [10.254.42.220])
 ([10.254.42.220])
 by orsmga008.jf.intel.com with ESMTP; 11 Oct 2019 07:02:12 -0700
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <87sgo2ilso.wl-kuninori.morimoto.gx@renesas.com>
 <87mueailrn.wl-kuninori.morimoto.gx@renesas.com>
 <c594c9fd-1001-a50f-d6c2-06298a1c2110@linux.intel.com>
 <87r23kw02g.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ea00b4be-6adc-356d-68a7-14419fc8cb2c@linux.intel.com>
Date: Fri, 11 Oct 2019 08:38:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87r23kw02g.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 04/21] ASoC: soc-core: rename
 soc_init_dai_link() to soc_dai_link_sanity_check()
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



On 10/10/19 8:19 PM, Kuninori Morimoto wrote:
> 
> Hi Pierre-Louis
> 
>>> -	for_each_card_prelinks(card, i, dai_link) {
>>> -		ret = soc_init_dai_link(card, dai_link);
>>> -		if (ret) {
>>> -			dev_err(card->dev, "ASoC: failed to init link %s: %d\n",
>>> -				dai_link->name, ret);
>>> -			mutex_unlock(&client_mutex);
>>> -			return ret;
>>> -		}
>>> -	}
>>
>> This part is difficult to understand.
>>
>> There were two calls to soc_init_dai_link(), here and [2] below.
>> Your patch removes the first call and the for loop, is this
>> intentional and needed?
> 
> soc_init_dai_link() is just sanity_check now.
> In my understanding, it is needed before soc_bind_dai_link().
> 
> Current code is like below.
> (1) and (2) are for care prelink:ed dai_link.
> (A) and (B) are for topology added new dai_link.
> and
> (1) is for (2)
> (A) is for (B)
> 
> 	int snd_soc_instantiate_card()
> 	{
> 		for_each_card_prelinks(...) {
> (1)			ret = soc_init_dai_link(...);
> 			...
> 		}
> 		...
> 		for_each_card_prelinks(...) {
> (2)			ret = soc_bind_dai_link(...);
> 			...
> 		}
> 		...
> 		for_each_card_links(...) {
> 			...
> (A)			ret = soc_init_dai_link(...);
> 			...
> (B)			ret = soc_bind_dai_link(...);
> 		}
> 	}
> 
> It is very confusing/verbose code for me.
> It can be more simple if we can call soc_init_dai_link()
> from soc_bind_dai_link().

ok, the explanations help, maye you can add them to the commit message 
to help explain the intent, e.g.

  Current code is like below.
  (1) and (2) are for care prelink:ed dai_link.
  (A) and (B) are for topology added new dai_link.
  and
  (1) is for (2)
  (A) is for (B)


  		for_each_card_prelinks(...) {
  (2)		 	int snd_soc_instantiate_card()
  	{
  		for_each_card_prelinks(...) {
  (1)			ret = soc_init_dai_link(...);
  			...
  		}
  		...	ret = soc_bind_dai_link(...);
  			...
  		}
  		...
  		for_each_card_links(...) {
  			...
  (A)			ret = soc_init_dai_link(...);
  			...
  (B)			ret = soc_bind_dai_link(...);
  		}


and the new code keeps the same flow/steps but collapses the two calls 
into one

  		for_each_card_prelinks(...) {
  (2)		 	int snd_soc_instantiate_card()
  	{
  		for_each_card_prelinks(...) {
  (1)			ret = soc_bind_dai_link(...);
  			...
  		}
  		...
  		for_each_card_links(...) {
  			
(A) (B)			ret = soc_bind_dai_link(...);
  		}

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
