From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Device creation order
Date: Fri, 3 Apr 2009 13:51:55 +0200
Message-ID: <20090403115155.GC15646@tango.0pointer.de>
References: <20090403015429.GA702@tango.0pointer.de>
	<alpine.LNX.2.00.0904030904160.17368@eeebox2.perex-int.cz>
	<20090403072030.GB15466@buzzloop.caiaq.de>
	<alpine.LNX.2.00.0904030921280.17368@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id F2D2F103898
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Apr 2009 13:51:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0904030921280.17368@eeebox2.perex-int.cz>
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

On Fri, 03.04.09 09:31, Jaroslav Kysela (perex@perex.cz) wrote:

> >> I would suggest to wait awhile with some small timeout (0.5 sec?) for all
> >> devices to get the usual static arrangement working and handle extra
> >> dynamic cases, too.
> >
> > Wouldn't the real fix be to make sure that the event from hal/udev
> > happens after all the initialization has finished, i.e. the device got
> > its firmware, all connected layers finished their work etc? Before all
> > that, the audio device is not really available, right?
> 
> But even with this extension, the user space should handle dynamic device 
> reconfiguration (my second example case). The question is, if it makes 
> sense to handle group of devices per card basis or just take single 
> devices and dynamically handle device changes.
> 
> Lennart, why you need to enumerate all devices per card at one time? I 
> think that having mixer access plus one PCM device is enough for minimal 
> configuration for PA.

PA has no clue how the different PCM device nodes of a card relate to
each other. To my knowledge Creative cards have multiple PCM device
nodes that are combined in userspace via 'multi' to make one surround
device. When PA wants to open that we need to make sure that all PCM
devices that are necessary for that are fully created. Since we have
no clue how the PCM devices relate to each other we have no other
option than to wait for all PCM devices.

Also, as Colin noted we probe a few possible combinations of how we
can open the audio device to know which combinations the sound card
supports. It's a bit ugly and slow but the only option right now since
the name hinting API is too limited for this since it does not tell us
which devices can be used simultaneously and which ones are exclusive.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
