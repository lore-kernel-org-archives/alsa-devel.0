From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: usbus428 0.0.7 patch against release alsa-driver 0.9.6 (was Re: tascam gives a go for us428 @ alsa ...)
Date: Mon, 18 Aug 2003 02:11:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308180211.46184.annabellesgarden@yahoo.de>
References: <200304301356.34023.annabellesgarden@yahoo.de> <20030810232609.GA478@tuba.home> <s5hoeyuj0g1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoeyuj0g1.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net, us428@drehmoment.org
List-Id: alsa-devel@alsa-project.org

> while we're in here: i'm looking at the code now and have some
> questions / suggestions to Karsten:
>
> * the comments in usbus428.c looks like the GPL/BSD dual license but
>   MODULE_LICENSE() is defined as GPL.  is it correct?
i mean "MODULE_LICENSE() is defined as GPL". example solely GPL header please?
>
> * what's the reason of the independent snd-usb-us428-dl module?
>   this module seems doing only feeding the firmware to the interface,
>   so why not in snd-usb-us428 itself?  this will reduce the use of
>   inter_module_* stuffs which are obsolete in 2.6 kernels.
since Pedro's tascam-firmware loader works, there is only one reason to have a 
separate module: it can be unloaded to free memory.
i'll reentegrate the 8001 firmware into the usb-us428 module for 2.6 reasons.
maybe with the FPGA downloader stuff, Martin has mentioned, we can get rid of 
firmware in module at all?
for now: which is the (2.6-)way to tell the kernel that a module's static 
const variable "is pageable" / "can be swaped out" to preserve memory?
>
> * usbus428ctls.c defines mmap & co.  they still be needed?
>   could they be replaced with the standard ALSA control API?
>   (btw, P_us428ctls_sharedmem_u may be unalighed to the page
>    when allocated via kmalloc().  so the mmap code looks buggy for
>    me anyway.  also, please avoid virt_to_phys() as much as possible.
>    this is architecture dependent, and won't run on non-x86 well.)
notice please the us-428 knobs/sliders events can only be received by an 
application in a sense like a users interface. so we have a difference here 
to standard mixer-like controls (opposite direction)?
mmh yes: they are comparable to the laptop's volume knobs..except most of them 
would trigger some app's filters instead of a chip's hardware directly... 
should i investigate that further? alsa-lib can help ?
or: how do i register/operate an alsa-sequencer midi-port from userspace?
which is the kernel function to obtain aligned memory for mmap?
>
> * 64bit division macros can be found in pcm.h.
>   the asm codes in usbus428audio.c can be removed.
>
> * there are still GCC-style of structs initialization in some parts :)
>
> * please follow the coding style described in linux/Documentation/
>   CodingStyle.  spaces after a (open) parenthesis are not common...
>   (i know it's a matter of tastes, but we should keep the consistent
>    style if possible.)
>   also, debug codes which are obviously unnecessary any more should be
>   removed in the release source codes.
>
> * you don't need to modify configure stuff but just add the following
>   to alsa-driver/utils/Modules.dep and run cvscompile again:
>
> 	%dir linux/sound/usb
> 	snd-usb-us428-dl
>
> 	|snd-usb-us428 snd-usb-audio snd-usb-us428-dl
will obey.
>
> thanks!
>
> Takashi

lots of ?. thanks!

Karsten




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
