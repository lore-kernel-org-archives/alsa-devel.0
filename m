From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: cannot submit datapipe for urb 0 on /dev/dsp access
 -extigy
Date: Mon, 05 Apr 2004 18:02:54 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404051800420.25421-100000@studcom.urz.uni-halle.de>
References: <20040402212657.75BE312D00@mprdmxin.myway.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlucom10.urz.uni-halle.de (mlucom10.urz.uni-halle.de [141.48.3.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA29556
	for <alsa-devel@alsa-project.org>; Mon, 5 Apr 2004 18:03:00 +0200
In-reply-to: <20040402212657.75BE312D00@mprdmxin.myway.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "John H." <mrmailer@myway.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John H. wrote:
> see, this is what is weird, it worked last week, now it doesn't
> work with exaudio or alsa! same errors!

Then it's not a problem of the sound driver.

> cannot submit datapipe for urb 0, err = -38

-38 means "not implemented".  Probably some bug in the USB core in
your kernel.

Have you connected the device through a USB 2.0 hub?


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
