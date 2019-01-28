From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 01/15] ASoC: add helper to change platform
 name for all dailinks
Date: Mon, 28 Jan 2019 09:57:20 -0600
Message-ID: <a1d2d0b9-69fc-21f6-dcee-bd004e3263a8@linux.intel.com>
References: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
 <20190125203509.22994-2-pierre-louis.bossart@linux.intel.com>
 <s5htvhv8g4y.wl-tiwai@suse.de> <20190128121933.GC11699@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A93F7267467
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 16:57:22 +0100 (CET)
In-Reply-To: <20190128121933.GC11699@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>>> +static inline
>>> +int snd_soc_fixup_dai_links_platform_name(struct snd_soc_card *card,
>>> +					  const char *platform_name)
>>> +{
>> Does it have to be inline?  The function has a significant size, and
>> it's supposed to be called by every Intel driver.
> Yeah, if it gets too big the compiler will just ignore you but given
> that this isn't exactly in a hot path or anything I can't see any reason
> why it should be inline.
Sure, I can fix this, no worries.
