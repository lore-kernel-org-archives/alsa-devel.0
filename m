From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB audio:  TI PCM2900 support
Date: Thu, 30 Jun 2005 16:38:42 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0506301617150.26349-100000@studcom.urz.uni-halle.de>
References: <20050615182733.13471.qmail@web60812.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050615182733.13471.qmail@web60812.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tsw@johana.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tom Watson wrote:
> My recent issue of Nuts & Volts has a project for using the TI (Burr Brown)
> PCM2900 chip.  The whole thing looks pretty simple, just PCM in and out.  I've
> got a couple of questions:
> 1)  This is supposed to be a standard USB audio thing, does it need
>     anything "special"?

No (if it's really compliant with the USB Audio specification, and if
the firmware doesn't have any bugs).

> 2)  In looking over the data sheet (near:
>           http://focus.ti.com/docs/prod/folders/print/pcm2900.html)
>     I see that it has provisions for 3 button inputs.  How would these be
>     implemented to do their function (Mute/Vol up/Vol Down)

It says:
| The HID function is designed as an independent end-point from both
| isochronous-in and -out end-points. This means that the result of
| affection for the HID operation depends on the host software.

Some program would have to read those buttons and change the
appropriate mixer controls.

> 4)  How good are these things?  I suspect that they are at least OK for
>     something as simple (sound wise) as VoIP, but 16 bit 44.1 kHz audio (96 db
>     SNR)??

Having digital processing (like the USB interface) on the same chip
might add noise to the analog part.


HTH
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
