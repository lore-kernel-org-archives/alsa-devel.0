Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67814C3815B
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 21:57:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C157520774
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 21:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Givt7YOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C157520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20EFD82A;
	Wed, 15 Apr 2020 23:56:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20EFD82A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586987852;
	bh=mfb70ZmvMkj4zvP5nbwNMdJkcGOaNutoWzjzJZ+omVk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Givt7YOVBJCYC13SrD8s18+Z7BHW4pErNmXPz9r2usIuHH0sJKr6Ay31ga2WrVvz3
	 8Wfh1cfV58XgOruz5If34VeNJ0TumO5UwYFeaytilVBeX8NjQPYpm0HctnLne7Scqm
	 BRMv+kibog3Uf1U69YaGXffTs9P9MJL79kyEvz2g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79AD0F80229;
	Wed, 15 Apr 2020 23:56:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 899A5F80245; Wed, 15 Apr 2020 23:56:39 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 866ADF800ED
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 23:56:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 866ADF800ED
IronPort-SDR: nlQjymD6L980K/KQZMuJ/yr/FnVq5DKWBS8AZcmVpCfeHTCW6cqcRrbNgtLND1sFEciuqdh7hQ
 KxH+Zknwujkw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 14:56:27 -0700
IronPort-SDR: BzJZ6a2Xp4J+PsoVcKvLKEI4ZZ5HXY7LD2WPsbyAWp6Q91WVl99Zp9Pq4VF1+LvxOoIZTuAra5
 FSnGZpi0pSCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; d="scan'208";a="253654666"
Received: from sthodupu-mobl.amr.corp.intel.com (HELO [10.134.45.17])
 ([10.134.45.17])
 by orsmga003.jf.intel.com with ESMTP; 15 Apr 2020 14:56:27 -0700
Subject: Re: [RFC TEST] ASoC: soc-dai: revert all changes to DAI
 startup/shutdown sequence
To: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
References: <20200415030437.23803-1-pierre-louis.bossart@linux.intel.com>
 <9bbb1e49-6542-b1a3-d9e6-8dd30b79d07f@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fd1a219b-28b4-e324-6657-9fb4a65ec640@linux.intel.com>
Date: Wed, 15 Apr 2020 16:56:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9bbb1e49-6542-b1a3-d9e6-8dd30b79d07f@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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



On 4/15/20 4:26 PM, Hans de Goede wrote:
> Hi,
> 
> On 4/15/20 5:04 AM, Pierre-Louis Bossart wrote:
>> On Baytrail/Cherrytrail, the Atom/SST driver fails miserably:
>>
>> [    9.741953] intel_sst_acpi 80860F28:00: FW Version 01.0c.00.01
>> [    9.832992] intel_sst_acpi 80860F28:00: FW sent error response 0x40034
>> [    9.833019] intel_sst_acpi 80860F28:00: FW alloc failed ret -4
>> [    9.833028] intel_sst_acpi 80860F28:00: sst_get_stream returned err -5
>> [    9.833033] sst-mfld-platform sst-mfld-platform: ASoC: DAI prepare 
>> error: -5
>> [    9.833037]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio 
>> Port failed
>> [    9.853942] intel_sst_acpi 80860F28:00: FW sent error response 0x40034
>> [    9.853974] intel_sst_acpi 80860F28:00: FW alloc failed ret -4
>> [    9.853984] intel_sst_acpi 80860F28:00: sst_get_stream returned err -5
>> [    9.853990] sst-mfld-platform sst-mfld-platform: ASoC: DAI prepare 
>> error: -5
>> [    9.853994]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio 
>> Port failed
>>
>> Commit b56be800f1292 ("ASoC: soc-pcm: call
>> snd_soc_dai_startup()/shutdown() once") was the initial problematic
>> commit.
>>
>> Commit 1ba616bd1a6d5e ("ASoC: soc-dai: fix DAI startup/shutdown 
>> sequence")
>> was an attempt to fix things but it does not work on Baytrail,
>> reverting all changes seems necessary for now.
>>
>> Fixes: 1ba616bd1a6d5e ("ASoC: soc-dai: fix DAI startup/shutdown 
>> sequence")
>> Signed-off-by: Pierre-Louis Bossart 
>> <pierre-louis.bossart@linux.intel.com>
> 
> Thank you for figuring this out!
> 
> I've tested this on the 2 devices where I have seen the problem
> (the only 2 devices on which I've tested 5.7-rc1 so far):
> 
> One Cherry Trail device with a RT5645 codec and another
> Cherry Trail device with an ES8316 and I can confirm that this
> fixes the issue on both devices:
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>

Thanks Hans for checking.

I must admit it was one of the more complicated bisects I've ever done, 
we had 3 different regressions so I end-up merging sound-v5.7-rc1 on top 
of v5.7-rc1, then do a manual rebase to create a linear branch, then 
squash fixes with the original problematic commits, and then bisecting 
once I had a single issue left.

I'll see if we can retask some of the SOF CI Baytrail/Cherrytrail 
machines to run regressions on the legacy driver on a periodic basis, 
e.g. during week-ends when no one is around.
