From: Ross Miller <miller@penguinstation.net>
Subject: AudioTrak Optoplay...
Date: Mon, 2 Jun 2003 14:18:26 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306021418.26840.miller@penguinstation.net>
Reply-To: miller@penguinstation.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Note: This is a repost of an email I sent a week ago which is still await=
ing=20
moderator approval.   I'm now a subscriber, so hopefully this post will g=
o=20
right through....

There was a thread on the alsa-user list back in March discussing Audiotr=
ack=20
products, and specifically the Optoplay USB device.  The relevant bits ar=
e:

>> The Optoplay, listed as '?' on the matrix, seemed to work OK, the driv=
ers
>> loaded but - no sound output. This is the same as the problem someone
>> reported a coulpe of months ago - it only works at 24 bits, and while =
the
>> driver loads, apps only try to open the device @ 16 bits, which doesn'=
t=20
>>work.
>
>This is only for OSS apps. ALSA programs (e.g. aplay) probably would hav=
e
>worked.
>

Having just tried it out on version 0.9.3c, I can confirm that the optopl=
ay=20
DOESN'T work, even at 24 bits, using aplay.   However, it can be made to =
work=20
with a quick hack to the driver code.  I'll get to that below.  First, he=
re's=20
the errors I get from aplay:

snoopy:/usr/local/alsa/bin # ./aplay ~/24bit.wav
Playing WAVE '/root/24bit.wav' : Signed 24 bit Little Endian in 3bytes, R=
ate=20
44100 Hz, Mono
ALSA lib pcm_hw.c:436:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE failed=
:=20
Connection timed out
aplay: set_params:840: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S24_3LE
SUBFORMAT:  STD
SAMPLE_BITS: 24
FRAME_BITS: 24
CHANNELS: 1
RATE: 44100
PERIOD_TIME: (61927 61928)
PERIOD_SIZE: 2731
PERIOD_BYTES: 8193
PERIODS: (3 4)
BUFFER_TIME: (247664 247665)
BUFFER_SIZE: 10922
BUFFER_BYTES: 32766
TICK_TIME: 10000

Also, the following lines are printed in the syslog:
May 24 23:28:17 snoopy kernel: usb-uhci.c: interrupt, status 2, frame# 98=
5
May 24 23:28:18 snoopy kernel: usb_control/bulk_msg: timeout
May 24 23:28:18 snoopy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1026: 5=
:1:2:=20
cannot get freq at ep 0x1

I looked at the source code, and line 1026 is in the init_usb_sample_rate=
=20
function.  According to the comment, the calls are made
only if the devices has "sampling rate control" .  I hacked that part out=
 (so=20
that the function no longer tries to set the rate) and then the device pl=
ayed=20
just fine, at 24, 16 and 8 bits.  The only problem was that it spat out a=
=20
continuous stream of messages to the syslog.  Here's a sample:

May 24 23:44:32 snoopy last message repeated 3 times
May 24 23:44:32 snoopy kernel: usb.c: usb-check-bandwidth would have FAIL=
ED:=20
was 456, would be 913, bustime =3D 457 us
May 24 23:44:32 snoopy kernel: usb.c: usb-check-bandwidth would have FAIL=
ED:=20
was 799, would be 913, bustime =3D 114 us
May 24 23:44:32 snoopy last message repeated 3 times
May 24 23:44:33 snoopy kernel: usb.c: usb-check-bandwidth would have FAIL=
ED:=20
was 456, would be 913, bustime =3D 457 us

These messages continue for as long as the sound is playing.

It looks to me like the audioformat structure is being set wrong for this=
=20
device.  Specifically, the  EP_CS_ATTR_SAMPLE_RATE attribute is set when =
it=20
probably shouldn't be.   Interestingly, a grep for that attribute only=20
returns 2 hits:  the #define for it and the code that I commented out tha=
t=20
tests it.  I didn't see any place where a value was set or unset.

Can anyone comment on this?  And can we find a way to set the audioformat=
=20
structure properly?  Also, what do all the usb-check-bandwidth messages m=
ean? =20
They appear to be coming from the USB system, but since they appear when=20
sound is playing, I assume it has something to do with the snd-usb-audio=20
driver. =20

I'd be happy to try out any patches or code samples anyone could provide.

Thanks very much,
-Ross




-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
