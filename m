From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio/Midiman - partial success
Date: Mon, 09 Sep 2002 19:46:21 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D7CDE6D.85602095@ladisch.de>
References: <Pine.LNX.4.31.0209090841350.25400-100000@lorien.wv.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Fedor Pikus <fedor_pikus@mentorg.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Fedor G. Pikus wrote:
> > > Why doesn't 48KHz work, and where are higher rates, where is 24bit
> > > recording?
> >
> > These features should be available if the device has correct descriptors.
> > Please post the output of lsusb.
> 
> Wow, that's a long output. Here is is:
> ...

Let's make a nice table from this:

intf alt endpt  rate  bits
0    0   (control, pcm0)
1    0
1    3   out 3  8-48  24
1    4   out 3  8-44  16
2    0
2    3   in 5   8-48  24
2    4   in 5   8-44  16
3    0   (control, pcm1)
4    0
4    1   out 3  88-96 24
4    2   out 3  88-96 16
4    3   out 3  8-48  24
4    4   out 3  8-48  16
5    0
5    1   in 5   88-96 24
5    2   in 5   88-96 16
5    3   in 5   8-48  24
5    4   in 5   8-48  16

The good news is that 24 bits (S24_3LE) should work fine (up to 48 kHz).

The bad news is that this device appears to be broken by design.

There are two PCM devices, but both use the same endpoints.
Consequently, when the driver wants to record from pcm1, it reads
from endpoint 5, but the USB driver then searches for descriptors for
EP 5 and finds those from pcm0 which do not have information about
88.2/96 kHz or 48 kHz at 16 bits.

It may be possible to fake better descriptors by adding a quirk and
some code to the snd-usb-audio driver. I'm not sure whether the host
controller driver had to be aware of the fake, too -- currently, the
alternate settings 1 and 2 wouldn't be found, and wMaxPacketSize
would be too small for 96 kHz.

The two PCM devices cannot be used at the same time anyway, so I think
creating a quirk for interface 0 which says "ignore this" could work.
Takashi, any comments?


Regards,
Clemens


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
