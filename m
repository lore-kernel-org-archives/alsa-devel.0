From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: USB Audio problems
Date: Thu, 20 Nov 2003 23:33:52 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBCD0D0.3020404@boosthardware.com>
References: <3FBBC461.1020006@opersys.com>	<3FBC560B.7040104@opersys.com> <s5hoev7ywfw.wl@alsa2.suse.de>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: karim@opersys.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> the current code is surely buggy, because it issues sync unlink
> inside the spinlocked context.  it's problematic on 2.6 kernel or SMP
> system, and may result in kernel oops.  i added async_unlink module
> option to change the behavior in the new version.
> 
> but it's still disabled as default, because unlinking multiple urbs
> asynchronouly on 2.4 kernel causes kernel panic.  sigh.
> unfortunately, there is no perfect solution to satisfy all versions
> yet.  perhaps we need to redesign the linked-pcm streams to make it
> possible to call prepare callback without spinlocks.
> 
>

Ahhh, Finally an explanaiton for why my root /var/ partition is always 
being filled up with usb errors.

Would this also have a detrimental effect on latency? If so then I can 
let other usb-audio user know why.


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
