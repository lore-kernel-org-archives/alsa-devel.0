From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0_synth
Date: Wed, 30 Mar 2005 16:04:13 +0800
Message-ID: <424A5D7D.2070400@netvigator.com>
References: <423CCDAC.80401@netvigator.com> <s5h4qf44vna.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qf44vna.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Takashi Iwai wrote:
> Raymond wrote:
>>>>Lee Revell wrote:
>>>>Looks like this chipset has a wavetable synth.  And I noticed some
>>>>references to a driver on the openvortex list.  Would it be possible
>>>>for ALSA to support it?
>>
>>>Manuel Jander wrote:
>>> Of course, but there are some unresolved hardware issues. The
>>> WaveTable helper hardware is very similar to the trident
>>> Wavetable helper hardware. It does not interpret MIDI directly, but
>>> at least does some effect processing in hardware.
>>
>>
>>http://sourceforge.net/mailarchive/message.php?msg_id=6004190
>>
>>1) Is the Trident Wavetable working ?
>
>
> Very limited.  It's no proper "MIDI" wavetable implementation.
> IIRC, only a module player worked with trident driver.
>

http://www.alsa-project.org/~frank/alsa-sequencer/node12.html

The midi port only need to support 16 voices, the 16 sample rate
convertors are just enough to produce 16 voices using the mono sound
samples in the soundfonts au30gm.arl

http://www.alsa-project.org/alsa-doc/alsa-lib/seq.html

Please correct me if I am wrong, there seem to be no documentation on
those ALSA sequencer functions such as snd_seq_create_kernel_client,...

What will be needed for a proper "MIDI" wavetable implementation ?

Manuel Jander wrote:
> Raymond wrote:
>>The "vortexcontrol" use alsa-lib API to play the audio
>>samples inside au30gm.arl through hw:0,0.
>
>
> Thats because its just for hearing a sample. Its not even close to
> what has to be done for a Wavetable implementation. The higher level
> arl soundbank interpreter is very valuable, but on the hardware side
> we are missing the WT engine support.
>
>

In snd_vortex_playback_hw_adb, .rates = SNDRV_PCM_RATE_CONTINUOUS

1) Can the sample rate convertor be used to perform pitch shift ?

2) Can panning be done by changing the mixin-mixout gain for left/right
channels of each voice ?

The current alsa driver do not even use the timer VORTEX_SMP_TIME or
timer interrupt VORTEX_SMP_TIMER

3) Is there any way to find out the resolution of the timer ?



















-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
