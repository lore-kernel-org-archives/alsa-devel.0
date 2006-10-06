From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: 5.1 surround sound playback XRUN /
 snd_pcm_writei() didn't unblock immediately / small 114 msec buffer
Date: Fri, 06 Oct 2006 15:09:39 +0200
Message-ID: <1160140179.28711.272704715@webmail.messagingengine.com>
References: <6.2.1.2.2.20060928013552.16a4b928@mailone.real.com>
	<s5hhcys2kr2.wl%tiwai@suse.de>
	<6.2.1.2.2.20060928125136.20c38030@mailone.real.com>
	<s5hhcyq52do.wl%tiwai@suse.de>
	<6.2.1.2.2.20061006012016.30ac5ee8@mailone.real.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <6.2.1.2.2.20061006012016.30ac5ee8@mailone.real.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Daniel Yek <dyek@real.com>, Alsa Developement <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Daniel Yek wrote:
> I opened "surround51" PCM device and set the sampling rate to 48000, S16_LE 
> format.

Better use "plug:surround51".  There are chips like ICE1712 that do not
support any format except S32_LE.

> I requested 500000 usec (0.5 sec) of buffer time, but I got back only
> 113770 usec. (equals to 65532 bytes.) Is there a way I can get a
> bigger buffer size?

You can try writing a value larger than 64 to
/proc/asound/card?/pcm?p/sub?/prealloc, but drivers for on-board
controllers typically don't support more than 128 KB.

There are drivers that force you to have even smaller or larger buffers.

> Does it depend on the driver or ALSA can typically provide more?

The maximum size is set by the driver, but many PCI sound drivers use a
random value of 128 or 256 KB although the hardware could support more.

> I used snd_pcm_writei() in blocking mode, transferring 28800 bytes (2400 
> frames) at a time. After two writes (buffer about full), the third write 
> blocked for 95 msec. Soon after, the function blocked for 128 msec, caused 
> XRUN. Is snd_pcm_writei() in blocking mode suitable for 5.1 channels 
> playback without XRUNs? Why snd_pcm_writei() didn't unblock immediately 
> when snd_pcm_avail_update() returned 5044 frames (105 msec.) available?

In theory, playback with a ~100 ms buffer should be possible.

There are several possibilities why your program wasn't waken up fast
enough:
1) The period size is too high.  The period size specifies the interval
   after which the hardware issues an interrupt.  If the buffer is full,
   you have to wait at least until the next period boundary before ALSA
   can detect that some part of the buffer is free.
   You should try to have at least about five periods per buffer.
2) avail_min and or xfer_align are set too high.  avail_min specifies
   how much free space must be in the buffer before snd_pcm_writei()
   continues writing; xfer_align specifies the minimum size of a block
   to write into the buffer.  The default value of both parameters is
   the period size, but this is not appropriate for your application;
   you don't want to wait before writing even the smallest possible
   amount.
   Set both these software parameters to one frame.
3) Some other process or thread was executed and prevented
   snd_pcm_writei() from executing.  This shouldn't be too much a
   problem because the kernel reschedules every 4 ms.  Make sure the
   priority of your audio thread is higher than the default.

> I'm going to try a non-blocking snd_pcm_writei() solution. Do you think it 
> is the answer to the XRUN problem?

No.  Using non-blocking writes does not change the wake-up behaviour.


HTH
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
