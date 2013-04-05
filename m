From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ALSA: hda/ca0132 - Update latency based
 on DSP state.
Date: Fri, 05 Apr 2013 10:01:04 -0500
Message-ID: <515EE730.6080705@linux.intel.com>
References: <1365108909-13587-1-git-send-email-dgreid@chromium.org>
 <s5hehep4jt9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id A260A265FDA
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 17:01:08 +0200 (CEST)
In-Reply-To: <s5hehep4jt9.wl%tiwai@suse.de>
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
Cc: Dylan Reid <dgreid@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>> The DSP in the CA0132 codec adds a variable latency to audio depending
>> on what processing is being done.  Add a new patch op to return that
>> latency for capture and playback streams.  The latency is determined
>> by which blocks are enabled and knowing how much latency is added by
>> each block.
>>
>> Signed-off-by: Dylan Reid <dgreid@chromium.org>
>
> Thanks, applied.

This conflicts with the audio timestamp stuff I contributed last year.
If the hardware supports a WALLCLK, and HDA does, the timestamp is just 
a read of the counter plus a translation to ns. If it doesn't, the 
timestamp corresponds to the delay. If you modify the definition of the 
delay then the timestamp will be off on some platforms.
-Pierre
