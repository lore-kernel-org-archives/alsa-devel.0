From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Scatter Gather
Date: Mon, 01 Mar 2004 13:52:09 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403010928390.5532-100000@studcom.urz.uni-halle.de>
References: <1077905854.6881.28.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1077905854.6881.28.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Manuel Jander <manuel.jander@mat.utfsm.cl>
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Manuel Jander wrote:
> AFAIK, it seems that when using a scatter gather buffer, not every
> period is located inside of a page. ...
> The problem is that a DMA transfer can not go accross 2 different pages.
> On Aureal hardware, even on contiguous buffers this causes all sort of
> odd problems. Each DMA chunk must be on the same page.
> ...
> That means that i would have to split each period that crosses a page
> boundary into 2 DMA chunks, with all the complications involved because
> of irregular sizes, offsets... ARghhh!

Yes.  Every driver using SG must do this.  Look into bt87x.c or
via82xx.c for examples.

> I could just leave the period size as a power of 2, on that way, a
> period would never cross any page boundary, but most ALSA programs are
> too picky to accept that kind of restrictions in most cases.

Devices like usb and ymfpci have a fixed period size, but their
drivers emulate arbitrary period sizes.


Regards,
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
