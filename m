From: "P. Christeas" <p_christ@hol.gr>
Subject: Re: Reproducible deadlock w. alsa/maestro3 when sleeping (ACPI,) 2.6.0-test1
Date: Thu, 17 Jul 2003 19:14:16 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307171914.16811.p_christ@hol.gr>
References: <200307141917.22813.p_christ@hol.gr> <200307161803.48574.p_christ@hol.gr> <3F156CD8.6010308@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F156CD8.6010308@superbug.demon.co.uk>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> >>This time, I did NOT have 'artsd' (i.e. the client) loaded. What happened
> >>was that the module was properly restored and I could load (and use)
> >> artsd even after the resume.
> >>That brings me to the first assumption/question I have made: is there
> >>something wrong if we suspend two parts (one module and a userspace
> >>process), while they inter-communicate through the /dev/* interface?
> >
> > In a second test, I have also added messages at the end of these
> > functions. They surely don't exit early indeed.
> >
> > Has anybody else managed to reproduce the bug?
> > Does it happen with other drivers (say, PCI cards w. pcm interface)?
> >
> > procedure:
> > 	(read the last step first; it is a warning)
> > 	1. load the sound module, like 'modprobe snd-maestro3'
> > 	2. load the client ("artsd" should be the one, others may eventually
> > release the descriptor. If you want, you could give them a try as well.)
> > 3. Suspend, S1, NOT with an all-capable script. The script you use must
> > not try to bring down ALSA.
> > 	4. Resume.
> > 	5. Check the state of the "artsd" (or equivalent) process.
> >
> > 	W. Note that if the process is waiting for I/O, you can do nothing but
> > reboot.
>
> I get a similar sort of problem, but that is with an USB sound card, and
> one unplugs the usb cable.
> The process (in my case a media appication) is waiting for a return from
> a call to alsa-lib, but the return from the call never happens.
> Maybe suspending a PCI sound card is similar to unplugging a USB sound
> card. In both cases, the device does not respond anymore, but alsa-lib
> fails to return an error to the application, but instead never returns.
>
> Cheers
> James

If you verify that you are unable to 'kill -9' the client application, then 
the problem becomes just little more serious. IMHO no such actions should 
cause the kernel to have 'blocked' resources.

One important observation I have is that 'esd' doesn't produce the bug. Esd 
uses '/dev/sound/dsp' rather than '/dev/snd/pcmXXX' (oss-emu. rather than 
ALSA). I don't even know what level of 'feedback' (in terms of function 
returns) OSS provides, in comparison to the ALSA system.





-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
