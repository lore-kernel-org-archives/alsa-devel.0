From: "Wouters, Michael" <Michael.Wouters@measurement.gov.au>
Subject: Random clicks at beginning of playback when audio length exceeds hardware buffer size
Date: Fri, 23 Jul 2004 09:26:18 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5AE60AD9CA268C49AC231924D4113193579269@s031pvmail.in.measurement.gov.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


(Looks like my first attempt to confirm subscription failed because of
local email
 problems so I'll try again)

Hello,

In my application, I am playing audio data which has an initial period
of silence
followed by audio of variable length and then finishing with a period of
silence.
I am playing sound data repeatedly, with breaks between each playback.
There is about 6 s
of 8 kHz audio, preceded by a few s of silence.

I have noticed that there is a "random" pop at the beginning of audio
playback when=20
the length of the section following the initial silence is bigger than
about 32 K (8 bit data). This amplitude of this pop is random.
This seems to correspond to the size of the hardware buffer. If I try to
set the hardware buffer bigger than 32K it is clamped to 32K so I assume
this is as big as it can get.
BTW the non-dependence on the initial period of silence suggests that
there is some sort of compression to reduce I/O - is this right ?

In my application I am writing from a buffer in non-blocked mode,
looping until the buffer is written.

I am using alsa 1.05a, SBLive!5.1 (emu10k1 driver) and a 2.4.18-5 kernel
(don't ask).

Cheers
Michael Wouters

Time and Frequency Section
National Measurement Institute
Bradfield Road
Lindfield NSW 2070 Australia
Ph  61 2 8467 3501
Fax 61 2 8467 3610



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
