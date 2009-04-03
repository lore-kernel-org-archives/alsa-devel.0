From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Device creation order
Date: Fri, 3 Apr 2009 09:20:30 +0200
Message-ID: <20090403072030.GB15466@buzzloop.caiaq.de>
References: <20090403015429.GA702@tango.0pointer.de>
	<alpine.LNX.2.00.0904030904160.17368@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 619C21037FC
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Apr 2009 09:20:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0904030904160.17368@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 03, 2009 at 09:12:34AM +0200, Jaroslav Kysela wrote:
> > PulseAudio listens for hotplugged audio devices via hal/udev. For each
> > card ALSA creates a bunch of device nodes in /dev. Before PA can open
> > the card it needs to make sure that all devices nodes of the card got
> > properly created. I.e. to make sure that surround sound and SPDIF
> > works it is not sufficient to wait until one PCM device is available,
> > but instead that *all* devices that belong to the card are available,
> > i.e. device nodes created with permissions and ACLs set up
> > correctly. Unfortunately there is no signal from udev/hal/kernel that
> > would tell me explicitly that all subdevices of a specific devices are
> > completely enumerated and device files created for. I have been
> > discussing this a bit with Kay Sievers and we came to the conclusion
> > that a simple fix would be if we could rely that the control
> > (i.e. /dev/snd/controlCxx) device is always the last device to be
> > created for a card.
> >
> > Looking at the drivers this seems to be generally the case, so I was
> > wondering if I can rely on this? Do all drivers behave like this? Do
> > all drivers expose a control device? Can we officially declare it part
> > of the userspace API that the control device is the last one to be
> > created?
> 
> Unfortunately, driver may use more complex scenarios like:
> 
> - some hardware requires additional firmware - in this case devices
>    might be created, but they are not useable until firmware is loaded
> - dynamic device creation at runtime - for example we have an
>    experimental HDA driver configuration code which might change
>    the arrangement of PCM devices on request from the user space
> 
> I would suggest to wait awhile with some small timeout (0.5 sec?) for all 
> devices to get the usual static arrangement working and handle extra
> dynamic cases, too.

Wouldn't the real fix be to make sure that the event from hal/udev
happens after all the initialization has finished, i.e. the device got
its firmware, all connected layers finished their work etc? Before all
that, the audio device is not really available, right?

Daniel
