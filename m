From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Re: alsa-devel@lists.sourceforge.net
Date: Mon, 2 Dec 2002 01:14:54 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0212020109070.1113-100000@ecabase.localdomain>
References: <200211212056.33194.info.mz@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200211212056.33194.info.mz@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Ziegler <info.mz@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sorry for the late response..

On Thu, 21 Nov 2002, Mark Ziegler wrote:

> thank you. You are right: my ide-dma is turned off. I only activated it in the 
> SUSE setup, but I've never check if it is really switched on.
> Unfortunately I can not turn on the dma:
[...] 
> linux:/home/woody # hdparm -m 8 -d 1 -u 1 -c 1 /dev/hda
> /dev/hda:
>  setting 32-bit IO_support flag to 1
>  setting multcount to 8
>  setting unmaskirq to 1 (on)
>  setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>  multcount    =  8 (on)
>  IO_support   =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  0 (off)

This is bad. You should check the linux-kernel archives and other 
relevant mailing lists... hopefully some newer kernel provides dma-support 
for your ide-chipset. This is critical for low-latency audio.

> Anyway, I tried again ecasound:
> woody@linux:~> ecasound  -z:db -z:intbuf -i alsa,ice_spdif -o test.wav

Ok, this will give us quite a lot of info:

> (audioio-alsa3) warning! capture overrun - samples lost!  Break was at least 
> 7.60 ms long.
> (audioio-alsa3) warning! capture overrun - samples lost!  Break was at least 
> 215.45 ms long.
> (audioio-alsa3) warning! capture overrun - samples lost!  Break was at least 
> 0.03 ms long.

This means that the xruns are caused by process scheduling latencies, not
by disk i/o scheduling. The longs xruns are probably caused by disk i/o
events that reserve the cpu for a long period of time (dma not used -> all
transfers go through the cpu -> trouble). I'd suggest trying low-latency /
pre-emption kernel patches, and/or finding a kernel with dma support for 
your ide chipset.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
