From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ALSA: core: Allow drivers to set R/W wait
 time.
Date: Fri, 16 Mar 2018 12:35:06 +0000
Message-ID: <1521203706.7762.390.camel@linux.intel.com>
References: <20180314204440.14027-1-liam.r.girdwood@linux.intel.com>
 <s5hsh928gak.wl-tiwai@suse.de> <1521120937.7762.258.camel@linux.intel.com>
 <s5hin9x76n8.wl-tiwai@suse.de> <1521130059.7762.298.camel@linux.intel.com>
 <c96ee845-31e7-6aae-3218-77ba21a9242e@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 33324267380
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 13:35:10 +0100 (CET)
In-Reply-To: <c96ee845-31e7-6aae-3218-77ba21a9242e@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2018-03-15 at 17:25 +0100, Jaroslav Kysela wrote:
> Dne 15.3.2018 v 17:07 Liam Girdwood napsal(a):
> > On Thu, 2018-03-15 at 15:30 +0100, Takashi Iwai wrote:
> > > > It's not atm, as it was being set by the driver. Would probably mean an
> > > > ABI
> > > > change to PCM ops or a new ioctl ? The latter wont break the ABI and the
> > > > default
> > > > value would remain if the ioctl was not called.
> > > 
> > > Basically this timeout is merely for a safety, wasn't considered as a
> > > part of the real functionality.
> > > 
> > > So, with your plan, this is exposed as a real PCM feature, as a part
> > > of API?  For what kind of scenario / purpose?
> > 
> > Use case is XRUN handling, DMA failure or FW crash detection. The shortened
> > timeout means we can recover far faster leaving a smaller gap in any audio.
> 
> We have the non-blocking access mode for this purpose where the
> application can choose the state check time independently.

Yes, but unfortunately I'm coming across a lot of userspace who are using ALSA
blocking IO as an audio synchronisation mechanism.

> 
> It seems to me, that you like to resolve something else with this. The
> 'error' checking should be handled at the driver level in my opinion.
> 

It mostly is handled by the driver in this case, but userspace may care and is
immediately notified by the IO failing. Fwiw, this is important in safety
critical situations where any failure of audio could be deemed a safety risk
(automotive use cases).

> I see only the possibility to reduce the timeout to a more appropriate
> value (we know all stream and buffering parameters to calculate the
> 'late' time limit). I agree that the current timeout is too big, but
> it's something outside the API as Takashi mentioned.

ok, any objections if I change it directly (in the structure) from the SOF
driver and have some core PCM hw_params() check that makes sure we are good for
period/buffer time ?

Liam

> 
> 					Jaroslav
> 
