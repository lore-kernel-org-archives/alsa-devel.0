From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: question on snd minors
Date: Tue, 15 Nov 2011 14:55:33 +0530
Message-ID: <1321349133.1516.134.camel@vkoul-udesk3>
References: <1321330163.1516.51.camel@vkoul-udesk3>
	<s5h62ildh3z.wl%tiwai@suse.de> <1321343139.1516.60.camel@vkoul-udesk3>
	<s5hy5vhbya9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id E5F96245C4
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 10:30:20 +0100 (CET)
In-Reply-To: <s5hy5vhbya9.wl%tiwai@suse.de>
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
Cc: alsa <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-11-15 at 09:11 +0100, Takashi Iwai wrote:
> > For compressed path (i had posted RFC roughly two months back [1]),
> we
> > are creating new devices /dev/snd/comprCxDxp which would be
> registered
> > as SNDRV_DEV_COMPRESS. For the registration part we need to assign
> the
> > minors, right? Hence the above question
> > 
> > Or did I miss something very obvious here...
> 
> Yes, take a look at PCM devices, for example.  They have sub-streams.
> So, you can open a single device file multiple times to assign
> multiple sub-streams.  If any specific substream with a given index is
> needed, it can be specified via ioctl before open.  Otherwise, the
> next empty substream is assigned.
> 
> The similar implementation is found in rawmidi, too.
Okay Thanks a bunch, I wanted to avoid these kind of mistakes :)

right now we don't have PCM devices or substreams notion. The DSP driver
registers the compressed_ops (not pcm) with framework and we create the
device nodes. framework would call them based on state and file_ops
called.

>From what I read in rawmidi and your suggestion about PCM devices, I
think you are suggesting to use a single file ops only (this a single
minor number (or two, including capture) would suffice instead of a
range, right? Any suggestion of which number to use?
(well i followed the usually convention of PCM for minor numbers,
although I cannot envision a device with multiple/large DSPs for audio
offload)

-- 
~Vinod
