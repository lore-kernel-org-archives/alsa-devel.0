From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: hdac_hdmi: add Icelake support
Date: Mon, 12 Nov 2018 08:00:36 -0600
Message-ID: <ad05386f-af75-3bf2-bc76-628928fc4fea@linux.intel.com>
References: <20181110211846.23667-1-yung-chuan.liao@linux.intel.com>
 <s5hftw8ngd4.wl-tiwai@suse.de>
 <ac9cecd2-7321-34dd-a317-4d6d3c21635e@linux.intel.com>
 <s5h5zx3o6um.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FAAE267A8E
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 15:00:38 +0100 (CET)
In-Reply-To: <s5h5zx3o6um.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


>>> Also, it'd be helpful if you fix the same for the legacy HD-audio HDMI
>>> codec driver.
>> Our intention was to revisit differences between legacy and non-legacy
>> in a separate patch if that's all right with you. We've identified
>> missing IDs and other things that should be fixed separately.
> Sure, I don't mean to fix both in a single patch, but just to remind
> you guys not to forget about that code path.

Yes, this is very much on our radar. I don't like the current approach 
where patch_hdmi.c and hdac_hdmi.c have duplicated/different definitions 
for the same things or capabilities that can't be traced back to 
hardware documentation or known issues. the main issue I am facing with 
the legacy path is ironically validation. Our team necessarily have 
access to all commercially-available platforms listed in those files or 
when we do it's not necessarily easy to work with the latest kernel or 
handle BIOS issues - we'll do what we can though.

And btw the big topic is still how we provide distributions the means to 
handle a 'graceful' fallback from DSP-enabled solutions (SST or SOF) to 
legacy HDAudio, it's already popped up for cases where we have HDaudio 
solutions with DMICs.

-Pierre
