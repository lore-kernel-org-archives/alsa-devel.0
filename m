From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: data write in alsa
Date: Fri, 02 Dec 2011 08:16:21 +0100
Message-ID: <4ED87B45.5080603@perex.cz>
References: <1322808881.1516.1011.camel@vkoul-udesk3>
	<s5hr50no3a9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 2ED922468C
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 08:16:40 +0100 (CET)
In-Reply-To: <s5hr50no3a9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa <alsa-devel@alsa-project.org>, Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Date 2.12.2011 08:12, Takashi Iwai wrote:
> At Fri, 02 Dec 2011 12:24:41 +0530,
> Vinod Koul wrote:
>>
>> Hi Takashi,
>>
>> For alsa pcm we have two ways to write data, either we use write()
>> system call or use ioctl SNDRV_PCM_IOCTL_WRITEI_FRAMES.
>>
>> Is there any specific reason why we have two methods and which one is
>> preferred and why?
>
> Well, I only remember vaguely.  IIRC, ioctl is used since it can pass
> the error code more directly without using errno.  Maybe Jaroslav
> knows more exact reason.

The true reason was to avoid the audio frame <-> byte conversions.

> But, honestly speaking, I don't like this implementation.  For a new
> interface, I'd suggest to stick with the normal read/write.  Otherwise
> you'll get a mess of 32bit compat layer again.

I think that for compressed data, the standard r/w ops are fine, because 
there are no "frames".

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
