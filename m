From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Device creation order
Date: Fri, 3 Apr 2009 13:58:26 +0200
Message-ID: <20090403115826.GE15646@tango.0pointer.de>
References: <20090403015429.GA702@tango.0pointer.de>
	<alpine.LNX.2.00.0904030904160.17368@eeebox2.perex-int.cz>
	<49D5BCF6.1020407@ladisch.de>
	<alpine.LNX.2.00.0904030945380.17368@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 675061037F3
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Apr 2009 13:58:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0904030945380.17368@eeebox2.perex-int.cz>
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

On Fri, 03.04.09 09:50, Jaroslav Kysela (perex@perex.cz) wrote:

> >> - dynamic device creation at runtime - for example we have an
> >>    experimental HDA driver configuration code which might change
> >>    the arrangement of PCM devices on request from the user space
> >>
> >> I would suggest to wait awhile with some small timeout (0.5 sec?) for all
> >> devices to get the usual static arrangement working and handle extra
> >> dynamic cases, too.
> >
> > The current implementation of the ALSA framework guarantees that the
> > control device file is that latest one to be created for all the devices
> > created at initialization.  Any devices created later depend on some
> > userspace action, so a small timeout won't help in this case.
> 
> The timeout might help to let alsactl utility to initialize the 
> soundcard's mixer. But I agree that alsactl should send a HAL message that 
> initial setting was done instead.

This is not an issue AFAICS. udev will run alsactl and only *after* that
finished forward the device creation events to HAL and then PA.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
