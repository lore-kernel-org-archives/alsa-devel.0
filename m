From: Ben Dooks <ben-alsa@fluff.org>
Subject: Re: OSS-em: jittery playback (stop/start) with S3C24XX
	(dev)
Date: Wed, 9 Aug 2006 11:23:19 +0100
Message-ID: <20060809102318.GB27724@trinity.fluff.org>
References: <20060807080525.GC2929@trinity.fluff.org>
	<1154940349.14887.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1154940349.14887.18.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Cc: Ben Dooks <ben-alsa@fluff.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 07, 2006 at 09:45:49AM +0100, Liam Girdwood wrote:
> On Mon, 2006-08-07 at 08:05 +0000, Ben Dooks wrote:
> > I am currently working on the I2S drivers for the S3C24XX series
> > ARM9 SoC, and have been having trouble with jittery or interrupted
> > playback with ALSA 1.0.12rc1, on 2.6.18-rc2. 
> > 
> > The problem seems to manifest itself the most when using pause
> > with madplay (madplay is compiled and optimised for the arm920t
> > core, so seems to be efficiently decoding mp3s).
> > 
> > The symptoms are:
> > 
> > 1) madplay opens and configures /dev/dsp
> > 
> > 2) madplay writes 4068 bytes to start play (apprx 1/40th sec, by my calc)
> > 
> > 3) ALSA starts the sound driver by calling hw_params and then trigger(START)
> > 
> > 4) before madplay has the chance to write more data, the hw indicates
> >    the initial buffer done (4096 bytes/buffer) and informs ALSA core. 
> > 
> > 5) more time passes, and the snd_pcm_hw_ptr_post detects an overrun on
> >    the buffer, and issues trigger(STOP) to stop the sound driver
> > 
> > 6) by this time, madplay writes some more data, and therefore we return
> >    to step 3.
> > 
> > The problem is that there is a large pause between 5 and 6, up to about
> > 1 second, and thus the sound output becomes choppy and/or broken. Sometimes
> > it seems to recover from this, and get back to playing audio fine.
> > 
> > examples from the log:
> > 
> > [21474589.680000] snd_pcm_oss_write: file c05341d4, buff befb0e20, size 4608
> > [21474589.680000] s3c24xx_snd_pcm_prepare: substream=c06ff1e4, chip=c0aa9b10
> > [21474589.760000] s3c2410_dma_enqueue: id=c0aa9b5c, data=30ab0000, size=4096
> > [21474589.760000] s3c24xx_snd_pcm_trigger: trigger START
> > [21474589.765000] snd_pcm_oss_write: returning 4608
> > [21474589.785000] dma0: s3c2410_dma_irq
> > [21474591.680000] snd_pcm_update_hw_ptr_post: hw_ptr=00003409, appl_ptr=00000400
> > [21474591.680000] snd_pcm_update_hw_ptr_post: xrun substream c06ff1e4
> > [21474591.680000] xrun: substream c06ff1e4
> > [21474591.680000] snd_pcm_stop: substream c06ff1e4, state 4
> > 
> > as you can see, in this case the next thing my debug can see after we
> > get the irq to say the buffer has completed, almost two seconds elapses
> > to the point where ALSA core finds the buffer has over-run (played more
> > data than the application wrote) and causes the stream to stop.
> > 
> > Are there any pointers to find out where the time is being taken, or has
> > anyone else encountered a similar problem recently?
> > 
> 
> Fwiw, I've not had any issues like this with madplay on pxa2xx. Mplayer
> also works fine on pxa2xx with oss emulation (although mplayer native
> alsa support has problems).
> 
> Is there enough buffer space (or periods) for your audio data ? (from
> struct snd_pcm_hardware). It looks like only 1 period worth of data is
> being written by madplay before audio trigger. I would usually expect it
> to write several periods worth of data and then trigger. 

Yeah, I advertise 64KiB total buffer, and 4096 byte periods (to ensure
that we can keep the DMA system running, as it only has a current/next
buffer serviced by an interrupt.
 
> However, if aplay works fine then it's probably not related to audio
> buffers.

aplay doesn't seem to even try and trigger, it gets to hw_params and then
sits there (although this could be a bug in my buildroot+alsautils build.

SoX behaves even worse than madplay, and I belive this is also using the
libasound to provide audio. It writes data then seems to sit around until
after the buffer has been played to start playing some more data.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
