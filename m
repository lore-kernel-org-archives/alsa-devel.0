From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Opening dev/dsp takes very long
Date: Sat, 20 Mar 2004 17:11:36 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403201708340.1816@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0403160917290.14608-100000@studcom.urz.uni-halle.de>
 <4056BF90.2060005@gmx.de> <405AE7B8.6080603@gmx.de> <405B6CFD.9070303@gmx.de>
 <405B88B1.3070204@superbug.demon.co.uk> <405BFEB2.9040402@gmx.de>
 <Pine.LNX.4.58.0403201420340.1816@pnote.perex-int.cz> <405C6CAA.9030709@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <405C6CAA.9030709@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lars Heineken <Lars.Heineken@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 20 Mar 2004, Lars Heineken wrote:

> 
> > It's related to the snd-ice1712 driver and hardware which has the cs8427 
> > transciever. I've added cs8427_timeout module option, so you can
> > lower the reset timeout value for this chip. I left the safe value 50 (0.5 
> > sec) as default. If you set this timeout to very small value, then
> > the S/PDIF output might be broken due to bug in some revisions of this 
> > chip.
> 
> ..but why doesn't it affect alsa, just it's OSS emulation ?

It affects both, but ALSA API does the setup of stream parameters once, 
but OSS API does this multiple times because there is no way to distict 
the configuration phase and the working phase, thus we must reconfigure
after settings of all parameters.

If you strace aplay then you'll see that one ALSA ioctl has exactly same 
0.5 sec peek.

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
