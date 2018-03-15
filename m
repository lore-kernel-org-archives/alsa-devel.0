From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: core: Allow drivers to set R/W wait
 time.
Date: Thu, 15 Mar 2018 17:25:39 +0100
Message-ID: <c96ee845-31e7-6aae-3218-77ba21a9242e@perex.cz>
References: <20180314204440.14027-1-liam.r.girdwood@linux.intel.com>
 <s5hsh928gak.wl-tiwai@suse.de> <1521120937.7762.258.camel@linux.intel.com>
 <s5hin9x76n8.wl-tiwai@suse.de> <1521130059.7762.298.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B0D4267252
 for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2018 17:25:44 +0100 (CET)
In-Reply-To: <1521130059.7762.298.camel@linux.intel.com>
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
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Dne 15.3.2018 v 17:07 Liam Girdwood napsal(a):
> On Thu, 2018-03-15 at 15:30 +0100, Takashi Iwai wrote:
>>> It's not atm, as it was being set by the driver. Would probably mean an ABI
>>> change to PCM ops or a new ioctl ? The latter wont break the ABI and the
>>> default
>>> value would remain if the ioctl was not called.
>>
>> Basically this timeout is merely for a safety, wasn't considered as a
>> part of the real functionality.
>>
>> So, with your plan, this is exposed as a real PCM feature, as a part
>> of API?  For what kind of scenario / purpose?
> 
> Use case is XRUN handling, DMA failure or FW crash detection. The shortened
> timeout means we can recover far faster leaving a smaller gap in any audio.

We have the non-blocking access mode for this purpose where the
application can choose the state check time independently.

It seems to me, that you like to resolve something else with this. The
'error' checking should be handled at the driver level in my opinion.

I see only the possibility to reduce the timeout to a more appropriate
value (we know all stream and buffering parameters to calculate the
'late' time limit). I agree that the current timeout is too big, but
it's something outside the API as Takashi mentioned.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
