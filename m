From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: Re: Re: [Alsa-user] fm801 driver status?
Date: Mon, 16 Dec 2002 21:55:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DFE3DA5.4000700@gmx.de>
References: <3DF8A109.2030206@gmx.de>	<s5hel8nuvee.wl@alsa2.suse.de>	<3DF8B8FA.3040009@gmx.de>	<s5h3cp3uorz.wl@alsa2.suse.de>	<m27keexn25.fsf@vador.mandrakesoft.com>	<3DF9C1CD.3090205@gmx.de>	<s5hisxxubkx.wl@alsa2.suse.de>	<3DFA1166.2020409@gmx.de>	<s5hel8lua27.wl@alsa2.suse.de>	<3DFA25F1.2000705@gmx.de> <s5hznr6roae.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznr6roae.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Thierry Vignaud <tvignaud@mandrakesoft.com>, alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!
Hopefully, the following information is of some help.

Takashi Iwai wrote:

>to be sure, could you elaborate the symptom again and the detail of
>your system (kernel version, applied patches, ALSA version)?
>  
>
kernel: 2.4.19-16mdkcustom, compiled with sound and without alsa. I 
compiled from the kernel source delivered with mandrake 9.0 and did not 
apply any patches.
alsa: cvs snapshot 2002-12-09.tar.bz2 with your patch (that fixes the 
i/o port error in /var/log/messages) applied

system:
duron 850, 128 MB PC 133
NMC (the name changed to enmic, I think) board, KT-133 chipset with via686a.
Award bios 01/10/2001-8363-686A-6A6LMNM9C-00

>especially, please check the following:
>
>- loading the module and unloading it immediately works?
>
yep. /proc/asound builds up immediately, lsmod shows snd, ... modules 
immediately after modprobing

>- the port and irq number are correct, i.e. match with the resources
>  listed on lspci?
>
info from /proc/asound/cards:
FM801-AS at 0xec00, irq 10

lspci output:
00:0b.0 Multimedia audio controller: Fortemedia, Inc Xwave QS3000A
[FM801] (rev a0)
       Subsystem: Fortemedia, Inc: Unknown device 1319
       Flags: bus master, medium devsel, latency 40, IRQ 10
       I/O ports at ec00 [size=128]

(IRQ 10, I/O ec00 also shown by window?)

>- playback (via aplay) works?  does the system hang up at the start,
>  during the playback or at the stop?
>
playback works. I even hear the correct sound when I plug in headphones :-)
The system locks when stopping playback. (If only I had infinite audio 
files...)

>- during the playback, does the count in /proc/interrupts increases?
>  (check with another terminal)
>  
>
the count at '10' (I assume this is irq 10) increases during playback by 
approx. 10-15 per second.

>a typical reason of such a hang up is either the wrong spinlocks,
>unexpected infinite loops in the driver code, or the interrupt
>storms.  if it's the interrupt storm, then it can be related with the
>hardware, often motherboard chipset, or BIOS version.
>or, could it be because of ACPI?  did you apply it?
>  
>
I unselected ACPI before compiling the kernel. ACPI is switched off in 
the bios. (I have only APM running as power management)

>ciao,
>
>Takashi
>  
>
Is there anything else I could do?
cheers,
fe



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
