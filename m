From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Trivial hdsp.c patch to support rev 50 cards
Date: Thu, 31 Jul 2003 14:14:01 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGEEPICNAB.mknecht@controlnet.com>
References: <20030731163611.M29660@vertice.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030731163611.M29660@vertice.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dan Nyborg <nyborg@www.vertice.ca>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
> haven't tried recording anything to see if the same problem exists there.
> it's tough to test these things as i'm guaranteed a lock-up, ie: my drives
> have to be fsck'd each time.
>
> does anyone know of a way to safely debug this? can i catch the playback
> thread before it pees on the floor, "NO! Geez hdsp, stream goes out the
> urinal! ...hold that thing, damnit!!!" ?
>
> dan.
>
The only safe way to debug this is to let someone else do it. ;-)

Use ext3/reiserfs and at least the time delays won't be as bad.

Do not have any other applications (email, etc.) open at the same time to
protect those databases.

Have a big, cold beer handy.....

(Sorry the mono thing didn't work. I can play Penguin-Command with lots of
sound and my HDSP 9652 driver works fine. Attempt alsaplayer for 1 second
and I lose all sound. Go figure...) ;-)




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
