From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH] sound/cs4231_lib: replace schedule_timeout() with msleep()
Date: Wed, 3 Nov 2004 09:56:50 -0800
Message-ID: <20041103175650.GD2163__38610.1197488189$1099507003$gmane$org@us.ibm.com>
References: <20041102192913.GA1710@us.ibm.com> <Pine.HPX.4.33n.0411031010440.25361-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.131])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3EC0F230
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2004 18:58:09 +0100 (MET)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id iA3HvJ1p726796
	for <alsa-devel@alsa-project.org>; Wed, 3 Nov 2004 12:57:57 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id iA3Hv9mF148092
	for <alsa-devel@alsa-project.org>; Wed, 3 Nov 2004 10:57:09 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id iA3Hv8I5014479
	for <alsa-devel@alsa-project.org>; Wed, 3 Nov 2004 10:57:08 -0700
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0411031010440.25361-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: perex@suse.cz, alsa-devel@alsa-project.org, kernel-janitors@lists.osdl.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 03, 2004 at 10:22:34AM +0100, Clemens Ladisch wrote:
> Nishanth Aravamudan wrote:
> > [...]
> > How about the following patch?
> 
> Applied, with some changes (see below).
> 
> > I used TASK_UNINTERRUPTIBLE (i.e. msleep()). This, though, will
> > guarantee that the task sleeps *at least* the requested time (20
> > ms per iteration). This may lead to a longer delay than desired,
> > for instance, if perhaps the condition should be checked after
> > each signal.
> 
> This code was never intended to handle signals; using
> TASK_INTERRUPTIBLE was a bug.
> 
> 20 ms happens to be the usual calibration time of the original CS4231
> chip (so it was expected to stop after the first iteration), but there
> are many clones that might need a slightly different time, so I
> changed it to 10 ms.  However, this doesn't really matter. :)
> 
> Finally, I removed the time variable because it wasn't used anymore.

Great,i

Acked-by: Nishanth Aravamudan <nacc@us.ibm.com>

I will resend the sparc patch now.

-Nish


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
