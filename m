From: "Rafal Powierski" <powierski@mediascore.de>
Subject: Re: spdif input, source synchronous?
Date: Wed, 23 Jan 2013 22:19:02 +0100
Message-ID: <1B9FEF259F5D4B4F83CD1C9FF0CF0FDB@mediascore.mediascore.de>
References: <50A17AEC.2080102@radagast.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 99FA42602F9
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2013 22:19:02 +0100 (CET)
In-Reply-To: <50A17AEC.2080102@radagast.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dave Platt <dplatt@radagast.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dave,

it took me some time, but I finally got a proper equipment to test ALC886 =

SPDIF input. (hw:1,1,0)
The test results show that the input is not "source synchronous"

experiment:
Analog->digital (spdif,toslink) Audio converter box, where internal crystal =

is removed and replaced with precision adjustable PLL-based gen.
2 simple independent sinus audio generators, providing audio source for ADC =

L,R inputs

software:
stream consequent samples (L,R) are compared.
frequency of identical consequent samples (32bits) is calculated (ppm)
results:
crystal marking is: 12288000 =3D 256*48kHz

gen. Hz | gen. ppm | duplicate probability (ppm)

12288000     0        0
12287856    -11.72    2
12287840    -13.02    4
12287824    -14.32    5
12287808    -15.62    7
12287792    -16.93    9
12287776    -18.22    10
12287760    -19.53    13
12287744    -20.83    14
12287728    -22.13    16
12287712    -23.44    17
12287696    -24.74    18
12287680    -26.04    20
12287664    -27.34    21

It seams that my HDA clock is a bit slower then definition ( about -10ppm)
Therefore resampling starts below -10ppm
It probably means that when spdif signal is 0ppm, about 10ppm of samples ar=
e =

missing.

Is this a bug? or it is planed like this?
Is this a software problem or hardware problem (codec or DMA sequencer) or =

configuration problem?
since it is not a real resampling (no signal reconstruction takes place) =

samples are just repeated or skipped,
it seams not right to me.
Who could comment on this?


Regards,
Rafal


-----Original Message----- =

From: Dave Platt
Sent: Monday, November 12, 2012 11:40 PM
To: powierski@mediascore.de
Subject: re: [alsa-devel] spdif input, source synchronous?

> Does anyone know how the SPDIF input is working on HDA?
> Is it using a source-synchronous data transfer over HDA?
> In my arrangement (ALC886) I can set up any rate and I am receiving a =

> rectangular =93resampling=94.
> =96 is this a bug?
> will this stay? so I can use higher ratio and some kind of software PLL t=
o =

> recover input rate?

I tested out S/PDIF input on my ALC262 setup some time ago.

What I found, at the time, was that the data capture did appear
to be driven by the rate of the incoming signal.  My outboard
ADC provides a 44100 sample/second rate, and that seemed to be
what I was getting.  I tried forcing the capture to 48000 samples
per second, and saw no difference in the captured file size... the
number of samples per second actually captured seemed to be the
same (within experimental error) and I didn't see any evidence
of resampling going on.

Now, this was a capture with "hw:Intel,1" as the device.  I
expect that I would have seen resampling, and a different
type of delivery if I had specified "plughw:Intel,1" or some
other input style which had gone through the plug interface.

Unfortunately I don't have any way of generating a CD-rate
data stream with a specific set of known values... I'd need
a CD player with an S/PDIF output and I don't have one of
those handy.  If I can figure out a way of doing this I'll
try generating a set of CDs with a known-value pattern, play
it, capture it, and see if it does or does not exactly
correlate.
