From: cliffw@easystreet.com
Subject: Re: usb-audio - kernel oops 2.5.72
Date: Mon, 23 Jun 2003 23:54:46 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306240654.h5O6skru003183@oldred.easystreet.com>
References: <tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Message from Takashi Iwai <tiwai@suse.de>
   of "Mon, 23 Jun 2003 15:01:09 +0200." <s5hptl52bje.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: cliffw@easystreet.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> At Sun, 22 Jun 2003 20:45:09 -0700,
> cliffw@easystreet.com wrote:
> > 
> > 
> > Am attempting to get linux-2.5.72 + snd-usb-audio happening.
> > Results have been poor. Machine is VIA C3, ALSA + jack working 
> > fine with the built-in via audio. Tried various kernels, 
> > real ugly failures with 2.5.70, also have tried 2.5.72-mm2. 
> 
> i fixed a bug in usb-audio driver on the cvs now.
> there are some calls of functions which may call schedule() in the
> spinlock.
> 
> please try the cvs version.
Am attempting, so far compile errors in serialmidi....am
getting the whole tree now. 
Will try again tomorrow.
cliffw
> 
> 
> ciao,
> 
> Takashi
> 




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
