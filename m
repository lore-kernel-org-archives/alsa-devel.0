From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp patch, version II
Date: Wed, 05 Mar 2003 08:21:15 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18qYmT-0003l2-00@sc8-sf-list1.sourceforge.net>
References: <1046862340.1767.30.camel@satellite.undata.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "05 Mar 2003 12:05:40 +0100."
             <1046862340.1767.30.camel@satellite.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>If I try to get out of hanged state with the magic sysrq sigterm or
>sigkill sequence, I get a flood of snd_printk messages from the
>hdsp_fifo_wait(...) function in hdsp.c (line 501), with count = 127.
>There are two places where hdsp_fifo_wait is called with count = 127:
>hdsp_write_gain (line 550)
>hdsp_initialize_firmware (line 3013)
>I checked with the last working code I have, but can't find the problem.
>I tried to switch back to the pre-udelay code in hdsp_fifo_wait, but the
>problem is still here.

we used to have this problem before i added udelay, but it would
manifest differently because the delay wasn't there. it seems that
some (all?) setups with either the cardbus or the multiface (or both)
show this behaviour. 

the code in question is waiting till there are 127 "words" available
in the command FIFO. to be honest, i never understood this code. other
places where we wait, we wait till there are zero "words" available,
which seems nonsensical to me. the idea is that the FIFO only
processes so many words per sample-clock-cycle, and so it can get
filled easily. it can hold a maximum of 128 "words". 

in short, i am confused :) :(



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
