From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: about usb midi endpoints quirks
Date: Thu, 31 Jul 2003 13:19:08 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0307311309240.10293-100000@studcom.urz.uni-halle.de>
References: <20030730194936.GA21226@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20030730194936.GA21226@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Martin Langer wrote:
> On Wed, Jul 30, 2003 at 09:58:18AM +0200, Clemens Ladisch wrote:
> > The MIDI quirk structure has separate fields for input and
> > output endpoints, so you must not use 0x80 in this case.
>
> must not???
>
> It doesn't work with the 0x80 flag!!!
> Only the 0x00 flag works! That was the point I've tried to explain.

And this is exactly the same what I tried to say. "you must not" =
"you are not allowed to".


Regards
Clemens




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
