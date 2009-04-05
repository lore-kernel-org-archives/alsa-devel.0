From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Device creation order
Date: Sun, 5 Apr 2009 16:40:42 +0200
Message-ID: <20090405144041.GA31963@tango.0pointer.de>
References: <20090403015429.GA702@tango.0pointer.de>
	<alpine.LNX.2.00.0904030904160.17368@eeebox2.perex-int.cz>
	<49D5BCF6.1020407@ladisch.de>
	<20090403115647.GD15646@tango.0pointer.de>
	<20090405131605.GA31915@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 4011610381C
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Apr 2009 16:40:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090405131605.GA31915@localhost>
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
List-Id: alsa-devel@alsa-project.org

On Sun, 05.04.09 21:16, Wu Fengguang (fengguang.wu@intel.com) wrote:

> > I'll ignore this for now since Jaroslav mentioned drivers doing this
> > are still experimental. But eventually we'd need to know some kind of
> > 'end notification' for this as well: i..e if the reconfiguration
> > causes multiple device nodes to disappear/appear we also need to know
> > when they are all complete. A possible simple fix would be to issue an
> > udev 'change' event on the control device after the reconfiguration
> > finished.
> 
> btw, HDMI sink devices could be taught to generate more event types:
> 
> - hotplug
>   The user connected/disconnected a HDMI device.

Wouldn't that overlap with the jack sensing API? 

> - reconfiguration
>   The update of HDMI audio capabilities due to some user actions.
> 
> - pause/play of audio stream
>   An advanced feature in Consumer Electronics Control (CEC) for
>   high-level user control of HDMI-connected devices.

What would these be?

> 
> The HDMI audio devices will be created at module loading time, and
> won't be dynamically created/tear down on hotplug events.  I wonder 
> if PA is interested in the HDMI current-connectivity state?

Yes, we certainly are. I am not entirely sure though how to best
expose this. 

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
