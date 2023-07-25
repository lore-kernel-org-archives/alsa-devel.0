Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662B5C0015E
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jul 2023 11:54:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6089C150F;
	Tue, 25 Jul 2023 13:53:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6089C150F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690286064;
	bh=R3yO1JQxEFIRfLkf6Z68bVBGgIfaqBVrbJHVow8bK+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=la0mWBvxv35SCzGmq1vEAaPWTro5aGNxNSSyrIXIF1McgPzwp8qXIrKAtRUUePhNB
	 I5vAiePQeId2A2MKj9dyPHMiprmcfX9QgF+Bo9MFcMWs5UC9uFqsXTiCgncuSmU2vl
	 ScN73cymXtlEqGH4Z1fW+YqN79+xp8++AVirGleg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59870F805B2; Tue, 25 Jul 2023 13:51:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B637BF805A0;
	Tue, 25 Jul 2023 13:51:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 585A5F80163; Tue, 25 Jul 2023 12:29:17 +0200 (CEST)
Received: from mblankhorst.nl (lankhorst.se
 [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 62E72F800C7;
	Tue, 25 Jul 2023 12:29:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62E72F800C7
Message-ID: <1bb7858d-fab0-f3c2-b786-a93f3789b400@linux.intel.com>
Date: Tue, 25 Jul 2023 12:29:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 8/9] ASoC: SOF: Intel: Remove deferred probe for SOF
Content-Language: en-US
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
Cc: sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 Matthew Auld <matthew.auld@intel.com>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
 <20230719164141.228073-9-maarten.lankhorst@linux.intel.com>
 <03d5abcd-53a6-bf61-227e-d608c5fbfe70@linux.intel.com>
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <03d5abcd-53a6-bf61-227e-d608c5fbfe70@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MailFrom: maarten.lankhorst@linux.intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 6QX4PUVKOGTD62IFKCE2Q3GM7ORJFH45
X-Message-ID-Hash: 6QX4PUVKOGTD62IFKCE2Q3GM7ORJFH45
X-Mailman-Approved-At: Tue, 25 Jul 2023 11:51:33 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6QX4PUVKOGTD62IFKCE2Q3GM7ORJFH45/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hey,

On 2023-07-24 13:32, Pierre-Louis Bossart wrote:
> 
> 
> On 7/19/23 18:41, Maarten Lankhorst wrote:
>> This was only used to allow modprobing i915, by converting to the
>> -EPROBE_DEFER mechanism, it can be completely removed, and is in
>> fact counterproductive since -EPROBE_DEFER otherwise won't be
>> handled correctly.
> 
> I personally remember only that the request_module("i915") was the main
> motivation for the use of the workqueue, but when it comes to the
> HDaudio codec management we don't even know what we don't know.
> 
> I am a bit worried that the snd-hda-intel driver keeps the workqueue for
> HDaudio codec initialization, and this patch removes the workqueue
> completely for SOF. That doesn't seem right. Either both drivers need a
> workqueue or none need a workqueue.
> 
> Maybe what we need is to move the i915/xe initialization out of the
> workqueue, and see in a second pass if that workqueue can be safely
> removed from the SOF driver?
> 
As I mentioned in some of the other sound driver conversions. I believe 
it's possible to completely kill off most workqueues.

However, I don´t have the hardware or knowledge to test it. I saw that 
the SOF had the non-workqueue path already, so it felt less risky to 
simply convert it to always use that path.

avs/skylake drivers should be easy to convert too. This is why I left 
the comment: "Removing the workqueue would simplify init even further, 
but is left as exercise for the reviewer."

HDA-intel has this retry-probe logic used on AMD's,
which makes me more hesitant to convert it.

I wanted to tackle one problem at a time, I believe workqueue removal 
can be done by anyone.

Cheers,
~Maarten
