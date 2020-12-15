Return-Path: <SRS0=TlZm=FT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BC3C4361B
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Dec 2020 16:01:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D822255F
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Dec 2020 16:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D822255F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B714117A5;
	Tue, 15 Dec 2020 17:00:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B714117A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608048106;
	bh=YUbi73JBUTSNFzHmrx3ongxGhLgufnTOWiqrzG2/9TI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vjzKvXRjoWmjaZWLex+lmDvGi4B4lkG1zxm0vliJ3AjfnPDL31bdkmRqPah5+MNmj
	 S7/GfEyKJb648uKoS2bDl1uUuIc2S6E8X0zSUaXe/Vty5F9Nd2d5IN6CaPg65EBNqZ
	 +hDNjpR/dqRQ/TBjUhH+I0yZgpHntO+Tlo4oFlac=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B22FF80259;
	Tue, 15 Dec 2020 17:00:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B3DD0F80129; Tue, 15 Dec 2020 17:00:44 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97F89F80129
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2020 17:00:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97F89F80129
IronPort-SDR: G6M+JRk+BPUCgffKSk9bbfuNq4qrMlq1pP7DhRYZSPXOni/Ue7xwnkTuLpkTDLBcXqI/kVvDBj
 zpp3N5X0Eagw==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="193274640"
X-IronPort-AV: E=Sophos;i="5.78,421,1599548400"; d="scan'208";a="193274640"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2020 08:00:23 -0800
IronPort-SDR: RVKKgeEz4Ax61vey1c9GG6QRhdW7BtXYH+DCeOwMKrVqhXtsoyJDfnT/0uohIjJYFCdDLru/J4
 3/I66lVzrdHQ==
X-IronPort-AV: E=Sophos;i="5.78,421,1599548400"; d="scan'208";a="487934004"
Received: from yikrimon-mobl1.amr.corp.intel.com (HELO [10.213.173.225])
 ([10.213.173.225])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2020 08:00:21 -0800
Subject: Re: [PATCH] ASoC: rt715: add main capture switch and main capture
 volume control
To: Jaroslav Kysela <perex@perex.cz>, jack.yu@realtek.com,
 broonie@kernel.org, lgirdwood@gmail.com, Takashi Iwai <tiwai@suse.de>
References: <20201214064903.2746-1-jack.yu@realtek.com>
 <8eeddc8c-91cb-e62d-6114-547117d4d83e@perex.cz>
 <0096059b-de76-d9a3-2446-b4c3becabce8@linux.intel.com>
 <0b0afd81-0595-c661-ec1e-e81b7e8f8fec@perex.cz>
 <7d74544f-77f2-db01-db3d-d1d8a56d576d@linux.intel.com>
 <cb07f528-6c2f-1357-db54-e3d062ad6dd3@perex.cz>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bcdc2aba-ab7e-08bf-7e25-02e38c9d660d@linux.intel.com>
Date: Tue, 15 Dec 2020 10:00:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cb07f528-6c2f-1357-db54-e3d062ad6dd3@perex.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de,
 derek.fang@realtek.com, bard.liao@intel.com, shumingf@realtek.com,
 flove@realtek.com
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




> My suggestions are (pick one):
> 
> 1) create one multichannel control and remove the stereo controls when the
> hardware is detected (no functionality dup)

we can't remove controls that existed before, this might break userspace 
with older UCM files that touch those ADC07 and ADC27. That's why we 
added a new one, to be backwards compatible with a user updates their 
kernel.

> 2) create proper vmaster control like for HDA playback

That might be the better option. What was suggested in this patch is 
essentially to introduce a layer that drives the actual controls, but it 
was done 'manually' and may not follow the proper rules.

That said I know absolutely nothing about 'vmaster controls', pointers 
to a typical example would be greatly appreciated.

> 3) wait until UCM can describe this hardware and set the DAC values manually
> to a sensible value via sequences (the specific hardware levels can be set
> using the conditions in UCM)

Not an option, there are products that need to ship soon.

> BTW: I see lack of analog volume level controls also for other SDW hardware
> (with the RT1308 amplifier). It's a bit pitty that the audio basics are
> ignored here. Everyone wants to control the analog levels at first for audio
> I/O and then to modify the samples in the digital stream.

I agree, there was an oversight in initial UCM files where the SOF 
controls modifying the digital parts were used across the board. This 
was mandatory for DMICs controlled by SOF but all other streams should 
have been controlled by controls exposed by external devices.
