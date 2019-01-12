From: Tomas Nordin <tomasn@posteo.net>
Subject: Record stereo from one input on the soundcard
Date: Sat, 12 Jan 2019 14:25:35 +0100
Message-ID: <87muo6uhww.fsf@fliptop.i-did-not-set--mail-host-address--so-tickle-me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AF11266BCF
 for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2019 14:25:42 +0100 (CET)
Received: from submission (posteo.de [89.146.220.130])
 by mout01.posteo.de (Postfix) with ESMTPS id 16A1916006A
 for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2019 14:25:39 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 43cL8J2c00z6tmV
 for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2019 14:25:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello List

I sent this question first to the alsa-user list but somebody
recommended somebody to send to this list instead when the user-list
don't get much attention.

I have an external USB soundcard called Audiobox from Presonus,
https://www.presonus.com/products/AudioBox-USB. Somewhere I read that
this is a class compliant USB sound card.

I use this card to record audio from a drum module (e-drums). I take the
audio signal from the head phones out socket on the module, and plug it
into input 1 on the card. The card has 2 inputs, for the moment I don't
use the second input but I consider it busy. For a minimum of hassle I
want to make my recording using arecord (want to use a command line
program).

So the card is a kind of bedroom musician type of card that might have 2
inputs, 4 inputs or 12 or whatever, to record a number of instruments at
the same time. But as I said, this card has two inputs.

The audio signal from the headphones out socket (on the drum module) is
stereo. The card support routing that stereo sound from one input, in so
far that it can be heard in stereo from the cards head phones out.

The following command lets me record audio from the card,

$ arecord -c 2 -d 60 -f S24_3LE -r 48000 -D hw:1,0 s3.wav

The resulting wav file has all hearable audio in the left speaker when
listening.

Do you think it is possible to get that stereo signal from one input on
the card into a stereo sound file. Or somehow else get left and right
audio separately from that input 1 on the card. My guess on what's
happening now is that the stereo signal gets merged as mono into one
channel.

Here are some listings:

$ uname -a
Linux raspberrypi 4.14.79+ #1159 Sun Nov 4 17:28:08 GMT 2018 armv6l GNU/Linux

$ arecord -l
**** List of CAPTURE Hardware Devices ****
card 1: USB [AudioBox USB], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

$ arecord --dump-hw-params -D hw:1,0 
Recording WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
HW Params of device "hw:1,0":
--------------------
ACCESS:  MMAP_INTERLEAVED RW_INTERLEAVED
FORMAT:  S24_3LE
SUBFORMAT:  STD
SAMPLE_BITS: 24
FRAME_BITS: 48
CHANNELS: 2
RATE: [44100 48000]
PERIOD_TIME: [1000 1981429)
PERIOD_SIZE: [45 87381]
PERIOD_BYTES: [270 524286]
PERIODS: [2 1024]
BUFFER_TIME: [1875 3962858)
BUFFER_SIZE: [90 174762]
BUFFER_BYTES: [540 1048572]
TICK_TIME: ALL
--------------------
arecord: set_params:1299: Sample format non available
Available formats:
- S24_3LE

Any ideas anyone?

Best regards
--
Tomas
