From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH v4] ALSA: usb-audio: Fix max packet size
 calculation for USB audio
Date: Sun, 11 Oct 2015 20:54:51 +0200
Message-ID: <alpine.DEB.2.02.1510112024130.10193@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id CAE3826060C
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2015 20:54:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


Rounding must take place before multiplication with the frame size, since =

each packet contains a whole number of frames.

We must also properly consider the data interval, as a larger data =

interval will result in larger packets, which, depending on the sampling =

frequency, can result in packet sizes that are less than integral =

multiples of the packet size for a lower data interval.

Detailed explanation and rationale:

The code before this commit had the following expression on line 613 to =

calculate the maximum isochronous packet size:

	maxsize =3D ((ep->freqmax + 0xffff) * (frame_bits >> 3)) =

			>> (16 - ep->datainterval);

Here, ep->freqmax is the maximum assumed sample frequency, calculated from =
the
nominal sample frequency plus 25%. It is ultimately derived from ep->freqn,
which is in the units of frames per packet, from get_usb_full_speed_rate()
or usb_high_speed_rate(), as applicable, in Q16.16 format.

The expression essentially adds the Q16.16 equivalent of 0.999... (i.e.  =

the largest number less than one) to the sample rate, in order to get a =

rate whose integer part is rounded up from the fractional value. The =

multiplication with (frame_bits >> 3) yields the number of bytes in a =

packet, and the (16 >> ep->datainterval) then converts it from Q16.16 back =

to an integer, taking into consideration the bDataInterval field of the =

endpoint descriptor (which describes how often isochronous packets are =

transmitted relative to the (micro)frame rate (125us or 1ms, for USB high =

speed and full speed, respectively)). For this discussion we will initially
assume a bDataInterval of 0, so the second line of the expression just
converts the Q16.16 value to an integer.

In order to illustrate the problem, we will set frame_bits 64, which
corresponds to a frame size of 8 bytes.

The problem here is twofold. First, the rounding operation consists
of the addition of 0x0.ffff and subsequent conversion to integer, but as the
expression stands, the conversion to integer is done after multiplication
with the frame size, rather than before. This results in the resulting
maxsize becoming too large.

Let's take an example. We have a sample rate of 96 kHz, so our ep->freqn is
0xc0000 (see usb_high_speed_rate()). Add 25% (line 612) and we get 0xf0000.
The calculated maxsize is then ((0xf0000 + 0x0ffff) * 8) >> 16 =3D 127 .
However, if we do the number of bytes calculation in a less obscure way it's
more apparent what the true corresponding packet size is: we get
ceil(96000 * 1.25 / 8000) * 8 =3D 120, where 1.25 is the 25% from line 612, =

and the 8000 is the number of isochronous packets per second on a high =

speed USB connection (125 us microframe interval).

This is fixed by performing the complete rounding operation prior to
multiplication with the frame rate.

The second problem is that when considering the ep->datainterval, this =

must be done before rounding, in order to take the advantage of the fact =

that if the number of bytes per packet is not an integer, the resulting =

rounded-up integer is not necessarily a factor of two when the data =

interval is increased by the same factor.

For instance, assuming a freqency of 41 kHz, the resulting =

bytes-per-packet value for USB high speed is 41 kHz / 8000 =3D 5.125, or =

0x52000 in Q16.16 format. With a data interval of 1 (ep->datainterval =3D 0=
),
this means that 6 frames per packet are needed, whereas with a data =

interval of 2 we need 10.25, i.e. 11 frames needed.

Rephrasing the maxsize expression to:

	maxsize =3D (((ep->freqmax << ep->datainterval) + 0xffff) >> 16) *
			 (frame_bits >> 3);

for the above 96 kHz example we instead get =

((0xf0000 + 0xffff) >> 16) * 8 =3D 120 which is the correct value.

We can also do the calculation with a non-integer sample rate which is when
rounding comes into effect: say we have 44.1 kHz (resulting ep->freqn =3D
0x58333, and resulting ep->freqmax 0x58333 * 1.25 =3D 0x6e3ff (rounded down=
)):

Original maxsize =3D ((0x6e3ff + 0xffff) * 8) << 16 =3D 63 (63.124.. rounde=
d down)
True maxsize =3D ceil(44100 * 1.25 / 8000) * 8 =3D 7 * 8 =3D 56
New maxsize =3D ((0x6e3ff + 0xffff) >> 16) * 8 =3D 7 * 8 =3D 56

This is also corroborated by the wMaxPacketSize check on line 616. Assume
that wMaxPacketSize =3D 104, with ep->maxpacksize then having the same valu=
e.
As 104 < 127, we get maxsize =3D 104. ep->freqmax is then recalculated to
(104 / 8) << 16 =3D 0xd0000 . Putting that rate into the original maxsize
calculation yields a maxsize of ((0xd0000 + 0xffff) * 8) >> 16 =3D 111
(with decimals 111.99988). Clearly, we should get back the 104 here,
which we would with the new expression: ((0xd0000 + 0xffff) >> 16) * 8 =3D =
104 .

(The error has not been a problem because it only results in maxsize being =

a bit too big which just wastes a couple of bytes, either as a result of =

the first maxsize calculation, or because the resulting calculation will =

hit the wMaxPacketSize value before the packet is too big, resulting in =

fixing the size to wMaxPacketSize even though the packet is actually not =

too long.)

Tested with an Edirol UA-5 both at 44.1 kHz and 96 kHz.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
---
V2: Added tested device to commit message. No other changes.
V3: Updated after input from Clemens. Since the expression is now getting
    rather convoluted, added a description in the comments in the code.
    New commit message to reflect the new version. Updated rationale below.
V4: Moved most of the rationale (slightly rephrased) to the commit message
    as suggested by Takashi.

Although the error is tolerable because it just wastes a couple of bytes =

in each packet, however, I'm working on a quirk for a device which stuffs =

an extra four (non sample) bytes into each isochronous packet, and that =

means that the maxsize calculation must take this into account. During =

this work it became obvious that there was something wrong with the =

maxsize calculation, as the resulting packet size when wMaxPacketSize was =

hit did not correspond to the packet size which triggered the if statement =

to start with.

Since this seems to me an obvious (after looking at it for a bit...) bug I'm
submitting this as a separate patch rather than part of an upcoming patch
series.

 sound/usb/endpoint.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index e6f7189..a77d9c8 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -610,8 +610,23 @@ static int data_ep_set_params(struct snd_usb_endpoint =
*ep,
 =

 	/* assume max. frequency is 25% higher than nominal */
 	ep->freqmax =3D ep->freqn + (ep->freqn >> 2);
-	maxsize =3D ((ep->freqmax + 0xffff) * (frame_bits >> 3))
-				>> (16 - ep->datainterval);
+	/* Round up freqmax to nearest integer in order to calculate maximum
+	 * packet size, which must represent a whole number of frames.
+	 * This is accomplished by adding 0x0.ffff before converting the
+	 * Q16.16 format into integer.
+	 * In order to accurately calculate the maximum packet size when
+	 * the data interval is more than 1 (i.e. ep->datainterval > 0),
+	 * multiply by the data interval prior to rounding. For instance,
+	 * a freqmax of 41 kHz will result in a max packet size of 6 (5.125)
+	 * frames with a data interval of 1, but 11 (10.25) frames with a
+	 * data interval of 2.
+	 * (ep->freqmax << ep->datainterval overflows at 8.192 MHz for the
+	 * maximum datainterval value of 3, at USB full speed, higher for
+	 * USB high speed, noting that ep->freqmax is in units of
+	 * frames per packet in Q16.16 format.)
+	 */
+	maxsize =3D (((ep->freqmax << ep->datainterval) + 0xffff) >> 16) *
+			 (frame_bits >> 3);
 	/* but wMaxPacketSize might reduce this */
 	if (ep->maxpacksize && ep->maxpacksize < maxsize) {
 		/* whatever fits into a max. size packet */
-- =

1.7.10.4

-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
