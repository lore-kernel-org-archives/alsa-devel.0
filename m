From: "Gupta, Kshitij" <kshitij@ti.com>
Subject: RE: buffer producer/consumer sync
Date: Tue, 9 Mar 2004 17:03:37 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <F509E6111989D311B63700805FA761DA09F29071@DBDE01>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Gupta, Kshitij" <kshitij@ti.com>, 'Russell King' <rmk+alsa@arm.linux.org.uk>, Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,
	I was referring to a ARM implementation in the ALSA tree for our
ALSA driver development on OMAP 1610 (ARM 926)
sound\arm\sa11xx-uda1341.c.  Just wanted to know if sa11xx-uda1341.c is also
affected by this problem.  
regards
-kshitij

-----Original Message-----
From: alsa-devel-admin@lists.sourceforge.net
[mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Gupta,
Kshitij
Sent: Tuesday, March 09, 2004 4:11 PM
To: 'Russell King'; Jaroslav Kysela
Cc: alsa-devel@lists.sourceforge.net
Subject: RE: [Alsa-devel] buffer producer/consumer sync


hi,
	Just for your information we are using OSS PCM emulation.  And let
me also first understand the problem :).  Which I am not able to figure out
yet :(. 
regards
-kshitij

-----Original Message-----
From: Russell King [mailto:rmk@arm.linux.org.uk]On Behalf Of Russell
King
Sent: Tuesday, March 09, 2004 3:48 PM
To: Jaroslav Kysela
Cc: Gupta, Kshitij; alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] buffer producer/consumer sync


On Tue, Mar 09, 2004 at 10:53:57AM +0100, Jaroslav Kysela wrote:
> On Tue, 9 Mar 2004, Gupta, Kshitij wrote:
> > > Can someone comment on this and guide a little bit to solve this
problem.
> 
> Yes, on ARM platform you might have problem with MMU / cache coherency, 
> because appl_ptr and hw_ptr are mmaped to user space. I observed this 
> behaviour on SA11xx platform, too.
> 
> Russell King already notified us about this problem. See the mail archive 
> for the proper fix of the midlevel code.

There currently doesn't exist a public fix for this yet, so people using
ARM platforms will have to live without ALSA for the time being.
(Actually, you can still use ALSA but you must use OSS PCM emulation.)

As you say, appl_ptr and hw_ptr have cache coherency problems.  However,
a portable and acceptable solution does not exist today to solve this
problem which would be acceptable to ALSA.  The current preferred
solution is to call flush_dcache_page() on the page whenever the kernel
reads and writes such a page - obviously that is too expensive for ALSA.

Therefore, kernel architecture people need to trash this issue out, but
I'm only interested in doing that post-2.6.4, once we've managed to get
the DMA mapping stuff sorted properly.

Unfortunately I'm busy for the next three days with other stuff, so I
won't be able to look at any of this; I doubt 2.6.4 will be out before
Friday morning anyway.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
