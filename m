Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495F1C04A6A
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Aug 2023 14:28:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93DD6832;
	Mon, 14 Aug 2023 16:27:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93DD6832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692023328;
	bh=buXjaFgzaFcCwRagp6RWDOeaBh0a9x/P3cQvekzCOpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lw61A1iA89x1qpeC7aux4hpfvAL7iQa2tLYGXc+jShqLWNPoc7dOUNrU8ALgxx7Nz
	 4anjPVtTGguSEmPqU0k6JOuoLvTE+5gi1SScY61ry7X5vhfhWsYqEVnimjZO8e4j4/
	 EYqfpneGSED6mqpDw5pGuF6YpEChXRwn5WKjGBfo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F26B3F805A9; Mon, 14 Aug 2023 16:26:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CBD9F80588;
	Mon, 14 Aug 2023 16:26:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6AF31F80166; Sat, 12 Aug 2023 16:43:20 +0200 (CEST)
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C4806F800FB;
	Sat, 12 Aug 2023 16:43:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4806F800FB
Message-ID: <b50a04c9-23d2-83d5-37fa-642c85e3d32d@lankhorst.se>
Date: Sat, 12 Aug 2023 16:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/9] ALSA: hda/i915: Add an allow_modprobe argument to
 snd_hdac_i915_init
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
 <20230807090045.198993-4-maarten.lankhorst@linux.intel.com>
 <451ab8a3-7c75-4aab-0b8b-554d9c44c34c@linux.intel.com>
 <877cq0r7qz.wl-tiwai@suse.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <877cq0r7qz.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: dev@lankhorst.se
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 7F7EKRVADNF7O3GT2AIHRAHNOBGOF7VL
X-Message-ID-Hash: 7F7EKRVADNF7O3GT2AIHRAHNOBGOF7VL
X-Mailman-Approved-At: Mon, 14 Aug 2023 14:26:35 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7F7EKRVADNF7O3GT2AIHRAHNOBGOF7VL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hey,

On 2023-08-12 10:21, Takashi Iwai wrote:
> On Mon, 07 Aug 2023 16:08:32 +0200,
> Pierre-Louis Bossart wrote:
>>
>>
>>
>> On 8/7/23 04:00, Maarten Lankhorst wrote:
>>> Xe is a new GPU driver that re-uses the display (and sound) code from
>>> i915. It's no longer possible to load i915, as the GPU can be driven
>>> by the xe driver instead.
>>>
>>> The new behavior will return -EPROBE_DEFER, and wait for a compatible
>>> driver to be loaded instead of modprobing i915.
>>>
>>> Converting all drivers at the same time is a lot of work, instead we
>>> will convert each user one by one.
>>>
>>> Changes since v1:
>>> - Use dev_err_probe to set a probe reason for debugfs' deferred_devices.
>>
>> You want the changes below the --- line ...
> 
> Note that there are subsystems preferring keeping the version change
> logs in the commit log (typically found in drm trees), although
> majority of subsystems (including sound) want rather cleaner logs,
> AFAIK.
Yeah, I usually maintain stuff in drm. :)

Cheers,
~Maarten
