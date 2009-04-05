From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: Device creation order
Date: Sun, 5 Apr 2009 21:16:05 +0800
Message-ID: <20090405131605.GA31915@localhost>
References: <20090403015429.GA702@tango.0pointer.de>
	<alpine.LNX.2.00.0904030904160.17368@eeebox2.perex-int.cz>
	<49D5BCF6.1020407@ladisch.de>
	<20090403115647.GD15646@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 483BE2444F
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Apr 2009 15:16:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090403115647.GD15646@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Colin Guthrie <gmane@colin.guthr.ie>, Clemens Ladisch <clemens@ladisch.de>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 03, 2009 at 01:56:47PM +0200, Lennart Poettering wrote:
> On Fri, 03.04.09 09:38, Clemens Ladisch (clemens@ladisch.de) wrote:
> 
> > > - dynamic device creation at runtime - for example we have an
> > >    experimental HDA driver configuration code which might change
> > >    the arrangement of PCM devices on request from the user space
> > > 
> > > I would suggest to wait awhile with some small timeout (0.5 sec?) for all 
> > > devices to get the usual static arrangement working and handle extra
> > > dynamic cases, too.
> > 
> > The current implementation of the ALSA framework guarantees that the
> > control device file is that latest one to be created for all the devices
> > created at initialization.  Any devices created later depend on some
> > userspace action, so a small timeout won't help in this case.
> > 
> > In other words:
> > 1) When the control device file has been created, all other devices
> >    (that are created during sound card initialization) are
> >    available.
> 
> OK. Very good. I'll then change PA to rely on this behaviour and hope
> that this is considered part of the ALSA userspace API and is not
> changed in the future...
> 
> > 2) When some device file for a specific sound card is created after the
> >    card's control device, the sound card configuration has changed.
> 
> I'll ignore this for now since Jaroslav mentioned drivers doing this
> are still experimental. But eventually we'd need to know some kind of
> 'end notification' for this as well: i..e if the reconfiguration
> causes multiple device nodes to disappear/appear we also need to know
> when they are all complete. A possible simple fix would be to issue an
> udev 'change' event on the control device after the reconfiguration
> finished.

btw, HDMI sink devices could be taught to generate more event types:

- hotplug
  The user connected/disconnected a HDMI device.

- reconfiguration
  The update of HDMI audio capabilities due to some user actions.

- pause/play of audio stream
  An advanced feature in Consumer Electronics Control (CEC) for
  high-level user control of HDMI-connected devices.

The HDMI audio devices will be created at module loading time, and
won't be dynamically created/tear down on hotplug events.  I wonder 
if PA is interested in the HDMI current-connectivity state?

Thanks,
Fengguang
