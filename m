Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFD5C2BB1D
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:12:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B759720663
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FVsVebr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B759720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0583616EF;
	Thu, 12 Mar 2020 15:11:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0583616EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584022337;
	bh=N26/s8Ni7HcFE3AqigG1T56Xrf4Zkb8Fen0sqN+x8UM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FVsVebr2TogsFJxw1YVf/FWALX97T7a20cHA3LgkB6tL4bcBEkqOoW4fbNoqAWcZw
	 MeFXOyCI7ebVXBxG+9f0PEm9fahz1h0wFhktsj2ToLF6eRE6Ke2Dpw1tKhzUCN71wo
	 V24KadlGH2sjGjMKvj0xeprdo8CcRctCfs2p3g2Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 714E6F80086;
	Thu, 12 Mar 2020 15:11:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E23F8F8020C; Thu, 12 Mar 2020 15:11:24 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 709FBF80086
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2020 15:11:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 709FBF80086
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 07:11:15 -0700
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; d="scan'208";a="232064841"
Received: from aslawinx-mobl1.ger.corp.intel.com (HELO [10.249.153.159])
 ([10.249.153.159])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 12 Mar 2020 07:11:13 -0700
Subject: Re: [PATCH] ASoC: topology: Perform component check upfront
To: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
References: <20200312122239.14489-1-amadeuszx.slawinski@linux.intel.com>
 <CAFQqKeUOQ5EU57SvEpzkSJ=khsRZ=E-WqarFoq2xpoycmhHqeA@mail.gmail.com>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Message-ID: <9f821557-dd15-638f-02bf-5d3abc37e5ca@linux.intel.com>
Date: Thu, 12 Mar 2020 15:11:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFQqKeUOQ5EU57SvEpzkSJ=khsRZ=E-WqarFoq2xpoycmhHqeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
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



On 3/12/2020 2:57 PM, Sridharan, Ranjani wrote:
> On Thu, Mar 12, 2020 at 3:14 AM Amadeusz Sławiński <
> amadeuszx.slawinski@linux.intel.com> wrote:
> 
>> Function soc_tplg_dbytes_create(), calls soc_tplg_init_kcontrol() to
>> perform additional driver specific initialization. While
>> soc_tplg_init_kcontrol() ensures that component is valid before invoking
>> ops->control_load, there is no such check at the end of
>> soc_tplg_dbytes_create() where list_add() is used.
>>
>> Also in quite a few places, there is reference of tplg->comp->dapm or
>> tplg->comp->card, without any checks for tplg->comp.
>>
>> In consequence of the above this may lead to referencing NULL pointer.
>>
>> This allows for removal of now unnecessary checks.
>>
>> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>> ---

(...)

>> @@ -2736,6 +2736,10 @@ int snd_soc_tplg_component_load(struct
>> snd_soc_component *comp,
>>          struct soc_tplg tplg;
>>          int ret;
>>
>> +       /* component needs to exist to keep and reference data while
>> parsing */
>> +       if (!comp)
>> +               return -EINVAL;
>> +
> 
> Amadeusz,
> 
> Thanks for this change. I agree that the checks for tplg->comp in the above
> functions should be removed but is the check here really necessary at all?
> snd_soc_tplg_component_load() is typically called when a component is
> probed. Can it ever be null at all if it is getting probed?
> 
> Thanks,
> Ranjani
> 
Well it can happen if you pass it wrong pointer for some reason (don't 
ask :P), I think it's better to have check than none at all.
If you pass it NULL pointer to component it can parse part of a file and 
then suddenly give you NULL pointer dereference in some seemingly 
"random" function. I would say it's easier for programmer to understand 
what happens and use such functionality if it performs such check upfront.

Amadeusz
