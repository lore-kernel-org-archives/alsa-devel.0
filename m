Return-Path: <SRS0=TVyu=6S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BAAC3A5A9
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 11:49:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88DB2063A
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 11:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GyaHUyhL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="joBOFuLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88DB2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5145C1706;
	Mon,  4 May 2020 13:48:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5145C1706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588592973;
	bh=p8pP5upVxd8JNzHsu4kADeiPsHkLulaCGJcTaTV3yes=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GyaHUyhLzngNQ26X+kOf6h2Wg4qIwglETAAk8m8BTHIcQve7TqcCeQSFdlpsiLppQ
	 mUE/A/0VEHc1YUYNPczurK74iPZN22E/bYG7naTsuQNeuIAG0p0Fu60gzX+mzDHXgo
	 S3uJBrt5ClkduFsacWohMPe/YcaTzrO15hS+tTSc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF078F800EE;
	Mon,  4 May 2020 13:48:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 43182F80249; Mon,  4 May 2020 13:48:41 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5C69F800DE
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2020 13:48:38 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 5EDAFA0040;
 Mon,  4 May 2020 13:48:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 5EDAFA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1588592918; bh=6IfCK7qbLQDPNuanfH+YZBHCm7jIVKL8gwS5n4vwq14=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=joBOFuLXg+BxmQ5JjhKPfd7W50CgqJCwBAUFTGxw+V/le1cF0/YSajywlvlFYDW/T
 6nODPI0GpIyc6IIS1iIPku8uNVA4gSvMSoOzGIrZsNZZ1R1hOwkjETINLyWLaeuQ1p
 /bTkDVf+dS5J3GX4o2zkfnoa1D1BvHxNrJdtj9BM=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon,  4 May 2020 13:48:33 +0200 (CEST)
Subject: Re: [PATCH v4] ucm2: hdadsp: add basic ucm config
To: Cezary Rojewski <cezary.rojewski@intel.com>
References: <20200318102605.20146-1-mateusz.gorski@linux.intel.com>
 <a19fcc24-b56b-a7ab-346f-239d60b4a9cf@intel.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <950c47a8-5dcd-b99a-e306-094299a2b187@perex.cz>
Date: Mon, 4 May 2020 13:48:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a19fcc24-b56b-a7ab-346f-239d60b4a9cf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 tiwai@suse.com, Mateusz Gorski <mateusz.gorski@linux.intel.com>
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

Dne 04. 05. 20 v 12:26 Cezary Rojewski napsal(a):
> On 2020-03-18 11:26, Mateusz Gorski wrote:
>> Basic UCM configuration for Intel Skylake SST with HDA DSP generic
>> machine driver enabling codec playback and capture on both HDA codec
>> and DMIC ports.
>>
>> Signed-off-by: Mateusz Gorski <mateusz.gorski@linux.intel.com>
>> ---
>>
>> Changes in v4:
>> - adjusted folder and files names to hda-dsp instead of hdadsp
>>
> 
> Hello Jaroslav,
> 
> Kernel patch series:
> 	[PATCH v6 0/3] Add support for different DMIC configurations
> 
> has already been merged by Mark and is now part of Skylake driver. UCM
> and topology patches are still missing though. I didn't find any review
> or issue that has not been addressed. Is there anything else you want us
> to do before merging? Patches have been tested using the exact same
> scope as kernel ones: Intel AVS platforms, RVP and production both.

I already merged this:

https://github.com/alsa-project/alsa-ucm-conf/tree/master/ucm2/hda-dsp

I probably forgot to notify you. Thank you.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
