From: T-Online <k.fetscher@t-online.de>
Subject: Re: ALSA Driver for ARM
Date: Tue, 29 Mar 2005 23:31:08 +0200
Message-ID: <4249C91C.9000000@t-online.de>
References: <42480A24.5070602@fetron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42480A24.5070602@fetron.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have a new hint, but the problem is not solved.

> I want to programm an driver for the Cirrus CS42516 and the ARM9 CPU 
> EP93xx also from Cirrus.
>
> I think, there are several errors:
>
> - when I start aplay, I receive a buffer. A dump to this memory region 
> show only zeros.
>
I have written some characters into the DMA Memory Area (with a Hardware 
Debugger) when the driver is started, but aplay is not started. After I 
start aplay, all my characters are overwritten with Zero.

Which function in ALSA is responsible for filling the DMA Buffer ?

> - after the complete buffer is transmitted (but not the complete 
> file), I receive an underrun from ALSA
>
> - I never detect a mmap function call.
>
>  

Thanks,

Klaus


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
