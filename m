From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Problem deducing buffer time with non-integer samplerate?
Date: Thu, 04 Mar 2004 14:30:08 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opr4cagij0q1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi

A PortAudio user has been experiencing a problem with his SB128 (Ensoniq=20
AudioPCI driver), which we tracked down to a call to=20
snd_pcm_hw_params_get_buffer_time returning -EINVAL. A dump of the curren=
t=20
hw configuration space looks like this:
ACCESS:  MMAP_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: (44099 44100)
PERIOD_TIME: (5804 5805)
PERIOD_SIZE: 256
PERIOD_BYTES: 1024
PERIODS: 5
BUFFER_TIME: (29024 29026)
BUFFER_SIZE: 1280
BUFFER_BYTES: 5120
TICK_TIME: 10000

Is the problem that the delta between min and max BUFFER_TIME exceeds one=
=20
(1)? The exact samplerate is 44099.81 which should correlate with the=20
integer min/max values. While I'm at it, is it correct to translate=20
samplerate fractions from 0.5 and upwards to dir =3D=3D -1 and 1 for frac=
tions=20
less than 0.5 (ie. 44099.81 translates to 44100 with dir =3D=3D -1)? Ther=
e's=20
also a "bug" in the documentation for snd_pcm_hw_params_set_buffer_size,=20
which mentions "dir", although its not part of the function signature.

Thanks

Arve Knudsen


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
