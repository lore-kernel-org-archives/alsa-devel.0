From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Reproducible deadlock w. alsa/maestro3 when sleeping
 (ACPI,) 2.6.0-test1
Date: Wed, 16 Jul 2003 16:18:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F156CD8.6010308@superbug.demon.co.uk>
References: <200307141917.22813.p_christ@hol.gr> <s5h7k6i1yoa.wl@alsa2.suse.de> <200307161718.50464.p_christ@hol.gr> <200307161803.48574.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200307161803.48574.p_christ@hol.gr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "P. Christeas" <p_christ@hol.gr>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

P. Christeas wrote:
>>Takashi Iwai wrote:
>>
>>>At Mon, 14 Jul 2003 19:17:22 +0300,
>>>
>>>P. Christeas <p_christ@hol.gr> wrote:
>>>
>>>>I have been experiencing some fully reproducible deadlock when waking
>>>>from sleep, using artsd over ALSA.
>>>>The scenario is:
>>>>I use ALSA, with the maestro3 device and everything else compiled as
>>>>modules. From userspace, I launch artsd, which uses its native ALSA
>>>>support to connect to /dev/pcmXXXXX .
>>>>I only have a custom script, which sleeps the machine by a 'echo 1>
>>>>/proc/acpi/sleep' . It does NOT stop alsa .
>>>
>>>could you check whether m3_suspend() and m3_resume() in
>>>sound/pci/maestro3.c are really called?
>>>
>>>
>>>Takashi
>>
>>OK, I did that.  I put two messages in both functions of the maestro3
>>driver. I suspended/resumed the machine. Both functions had been called.
>>
>>This time, I did NOT have 'artsd' (i.e. the client) loaded. What happened
>>was that the module was properly restored and I could load (and use) artsd
>>even after the resume.
>>That brings me to the first assumption/question I have made: is there
>>something wrong if we suspend two parts (one module and a userspace
>>process), while they inter-communicate through the /dev/* interface?
>>
>>
> 
> In a second test, I have also added messages at the end of these functions. 
> They surely don't exit early indeed.
> 
> Has anybody else managed to reproduce the bug?
> Does it happen with other drivers (say, PCI cards w. pcm interface)?
> 
> procedure:
> 	(read the last step first; it is a warning)
> 	1. load the sound module, like 'modprobe snd-maestro3'
> 	2. load the client ("artsd" should be the one, others may eventually release 
> the descriptor. If you want, you could give them a try as well.) 
> 	3. Suspend, S1, NOT with an all-capable script. The script you use must not 
> try to bring down ALSA.
> 	4. Resume.
> 	5. Check the state of the "artsd" (or equivalent) process.
> 
> 	W. Note that if the process is waiting for I/O, you can do nothing but 
> reboot.
> 
> 
> 
I get a similar sort of problem, but that is with an USB sound card, and 
one unplugs the usb cable.
The process (in my case a media appication) is waiting for a return from 
a call to alsa-lib, but the return from the call never happens.
Maybe suspending a PCI sound card is similar to unplugging a USB sound 
card. In both cases, the device does not respond anymore, but alsa-lib 
fails to return an error to the application, but instead never returns.

Cheers
James






-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
