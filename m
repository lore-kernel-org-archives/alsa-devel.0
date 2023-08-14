Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC4FC04A6A
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Aug 2023 14:30:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AECC9828;
	Mon, 14 Aug 2023 16:29:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AECC9828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692023444;
	bh=72lAIwDJyqKuoxlrgFAQv/XgF0qC+sYlLasKvyy0uFQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FJbx2dht/pOBYVrSSfSioUKV/SRJdeNtccl9vOdH/PpWm+uJ+FVFzS93tG/3aL0Y6
	 DFtqbsKe1rpZe7Rz+PJ2UdITLiuov7GATorTNL/CSZ03ACN9SU1g3y/i1g+VCmnDTV
	 9pC2bMVNp7/9RuGongnLAc2dlHg4ejUOA805Wt7g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42D48F805F5; Mon, 14 Aug 2023 16:27:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A979EF805FC;
	Mon, 14 Aug 2023 16:27:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C4D0EF8025F; Mon, 14 Aug 2023 16:26:11 +0200 (CEST)
Received: from mblankhorst.nl (lankhorst.se
 [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7BDAEF800EE;
	Mon, 14 Aug 2023 16:26:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7BDAEF800EE
Message-ID: <e88d139f-e62b-1654-0d35-a46c698298c6@lankhorst.se>
Date: Mon, 14 Aug 2023 16:26:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 8/9] ASoC: SOF: Intel: Move binding to display driver
 outside of deferred probe
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20230807090045.198993-1-maarten.lankhorst@linux.intel.com>
 <20230807090045.198993-9-maarten.lankhorst@linux.intel.com>
 <4acc7318-69b3-3eb5-1fe8-f7deea8adfad@linux.intel.com>
 <87a5uwr7ya.wl-tiwai@suse.de>
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <87a5uwr7ya.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: dev@lankhorst.se
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 4PXJG5APHEZ5QPA2JFW2CA5FGP5JJPYZ
X-Message-ID-Hash: 4PXJG5APHEZ5QPA2JFW2CA5FGP5JJPYZ
X-Mailman-Approved-At: Mon, 14 Aug 2023 14:27:12 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4PXJG5APHEZ5QPA2JFW2CA5FGP5JJPYZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Ping on this?

On 2023-08-12 10:17, Takashi Iwai wrote:
> On Mon, 07 Aug 2023 16:26:53 +0200,
> Pierre-Louis Bossart wrote:
>>
>>
>>
>> On 8/7/23 04:00, Maarten Lankhorst wrote:
>>> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
>>> the snd_hdac_i915_init into a workqueue.
>>>
>>> Use the -EPROBE_DEFER mechanism instead, which must be returned in the
>>> probe function.
>>
>> I don't think this patch is aligned with the previous discussions. What
>> we agreed on is that snd_hdac_i915_init() would be called from and not
>> from the workqueue.
>>
>> But this patch also moves all codec initialization out of the workqueue.
>>
>> I think we need two callbacks for device-specific initilization, one
>> that is called from the probe function and one from the workqueue,
>> otherwise we'll have a structure that differs from the snd-hda-intel -
>> which would be rather silly in terms of support/debug.
>>
>> I realize there's quite a bit of surgery involved, and most likely the
>> SOF folks should provide this patch for you to build on.
> 
> So this patch looks like the only significant concern in the whole
> patch set.  Can we reach to some agreement for merging to 6.6 in time?
> 
> 
> thanks,
> 
> Takashi
