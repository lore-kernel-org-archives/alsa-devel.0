From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: sc423x's usage of schedule_timeout()
Date: Tue, 2 Nov 2004 13:20:04 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411021308490.27226-100000__41221.0769289688$1099400567$gmane$org@studcom.urz.uni-halle.de>
References: <20041102003031.GD4255@us.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.Uni-Halle.DE [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3D2BD218
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2004 13:20:10 +0100 (MET)
In-Reply-To: <20041102003031.GD4255@us.ibm.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: perex@suse.cz, alsa-devel@alsa-project.org, kernel-janitors@lists.osdl.org
List-Id: alsa-devel@alsa-project.org

Nishanth Aravamudan wrote:
> sound/isa/cs423x/cs4231_lib.c
>
> which contains the following code:
>
> 	timeout = HZ / 4 / 2;
> 	time = 2;
> 	while (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) {
> 		set_current_state(TASK_INTERRUPTIBLE);
> 		time = schedule_timeout(time);
> 		if (time > 0)
> 			continue;
> 		time = 2;
> 		if (--timeout < 0) {
> 			snd_printk("mce_down - auto calibration time out (2)\n");
> 			return;
> 		}
> 	}
>
> This code seems pretty strange, as the delay is in terms of time, which
> seems to mean the loop (as long as the condition is true, of course)
> sleeps for 2 jiffies, then sleeps for another 2, about HZ / 4 / 2 (HZ /
> 8) times. This results in a maximal delay of HZ / 4 jiffies...

This code was introduced in revision 1.29:
http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/isa/cs423x/cs4231_lib.c?rev=HEAD&view=log#rev1.29

Originally, there was a single timeout of 250 ms, but it had to be
split up into several waits to be able to check the chip status more
frequently.

There is no reason to use 2 jiffies -- the code was written assuming
HZ=100 (for 20ms waits), but now this isn't the case anyway.

BTW: Using TASK_INTERRUPTIBLE isn't quite correct because we don't
check for signals here.


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
