From: Christoph Lukas <christoph.lukas@gmx.net>
Subject: Re: snd_intel8x0 fails after ACPI sleep
Date: Sat, 13 Mar 2004 19:13:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1079201584.2991.13.camel@beja>
References: <XFMail.20040310104621.pochini@shiny.it>
	 <1078928193.18054.247.camel@renegade> <404F62B1.30206@superbug.demon.co.uk>
	 <1078982128.1838.72.camel@localhost>
	 <1078989194.4050118a9a0df@webmail.mail.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078989194.4050118a9a0df@webmail.mail.gatech.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: gte654n@mail.gatech.edu
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

> I have a Fujitsu E7110 laptop with a builtin audio card.  This is what lspci 
> reports... 
>  
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 
> 02) 
>         Subsystem: Citicorp TTI: Unknown device 1177 
>         Flags: bus master, medium devsel, latency 0, IRQ 11 
>         I/O ports at 1000 [size=256] 
>         I/O ports at 1880 [size=64] 
>  
> I am running 2.6.4-rc2 kernel, and I have been trying to get ACPI S3 (suspend 
> to ram) to wake up correctly.  One of the problems that I am encountering is 
> that with the sound modules loaded (I have always had success with 
> snd_intel8x0 on the same hardware) coming back from sleep freezes my laptop 
> hard.  If I rmmod *all* the sound-related modules before going to sleep, the 
> laptop resumes without a hitch.  However, if I attempt to modprobe 
> snd_intel8x0 after resume, I get a hard freeze again.  I cannot recover any 
> debug output, because the end of /var/log/messages is garbled on reboot. 

I have nearly the same behaviour here with a Dell D800 with the following sound card:

00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24c5 (rev 01)
        Subsystem: Dell Computer Corporation: Unknown device 014e
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at b800 [size=256]
        I/O ports at bc40 [size=64]
        Memory at f4fff800 (32-bit, non-prefetchable) [size=512]
        Memory at f4fff400 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

If I unload usb, network and sound modules before entering S3 I can
resume successfully. 

Reloading the sound modules after resume the behaviour differs depending
on the order I load the modules in.

If I modprobe the snd modules _after_ usb or network modules the system
freezes. 
If I modprobe the snd modules _before_ the others I get the following
messages in the syslog:

Mar 13 18:54:25 beja kernel: PCI: Setting latency timer of device
0000:00:1f.5 to 64
Mar 13 18:54:25 beja kernel: ALSA
/usr/src/modules/alsa-driver/kbuild/../pci/intel8x0.c:1969: AC'97 warm
reset still in progress? [0xffffffff]
Mar 13 18:54:25 beja kernel: Intel ICH: probe of 0000:00:1f.5 failed
with error -5

Is this problem hardware specific or does the alsa system not support
ACPI powermanagement?

I would really like helping to get this to work as this is the only
problem preventing me from using S3. 

I could supply more information if necessary.

Thanks for any hints,
Christoph



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
