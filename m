From: Michael Howard <mike@dewberryfields.co.uk>
Subject: Wandboard Quad - SPDIF issue, no sound
Date: Mon, 23 Jun 2014 19:07:01 +0100
Message-ID: <53A86CC5.2060204@dewberryfields.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dewberryfields.co.uk (mail.dewberryfields.co.uk
 [217.41.92.67]) by alsa0.perex.cz (Postfix) with ESMTP id 1BAA4261A32
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 20:07:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello All,

I'm resending this email as orignally I wasn't subcribed and I've been 
told the message hasn't made it through.

I was pointed here from the Wandboard Google Groups forum. If I'm in the 
wrong place please accept my appologies.

With known good cabling and receiver I'm not getting sound from the 
Wandboard Quad's S/PDIF output. I have built various kernels from 
mainline, the last two sources I tried are 3.15.1 and 3.16-rc2.

With sound built as modules I get nothing on any outputs, errors from 
dmesg are;

dmesg | grep snd
5.206990] imx-spdif sound-spdif.13: snd_soc_register_card failed: -517
[ 5.241976] imx-spdif sound-spdif.13: snd_soc_register_card failed: -517
[ 5.258174] imx-spdif sound-spdif.13: snd-soc-dummy-dai <-> 
2004000.spdif mapping ok
[ 5.281704] imx-sgtl5000 sound.12: snd_soc_register_card failed (-517)

With sound built in I get sound on the 'line out' output and from dmesg;

dmesg | grep snd
imx-spdif sound-spdif: snd-soc-dummy-dai <-> 2004000.spdif mapping ok

In both cases I get (or similar);

dmesg | grep firm
imx-sdma 20ec000.sdma: Direct firmware load failed with error -2
imx-sdma 20ec000.sdma: loaded firmware 1.1

Not sure if the firmware message above is a problem or not.

aplay output;

aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: imx6wandboardsg [imx6-wandboard-sgtl5000], device 0: HiFi 
sgtl5000-0 []
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 1: imxspdif [imx-spdif], device 0: S/PDIF PCM snd-soc-dummy-dai-0 []
   Subdevices: 1/1
   Subdevice #0: subdevice #0

aplay -L
null
     Discard all samples (playback) or generate zero samples (capture)
pulse
     PulseAudio Sound Server
sysdefault:CARD=imx6wandboardsg
     imx6-wandboard-sgtl5000,
     Default Audio Device
sysdefault:CARD=imxspdif
     imx-spdif,
     Default Audio Device

aplay -vv ImABeliever.wav
Playing WAVE 'ImABeliever.wav' : Signed 16 bit Little Endian, Rate 44100 
Hz, Stereo
Hardware PCM card 1 'imx-spdif' device 0 subdevice 0
Its setup is:
   stream       : PLAYBACK
   access       : RW_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 2
   rate         : 44100
   exact rate   : 44100 (44100/1)
   msbits       : 16
   buffer_size  : 16384
   period_size  : 4096
   period_time  : 92879
   tstamp_mode  : NONE
   period_step  : 1
   avail_min    : 4096
   period_event : 0
   start_threshold  : 16384
   stop_threshold   : 16384
   silence_threshold: 0
   silence_size : 0
   boundary     : 1073741824
   appl_ptr     : 0
   hw_ptr       : 0
#################           +                      | 55%

but no sound form SPDIF.

If this is right place for this and if I can be of any help debuuging or 
you need more info I'm more than happy to help in any way I can.

Since I sent the original message Ive realised that data is being sent 
to and received at the SPDIF output of the wandboard quad it can't seem 
to handle it. If I connect a DAC to the SPDIF output and then connect 
the DAC to my recievers aux input I hear the sound in all it's glory.

The same receiver and cabling works with a cubietruck and the sunxi kernel.

Cheers,
Mike

-- 
