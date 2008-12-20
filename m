From: "Sean McNamara" <smcnam@gmail.com>
Subject: Re: ALsa Querries about buffer size configuration
Date: Sat, 20 Dec 2008 09:45:49 -0500
Message-ID: <74eb1fe20812200645i485517hf4e3a3eb6d4b035d@mail.gmail.com>
References: <35fa40850812200530x1d077b4cpf64a3ff8f51885a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id C8D131037ED
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2008 15:45:50 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id l35so736630waf.16
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2008 06:45:49 -0800 (PST)
In-Reply-To: <35fa40850812200530x1d077b4cpf64a3ff8f51885a3@mail.gmail.com>
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
To: alsa-devel@alsa-project.org, subhra85@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Sat, Dec 20, 2008 at 8:30 AM, SUBHRANIL CHOUDHURY <subhra85@gmail.com> wrote:
> I have some doubts on the ALSA programming,
>
> 1)My ALSA driver supports minimum Period Bytes size as 32 bytes, but when i
> set the period size as 512 bytes it is always setting to 1024 bytes.I am
> using the function "snd_pcm_hw_params_set_period_size_near()" . What might
> be wrong here?Is the function what i am using correct?

You're using the right function to set the period, but you have to
consider that _near() will try and match the application's period size
request as closely as possible.

On my HDA Intel driver, using the aplay test program, here is how it
behaves (and I believe this is the correct, bug-free behavior):

1. Requesting a period-size of 1 ~ 47 frames gives me a period-size of
32 frames, which is the minimum the driver supports.
2. Requesting a period-size of 48 ~ 79 frames gives me 64 frames.
3. Requesting a period-size of 80 ~ 111 frames gives me 96 frames.

As you can see, it just calculates the distance between the requested
number of frames and the two nearest numbers of frames supported by
the driver -- the one below, and the one above. Whichever one has a
smaller distance is chosen. It also chooses the higher period size
when the distance is identical, i.e. 48 - 32 == 64 - 48 == 16.

If you request 512, and your driver supports 512, then the distance is
0, so there's no way the userspace would choose any other value. What
I'm thinking is that your driver somehow doesn't support 512 for
whatever reason. With my driver, requesting 496 ~ 527 frames gives me
512, because it supports all period sizes divisible by 32.

If your driver supports period sizes differently, that may be a bug in
your code... but to make sure, try some different versions of
alsa-lib; for example, try the latest stable and compare it to git
master.

>
> 2)How the Library functions and the Driver functions interact, what is the
> interface between the library functions and driver functions?Is there any
> document which explains this. I got a document which explains how to write
> ALSA driver.But it does not mention the interface with the library.

Well, the bulk of the implementation is in src/pcm/pcm_hw.c . The
actual syscalls being sent over the fence from kernel to userspace are
just open, read, write, and ioctl, for the most part. Data is sent and
received over the character devices in /dev/snd. The timing source is
/dev/snd/timer; playback subdevices are mapped as /dev/snd/pcm*p;
capture subdevices are mapped as /dev/snd/pcm*c. Mixer settings by
card are sent over /dev/snd/controlC*.

I've never written an ALSA driver myself, but I'm guessing that the
common snd_pcm kernel module decodes the ioctls for you and calls a
bunch of function pointers in your driver implementation when it
determines that something needs to be done on the hardware end. If you
want to see the way your driver functions are being called, look in
the corresponding snd_pcm.ko source code.

>
> 3)How Can we achive MIC and LINEIN switching using the mixer?What library
> function do i need to use to achive this?

What do you mean by switching? If you want to toggle which capture
subdevices are active, you'd use snd_mixer_selem_set_capture_switch
and similar. See
http://www.alsa-project.org/alsa-doc/alsa-lib/group___simple_mixer.html

You can also look at alsamixer for an example of how to do this in the library.

>
> 4)If i want to get the Timestamp for each buffer captured, what library
> function should be used?

Sorry, I don't know the immediate answer to this one without more
research. But please keep in mind that if you are writing a
user-facing application or subsystem, I highly recommend that you at
least consider using the "safe" ALSA API subset as declared in Lennart
Poettering's blog here:
http://0pointer.de/blog/projects/guide-to-sound-apis.html

Of course, if you're just wanting this information for testing your
driver, that's perfectly fine -- I just don't know how to do this
myself.

>
>
>
> 5)I am trying to capture and play the same audio (ALSA duplex). When i
> capture and store it in a file and play from the file i am able to hear the
> sound properly. If i capture in a buffer and play the same buffer directly
> it says Broken PIPE ERROR in the playout.
>
>  I tried the capture and playout in two different threads, i am able to hear
> the sound and i am not getting any Broken PIPE error. But along with the
> audio i am hearing some noise.
>
> Do we need to use some kind of synchronisation between the threads for
> capture and playout?

If you're using the blocking API, ALSA performs the synchronization
for you. A read from the capture device won't return until there's
something to read; a write to the playback device won't return until
there's room in the buffer to write it. If you're just getting clicks
and pops in your loopback, you probably want to increase the buffering
on both ends to be sure that it isn't a matter of overruns occurring.
Also make sure you handle any overrun (capture) or underrun (playback)
with snd_pcm_recover(), rather than your own code.

HTH,

Sean

>
>
>
> Any help on these things is appreciated.
>
> Thank you in advance.
> Regards,
> Subhranil
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
