From: "William Juul" <william@juul.no>
Subject: Re: new driver: 30mS interval problem
Date: Tue, 26 Feb 2008 13:56:51 +0100
Message-ID: <2563ac9e0802260456j315c0eb1i7690cf03f4ee2d7f@mail.gmail.com>
References: <2563ac9e0802250646t419bdc41v3b6b10d7566fec3d@mail.gmail.com>
	<s5hejb1t52u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D30924630
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 13:56:56 +0100 (CET)
Received: by el-out-1112.google.com with SMTP id z25so1722596ele.8
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 04:56:54 -0800 (PST)
In-Reply-To: <s5hejb1t52u.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 25, 2008 at 4:43 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 25 Feb 2008 15:46:28 +0100,
>
> William Juul wrote:
>  >
>  > Hello
>  >
>  > I am new to ALSA and trying to write a new driver for a DAC connected
>  > with PCM to an AVR32 on a NGW100 reference card provided by Atmel.
>  >
>  > The sampling rate I am currently using is 11047and the DAC is
>  > providing 4 channels of 24bit. The HW interface is using DMA to copy
>  > data to RAM.
>  > By studying the audio data in hexdump or in Audacity I can verify that
>  > the sound looks good in intervals of about 30mS, then all channels are
>  > garbled for 30mS. This pattern repeat itself throughout the audio
>  > capture.
>  >
>  > I am not confident I have configured all ALSA parameters properly.
>  > How can I go about fixing/debugging this 30mS intverval problem?
>
>  Maybe the period size has to be aligned to some value?
>
>
>  >
>  > Below is the command I am using.
>  >
>  >
>  > Best regards
>  > William Juul
>  >
>  > # arecord -r 11047 -c 4 -f S24_LE -s 1 -A 100 -d 5 --buffer-size 16384
>  > -F 21333 -v > test.wav
>
>  Try to change the period size as well.
>
>
>  Takashi
>
I tried changing the period size in both directions but it would never
change to anything but 490.
Then I tried changing the number of channels. -c 1 gave me lots of
"overrun", but -c 2 made everything work. The WAV file would still
contain data from all 4 channels. I do not understand the correlation
between the different parameters and why it behaves like this. Thus I
do not know what to adjust to remedy this.

The command I used to make everything work was:
arecord -r 11047 -c 2 -f S24_LE -s 100 -A 10000 -d 5 > test.wav

It turned out that --buffer-size and -F did not actually change anything.

The problem that is still bothering me is that the different channels
from the PCM stream comes in different positions in the WAV file. For
example when I disable all but the first PCM channel, the data from
this channel can occur in any of the 4 channels in the WAV file (there
is still four channels with data in the WAV file but the WAV header
says it contains 2 channels when captured with -c 2).

How can I make sure that the data from one particular channel always
occur in a fixed position in the WAV file?

Best regards
William
>
>
>
>  > Recording WAVE 'stdin' : Signed 24 bit Little Endian, Rate 11047 Hz, Channels 4
>  > Plug PCM: Hardware PCM card 0 'AVR32 NGW100 external DAC' device 0 subdevice 0
>  > pcm->setup: 1
>  >   stream       : CAPTURE
>  >   access       : RW_INTERLEAVED
>  >   format       : S24_LE
>  >   subformat    : STD
>  >   channels     : 4
>  >   rate         : 11047
>  >   exact rate   : 11047 (11047/1)
>  >   msbits       : 32
>  >   buffer_size  : 16384
>  >   period_size  : 490
>  >   period_time  : 44355
>  >   tick_time    : 4000
>  >   tstamp_mode  : NONE
>  >   period_step  : 1
>  >   sleep_min    : 0
>  >   avail_min    : 490
>  >   xfer_align   : 490
>  >   start_threshold  : 1
>  >   stop_threshold   : 16384
>  >   silence_threshold: 0
>  >   silence_size : 0
>  >   boundary     : 1073741824
>  > _______________________________________________
>  > Alsa-devel mailing list
>  > Alsa-devel@alsa-project.org
>  > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>  >
>  _______________________________________________
>  Alsa-devel mailing list
>  Alsa-devel@alsa-project.org
>  http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
