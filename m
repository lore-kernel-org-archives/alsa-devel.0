From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Juli@-Card and hanging process snd-ak4114/0
Date: Thu, 10 Mar 2005 18:14:12 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0503101812250.1733@pnote.perex-int.cz>
References: <20050310170354.GH78387@mail.webmonster.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6B1F31C5
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2005 18:26:27 +0100 (MET)
In-Reply-To: <20050310170354.GH78387@mail.webmonster.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sebastian Benoit <benoit-lists@fb12.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 10 Mar 2005, Sebastian Benoit wrote:

> 
> Hi,
> 
> I already reported this in a note to issue 930 of the ALSA bugtracking
> system:
> 
> I've a Juli@-Soundcard working with the current CVS-driver.
> 
> The main problem is, that a process "snd-ak4114/0" is using 60% of my CPU
> time. I would like to solve this problem, and have started reading trough
> the code. But it seems I need some pointers where to look ;-)

You may try to change queue_delayed_work(chip->workqueue, &chip->work, 1);
to queue_delayed_work(chip->workqueue, &chip->work, 2); (or highter value)
in alsa-kernel/i2c/other/ak4114.c .

It seems that i2c takes too much time. Or it might be, that the scheduler 
code for task statistics is somewhat broken.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
