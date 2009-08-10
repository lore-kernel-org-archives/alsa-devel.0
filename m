From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Implementing sync start
Date: Sun, 9 Aug 2009 22:13:42 -0400
Message-ID: <9e4733910908091913j63debfefja44e8e04e278e087@mail.gmail.com>
References: <9e4733910908081116p221e606cma31a95b06d9b5be6@mail.gmail.com>
	<9e4733910908082007n5d2e7f48g453b1f2e3c6eb23e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id DE3922465F
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 04:13:43 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c37so877561anc.2
	for <alsa-devel@alsa-project.org>; Sun, 09 Aug 2009 19:13:43 -0700 (PDT)
In-Reply-To: <9e4733910908082007n5d2e7f48g453b1f2e3c6eb23e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I found the problem causing static. The MCLK was not programmed
properly when both channels are active.

How do you do sync stop? or do you do sync stop?
I'm getting this error when stopping the streams. The streams have
been sync started.

ALSA sound/core/pcm_native.c:1499: playback drain error (DMA or IRQ trouble?)

root@phyCORE:~ aplay -D quad2 startup.wav
mpc5200-psc-i2s f0002000.i2s: psc_dma_open(substream=c3862c00)
dspeak01_fabric_startup
asoc: pcm1690 <-> i2s-0 info:
asoc: rate mask 0x1ee0
asoc: min ch 2 max ch 2
asoc: min rate 32000 max rate 192000
mpc5200-psc-i2s f0002200.i2s: psc_dma_open(substream=c3862d00)
dspeak01_fabric_startup
asoc: pcm1690 <-> i2s-1 info:
asoc: rate mask 0x1ee0
asoc: min ch 2 max ch 2
asoc: min rate 32000 max rate 192000
Playing WAVE 'startup.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
dspeak01_fabric_hw_params
mpc5200-psc-i2s f0002000.i2s: psc_i2s_set_sysclk(cpu_dai=c390d540,
freq=22579200, dir=1, mclk=0)
JDS - clock enable 1 23
pcm1690 0-004c: pcm1690_hw_params(substream=c3862c00, params=c396c400)
pcm1690 0-004c: rate=44100 format=11
mpc5200-psc-i2s f0002000.i2s: psc_i2s_hw_params(substream=c3862c00)
p_size=5513 p_bytes=44104 periods=4 buffer_size=22052
buffer_bytes=176416
mpc5200-psc-i2s f0002000.i2s: psc_i2s_hw_params(substream=c3862c00)
rate=44100 sysclk=22579200 framesync=64 bitclk=8 reg=3F070000
mpc5200-psc-i2s f0002000.i2s: psc_i2s_hw_params exit
dspeak01_fabric_prepare subdevice #0
soc-audio soc-audio.1: Setting bias prepare
DAPM pcm1690 snd_soc_dapm_stream_event
pcm1690 0-004c: pcm1690_mute(dai=c0403230, mute=0)
dspeak01_fabric_hw_params
mpc5200-psc-i2s f0002200.i2s: psc_i2s_set_sysclk(cpu_dai=c390dc00,
freq=22579200, dir=1, mclk=1)
pcm1690 0-004c: pcm1690_hw_params(substream=c3862d00, params=c396c400)
pcm1690 0-004c: rate=44100 format=11
mpc5200-psc-i2s f0002200.i2s: psc_i2s_hw_params(substream=c3862d00)
p_size=5513 p_bytes=44104 periods=4 buffer_size=22052
buffer_bytes=176416
mpc5200-psc-i2s f0002200.i2s: psc_i2s_hw_params(substream=c3862d00)
rate=44100 sysclk=22579200 framesync=64 bitclk=8 reg=3F070000
mpc5200-psc-i2s f0002200.i2s: psc_i2s_hw_params exit
dspeak01_fabric_prepare subdevice #0
soc-audio soc-audio.1: Setting bias prepare
DAPM pcm1690 snd_soc_dapm_stream_event
pcm1690 0-004c: pcm1690_mute(dai=c0403230, mute=0)
dspeak01_fabric_prepare subdevice #0
soc-audio soc-audio.1: Setting bias prepare
DAPM pcm1690 snd_soc_dapm_stream_event
pcm1690 0-004c: pcm1690_mute(dai=c0403230, mute=0)
dspeak01_fabric_prepare subdevice #0
soc-audio soc-audio.1: Setting bias prepare
DAPM pcm1690 snd_soc_dapm_stream_event
pcm1690 0-004c: pcm1690_mute(dai=c0403230, mute=0)
dspeak01_fabric_prepare subdevice #0
soc-audio soc-audio.1: Setting bias prepare
DAPM pcm1690 snd_soc_dapm_stream_event
pcm1690 0-004c: pcm1690_mute(dai=c0403230, mute=0)
dspeak01_fabric_prepare subdevice #0
soc-audio soc-audio.1: Setting bias prepare
DAPM pcm1690 snd_soc_dapm_stream_event
pcm1690 0-004c: pcm1690_mute(dai=c0403230, mute=0)
mpc5200-psc-i2s f0002000.i2s: psc_dma_trigger(substream=c3862c00,
cmd=1) stream_id=0
mpc5200-psc-i2s f0002200.i2s: psc_dma_trigger(substream=c3862c00,
cmd=1) stream_id=0
mpc5200-psc-i2s f0002000.i2s: psc_dma_trigger(substream=c3862c00,
cmd=0) stream_id=0
mpc5200-psc-i2s f0002200.i2s: psc_dma_trigger(substream=c3862c00,
cmd=0) stream_id=0
ALSA sound/core/pcm_native.c:1499: playback drain error (DMA or IRQ trouble?)
mpc5200-psc-i2s f0002000.i2s: psc_dma_trigger(substream=c3862d00,
cmd=0) stream_id=0
mpc5200-psc-i2s f0002200.i2s: psc_dma_trigger(substream=c3862d00,
cmd=0) stream_id=0
dspeak01_fabric_hw_free
dspeak01_fabric_hw_free
dspeak01_fabric_hw_free
pcm1690 0-004c: pcm1690_mute(dai=c0403230, mute=1)
dspeak01_fabric_shutdown
mpc5200-psc-i2s f0002000.i2s: psc_dma_close(substream=c3862c00)
dspeak01_fabric_hw_free
pcm1690 0-004c: pcm1690_mute(dai=c0403230, mute=1)
dspeak01_fabric_shutdown
mpc5200-psc-i2s f0002200.i2s: psc_dma_close(substream=c3862d00)
root@phyCORE:~ pop wq checking: Playback status: inactive waiting: yes
soc-audio soc-audio.1: Setting bias prepare
DAPM pcm1690 snd_soc_dapm_stream_event



-- 
Jon Smirl
jonsmirl@gmail.com
