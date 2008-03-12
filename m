From: "gmail zaq79324" <zaq79324@gmail.com>
Subject: driver development questions
Date: Wed, 12 Mar 2008 19:53:05 +0900
Message-ID: <64431e5a0803120353l3d832f21p10c5a5af4742266c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.249])
	by alsa0.perex.cz (Postfix) with ESMTP id B2E7B1038C3
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 11:53:07 +0100 (CET)
Received: by ag-out-0708.google.com with SMTP id 22so4793188agd.8
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 03:53:06 -0700 (PDT)
Content-Disposition: inline
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
Cc: zaq79324@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi everyone,

I'm currently developing an ALSA driver from scratch. It
is almost done, but memory buffer management problem
remains. I have tried in various way of debugging. But
currently I'm almost giving it up.

My target hardware has a small data buffer(2K+2K ring
buffer). The driver fills the first half buffer(2K) and
writes hardware port. After this the interrupt occurs to
urge writting the second half buffer and hardware port.
The second buffer is filled in the same way. The buffer
filling scheme will repeat continuously until the end of
the sound.

Through my driver, aplay command can generate the sound
within few seconds, but it stops before finishing
completely.

It seems to have the problem of buffer management. So I
set xrun_debug option like as follows.
echo 1 > /proc/asound/SM502I2S/pcm0p/xrun_debug

And I got the following output.  Does anyone know what the
problem is and how to fix it?

# ./bin/aplay --channels=1 --period-size=2048 sample.wav
Playing WAVE 'sample.wav' : Signed 16 bit Little Endian,
Rate 44100 Hz, Stereo
aplay: pcm_write:1266: write error: Input/output error

ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1536, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1536, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1024, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1024, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -512, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -512, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -2048, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1536, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1536, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1024, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1024, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -512, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -512, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -2048, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1536, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1536, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1024, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1024, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -512, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -512, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -2048, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1536, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1536, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1024, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1024, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -512, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -512, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -2048, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1536, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1536, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1024, max jitter = 11025): wrong
interrupt acknowledge?
ALSA sound/core/pcm_lib.c:240: Unexpected hw_pointer value
[1]
 (stream = 0, delta: -1024, max jitter = 11025): wrong
interrupt acknowledge?

Regards,
Tadashi
