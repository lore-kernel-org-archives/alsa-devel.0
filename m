From: Warren Turkal <wturkal@cbu.edu>
Subject: Re: refactoring of maestro continues
Date: Mon, 21 Jul 2003 21:41:24 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307212126.51320.wturkal@cbu.edu>
References: <200307190159.44755.wturkal@cbu.edu> <s5hwuechro3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwuechro3.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 21 July 2003 09:37 am, Takashi Iwai wrote:
> Hi Warren,
>
> At Sat, 19 Jul 2003 01:59:44 -0500,
>
> Warren Turkal wrote:
> > Here is a patch against the HEAD of linus' tree. This time there are no
> > AC97 defines in maestro3.c for the generic AC97 support.
>
> thanks.
>
> but i thought we agreed to move ASSP things to maestro3 part..?

I thought you said they were relevant for other maestros also...even if they 
weren't used yet.

>
> please let me know if you think it's enough good to merge into cvs.
>

Not yet...I can get better separation, and I need to remove the huge comment 
in maestro.h.

Sayonara, Warren
-- 
Treasurer, GOLUM, Inc.
http://www.golum.org



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
