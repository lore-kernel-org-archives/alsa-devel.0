From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: Trivial hdsp.c patch to support rev 50 cards
Date: Sat, 2 Aug 2003 03:38:51 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <34635.80.11.13.118.1059788331.squirrel@www.undata.org>
References: <20030731163611.M29660@vertice.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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
To: nyborg@www.vertice.ca
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> hello,
>
> tried playback of a mono file, to the same ends. yesterday in one
> instance, i got around 45min of stereo playback before  a lock up.
>
> also experienced a lock up in ardour yesterday, monitoring a single
> channel and outputing it on another channel.
>
> haven't tried recording anything to see if the same problem exists
> there.  it's tough to test these things as i'm guaranteed a lock-up, ie:
> my drives have to be fsck'd each time.
>
> does anyone know of a way to safely debug this? can i catch the playback
> thread before it pees on the floor, "NO! Geez hdsp, stream goes out the
> urinal! ...hold that thing, damnit!!!" ?
>
> dan.
>

Can you please give us more informations about your system ?

* hardware (x86, PowerPC, SMP, laptop, cardbus or pci version of the hdsp ?)
* linux kernel version and patches applied
* alsa packages versions
* gcc version used to compile kernel and alsa modules

Thomas





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
