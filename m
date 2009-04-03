From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Device creation order
Date: Fri, 3 Apr 2009 13:56:47 +0200
Message-ID: <20090403115647.GD15646@tango.0pointer.de>
References: <20090403015429.GA702@tango.0pointer.de>
	<alpine.LNX.2.00.0904030904160.17368@eeebox2.perex-int.cz>
	<49D5BCF6.1020407@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AEF51037FF
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Apr 2009 13:56:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49D5BCF6.1020407@ladisch.de>
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

On Fri, 03.04.09 09:38, Clemens Ladisch (clemens@ladisch.de) wrote:

> > - dynamic device creation at runtime - for example we have an
> >    experimental HDA driver configuration code which might change
> >    the arrangement of PCM devices on request from the user space
> > 
> > I would suggest to wait awhile with some small timeout (0.5 sec?) for all 
> > devices to get the usual static arrangement working and handle extra
> > dynamic cases, too.
> 
> The current implementation of the ALSA framework guarantees that the
> control device file is that latest one to be created for all the devices
> created at initialization.  Any devices created later depend on some
> userspace action, so a small timeout won't help in this case.
> 
> In other words:
> 1) When the control device file has been created, all other devices
>    (that are created during sound card initialization) are
>    available.

OK. Very good. I'll then change PA to rely on this behaviour and hope
that this is considered part of the ALSA userspace API and is not
changed in the future...

> 2) When some device file for a specific sound card is created after the
>    card's control device, the sound card configuration has changed.

I'll ignore this for now since Jaroslav mentioned drivers doing this
are still experimental. But eventually we'd need to know some kind of
'end notification' for this as well: i..e if the reconfiguration
causes multiple device nodes to disappear/appear we also need to know
when they are all complete. A possible simple fix would be to issue an
udev 'change' event on the control device after the reconfiguration
finished.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
