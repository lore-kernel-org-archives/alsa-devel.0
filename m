From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sst: Intel SST audio driver
Date: Sun, 17 Oct 2010 11:36:27 +0100
Message-ID: <20101017103626.GB6311@opensource.wolfsonmicro.com>
References: <20100930162123.21348.86482.stgit@localhost.localdomain>
	<20101002230610.GA21181@sirena.org.uk>
	<20101003112244.488282fd@linux.intel.com>
	<20101003201943.GA31764@opensource.wolfsonmicro.com>
	<20101004100424.4e5cf40c@linux.intel.com>
	<s5hr5fpur7u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BE6AC2446D
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Oct 2010 12:36:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hr5fpur7u.wl%tiwai@suse.de>
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
Cc: greg@kroah.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 17, 2010 at 11:02:45AM +0200, Takashi Iwai wrote:

> SST driver has been once (sort of) posted and reviewed, but stalled
> since then.  But in general I'm not against merging to the sound main
> tree at all.  The only reason that it didn't occur was that the
> activity just stopped somehow.

I'm really concerned about this idea.  Allowing embedded vendors to push
drivers into mainline which don't work with the standard frameworks for
what they're doing sets a bad precedent which makes it much harder to
push back on other vendors who also want to push their own stacks.

This sort of thing is very common in the embedded space for audio, to a
large extent because other OSs don't have any sort of standard framework
for representing the hardware.  The experience is that it's always
pretty painful if there's any active work with the device - hardware
changes that should be straightforward like substituting a new CODEC or
even changing the physical configuration of the outputs become much more
involved.  You can see in the current code that the bulk of the audio
configuration is register write sequences for various operations, at
best you end up needing to replicate those into each vendor's stack for
each CODEC that gets deployed and at worst you end up replicating
everything per-board rather than per-CPU.  This isn't great for anyone,
it's a lot more work and a lot less clear.

The Moorestown CPU appears to be very standard embedded audio hardware -
a CPU communicating with an external CODEC over I2S/PCM data links - and
so I can't see any reason why we should treat it differently to other
such hardware.
