From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ALSA calling pcm_pointer excessively?
Date: Thu, 10 May 2012 17:42:40 +0100
Message-ID: <20120510164240.GD12727@n2100.arm.linux.org.uk>
References: <20120510160601.GC12727@n2100.arm.linux.org.uk>
	<CA+7tXijRBYW8frA650=kXJOKnZ4nfAHQi18baLB+D3Zc867bGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id DE43F10BAB1
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 18:42:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CA+7tXijRBYW8frA650=kXJOKnZ4nfAHQi18baLB+D3Zc867bGQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <tpiepho@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 10, 2012 at 12:34:19PM -0400, Trent Piepho wrote:
> On Thu, May 10, 2012 at 12:06 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > The question is - what would cause ALSA to hammer away at the buffer
> > like that - checking it every 16 or 8 DMA bytes transferred? =A0I'm also
> > seeing around 75% system CPU time, which really isn't good.
> >
> > The above was captured while aplay was running, with no apparant audio
> > corruption.
> =

> I've had this happen, but not with aplay.  I sent something to the
> list a few months ago about it.
> =

> The problem is triggered when writing to ALSA with writes that are
> unequal to the period size and using sampling rate conversion in an
> ALSA plugin.

I'm not using any plugins, and there's definitely no sample rate
conversion going on.  I'm basically piping a raw S16_LE stereo file
into "aplay -c2 -r48000 -fS16_LE" and that's the only format the
hardware supports:

Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Ster=
eo
Plug PCM: Hardware PCM card 0 'Assabet' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 16384
period_size  : 4096
period_time  : 85333
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4096
xfer_align   : 4096
start_threshold  : 16384
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 1073741824

Note that this is not using mmap, as ARM is not cache coherent.

Interestingly, if I use -M to aplay to force it to use mmap, things get
a _lot_ better and I only get a lot fewer calls to the pcm_pointer()
method per period.  I've included in this log the DMA engine output
(which shows the raw DMA address - the buffer is 64K aligned) and where
the pcm_pointer() method was called from.

tx_status: addr:c0f14010
soc_dmaengine_pointer: index 1 stat 1 residue 3ff0 cookie 1792 pos 8000 byt=
es 4010
snd_pcm_update_hw_ptr0+0x30/0x24c
soc_dmaengine_submit: submitting index 0 size 4000 cookie 1795
tx_status: addr:c0f14060
soc_dmaengine_pointer: index 1 stat 1 residue 3fa0 cookie 1792 pos 8000 byt=
es 4060
snd_pcm_update_hw_ptr0+0x30/0x24c
tx_status: addr:c0f14130
soc_dmaengine_pointer: index 1 stat 1 residue 3ed0 cookie 1792 pos 8000 byt=
es 4130
snd_pcm_update_hw_ptr0+0x30/0x24c
soc_dmaengine_callback: complete
tx_status: addr:c0f18010
soc_dmaengine_pointer: index 2 stat 1 residue 3ff0 cookie 1793 pos c000 byt=
es 8010
snd_pcm_update_hw_ptr0+0x30/0x24c
soc_dmaengine_submit: submitting index 1 size 4000 cookie 1796
tx_status: addr:c0f18060
soc_dmaengine_pointer: index 2 stat 1 residue 3fa0 cookie 1793 pos c000 byt=
es 8060
snd_pcm_update_hw_ptr0+0x30/0x24c
tx_status: addr:c0f18150
soc_dmaengine_pointer: index 2 stat 1 residue 3eb0 cookie 1793 pos c000 byt=
es 8150
snd_pcm_update_hw_ptr0+0x30/0x24c
soc_dmaengine_callback: complete
tx_status: addr:c0f1c010
soc_dmaengine_pointer: index 3 stat 1 residue 3ff0 cookie 1794 pos 10000 by=
tes c010
snd_pcm_update_hw_ptr0+0x30/0x24c
soc_dmaengine_submit: submitting index 2 size 4000 cookie 1797
tx_status: addr:c0f1c060
soc_dmaengine_pointer: index 3 stat 1 residue 3fa0 cookie 1794 pos 10000 by=
tes c060
snd_pcm_update_hw_ptr0+0x30/0x24c
tx_status: addr:c0f1c130
soc_dmaengine_pointer: index 3 stat 1 residue 3ed0 cookie 1794 pos 10000 by=
tes c130
snd_pcm_update_hw_ptr0+0x30/0x24c
soc_dmaengine_callback: complete
tx_status: addr:c0f10068
soc_dmaengine_pointer: index 0 stat 1 residue 3f98 cookie 1795 pos 4000 byt=
es 0068
snd_pcm_update_hw_ptr0+0x30/0x24c
soc_dmaengine_submit: submitting index 3 size 4000 cookie 1798
tx_status: addr:c0f100f0
soc_dmaengine_pointer: index 0 stat 1 residue 3f10 cookie 1795 pos 4000 byt=
es 00f0
snd_pcm_update_hw_ptr0+0x30/0x24c
tx_status: addr:c0f101c8
soc_dmaengine_pointer: index 0 stat 1 residue 3e38 cookie 1795 pos 4000 byt=
es 01c8
snd_pcm_update_hw_ptr0+0x30/0x24c
soc_dmaengine_callback: complete
tx_status: addr:c0f14010
soc_dmaengine_pointer: index 1 stat 1 residue 3ff0 cookie 1796 pos 8000 byt=
es 4010
snd_pcm_update_hw_ptr0+0x30/0x24c
soc_dmaengine_submit: submitting index 0 size 4000 cookie 1799
tx_status: addr:c0f14060
soc_dmaengine_pointer: index 1 stat 1 residue 3fa0 cookie 1796 pos 8000 byt=
es 4060
snd_pcm_update_hw_ptr0+0x30/0x24c
tx_status: addr:c0f14130
soc_dmaengine_pointer: index 1 stat 1 residue 3ed0 cookie 1796 pos 8000 byt=
es 4130
snd_pcm_update_hw_ptr0+0x30/0x24c
