From: Sinan Akman <sinan@writeme.com>
Subject: Re: Wandboard Quad - SPDIF issue, no sound
Date: Tue, 24 Jun 2014 01:33:12 -0400
Message-ID: <53A90D98.3050000@writeme.com>
References: <53A86CC5.2060204@dewberryfields.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from walmailout03.yourhostingaccount.com
 (walmailout03.yourhostingaccount.com [65.254.253.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 070EA2619FF
 for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2014 07:33:17 +0200 (CEST)
Received: from mailscan04.yourhostingaccount.com ([10.1.15.4]
 helo=walmailscan04.yourhostingaccount.com)
 by walmailout03.yourhostingaccount.com with esmtp (Exim)
 id 1WzJM5-0007a8-CG
 for alsa-devel@alsa-project.org; Tue, 24 Jun 2014 01:33:17 -0400
In-Reply-To: <53A86CC5.2060204@dewberryfields.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Howard <mike@dewberryfields.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


   Hi Micheal

On 06/23/2014 02:07 PM, Michael Howard wrote:
> Hello All,
>
> I'm resending this email as orignally I wasn't subcribed and I've been
> told the message hasn't made it through.
>
> I was pointed here from the Wandboard Google Groups forum. If I'm in the
> wrong place please accept my appologies.
>
> With known good cabling and receiver I'm not getting sound from the
> Wandboard Quad's S/PDIF output.

   How are you testing your spdif output exactly ?

> I have built various kernels from
> mainline, the last two sources I tried are 3.15.1 and 3.16-rc2.
>
> With sound built as modules I get nothing on any outputs, errors from
> dmesg are;
>
> dmesg | grep snd
> 5.206990] imx-spdif sound-spdif.13: snd_soc_register_card failed: -517
> [ 5.241976] imx-spdif sound-spdif.13: snd_soc_register_card failed: -517
> [ 5.258174] imx-spdif sound-spdif.13: snd-soc-dummy-dai <->
> 2004000.spdif mapping ok
> [ 5.281704] imx-sgtl5000 sound.12: snd_soc_register_card failed (-517)
>
> With sound built in I get sound on the 'line out' output and from dmesg;
>
> dmesg | grep snd
> imx-spdif sound-spdif: snd-soc-dummy-dai <-> 2004000.spdif mapping ok
>
> In both cases I get (or similar);
>
> dmesg | grep firm
> imx-sdma 20ec000.sdma: Direct firmware load failed with error -2
> imx-sdma 20ec000.sdma: loaded firmware 1.1
>
> Not sure if the firmware message above is a problem or not.

   No, it should work without loading external firmware to ram.

>
> aplay output;
>
> aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: imx6wandboardsg [imx6-wandboard-sgtl5000], device 0: HiFi
> sgtl5000-0 []
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0
> card 1: imxspdif [imx-spdif], device 0: S/PDIF PCM snd-soc-dummy-dai-0 []
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0
>
> aplay -L
> null
>      Discard all samples (playback) or generate zero samples (capture)
> pulse
>      PulseAudio Sound Server
> sysdefault:CARD=imx6wandboardsg
>      imx6-wandboard-sgtl5000,
>      Default Audio Device
> sysdefault:CARD=imxspdif
>      imx-spdif,
>      Default Audio Device
>
> aplay -vv ImABeliever.wav
> Playing WAVE 'ImABeliever.wav' : Signed 16 bit Little Endian, Rate 44100
> Hz, Stereo
> Hardware PCM card 1 'imx-spdif' device 0 subdevice 0
> Its setup is:
>    stream       : PLAYBACK
>    access       : RW_INTERLEAVED
>    format       : S16_LE
>    subformat    : STD
>    channels     : 2
>    rate         : 44100
>    exact rate   : 44100 (44100/1)
>    msbits       : 16
>    buffer_size  : 16384
>    period_size  : 4096
>    period_time  : 92879
>    tstamp_mode  : NONE
>    period_step  : 1
>    avail_min    : 4096
>    period_event : 0
>    start_threshold  : 16384
>    stop_threshold   : 16384
>    silence_threshold: 0
>    silence_size : 0
>    boundary     : 1073741824
>    appl_ptr     : 0
>    hw_ptr       : 0
> #################           +                      | 55%
>
> but no sound form SPDIF.
>
> If this is right place for this and if I can be of any help debuuging or
> you need more info I'm more than happy to help in any way I can.
>
> Since I sent the original message Ive realised that data is being sent
> to and received at the SPDIF output of the wandboard quad it can't seem
> to handle it.

   This is somewhat unclear. If you confirm that the data is being
set to spdif port correctly, what do you mean by "it can't seem to
handle it" ?


> If I connect a DAC to the SPDIF output and then connect
> the DAC to my recievers aux input I hear the sound in all it's glory.

   If you have your spdif output connected to dac and that works fine
then I would say your spdif is just fine. There might be something
specific with your receiver.

>
> The same receiver and cabling works with a cubietruck and the sunxi kernel.

   I would suggest you hook up a scope to your spdif output for both
wandboard and cubietruck and compare the signals. Perhaps the voltage
levels are too low for your receiver. You might want to try another
receiver, but I would check the scope outputs first.

   Hope this helps.

   Sinan Akman
