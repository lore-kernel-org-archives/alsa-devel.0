Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF83C10DCE
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:56:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA19206FA
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Li4IBWje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA19206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBDC21773;
	Thu, 12 Mar 2020 23:55:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBDC21773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584053795;
	bh=YF9vzVGitpO9QOtYUFl9R8fIGPJkRYWjz65zJa6Hl/s=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Li4IBWjehv7JGiTkemSvntWAjl5qknM9cGy/cTHQ7vPA76WzDnlrjr1pfmJEFYzOf
	 zkV3vVF++9Eq1NZ3mlcBofWasZ43nvbZe0XWswHuSdmMRYiuWWov5uLfS1CDStaDBj
	 nlS9rOeehc4yuwtj//tEZiyrxL4ssDzo/YBZ5iOY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63E26F801D9;
	Thu, 12 Mar 2020 23:55:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79A37F8020C; Thu, 12 Mar 2020 23:55:43 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3C69F800BE
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2020 23:55:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3C69F800BE
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 15:55:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,546,1574150400"; d="scan'208";a="235164348"
Received: from bobrowni-mobl1.amr.corp.intel.com (HELO [10.252.205.211])
 ([10.252.205.211])
 by fmsmga007.fm.intel.com with ESMTP; 12 Mar 2020 15:55:36 -0700
Subject: Re: ASoc: soc_core.c stream direction from snd_soc_dai
To: Matt Flax <flatmax@flatmax.org>, alsa-devel@alsa-project.org
References: <5598a2fc-9b49-ad5e-2265-fbc0593ead1b@flatmax.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0d9a9459-9cd7-d384-b1ff-72860895ad13@linux.intel.com>
Date: Thu, 12 Mar 2020 17:55:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5598a2fc-9b49-ad5e-2265-fbc0593ead1b@flatmax.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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



On 3/11/20 5:54 PM, Matt Flax wrote:
> Hi there,
> 
> A large number of audio codecs allow different formats for playback and 
> capture. This becomes very useful when there are different latencies 
> between playback and capture hardware data lines. For example digital 
> isolation chips typically have a 1 bit delay in propagation as the bit 
> clock rate gets faster for higher sample rates. By setting the capture 
> and playback formats to differ by one or two bit clock cycles, the delay 
> problem is solved.
> 
> There doesn't seem to be a simple way to detect stream direction in the 
> codec driver's set_fmt function.
> 
> The snd_soc_runtime_set_dai_fmt function :
> 
> https://github.com/torvalds/linux/blob/master/sound/soc/soc-core.c#L1480
> 
> calls the snd_soc_dai_set_fmt function :
> 
> https://github.com/torvalds/linux/blob/master/sound/soc/soc-dai.c#L101
> 
> which calls the set_fmt function :
> 
> https://github.com/torvalds/linux/blob/master/include/sound/soc-dai.h#L189
> 
> 
> The snd_soc_dai_ops set_fmt function is defined as :
> 
>      int (*set_fmt)(struct snd_soc_dai *dai, unsigned int fmt);
> 
> 
> Is there a simple way to find the stream direction from a snd_soc_dai ?
> 
> If the stream direction can be detected then the playback and capture 
> formats can be set independently for the codec.
> 
> It there a different way to set the playback and capture formats for the 
> codec independently at runtime, depending on the sample rate ?

FWIW I remember a discussion in the past on how to deal with interfaces 
that may have different clocks sources for capture and playback 
(typically with the 6-pin version of I2S/TDM), and the answer was: use 
two dais, with one dealing with capture and the other with playback.

I would bet this applies for the format as well. If you use a DAI that 
can do both directions, then indeed there's no obvious way to specify 
that formats or clock ownership could be different between the two 
directions.

It would probably make sense anyway to have a representation with two 
dais, e.g. the codec capture dai receives data from somewhere and the 
codec playback dai forwards it to another destination.

My 2 cents
-Pierre
