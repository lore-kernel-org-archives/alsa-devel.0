From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [TINYCOMPRESS][PATCH 1/1] compress: no need to	set
 metadata before calling next_track
Date: Mon, 03 Mar 2014 08:57:10 -0600
Message-ID: <53149846.3040104@linux.intel.com>
References: <20140226142829.GB2002@opensource.wolfsonmicro.com>
 <530F62CA.6080002@linux.intel.com>
 <20140303132547.GA20710@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id A786B265141
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 15:57:13 +0100 (CET)
In-Reply-To: <20140303132547.GA20710@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: vinod.koul@intel.com, ckeepax@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, elaurent@google.com
List-Id: alsa-devel@alsa-project.org


> Any format, or any use-case, where we don't need to send metadata. I said "other formats do not
> _necessarily_ require any additional metadata". I'm not saying that _no_ other format needs metadata,
> just that it's not something that's always going to be mandatory. Also you shouldn't think only in
> terms of gapless play, you can chain track together for other reasons than gapless (for example to
> make best use of the DSP buffering and allow maximum host sleep time across multiple tracs) and still
> want to be able to do partial drains to know when the DSP starts decoding the next track.

My point was that it's way simpler to use regular playback if you don't 
need the gapless functionality. I don't buy the argument on power 
savings either, if the transition lasts 500ms with 3mn tracks, we are 
talking about optimizing a state that represents 0.27% of the AP activity.

> Also there's no reason why the kernel should be enforcing this restriction - the core ALSA state
> machine doesn't need the metadata so it should be left to the DSP driver and/or firmware to decide
> whether metadata is mandatory in the current situation.

The problem is that you removed checks at the kernel and tinycompress 
levels, essentially moving error management to the HAL and firmware. I 
would agree to the change at the kernel level but it makes sense to have 
a common approach in tinycompress to make the integration work lighter.
If you truly want to be generic we should provide information at the 
codec level on whether gapless is supported and if there is a need for 
metadata - e.g. reclaim a reserved field from snd_codec_desc in 
compress_params.h, and do the check only if needed.
