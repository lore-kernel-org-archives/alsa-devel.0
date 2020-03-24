Return-Path: <SRS0=1tVn=5J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8470FC43331
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:35:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D407206F6
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tDwJ7nyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D407206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1477586F;
	Tue, 24 Mar 2020 14:34:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1477586F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585056901;
	bh=qrKoGahmaLOmg86hLDhKiGQRqB9icAdFjEQyAhEXC3o=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tDwJ7nyYez0ifx+hrac/k5KUOJukxUoGYh5P30hrFYN85kQtBaMX4pB1FB5YBK2Bg
	 70NRJkNFPDuEFGpLgWgEOYwdA+7qgScpHouI1yUKXeHhGLrFz55yasNY8+rRwV18YU
	 zqLeogSvIC4LzLOnvY7D6dOp4btKo4FMLKyq5vP4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6818F800B9;
	Tue, 24 Mar 2020 14:34:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E39C0F80095; Tue, 24 Mar 2020 14:34:09 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4098CF80095
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 14:34:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4098CF80095
IronPort-SDR: 8FkaYvUFhR9t1OU3Rh7j31wvspIGG2yP06du8QpTuAZwrflNELtVBvEwow4ghp5O5AzkT+tva7
 zWZwbrnDMxQA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2020 06:34:03 -0700
IronPort-SDR: moSkF3Z9ZTQSHtYGy2/SaoXvw7ToEJ+VA2uXlZsncSL+i1XdjmSAnaEmDQURgNVVFfODNLu+4d
 j97azWW7dF2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; d="scan'208";a="325910636"
Received: from jgcortes-mobl1.amr.corp.intel.com (HELO [10.251.225.70])
 ([10.251.225.70])
 by orsmga001.jf.intel.com with ESMTP; 24 Mar 2020 06:34:02 -0700
Subject: Re: [PATCH] ALSA: core: sysfs: show components string
To: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org
References: <20200323193623.3587-1-pierre-louis.bossart@linux.intel.com>
 <20200324015331.GA3679@workstation>
 <d31659cc-d528-345f-1e56-b0cfae36be5c@linux.intel.com>
 <20200324043336.GA8342@workstation>
 <a74e4b68-d6f6-c12d-d600-d8cb7321cc00@linux.intel.com>
 <20200324090152.GA14579@workstation>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <69761ee4-463b-25ff-1d2d-635a19487663@linux.intel.com>
Date: Tue, 24 Mar 2020 08:15:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200324090152.GA14579@workstation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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



On 3/24/20 4:01 AM, Takashi Sakamoto wrote:
> On Tue, Mar 24, 2020 at 12:12:15AM -0500, Pierre-Louis Bossart wrote:
>> when people report that their microphone is not reported by PulseAudio/UCM,
>> it's very helpful to know what UCM was supposed to use in the first place.
>> We don't have a debugger or step-by-step mechanisms to figure out what the
>> configurations are.
> 
> If I get your intension correctly, the addition of sysfs node is just to
> investigate which use-case configuration is applied in cases that people
> get issues. If so, it's really exaggerative in a point of the concept of
> sysfs.
> 
> I have two alternatives. If it's possible to focus on ALSA SoC part only,
> addition of node to debugfs is reasonable for this purpose.
> 
> Another alternative is to change output of 'cards' node of procfs. The
> latter is commonly available for all cases. For example:

I initially wanted to use /proc but thought it was a thing from the past 
so I looked at sysfs. If this is the recommendation I don't mind using it.

debugsfs is not something the average user is familiar with, and it's 
not available in all cases. I'd like to extend existing pieces of 
information than add new things.
