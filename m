From: Friedrich Ewaldt <Friedrich.Ewaldt@gmx.de>
Subject: Re: Re: SiS748/963L + CMI9739, no IRQs from card?
Date: Fri, 05 Dec 2003 21:15:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FD0E75A.6090907@gmx.de>
References: <200312051709.hB5H93Ei005539@cichlid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312051709.hB5H93Ei005539@cichlid.com>
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

many thanks for all your advices!

Indeed, it was a IRQ problem, which was solved automatically when I 
plugged in the terratec Xfire soundcard from my old PC. The BIOS 
reassigned the IRQs and now the onboard sound works, too.

What I've tested so far:
* aplay works

* ac3dec works perfectly with 4 channel output. With 6 channel output, 
the sound of all 6 channels gets chopped, sounds like staccato...

* xine (the version from mandrake9.2) writes a core dump and dies with 
some message about not being able to find a volume control.

* changing the volume does NOT work (always max volume). I think I've 
read about this behavior for this cmedia codec before (IIRC volume 
changes must be done in software). Until this has happened, the onboard 
sound isn't of very much use for me. I could connect it to a preamp or 
some potentiometers...let's see, I'll have to do some more tests (jack, 
mplayer, aoss,...).
thanks!
  fe


Andrew Burgess wrote:

>>have you tried enabling the kernel build options 'IO-APIC support on
>>uniprocessors' and 'Local APIC Support on Uniprocessors' yet (provided
>>your box does ACPI; probably so since you say it is a recent design)?
> 
> 
> Good advice. 
> 
> Also try changing BIOS setting related to interrupts, mine has a
> selection 'assign pci interrupts' or something like that.

unfortunately, this asrock board is a very cheap board. No possibility 
to assign IRQs by hand...
> 
> HTH
> 





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
