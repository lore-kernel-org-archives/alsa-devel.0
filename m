Return-Path: <SRS0=vl9c=YK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D26DFA372A
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:51:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB76205F4
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZJqd5vuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB76205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EEF4B1683;
	Thu, 17 Oct 2019 16:50:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EEF4B1683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571323888;
	bh=PwlCLGL7fC/LJMCTmG7ZD1OE5J/QVWM6LTg0eu0mIx4=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZJqd5vucz5dwIfHdPt3BiY66qEIT4sf6ndvfL4ROmI3AJEzu5XQaFMEVOOCqwqY3f
	 x42InkUITwtsFpTMB1D4diqgypfopB/fYpJr/yDeAlsw7+hL2QbAZ01xGs1Pyms3yE
	 x6BURw/FgE6GOum6z2pwk6/xlrZyk5zjsLf3KGYA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E515FF805FB;
	Thu, 17 Oct 2019 16:49:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B2B96F804AA; Thu, 17 Oct 2019 16:49:35 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38B93F802A0
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2019 16:49:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38B93F802A0
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Oct 2019 07:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,308,1566889200"; d="scan'208";a="190045711"
Received: from albeaudr-mobl1.amr.corp.intel.com (HELO [10.252.136.206])
 ([10.252.136.206])
 by orsmga008.jf.intel.com with ESMTP; 17 Oct 2019 07:49:27 -0700
To: Takashi Iwai <tiwai@suse.de>, Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20191011112745.25800-1-kai.vehmanen@linux.intel.com>
 <20191011112745.25800-6-kai.vehmanen@linux.intel.com>
 <cf6a8edb-689d-e068-a9c4-d728b7741fec@linux.intel.com>
 <alpine.DEB.2.21.1910111705060.16459@zeliteleevi>
 <s5hmudziz13.wl-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2b172a1b-04d3-624f-f10b-6ff15bdc6c9d@linux.intel.com>
Date: Thu, 17 Oct 2019 08:20:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <s5hmudziz13.wl-tiwai@suse.de>
Content-Language: en-US
Cc: libin.yang@intel.com, alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH v6 5/9] ASoC: SOF: Intel: add support for
 snd-hda-codec-hdmi
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



On 10/17/19 2:58 AM, Takashi Iwai wrote:
> On Fri, 11 Oct 2019 16:10:29 +0200,
> Kai Vehmanen wrote:
>>
>> Hey,
>>
>> On Fri, 11 Oct 2019, Pierre-Louis Bossart wrote:
>>> Kai, I get a conflict when I try to apply these patches on Mark's tree? You
>>> probably want to rebase?
>>> Or was the intent to go through Takashi's tree?
>>
>> I rebased this on top of Takashi's latest before sending:
>>
>> 07be92a0e6b0 (tiwai/master) Merge branch 'for-next'
>>
>> But yeah, the series will conflict with the DMI patch in Mark's tree:
>>
>> 43b2ab9009b1 ASoC: SOF: Intel: hda: Disable DMI L1 entry during capture
> 
> A trivial conflict can be resolved by either Mark or my side, so don't
> worry too much about it.
> 
> But if the patches don't rely on the new stuff that are found only in
> my tree, maybe it's better to rebase on Mark's tree, so that you can
> follow the whole other SOF development.

I'll let Kai comment, but this change will have ripple effects on 
machine drivers we need to upstream, so it might be better to use Mark's 
tree?
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
