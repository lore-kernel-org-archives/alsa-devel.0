From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: period_size, periods, count parameters
Date: Fri, 27 Feb 2004 12:18:59 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402271216330.13003-100000@studcom.urz.uni-halle.de>
References: <1077843957.403e97f588b44@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlucom10.urz.uni-halle.de (mlucom10.urz.Uni-Halle.DE [141.48.3.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA25482
	for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2004 12:20:11 +0100
In-reply-to: <1077843957.403e97f588b44@www.imp.polymtl.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mathieu Rondonneau <mathieu.rondonneau@polymtl.ca>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mathieu Rondonneau wrote:

> Selon Clemens Ladisch <clemens@ladisch.de>:
>
> > Mathieu Rondonneau wrote:
> > > I don't understand why count is 1024 ?
> > > why count is not equal to runtime->period_size (i.e. 16*1024)?
> >
> > If your frame size is 4, this is the size of a memory page.  I guess
> > ALSA wants to copy the data one page at a time, and this is required
> > if the buffer isn't contiguous.
>
> How do i know the frame size?
> Is it the runtime->frame_bits value?

Yes IIRC

> I'm using snd_pcm_lib_preallocate_pages_for_all api for memory space allocation.
> Does it mean the buffer isn't contiguous?

The buffer usually is contiguous.  But the copy callback is used for
cases where the real buffer is somewhere else, so it wouldn't need to
be contiguous.


Regards,
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
