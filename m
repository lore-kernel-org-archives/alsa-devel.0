From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: What does underrun mean with aplay ?
Date: Fri, 9 Apr 2004 12:51:21 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0404091243350.13421@denise.shiny.it>
References: <004d01c41e0e$6cfa1280$fbf7a8c0@Lapitopi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <004d01c41e0e$6cfa1280$fbf7a8c0@Lapitopi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Robert Rozman <rozman@fri.uni-lj.si>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



> I have some problems with 6 channel sis 7012 device - I'm using it as 3
> stereo channels. I trigger 3 different instances of aplay at once and I get
> underrun messages from aplay.
>
> What does this mean ?

It happens because aplay can't send audio data as fast as the card needs it.

> How to solve this  (bigger buffer? ) ?

Yes, or reduce system load, or run aplay at higher priority (very
recommended, since it requires very little cpu time and low latency), or
buy a faster disk.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
