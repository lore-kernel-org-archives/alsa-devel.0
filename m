From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [RFC v2][PATCH 00/11] ALSA: fireface: new driver
 for RME Fireface series
Date: Tue, 22 Dec 2015 17:15:35 +1030
Message-ID: <20151222064535.GZ11792@marvin.atrad.com.au>
References: <1450614523-9367-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151221041439.GC13668@marvin.atrad.com.au>
 <5677F7F6.1050901@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DAA92651DB
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 07:45:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5677F7F6.1050901@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 21, 2015 at 10:00:38PM +0900, Takashi Sakamoto wrote:
> On Dec 21 2015 13:14, Jonathan Woithe wrote:
> > On Sun, Dec 20, 2015 at 09:28:32PM +0900, Takashi Sakamoto wrote:
> >> I note that just powering on, the device is muted.
> > 
> > Only with respect to the audio streams from the PC.  All other
> > hardware-based routing is set up as per the saved device configuration.
> > 
> >> You can de-mute it by write
> >> transaction. For example, by using 'firewire-request' command in
> >> linux-firewire-utils(https://github.com/cladisch/linux-firewire-utils):
> >>
> >> $ ./firewire-request /dev/fw1 write 0x0000801c0000 0x000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000010000000100000001000000
> >>
> >> Currently, libffado gives no way to do it via its mixer interface. Instead, done
> >> in methods to start streaming. I think it better to move de-mute codes to mixer
> >> initialization.
> > 
> > The mutes controlled here apply only to the software audio streams.  I
> > suspect they are utilised to eliminate noise during streaming setup and when
> > the device is idle with respect to the computer.  When other systems mute
> > individual playback channels under user control they do not use these mutes
> > and instead do it in other ways.  The above mutes are only ever turned off
> > and on as part of streaming setup and teardown.  As a result, I think Linux
> > should do the same thing because this is the mode of operation used on other
> > systems and is therefore the "supported" approach.
> > 
> > In other words, I think we should do what all other systems do with these
> > devices and treat this mute register as a part of the streaming setup
> > procedure.
> > 
> > Note in passing that the above firewire-request will only enable output for
> > the first four audio streams.  Others (such as ADAT) will remain muted.  The
> > correct initialisation of the 28 quadlets at 0x0000801c0000 is to set every
> > quadlet to 1.

I made a typo at the end of that last paragraph: the statement should have
read "set every quadlet to 0".  It's a mute state, so the unmuted state is
obviously 0.  The above firewire-request will leave some higher-numbered
channels muted which may be in the unused portion of the FF400 map (I
haven't counted the zeros to know where the 0x1's start).  Apologies for any
confusion caused.

> Could I request your opinion about the fact that the device keeps unmute
> state once unmuted? If your insistent is reasonable, the device should
> get mute every time to start to receive packets.

I'm not quite sure what you mean here.  Are you saying that on your device,
once the block at 0x801c0000 is set to "unmute", that setting it back to
mute has no effect?  Or was this asked as a result of confusion caused by
my typo?

> >> In my previous RFC, I described that zero bits have no effect in write
> >> transactions to 0x00008010051c. But this is wrong. The transaction has
> >> side effect to set the other options.
> > 
> > That would be correct.  0x00008010051c is the start of the FF400's
> > configuration block.  Fields within this set all manner of things including
> > phantom power status, input pads, optical port mode and so on.  Blindly
> > writing zeros will force the device into the physical state represented by
> > that zero byte pattern.
> > 
> >> In this patchset, the state of clock is changed on the way to initialize
> >> transaction.  This is a bit rude but unavoidable.  Fortunately, it's
> >> software's responsibility to read from flash memory and set initial
> >> configuration,
> > 
> > Not quite.  The device powers up with the configuration that is stored in
> > the internal flash memory and does not require any interaction with a
> > computer in order to be functional.  Software needs to synchronise itself
> > with this configuration so as to maintain it.  Forcing a particular
> > configuration is fine for an initial version of a driver, but in time there
> > is a need to be more sophisticated about how this is handled.  The setup of
> > these interfaces can be highly complex and many users rely on the flash
> > memory configuration to avoid time consuming setup at every power on. 
> > Forcing a configuration reset like this can certainly be worked around
> > during initial development, but in the long term the driver needs to
> > preserve device status.
> > 
> > I have several ideas about how this might look but need to wait to see what
> > framework we have to work within before any of that can be solidified.  The
> > primary difficulty is that the configuration register needs to be known by
> > all software components which interact with the device: not just the
> > streaming system.  A way to make the configuration available to usespace
> > will be needed.  In FFADO this was handled with a shared memory segment so
> > it didn't matter which component (streaming, mixer) was started first.  I
> > imagine in FFADO the configuration will be made available via hwdep, /proc/
> > or something similar, ideally in a manner which is transparent to the type
> > of Fireface device in use.
> > 
> > In summary: zeroing out the configuration block is fine for now, but in time
> > this will need to be revisited.
> 
> I'd like to drop the code to send write transactions to the address, and
> leave the decision to userspace. ...

That would be ideal as it would keep the kernel code as clean and
light-weight as possible.  However, the streaming system needs to know some
of the details as set by the configuration block because some of those
settings affect the number of channels being streamed.  The configuration
block is write-only (reading that address returns different information) so
it's not possible to interrogate the device for its current setting.  This
is why software needs to maintain a persistent copy of the device's
configuration that's accessible to both device configuration programs
(running in userspace) and streaming code (running in the kernel).  At the
very least the kernel will need to provide a pass-through interface to the
configuration block so it can keep track of the device's settings.  However,
rather than a non-descript binary block it would be better imho if a more
descriptive interface was used.

Regards
  jonathan
