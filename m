From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Implementing sync start
Date: Sat, 8 Aug 2009 23:07:47 -0400
Message-ID: <9e4733910908082007n5d2e7f48g453b1f2e3c6eb23e@mail.gmail.com>
References: <9e4733910908081116p221e606cma31a95b06d9b5be6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f203.google.com (mail-yw0-f203.google.com
	[209.85.211.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 8763624707
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Aug 2009 05:07:48 +0200 (CEST)
Received: by ywh41 with SMTP id 41so3519327ywh.23
	for <alsa-devel@alsa-project.org>; Sat, 08 Aug 2009 20:07:47 -0700 (PDT)
In-Reply-To: <9e4733910908081116p221e606cma31a95b06d9b5be6@mail.gmail.com>
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

On Sat, Aug 8, 2009 at 2:16 PM, Jon Smirl<jonsmirl@gmail.com> wrote:
> Is there a simple way to test this with something like a mono sine wav
> file? A aplay mono.wav and then use and ALSA conf to copy the sine to
> all channels and then sync start them.

I've tried this, but I'm just getting static.

pcm.quad {
        type multi

        slaves.a.pcm "plughw:0,0"
        slaves.a.channels 2
        slaves.b.pcm "plughw:0,1"
        slaves.b.channels 2

        bindings.0.slave a
        bindings.0.channel 0
        bindings.1.slave a
        bindings.1.channel 1
        bindings.2.slave b
        bindings.2.channel 0
        bindings.3.slave b
        bindings.3.channel 1
}

pcm.quad2 {
        type route
        slave.pcm "quad"
	slave.channels 4
        ttable.0.0 1
        ttable.1.1 1
        ttable.0.2 1
        ttable.1.3 1
}

Trace looks ok, haven't figured out what is failing yet.

oot@phyCORE:~ aplay -D quad2 startup.wav
mpc5200-psc-i2s f0002000.i2s: psc_dma_open(substream=c3870c00)
dspeak01_fabric_startup
asoc: pcm1690 <-> i2s-0 info:
asoc: rate mask 0x1ee0
asoc: min ch 2 max ch 2
asoc: min rate 32000 max rate 192000
mpc5200-psc-i2s f0002200.i2s: psc_dma_open(substream=c3870d00)
dspeak01_fabric_startup
asoc: pcm1690 <-> i2s-1 info:
asoc: rate mask 0x1ee0
asoc: min ch 2 max ch 2
asoc: min rate 32000 max rate 192000
Playing WAVE 'startup.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
dspeak01_fabric_hw_params
mpc5200-psc-i2s f0002000.i2s: psc_i2s_set_sysclk(cpu_dai=c390d540,
freq=22579200, dir=1)
JDS - clock enable 1 23
pcm1690 0-004c: pcm1690_hw_params(substream=c3870c00, params=c395fc00)
pcm1690 0-004c: rate=44100 format=11
mpc5200-psc-i2s f0002000.i2s: psc_i2s_hw_params(substream=c3870c00)
p_size=5513 p_bytes=44104 periods=4 buffer_size=22052
buffer_bytes=176416
mpc5200-psc-i2s f0002000.i2s: psc_i2s_hw_params(substream=c3870c00)
rate=44100 sysclk=22579200 framesync=64 bitclk=8 reg=3F070000
mpc5200-psc-i2s f0002000.i2s: psc_i2s_hw_params exit
dspeak01_fabric_prepare
soc-audio soc-audio.1: Setting bias prepare
DAPM pcm1690 snd_soc_dapm_stream_event
pcm1690 0-004c: pcm1690_mute(dai=c0403230, mute=0)
dspeak01_fabric_hw_params
mpc5200-psc-i2s f0002200.i2s: psc_i2s_set_sysclk(cpu_dai=c390dc00,
freq=22579200, dir=1)
JDS - clock enable 2 23
pcm1690 0-004c: pcm1690_hw_params(substream=c3870d00, params=c395fc00)
pcm1690 0-004c: rate=44100 format=11
mpc5200-psc-i2s f0002200.i2s: psc_i2s_hw_params(substream=c3870d00)
p_size=5513 p_bytes=44104 periods=4 buffer_size=22052
buffer_bytes=176416
mpc5200-psc-i2s f0002200.i2s: psc_i2s_hw_params(substream=c3870d00)
rate=44100 sysclk=22579200 framesync=64 bitclk=8 reg=3F070000
mpc5200-psc-i2s f0002200.i2s: psc_i2s_hw_params exit
dspeak01_fabric_prepare
soc-audio soc-audio.1: Setting bias prepare
DAPM pcm1690 snd_soc_dapm_stream_event
pcm1690 0-004c: pcm1690_mute(dai=c0403230, mute=0)
dspeak01_fabric_prepare
soc-audio soc-audio.1: Setting bias prepare
DAPM pcm1690 snd_soc_dapm_stream_event
pcm1690 0-004c: pcm1690_mute(dai=c0403230, mute=0)
dspeak01_fabric_prepare
soc-audio soc-audio.1: Setting bias prepare
DAPM pcm1690 snd_soc_dapm_stream_event
pcm1690 0-004c: pcm1690_mute(dai=c0403230, mute=0)
dspeak01_fabric_prepare
soc-audio soc-audio.1: Setting bias prepare
DAPM pcm1690 snd_soc_dapm_stream_event
pcm1690 0-004c: pcm1690_mute(dai=c0403230, mute=0)
dspeak01_fabric_prepare
soc-audio soc-audio.1: Setting bias prepare
DAPM pcm1690 snd_soc_dapm_stream_event
pcm1690 0-004c: pcm1690_mute(dai=c0403230, mute=0)
mpc5200-psc-i2s f0002000.i2s: psc_dma_trigger(substream=c3870c00,
cmd=1) stream_id=0
mpc5200-psc-i2s f0002200.i2s: psc_dma_trigger(substream=c3870d00,
cmd=1) stream_id=0
mpc5200-psc-i2s f0002000.i2s: psc_dma_trigger(substream=c3870c00,
cmd=0) stream_id=0
mpc5200-psc-i2s f0002200.i2s: psc_dma_trigger(substream=c3870d00,
cmd=0) stream_id=0
dspeak01_fabric_hw_free
dspeak01_fabric_hw_free
dspeak01_fabric_hw_free
pcm1690 0-004c: pcm1690_mute(dai=c0403230, mute=1)
dspeak01_fabric_shutdown
mpc5200-psc-i2s f0002000.i2s: psc_dma_close(substream=c3870c00)
dspeak01_fabric_hw_free
pcm1690 0-004c: pcm1690_mute(dai=c0403230, mute=1)
dspeak01_fabric_shutdown
mpc5200-psc-i2s f0002200.i2s: psc_dma_close(substream=c3870d00)
root@phyCORE:~ pop wq checking: Playback status: inactive waiting: yes
soc-audio soc-audio.1: Setting bias prepare
DAPM pcm1690 snd_soc_dapm_stream_event




-- 
Jon Smirl
jonsmirl@gmail.com
