From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Re: questions for alsa-devel
Date: Thu, 03 Oct 2002 01:12:48 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D9B1B00.1020502@boosthardware.com>
References: <200210021157.g92Bvvk12578@op.net>	<s5hu1k5j939.wl@alsa2.suse.de>	<m2ptutdlpl.fsf@vador.mandrakesoft.com> <s5hn0pxj7f4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Thierry Vignaud <tvignaud@mandrakesoft.com>, Paul Davis <pbd@op.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Hi,
> 
> At Wed, 02 Oct 2002 15:17:10 +0200,
> Thierry Vignaud wrote:
> 
>>Takashi Iwai <tiwai@suse.de> writes:
>>
>>
>>>>2) i recently compiled rc3 on a mandrake 8.2 system. everything
>>>>went smoothly. when i went to modprobe, i got messages suggesting
>>>>to me that there a mismatch between the kernels and the ALSA
>>>>modules with respect to symbol versioning. (several missing
>>>>symbols, all with versions). i've looked through the archives and
>>>>tried google, but i can't see how to fix this or if something else
>>>>is going on.
>>>
>>1) "make mrproper" should be the first step when recompiling a kernel
>>   from the kernel-source package since it has previously be used to
>>   compile our various kernel (up, smp, enterprise [smp+highmem],
>>   secure, linus (no patches), BOOT [for drakx installer]).
>>
>>   most people don't do it and have problems.
>>
>>2) alter the extraversion in main Makefile so that you don't screw up
>>   the mandrake kernel if you make something wrong (there's a rescue
>>   on the first cd but just avoid troubles)
>>   eg: in mdk9.0, we now alter it by default ("EXTRAVERSION = -16mdk"
>>   became "EXTRAVERSION = -16mdkcustom")
>>
>>these 2 items should prevent versionning problems regarding modules
>>
>>3) you can then steal the mdk kernel config from /boot/config (link on
>>   /boot/config-2.4.....)
> 
>  
> it would be nice to collect such info for each distribution and put
> them on alsa's web page.
> 

I will write it up if people send me the info that needs to be included. 
Like this thread.

What should the page be called though?

> 
> 
>>4) note that if you boot with a kernel with alsa-0.9.0, all your alsa
>>   apps won't work unless you use them in oss emulation mode.
> 
>  
> why?  is there any incompatibility?
> 
> 
> Takashi
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
