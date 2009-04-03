From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Device creation order
Date: Fri, 3 Apr 2009 13:43:59 +0200
Message-ID: <20090403114359.GB15646@tango.0pointer.de>
References: <20090403015429.GA702@tango.0pointer.de>
	<alpine.LNX.2.00.0904030904160.17368@eeebox2.perex-int.cz>
	<20090403072030.GB15466@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B1FC103884
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Apr 2009 13:44:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090403072030.GB15466@buzzloop.caiaq.de>
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

On Fri, 03.04.09 09:20, Daniel Mack (daniel@caiaq.de) wrote:

> > Unfortunately, driver may use more complex scenarios like:
> > 
> > - some hardware requires additional firmware - in this case devices
> >    might be created, but they are not useable until firmware is loaded
> > - dynamic device creation at runtime - for example we have an
> >    experimental HDA driver configuration code which might change
> >    the arrangement of PCM devices on request from the user space
> > 
> > I would suggest to wait awhile with some small timeout (0.5 sec?) for all 
> > devices to get the usual static arrangement working and handle extra
> > dynamic cases, too.
> 
> Wouldn't the real fix be to make sure that the event from hal/udev
> happens after all the initialization has finished, i.e. the device got
> its firmware, all connected layers finished their work etc? Before all
> that, the audio device is not really available, right?

But still, we'd need some kind of 'end marker' to know when all
devices are set up properly. Just delaying the device creation events
and then triggering them all at once doesn't really fix the entire
issue.


Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
