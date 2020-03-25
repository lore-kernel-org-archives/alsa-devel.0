Return-Path: <SRS0=ybvW=5K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC31C54FD0
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:43:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB7C208E0
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HSvdge1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB7C208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9C1D165F;
	Wed, 25 Mar 2020 15:42:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9C1D165F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585147421;
	bh=JWDHkEbbsQ0RQpgUd6QeHEVy8qpKWQD2OWDUMfGgV5Q=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HSvdge1lCEFQPDPB91Ui2GHPGLVWSpd1NzlxMwm4JZHxCTPcw86LY0gNGPEZKdOa1
	 vlYTVtwy1XU7tQ1vj8OKP9z0f4BgwxxNvQC8plWb+cRrbRnpcEM5P1IQ9hq8RalpfM
	 EKdF2sXES4BJdRiUgX+Bdy2AtcGKHuj0CniZ48w0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D45DDF80147;
	Wed, 25 Mar 2020 15:42:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28146F80158; Wed, 25 Mar 2020 15:42:49 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BCB5AF8011E
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 15:42:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BCB5AF8011E
IronPort-SDR: L4p1oA7fhHQkzMWm7ysPpY7eA2pS999G8BfhbPKN82CsXqYc3Jeq50K0hroa67k3jWYYNd2F63
 dufxp7ikLfYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 07:42:37 -0700
IronPort-SDR: kklz9AuhUK0E2X90hZghP+MecZvPdYu8J+xPgr+OhNhD9kjGBCcof97r91C93RGB/5szhIY8mA
 5C03foZUk/tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; d="scan'208";a="393648602"
Received: from swmckee-mobl2.amr.corp.intel.com (HELO [10.252.137.27])
 ([10.252.137.27])
 by orsmga004.jf.intel.com with ESMTP; 25 Mar 2020 07:42:35 -0700
Subject: Re: [PATCH 3/4] ASoC: Intel: bdw-rt5677: Remove ignore_suspend flag
 from SSP0 dai link
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Curtis Malainey <cujomalainey@google.com>
References: <20200319204947.18963-1-cezary.rojewski@intel.com>
 <20200319204947.18963-4-cezary.rojewski@intel.com>
 <dea20cf7-f324-a933-8f8e-e70a4dffa249@linux.intel.com>
 <CAOReqxj=DBO2FyL466jWHDUG6_A4uU_o0cSyVPHbH8mjWs=JTg@mail.gmail.com>
 <27e30f23-851e-18ad-6014-2b4d890adf62@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6809b9d3-e15a-35cc-ceb3-bfcf96f5d639@linux.intel.com>
Date: Wed, 25 Mar 2020 09:42:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <27e30f23-851e-18ad-6014-2b4d890adf62@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>, Dominik Brodowski <linux@dominikbrodowski.net>,
 Liam Girdwood <lgirdwood@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
 vkoul@kernel.org, Mark Brown <broonie@kernel.org>,
 Ben Zhang <benzh@google.com>
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



On 3/25/20 8:28 AM, Cezary Rojewski wrote:
> On 2020-03-19 23:43, Curtis Malainey wrote:
>> On Thu, Mar 19, 2020 at 3:15 PM Pierre-Louis Bossart
>> <pierre-louis.bossart@linux.intel.com> wrote:
>>> On 3/19/20 3:49 PM, Cezary Rojewski wrote:
>>>> As of commit:
>>>> ASoC: soc-core: care .ignore_suspend for Component suspend
>>>>
>>>> function soc-core::snd_soc_suspend no longer ignores 'ignore_suspend'
>>>> flag for dai links. While BE dai link for System Pin is
>>>> supposed to follow standard suspend-resume flow, appended
>>>> 'ignore_suspend' flag disturbs that flow and causes audio to break
>>>> right after resume. Remove the flag to address this.
>>>>
>>>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>>> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
>>>> Cc: Mark Brown <broonie@kernel.org>
>>>> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
>>>
>>> we should ask Ben and Curtis @ Google if the changes related to suspend
>>> interfere with the wake-on-voice support?
>>
>> I have a samus with me so I can test it but my backlog is definitely
>> growing due to WFH slowness. I will see if I can take a look tomorrow.
>>
> 
> Any update?
> 
> Maybe let's leave bdw-rt5650/ bdw-rt5677 behind so people have more time 
> to test and merge just the broadwell & haswell part. Hmm?

Can you give us a bit more time (couple of days tops)? we also see a 
problem with SOF when playing after suspend-resume, and I just thought 
this might be related to the same issue.
