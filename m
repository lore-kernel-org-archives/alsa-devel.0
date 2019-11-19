Return-Path: <SRS0=I/J9=ZL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0810C432C3
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:26:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B40222A9
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gEEZ9nzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B40222A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C935D1674;
	Tue, 19 Nov 2019 15:25:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C935D1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574173600;
	bh=FHtPkC/a5JMyGnuhsK4dbnEUfEkjJS0unN5eTMtbhmM=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gEEZ9nzy0QdG7/cu68dEtySfyp2avRPbOIOyU81Dh0U9TVtYPumNCdVsd57HOfCGe
	 cvKCUul0T24LHCw5GyVDBnnrAtD325q5etzJ0Yi9nIWZJtI3gnsb4Y2tfKNv01mnjr
	 +S1t3J2P6fm6txOx5yksy8W1RE6Wx7GFerL7iCmM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 349FFF80138;
	Tue, 19 Nov 2019 15:25:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6F13F800F4; Tue, 19 Nov 2019 15:25:48 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C105F800F4
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2019 15:25:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C105F800F4
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Nov 2019 06:25:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,324,1569308400"; d="scan'208";a="215551231"
Received: from trgallx-mobl.amr.corp.intel.com (HELO [10.251.154.79])
 ([10.251.154.79])
 by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2019 06:25:41 -0800
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <87r226x8aq.wl-kuninori.morimoto.gx@renesas.com>
 <33d0b023-1886-32fe-e04a-d87685068343@linux.intel.com>
 <87y2wc6584.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a63127e6-fbf1-af5e-d4f5-5b98c00040b5@linux.intel.com>
Date: Tue, 19 Nov 2019 07:37:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <87y2wc6584.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 0/2] ASoC: fixup topology dai_link remove
 issue
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



On 11/18/19 7:10 PM, Kuninori Morimoto wrote:
> 
> Hi Pierre-Louis
> 
>>> These are already tested by Intel CI, and all issues were solved.
>>> (https://github.com/thesofproject/linux/pull/1504)
>>> Extra Tested-by / Reviewed-by are very welcome from Intel
>>
>> if you don't mind I'd like to retest this new series, it's based on a
>> different tip and is not exactly the same as before.
> 
> Yes, of course.
> Sorry I didn't mention about it.
> 
>> -	/* free the ALSA card at first; this syncs with pending operations */
>> -	if (card->snd_card) {
>> -		snd_card_free(card->snd_card);
>> -		card->snd_card = NULL;
>> -	}
>> +	if (card->snd_card)
>> +		snd_card_disconnect_sync(card->snd_card);
>>
>>   	snd_soc_dapm_shutdown(card); <<< not tested yet.
>>
>>   	/* remove and free each DAI */
>>   	soc_remove_link_dais(card);
>> +	soc_remove_link_components(card);
> 
> Yes.
> It is from
> 
> 2a6f0892bda954dc2688b002060093ee0fe38528
> ("ASoC: soc-core: call snd_soc_dapm_shutdown() at soc_cleanup_card_resources()")

No regression detected so from the Intel side we're good with this patchset.
Thanks Morimoto-san for this comprehensive analysis, really nice work!

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
