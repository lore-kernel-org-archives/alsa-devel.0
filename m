From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] sound/cs4231: replace schedule_timeout()
 with msleep_interruptible()
Date: Wed, 3 Nov 2004 10:31:42 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411031024450.25361-100000__31560.2888157175$1099476462$gmane$org@studcom.urz.uni-halle.de>
References: <20041102194019.GA2163@us.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 05D672DF
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2004 10:31:43 +0100 (MET)
In-Reply-To: <20041102194019.GA2163@us.ibm.com>
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
Cc: perex@suse.cz, kernel-janitors@lists.osdl.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nishanth Aravamudan wrote:
> +	time = 250;
>  	while (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) {
>  		spin_unlock_irqrestore(&chip->lock, flags);
>  		if (time <= 0) {
>  			snd_printk("mce_down - auto calibration time out (2)\n");
>  			return;
>  		}
> -		set_current_state(TASK_INTERRUPTIBLE);
> -		time = schedule_timeout(time);
> +		time = msleep_interruptible(time);
>  		spin_lock_irqsave(&chip->lock, flags);
>  	}
>
> Description: Uses msleep_interruptible() instead of schedule_timeout()
> to guarantee the task delays as expected.

The SPARC driver originated as a copy of the ISA driver and still has
the problem that was fixed there, i.e., it uses a single 250 ms wait
(which results in a delay of several seconds if OSS programs try to
enumerate sample rates).

Like the ISA driver, this driver should check the hardware status more
often so that the wait can be aborted as soon as the calibration has
finished.

And this driver doesn't expect do receive signals; using msleep()
would be just fine.


Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
