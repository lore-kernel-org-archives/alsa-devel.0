From: Delio Brignoli <dbrignoli@audioscience.com>
Subject: Re: Re: [PATCH] asihpi update
Date: Sat, 19 Nov 2005 00:58:37 +1300
Message-ID: <437DC1ED.6020409@audioscience.com>
References: <437D1FAE.3000400@audioscience.com> <s5hy83mp5i1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy83mp5i1.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 18 Nov 2005 13:26:22 +1300,
> Delio Brignoli wrote:
> 
>>Hello Takashi,
>>
>>this patch brings asihpi directory in alsa up to date with our internal 
>>CVS repo. To be able to maintain ALSA reasonably up to date I've written 
>>a preprocessor to strip most of the OS related code and generate asihpi 
>>files automatically from a CVS workdir.
> 
> 
> Well, I don't this it's good to go to this way.  We have imported the
> stuff to CVS.  These codes have to be updated appropriately, too, not
> generated at compile time.

I think there is a misunderstanding, we do not plan to force people to 
generate the ALSA source at compile time BUT we need to be able to 
generate the source code for ALSA from our CVS automatically.
Once this patch (or a cleaner version of it) is accepted, we are going 
to send only differences. Is that ok?

> Please consider the following, too:
> 
> - Replacement of HW8/HW16/HW32 with u8/u16/u32 types.
>   Replacement of PLONG, etc, too.
> 
> - Don't set EXTRA_CFLAGS.  They can be either in a local header for
>   static definitions, or derived from Kconfig (CONFIG_XXX).
> 
> - No static hotplug directory in the kernel code.
> 
> - Proper indentation and spaces.  The indent is 8-chars in K&R style.
>   Fold too long lines in 80 chars.
>   See $KERNEL/Documentation/CodingStyle for details.
>   If processing using a script, you can use "indent" program, too.

I'll make these changes.

> This change looks wrong.  dwSerialNumber is HW32, so it's fine with
> %d.  %ld is for long type.

which version of gcc is the 'default' one for compiling ALSA?
I get a warning for using %d with HW32, I'll double check.

>>-#include "hpios.h"        // for defn. 
>>+#include <hpios.h>        // for HFAR defn. 
> 
> 
> We shouldn't use <> for local headers.

fixed this already.

thanks
--
Delio


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
