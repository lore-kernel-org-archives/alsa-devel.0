From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: problems with Terratec Aureon Sky 5.1
Date: Sun, 14 Mar 2004 18:21:32 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403141819350.3332@pnote.perex-int.cz>
References: <20040314164136.GA24447@phoenix.hadiko.de>
 <Pine.LNX.4.58.0403141751370.3332@pnote.perex-int.cz>
 <20040314171747.GA24849@phoenix.hadiko.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040314171747.GA24849@phoenix.hadiko.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andreas Bulling <uek32z@phoenix.hadiko.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 14 Mar 2004, Andreas Bulling wrote:

> | And now, 'aplay -Dduplicate' will duplicate stream to all six channels.
> 
> -> slave.pcm "surround51":
> That means that the standard surround51 device should also work right out of
> the box with the ice1724 chip?

Yes, but you must use 32-bit samples. Otherwise the plug plugin will do 
the automatic conversion.

> I was surprised that the format problem has gone ;)

Yes, because the plug plugin is used in my pcm definition.

> Hm... I tried that but it doesn't work - still sound only out of the front speakers with
> xmms and the duplicate output device. Do I need anything else?

If you have volumes up, then it should work.

What does say command 'aplay -v -Dduplicate <somefile>'?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
