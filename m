From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: quattro usb-audio endianess conversion layer
Date: Mon, 14 Jun 2004 19:14:00 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406141905110.14592-100000@studcom.urz.uni-halle.de>
References: <40CDC671.4020706@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <40CDC671.4020706@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> > Patrick Shirkey wrote:
> >
> >>It turns out the reason for the noise in the input channels all this
> >>time is due to the quattro only reading big endian at input.
>
> I finally was able to test the patch and my first impression is that it
> has made a significant difference

Good.

> My next question is: Does anyone have a good idea how to apply this to a
> jack setup without sacrificing latency?

By adding non-native endianness support to Jack.  (Which requires
supporting different sample formats for playback vs. recording.)


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
