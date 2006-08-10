From: Ben Dooks <ben-alsa@fluff.org>
Subject: Re: OSS-em: jittery playback (stop/start) with	S3C24XX
	(dev)
Date: Thu, 10 Aug 2006 17:25:08 +0100
Message-ID: <20060810162508.GC22950@trinity.fluff.org>
References: <20060807080525.GC2929@trinity.fluff.org>
	<1154940349.14887.18.camel@localhost.localdomain>
	<20060809102318.GB27724@trinity.fluff.org>
	<1155121254.8442.78.camel@localhost.localdomain>
	<20060809111111.GC27724@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060809111111.GC27724@trinity.fluff.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Ben Dooks <ben-alsa@fluff.org>
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 09, 2006 at 12:11:11PM +0100, Ben Dooks wrote:
> On Wed, Aug 09, 2006 at 12:00:54PM +0100, Liam Girdwood wrote:
> > On Wed, 2006-08-09 at 11:23 +0100, Ben Dooks wrote:
> > > On Mon, Aug 07, 2006 at 09:45:49AM +0100, Liam Girdwood wrote:
> > > > On Mon, 2006-08-07 at 08:05 +0000, Ben Dooks wrote:
> > > > > I am currently working on the I2S drivers for the S3C24XX series
> > > > > ARM9 SoC, and have been having trouble with jittery or interrupted
> > > > > playback with ALSA 1.0.12rc1, on 2.6.18-rc2. 
> > > > > 
> > > > > The problem seems to manifest itself the most when using pause
> > > > > with madplay (madplay is compiled and optimised for the arm920t
> > > > > core, so seems to be efficiently decoding mp3s).
> > > > > 
> > > > > The symptoms are:
> > > > > 
> > > > > 1) madplay opens and configures /dev/dsp
> > > > > 
> > > > > 2) madplay writes 4068 bytes to start play (apprx 1/40th sec, by my calc)
> > > > > 
> > > > > 3) ALSA starts the sound driver by calling hw_params and then trigger(START)
> > > > > 
> > > > > 4) before madplay has the chance to write more data, the hw indicates
> > > > >    the initial buffer done (4096 bytes/buffer) and informs ALSA core. 
> > > > > 
> > > > > 5) more time passes, and the snd_pcm_hw_ptr_post detects an overrun on
> > > > >    the buffer, and issues trigger(STOP) to stop the sound driver
> > > > > 
> > > > > 6) by this time, madplay writes some more data, and therefore we return
> > > > >    to step 3.
> > > > > 
> > > > > The problem is that there is a large pause between 5 and 6, up to about
> > > > > 1 second, and thus the sound output becomes choppy and/or broken. Sometimes
> > > > > it seems to recover from this, and get back to playing audio fine.
> > > > > 
> > > > > examples from the log:
> > > > > 
> > > > > [21474589.680000] snd_pcm_oss_write: file c05341d4, buff befb0e20, size 4608
> > > > > [21474589.680000] s3c24xx_snd_pcm_prepare: substream=c06ff1e4, chip=c0aa9b10
> > > > > [21474589.760000] s3c2410_dma_enqueue: id=c0aa9b5c, data=30ab0000, size=4096
> > > > > [21474589.760000] s3c24xx_snd_pcm_trigger: trigger START
> > > > > [21474589.765000] snd_pcm_oss_write: returning 4608
> > > > > [21474589.785000] dma0: s3c2410_dma_irq
> > > > > [21474591.680000] snd_pcm_update_hw_ptr_post: hw_ptr=00003409, appl_ptr=00000400
> > > > > [21474591.680000] snd_pcm_update_hw_ptr_post: xrun substream c06ff1e4
> > > > > [21474591.680000] xrun: substream c06ff1e4
> > > > > [21474591.680000] snd_pcm_stop: substream c06ff1e4, state 4
> > > > > 
> > > > > as you can see, in this case the next thing my debug can see after we
> > > > > get the irq to say the buffer has completed, almost two seconds elapses
> > > > > to the point where ALSA core finds the buffer has over-run (played more
> > > > > data than the application wrote) and causes the stream to stop.
> > > > > 
> > > > > Are there any pointers to find out where the time is being taken, or has
> > > > > anyone else encountered a similar problem recently?
> > > > > 
> > > > 
> > > > Fwiw, I've not had any issues like this with madplay on pxa2xx. Mplayer
> > > > also works fine on pxa2xx with oss emulation (although mplayer native
> > > > alsa support has problems).
> > > > 
> > > > Is there enough buffer space (or periods) for your audio data ? (from
> > > > struct snd_pcm_hardware). It looks like only 1 period worth of data is
> > > > being written by madplay before audio trigger. I would usually expect it
> > > > to write several periods worth of data and then trigger. 
> > > 
> > > Yeah, I advertise 64KiB total buffer, and 4096 byte periods (to ensure
> > > that we can keep the DMA system running, as it only has a current/next
> > > buffer serviced by an interrupt.
> > >  
> > > > However, if aplay works fine then it's probably not related to audio
> > > > buffers.
> > > 
> > > aplay doesn't seem to even try and trigger, it gets to hw_params and then
> > > sits there (although this could be a bug in my buildroot+alsautils build.
> > > 
> > 
> > Btw, are you using gcc 4.1.x. I've seen some optimisation issues with it
> > where it completely breaks the pcm parameter refinements on ARM.
> 
> No, 3.4.2, i've already run into optimisation bugs in the kernel with
> 4.0.1, so have been using the older compilers to build buildroot.

I have finally managed to track down two bugs, which improve the
output, which are:

1) the DMA min bytes is too low, as our DMA is being partially software
   managed, we end up not being able to keep up.

2) used snd_pcm_lib_buffer_bytes() in hw_params, where I actually needed
   to get params_buffers_bytes() to get the correctly requested byte
   count for the period

This has fixed sox's play command, which can now play wav files.

I am still getting over-runs, but they are now only 4 or 8 frames of
data, and the recovery is grealy improved. The following is a typical
dump for debug added into the pcm core:

[ 1700.456000] s3c24xx_snd_playback_buffdone: c036cdbc,c0609b5c, or c0609b5c, sz 8192, res 0
[ 1700.456000] snd_pcm_update_hw_ptr_post: avail=32771, stop_threshold=32768
[ 1700.456000] snd_pcm_update_hw_ptr_post: hw_ptr=00000803, appl_ptr=00000800
[ 1700.456000] snd_pcm_update_hw_ptr_post: xrun substream c07001e4
[ 1700.456000] xrun: substream c07001e4
[ 1700.456000] snd_pcm_stop: substream c07001e4, state 4

As you can see, the app has written 0x800 frames(?) and our DMA buffer
has gotten to 0x804. I'm not sure wether this is down to starvation
from the writer, or some other problem.

I cannot currently get aplay to work, it spews out the following:

aplay gnarles.wav 
Playing WAVE 'gnarles.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
aplay: set_params:1012: unable to install sw params:
start_mode: EXPLICIT
xrun_mode: NONE
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 0
xfer_align: 78436
silence_threshold: 0
silence_size: 0
boundary: 1344798720

I am not sure if my buildroot is correctly building these yet,
but do not have the time to investigate further right now.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
