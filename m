From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: Re: AudioScience driver
Date: Wed, 25 Jun 2003 14:58:23 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030625145823.9192.h003.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: fredg@salemradiolabs.com
List-Id: alsa-devel@alsa-project.org

Fred thanks for your feedback

> I've tried building things with the patch, and have some questions:

> 1)  Your directions tell me to execute a './cvsconfigure' command (at the root 
> of the ALSA source tree).  There is no such command in the 0.9.4 tree (at 
> least in the tarball).  Does this patch require use of a checked-out CVS 
> tree?

Sorry Fred, I misremembered the script name...
I meant ./cvscompile  in alsa-driver-0.9.4/
This rebuilds the dependencies so that snd-asihpi is known about and can be
built.

> 2)  What is the name of the module that this should generate?  'snd-asihpi' is 
> coming up as not found.

Correct

3)  What is the exact relationship between the ALSA module and 'asihpi'?  Does 
one need to be loaded for the other to work?  Exactly what is dependent upon 
what?  An example 'modules.conf' setup would be very helpful here!

snd-asihpi needs asihpi.  This is covered automatically by the "depmod -a" that
happens at the end of a make install.
So if you "modprobe snd-asihpi" all the underlying alsa modules + asihpi will
get loaded.

All I have in my modules.conf is "alias snd-card-0 snd-asihpi"

A note about Card indices
snd-asihpi will try to assign the ALSA device index to be the same as the card
index set by the jumpers on the card.  But if the ALSA driver for another card
has already been loaded, then the ASI card will get the next available ALSA card
index instead.

> ... proposed install locations for user lib and include files

Good idea.
how about /usr/include/asihpi/hpi.h

(thinking maybe /hpi/ is not distinctive enough.

- Eliot

Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
