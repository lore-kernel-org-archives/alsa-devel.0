From: Mathieu Rondonneau <mathieu.rondonneau@polymtl.ca>
Subject: Re: period_size, periods, count parameters
Date: Thu, 26 Feb 2004 20:05:57 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1077843957.403e97f588b44@www.imp.polymtl.ca>
References: <Pine.HPX.4.33n.0402261735200.25586-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.polymtl.ca (IDENT:0@smtp.polymtl.ca [132.207.4.11])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id CAA15220
	for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2004 02:06:03 +0100
In-Reply-To: <Pine.HPX.4.33n.0402261735200.25586-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Selon Clemens Ladisch <clemens@ladisch.de>:

> Mathieu Rondonneau wrote:
> > I don't understand why count is 1024 ?
> > why count is not equal to runtime->period_size (i.e. 16*1024)?
> 
> If your frame size is 4, this is the size of a memory page.  I guess
> ALSA wants to copy the data one page at a time, and this is required
> if the buffer isn't contiguous.


How do i know the frame size?
Is it the runtime->frame_bits value?
the frame_bits is 16.

I'm using snd_pcm_lib_preallocate_pages_for_all api for memory space allocation.
Does it mean the buffer isn't contiguous?

Thank you for your help.

Mathieu






-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
