From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: sc423x's usage of schedule_timeout()
Date: Mon, 1 Nov 2004 16:30:31 -0800
Message-ID: <20041102003031.GD4255__22513.8800604784$1099357099$gmane$org@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.132])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C473A212
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2004 01:30:35 +0100 (MET)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id iA20UXJ8409988
	for <alsa-devel@alsa-project.org>; Mon, 1 Nov 2004 19:30:33 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id iA20UXbN171410
	for <alsa-devel@alsa-project.org>; Mon, 1 Nov 2004 17:30:33 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id iA20UXL9024851
	for <alsa-devel@alsa-project.org>; Mon, 1 Nov 2004 17:30:33 -0700
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, kernel-janitors@lists.osdl.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am going through the kernel, as part of the Kernel-Janitors TODO and
replacing schedule_timeout() with msleep() and its variants. In this
process, I came across

sound/isa/cs423x/cs4231_lib.c

which contains the following code:

	timeout = HZ / 4 / 2;
	time = 2;
	while (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) {
		set_current_state(TASK_INTERRUPTIBLE);
		time = schedule_timeout(time);
		if (time > 0)
			continue;
		time = 2;
		if (--timeout < 0) {
			snd_printk("mce_down - auto calibration time out (2)\n");
			return;
		}
	}

This code seems pretty strange, as the delay is in terms of time, which
seems to mean the loop (as long as the condition is true, of course)
sleeps for 2 jiffies, then sleeps for another 2, about HZ / 4 / 2 (HZ /
8) times. This results in a maximal delay of HZ / 4 jiffies...

This just seemed like a very strange coding style. Perhaps that is just
me, though.

My first concern, though, is whether perhaps here the time and timeout
values have been switched, as it's unusual to treat any variable whose
value is expressed in terms of HZ as a counter (or really anything
except a time variable).

Please let me know if this code should be left as is, or should be fixed
(and how?).

Thanks,
Nish


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
