From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: non hw pcm's and jackd (was: Fw: [Alsa-devel]
	emu10k1 device naming)
Date: Sun, 25 Jul 2004 13:41:58 -0400
Sender: jackit-devel-admin@lists.sourceforge.net
Message-ID: <1090777318.14951.19.camel@mindpipe>
References: <20040725125607.50e94ae2@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040725125607.50e94ae2@mango.fruits.de>
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: jackit-devel <jackit-devel@lists.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2004-07-25 at 06:56, Florian Schmidt wrote:
> Begin forwarded message:
> 
> Date: Sun, 25 Jul 2004 12:53:10 +0200
> From: Florian Schmidt <mista.tapas@gmx.net>
> To: Lee Revell <rlrevell@joe-job.com>
> Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, tiwai@suse.de, pzad@pobox.sk
> Subject: Re: [Alsa-devel] emu10k1 device naming
> 
> 
> On Sun, 25 Jul 2004 00:29:27 -0400
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Now that the emu10k1 driver supports low latency, multichannel capture,
> > it would be useful to rearrange the devices.  Currently you have to use
> > hw:0,0 for playback, and hw:0,2 for capture.  This works down to 32
> > frames (you have to record more than 2 channels to get 32 frames,
> > because 512 bytes is the smallest period JACK supports).  JACK requires
> > the playback and capture device to be the same for both directions.
> 
> Actually jack supports period sizes smaller than 512 frames. I can easily 
> start jackd with a period size of 64 frames. This is not a limitation of 
> jackd but rather of your soundcard.
> 

I said 512 *bytes*, not 512 frames.  I should have been clearer: 512
bytes is the largest *capture* period size that JACK and the hardware
both support.  The hardware can go down to 384 frames, but JACK only
supports power of two period sizes, so 512 *bytes* is the smallest
usable capture period.  If you capture 4 channels you can go down to 64
frames, 8 channels lets you go down to 32 frames.

The ALSA driver also had this wrong until I submitted a patch to fix it,
because the constraints are confusingly names SND_PCM_PERIOD_SIZE (value
in frames) and SND_PCM_PERIOD_BYTES (self-explanatory).  Maybe the
former should be changed to SND_PCM_PERIOD_FRAMES.

> > 
> > The current hw:0,0 device could be moved to hw:0,2.  This is the best
> > arrangement, because these are the only two devices that it makes sense
> > to use for full-duplex.  The hw:0,2 playback device is a special AC3
> > passthrough device, there is no capture device that corresponds to it. 
> > The same applies to the current hw:0,0 (ADC capture) and hw:0,1 (mic
> > capture - 8000 Hz) devices, there is no corresponding playback device.
> > 
> > It was suggsted to use the 'asym' PCM plugin for this, but JACK does not
> > support using a PCM as the device name, you need to give it a hardware
> > device.
> 
> jackd also supports using non hw pcm devices. it should only spit out a 
> warning to the user.. I just tried and besides some other weird behaviour 
> it hardlocked my machine.. So this might be a bug that should be reported 
> to the jack people.. But by design it should work..
> 
> One other thing that bothers me about jack is that it requires a ctl device 
> by the same name as the used pcm device [which is only needed in the case of hw 
> monitoring].. For people who don't need hw monitoring, this should not be required.. 
> I'll write to jackit-devel about this [forwarding this mail :)]..
> 

OK, I am also on jackit-devel, we can continue this discussion there.

I was told on this list I could put the following in my .asoundrc:
pcm.fx {
    type asym
    playback.pcm "hw:0,0"
    capture.pcm "hw:0,2"
}

then use the PCM 'pcm.fx' for JACK.

This is what happens when I try it:

rlrevell@mindpipe:~$ jackd -d alsa -d pcm.fx
jackd 0.98.1
Copyright 2001-2003 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

JACK compiled with System V SHM support
loading driver ..
creating alsa driver ... pcm.fx|pcm.fx|1024|2|48000|0|0|nomon|swmeter|-|32bit
ALSA lib dlmisc.c:107:(snd_dlsym_verify) unable to verify version for symbol _snd_ctl_asym_open
ALSA lib control.c:629:(snd_ctl_open_conf) symbol _snd_ctl_asym_open is not defined inside (null)
control open "pcm.fx" (No such device or address)
cannot load driver module alsa

Lee





-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
