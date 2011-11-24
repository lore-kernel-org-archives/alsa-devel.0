From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Thu, 24 Nov 2011 15:02:37 +0530
Message-ID: <1322127157.1516.973.camel@vkoul-udesk3>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
	<s5hbos2g4af.wl%tiwai@suse.de> <1322106354.1516.951.camel@vkoul-udesk3>
	<s5hfwhd29a5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BE9E24452
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 10:36:03 +0100 (CET)
In-Reply-To: <s5hfwhd29a5.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-11-24 at 09:51 +0100, Takashi Iwai wrote: 
> > If you don't mind we can keep it as is for now, and once we have
> > capture, mmap and other support built and tested we can merge these?
> 
> Well, such a decision should be done as early as possible.  Changing
> the device file assignment means to change the interface to the
> user-space.  So, this is not allowed once when the code is merge to
> the upstream.
Somehow I was anticipating this
> 
> That said, if you want to fiddle it in your tree, I'm fine.  But,
> until the API is fixed, the code can be never merged.
> 
> I'm OK to keep the direction-separated devices if it's mandatory, but
> note that it's a special handling only for ALSA PCM.  (OSS PCM doesn't
> need it, too.)
Well I am planning to get it merged ASAP, not keep in my tree.

Only reason why I asked is since we don't have mmap support and capture
support, if it all we need to differentiate we should have a way.
Given that, today I don't have a reason why we cant do that if we know
the direction. Something like
if (playback)
	do_this_way;
else
	do_another_way;

So I will take your advice and fix it once for now.


> Hm, but this also change other pr_*().  If you want only the debug
> prints, you can use snd_printdd().  This is compiled conditionally,
> and can show the file, the function and the line number.
I wanted for all prints, its nicer to have this info as well for error
and info prints.

> 
> Do you mean the race of opening the same device or among (all)
> different devices?  For the first case, the lock should be
> device-specific.  For the latter case, I don't understand why.
former case, yes makes sense to use device lock rather than global. I
will split locking now.

> But snd_compr_calc_avail() may return without filling avail->avail, e.g.
> 
> 	if (stream->runtime->bytes_written == 0 &&
> 			stream->runtime->state == SNDRV_PCM_STATE_SETUP) {
> 		pr_debug("detected init and someone forgot to do a write\n");
> 		return stream->runtime->buffer_size;
> 	}
> 
> So, this leaks the uninitialized space.
got it :)

> The biggest problem is the conflict of terminology.
> What do you mean as "frame" and what do you mean as "fragment" in your
> implementation?  At least, the term "frame" is already used in ALSA
> PCM, and I'm not sure whether you use this term for the very same
> meaning in the above context...
fragment is some random number of bytes after which driver will
callback. This is typically used for pushing data to device.

For capture, since application may need to get data on frame basis
(think video recording with encoded video usage, where application needs
audio compressed data on "frame" basis for encapsulation). The DSP is
supposed callback after every encoded frame. I think only difference
between PCM and this is encoding format, otherwise in terms of decoded
data and time they would mean the same.. I am not expert here so maybe
wrong.

> And, another question is how you can guarantee that the capture works
> in that way.  What happens if a hardware updates the data only in the
> fragments level even for the capture?
That would be a buggy driver and I would ask them to read the
documentation. At least it wont work for apps which need data on frame
basis

> 
> Yes, but the substitution of cmd is useless in your code:
> 
> +	case _IOC_NR(SNDRV_COMPRESS_DRAIN):
> +		cmd = SND_COMPR_TRIGGER_DRAIN;
> +		retval = snd_compr_drain(stream);
> +		break;
I should start wearing glasses now


-- 
~Vinod
