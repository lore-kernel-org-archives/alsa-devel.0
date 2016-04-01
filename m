From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: add support for
 TAS5720 digital amplifier
Date: Fri, 1 Apr 2016 16:14:02 -0500
Message-ID: <20160401211402.GA26370@borg.dal.design.ti.com>
References: <1458580107-4632-1-git-send-email-dannenberg@ti.com>
 <1458580107-4632-3-git-send-email-dannenberg@ti.com>
 <20160328190143.GC2350@sirena.org.uk>
 <20160330025318.GB2073@borg.dal.design.ti.com>
 <20160330153853.GW2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 79F06265173
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 23:14:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160330153853.GW2350@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,
thanks for the continued feedback - please see below.

On Wed, Mar 30, 2016 at 08:38:53AM -0700, Mark Brown wrote:
> On Tue, Mar 29, 2016 at 09:53:18PM -0500, Andreas Dannenberg wrote:
> > On Mon, Mar 28, 2016 at 08:01:43PM +0100, Mark Brown wrote:
> > > On Mon, Mar 21, 2016 at 12:08:27PM -0500, Andreas Dannenberg wrote:
> 
> > > Remove empty funnctions, -ENOTSUPP is expected behaviour for anything
> > > that isn't explicitly supported by a driver.
> 
> > Ok will double-check. Very early during my driver development I was not
> > able to play audio through aplay if this function was not provided. I
> > don't recall what specific Kernel version that was but it may have been
> > something like 4.1.
> 
> This would be a bug in your machine driver then.

Will look at this again in context of later Kernel versions and make
sure we'll get this fixed as needed.

> > As explained in the code comment even with a boiled-down test code that
> > has an empty threaded handler the system would come to a grinding halt
> > when bombarded with interrupts every 300us which I found odd but not
> > completely unexpected (from my MCU background POV that is). And while
> > digging I had seen that the interrupts do get disabled just like you
> > mention during threaded handling to operate in a more graceful manner.
> > But I wasn't sure at this point if the additional (high priority, I
> > suppose) overhead of creating/starting the thread (even an empty one)
> > every 300us was just too much for my poor single-core SoC to handle so
> > my assumption was that it never got cycles to process stuff other than
> > interrupts, and disabling interrupts in the low-level handler fixed just
> > that. But I'm going to spend some extra cycles trying to re-digest the
> > realtime behavior of my particular SoC/setup to understand why exactly
> > this is happening.
> 
> If your device is constantly retriggering the same interrupt that
> suggests there is a problem with how you are handling your device,
> perhaps you need to disable the interrupts at source if it's truly
> broken beyond repair.

The only way to prevent the device from throwing those crazy
300us-spaced SAIF errors would be by (1) providing an always-on SAIF
audio stream (not really a solution...), or (2) by keeping it in
SHUTDOWN most of the time (while not actively playing audio) which is
what I attempted.

> > I'm currently using these handlers to essentially tame the TAS5720
> > error reporting. Only when the device is in shutdown mode it will
> > seize bombarding the host with 300us-spaced FAULT interrupts (that
> > will come as soon as the SAIF stream stops).  Unfortunately that's
> > the way the TAS5720 was designed and I've already provided feedback
> > internally that this makes an elegant / low-overhead SW
> > implementation quite challenging. Anyways I did see several places
> > where this shutdown mode handling could get added so I simply picked
> > the one that was not directly
> > associated with the audio stream itself to make it more explicit what
> > this is about but this can certainly be changed.
> 
> It sounds like this feature is unusably broken...  possibly you could do
> something in the mute handler but it seems that anything you try to do
> to use this feature is going to be both fragile and disruptive to the
> system.

Agreed, this is not the first time this has come up :( Btw in my quest
for a solution one of my earlier implementations actually hooked into
the MUTE handler, but while this worked keeping the TA5720 in shutdown
most of the time it did not completely solve the interrupt-overrun issue
(the TAS5720 would still generate SAIF errors for brief periods,
dead-locking my SoC even with an empty threaded handler). I was also
concerned that hooking such parasitic code into a MUTE handler would be
a bit of an abuse and not make me may friends here.

> What is the value in implementing it?

There is a strong request from one rather large customer to have
interrupt-driven fault handling. I did have an early implementation of
the driver that polled for errors (except SAIF) at the beginning and the
end of the audio playback but this was not good enough.

But thinking about this some more, what if I do not actually use the
interrupt signal, but rather during playback use a timer that fires
every let's say 1s to check the TAS5720 fault register? This way one
would still get critical error reporting _during_ the playback (which is
likely the reason for the customer requirement) of longer audio files,
and while not immediate, this should still give a good enough response
time as the errors being reported (over current, over temp, ...) would
be latched and their detection involves some time constants as well. Any
comments/concerns with such an approach?

Thanks,

--
Andreas Dannenberg
Texas Instruments Inc
