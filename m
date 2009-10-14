From: David Huggins-Daines <dhuggins@cs.cmu.edu>
Subject: Channel conversion in plughw not working for my
 driver... confused about snd_pcm_plug_hw_params()
Date: Tue, 13 Oct 2009 23:44:26 -0400
Message-ID: <4AD5491A.4050702@cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 3140B1038B0
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Oct 2009 05:44:30 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 14so3462765qwa.56
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2009 20:44:29 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to make mono output work on the audio driver for the Cirrus
EDB9302 evaluation board.  For some reason, plughw is refusing to do any
channel conversion.  When I try to play a mono file, I simply get:

aplay: set_params:1022: Unable to install hw params:

The driver's struct snd_pcm_hardware contains:

    .channels_min	= 2,
    .channels_max	= 2,

which I believe is the correct way to tell userspace "this driver can
only do stereo output" - at least, this is how intel8x0.c does it, and
that driver really ought to work by now!

I've traced this to the exact point of failure, and what I see is that
in snd_pcm_plug_hw_params(), despite figuring out exactly what the set
of hardware parameters will work for the slave device, it goes and calls
 _snd_pcm_hw_params() with the actual parameters requested by the
client, which obviously fails, and leads to the error shown above.

I added some calls to snd_pcm_hw_params_dump() which give this output.
The first is sparams, which is the refined set of parameters which I
assume are supposed to be set in the slave device.  The second is
params, which is the set of parameters requested by the client (aplay in
this case).

sparams are:
ACCESS:  RW_INTERLEAVED
FORMAT:  U8
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 16
CHANNELS: 2
RATE: 11025
PERIOD_TIME: (124988 124989)
PERIOD_SIZE: 1378
PERIOD_BYTES: 2756
PERIODS: (4 5)
BUFFER_TIME: (500045 500046)
BUFFER_SIZE: 5513
BUFFER_BYTES: 11026
TICK_TIME: 0
params are:
ACCESS:  RW_INTERLEAVED
FORMAT:  U8
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 8
CHANNELS: 1
RATE: 11025
PERIOD_TIME: (124988 124989)
PERIOD_SIZE: 1378
PERIOD_BYTES: 1378
PERIODS: (4 5)
BUFFER_TIME: (500045 500046)
BUFFER_SIZE: 5513
BUFFER_BYTES: 5513
TICK_TIME: 0
inserting plugins whatever that means
in snd_pcm_plug_change_channels!

So, yeah, that's great, it figured it all out, and realized that it had
to do channel conversion, which presumably is done in
snd_pcm_plug_change_channels().  But now, we see that it goes ahead and
tries to set these parameters in the slave device:

calling _snd_pcm_hw_params with params:
ACCESS:  RW_INTERLEAVED
FORMAT:  U8
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 8
CHANNELS: 1
RATE: 11025
PERIOD_TIME: (124988 124989)
PERIOD_SIZE: 1378
PERIOD_BYTES: 1378
PERIODS: (4 5)
BUFFER_TIME: (500045 500046)
BUFFER_SIZE: 5513
BUFFER_BYTES: 5513
TICK_TIME: 0

But that's wrong!  The slave device can't do single-channel input!

So what gives?  This can't possibly be broken, or nobody's Intel
on-board audio would ever work at all... so what is my driver doing wrong?
