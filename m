From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Is there plans to support SiS7019?
Date: Thu, 19 Aug 2004 13:54:15 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408191353210.1779@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0408191306530.11486-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0408191306530.11486-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Vrihad Shoonya <vrihad@softhome.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 19 Aug 2004, Clemens Ladisch wrote:

> Vrihad Shoonya wrote:
> > > For me looks like 7019 is diffrent from 7018. :-(
> >
> > Now how much effort is required to support it in alsa if we have the
> > register guide with us? We also have an OSS implementation with
> > some bugs related to blocking read of the device.
> 
> It might help if we can take a look at the source.
> 
> Google finds a NetBSD patch at
> <http://www.yasuoka.net/~yasuoka/sis7019.html>, so it's possible.

It looks that the driver must be written from scratch, because hardware is 
different from SI7018 and SI7012.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
