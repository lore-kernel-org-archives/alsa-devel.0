From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Juli@-Card and hanging process snd-ak4114/0
Date: Tue, 15 Mar 2005 17:56:37 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0503151755530.21135@pnote.perex-int.cz>
References: <20050310170354.GH78387@mail.webmonster.de>
 <Pine.LNX.4.58.0503101812250.1733@pnote.perex-int.cz>
 <20050315164817.GA86246@mail.webmonster.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E74C9207
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2005 17:57:14 +0100 (MET)
In-Reply-To: <20050315164817.GA86246@mail.webmonster.de>
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

On Tue, 15 Mar 2005, Sebastian Benoit wrote:

> A value of two gives me 40% CPU time, with 100 the process uses ~2%.

Fine. I put 'HZ / 10' value to CVS sources now.

> > It seems that i2c takes too much time. Or it might be, that the scheduler 
> > code for task statistics is somewhat broken.
> 
> My other process behave like they dont get enough time, so i think the
> scheduler stats are right ;-)
> 
> With the value in ak4114.c set to 100 everything is working. I don't know
> about spdif, i haven't tried that, am i right that the ak4114.c code manages
> digital i/o?
> 
> My application is recording and playing (something differen) at the same
> time via this card, and that works fine now, except for the output volume.
> 
> I am willing to test more. Is someone working on the mixer code?

And what does not work exactly? You should have volume controls.
Use alsamixer for reference...

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
