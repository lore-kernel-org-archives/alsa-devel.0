From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: buffer_size and period_size
Date: Mon, 27 Jan 2003 12:32:22 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18dD2R-00085w-00@sc8-sf-list1.sourceforge.net>
References: <20030127174509.A28149@osiris.uid0.sk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 27 Jan 2003 17:45:09 +0100."
             <20030127174509.A28149@osiris.uid0.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jozef Kosoru <zyzstar@uid0.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I would like to fully understand the exact meaning of buffer_size and
>period_size and how can I compute the final latency in the full duplex
>processing from these variables.

period_size = frames between interrupts from the hardware
buffer size = total frames for the hardware buffer

max output latency = buffer_size
min output latency = buffer_size - period_size

max input latency = period_size + interrupt overhead
min input latency = 1 frame + interrupt overhead

the latency numbers assume:

    a) the buffer is generally full
    b) you process data 1 period at a time
    c) your s/w keeps up with the h/w
    d) its an average, computed across a period's worth of data

--p


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
