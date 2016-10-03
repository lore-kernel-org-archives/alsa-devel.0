From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 5/7] ALSA: hda: add default value for
 max_inflight_bytes
Date: Mon, 3 Oct 2016 09:44:27 -0500
Message-ID: <f5c1f2d1-7182-3ca3-7c92-8efe2958228b@linux.intel.com>
References: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
 <1475239410-16548-6-git-send-email-subhransu.s.prusty@intel.com>
 <20161003084817.GC9636@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 39090266B91
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 16:44:45 +0200 (CEST)
In-Reply-To: <20161003084817.GC9636@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hardik Shah <hardik.t.shah@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


>> --- a/sound/pci/hda/hda_controller.c
>> +++ b/sound/pci/hda/hda_controller.c
>> @@ -587,6 +587,7 @@ static struct snd_pcm_hardware azx_pcm_hw = {
>>  	.periods_min =		2,
>>  	.periods_max =		AZX_MAX_FRAG,
>>  	.fifo_size =		0,
>> +	.max_inflight_bytes = 128 /* default value for all legacy HDAudio controllers, override as needed */
>
> This line is going beyond 100 chars

introducing multi-line comments makes the structure less readable so 
even if checkpatch complains with a warning I used a single line. If you 
disagree please suggest a format that leaves the readable AND meets the 
80 char/line rule.
