From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: AudioTrak Optoplay...
Date: Tue, 03 Jun 2003 09:03:06 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0306030852380.24147-100000@studcom.urz.uni-halle.de>
References: <200306021418.26840.miller@penguinstation.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200306021418.26840.miller@penguinstation.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ross Miller <miller@penguinstation.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ross Miller wrote:
> There was a thread on the alsa-user list back in March discussing Audiotrack
> products, and specifically the Optoplay USB device.  The relevant bits are:
>
> >> The Optoplay, listed as '?' on the matrix, seemed to work OK, the drivers
> >> loaded but - no sound output. This is the same as the problem someone
> >> reported a coulpe of months ago - it only works at 24 bits, and while the
> >> driver loads, apps only try to open the device @ 16 bits, which doesn't
> >>work.
> >
> >This is only for OSS apps. ALSA programs (e.g. aplay) probably would have
> >worked.
>
> Having just tried it out on version 0.9.3c, I can confirm that the optoplay
> DOESN'T work, even at 24 bits, using aplay.   However, it can be made to work
> with a quick hack to the driver code.  I'll get to that below.  First, here's
> the errors I get from aplay:
>
> snoopy:/usr/local/alsa/bin # ./aplay ~/24bit.wav
> Playing WAVE '/root/24bit.wav' : Signed 24 bit Little Endian in 3bytes, Rate
> 44100 Hz, Mono
> ALSA lib pcm_hw.c:436:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE failed:
> Connection timed out
> aplay: set_params:840: Unable to install hw params:
> ACCESS:  RW_INTERLEAVED
> FORMAT:  S24_3LE
> SAMPLE_BITS: 24
> CHANNELS: 1
> ...

Are you sure that the Optoplay supports _one_-channel output?

> Also, the following lines are printed in the syslog:
> May 24 23:28:17 snoopy kernel: usb-uhci.c: interrupt, status 2, frame# 985
> May 24 23:28:18 snoopy kernel: usb_control/bulk_msg: timeout
> May 24 23:28:18 snoopy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1026: 5:1:2:
> cannot get freq at ep 0x1
>
> I looked at the source code, and line 1026 is in the init_usb_sample_rate
> function.  According to the comment, the calls are made
> only if the devices has "sampling rate control" .  I hacked that part out (so
> that the function no longer tries to set the rate) and then the device played
> just fine, at 24, 16 and 8 bits.  The only problem was that it spat out a
> continuous stream of messages to the syslog.  Here's a sample:
>
> May 24 23:44:32 snoopy kernel: usb.c: usb-check-bandwidth would have FAILED:
> was 456, would be 913, bustime = 457 us
> ...
> These messages continue for as long as the sound is playing.
>
> It looks to me like the audioformat structure is being set wrong for this
> device.  Specifically, the  EP_CS_ATTR_SAMPLE_RATE attribute is set when it
> probably shouldn't be.

Hmm, this flag is to be set by the device in its USB descriptors if it
supports sampling rate control.

Please post the contents of /proc/asound/cardX/stream0 and the output of
"lsusb -v".

> And can we find a way to set the audioformat structure properly?

Yes; the Optoplay isn't the only device with (apparently) broken
descriptors.

> Also, what do all the usb-check-bandwidth messages mean?

The device sends or receives more data than it should. Probably because
the sampling rate isn't set correctly ...


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
