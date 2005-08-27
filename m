From: Raymond <rayau@netvigator.com>
Subject: Re: Alsa mix in HW
Date: Sat, 27 Aug 2005 10:02:29 +0800
Message-ID: <430FC9B5.8070101@netvigator.com>
References: <42EBAE72.9090608@e4a.it>	<4306EA27.7060000@netvigator.com> <s5hwtmdorfh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwtmdorfh.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dino Puller <dino@e4a.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dino,

Do your sound cards has devices (snd_hardware_t) support the following
features ?

1) Hardware mixing (no. of subdevices > 1 ??? )
2) Panning mono to 2 or more speakers (.channels_min = 1 and pcm 
volume/panning control for each subdevice)
3) Playback 8/16 bits mono/stereo audio (.format )
3) Doppler Effect (.rate = SNDRV_PCM_RATE_CONTINUOUS )
4) Recording API (capture 8/16 bits mono/stereo audio)
5) Background music (.channels_max >= 2 )


Valid Formats are AL_FORMAT_MONO8, AL_FORMAT_MONO16, AL_FORMAT_STEREO8
and AL_FORMAT_STEREO16.

Refer to alsa-lib/include/pcm.h

	/** Signed 8 bit */
	SND_PCM_FORMAT_S8 = 0,
	/** Unsigned 8 bit */
	SND_PCM_FORMAT_U8,
	/** Signed 16 bit Little Endian */
	SND_PCM_FORMAT_S16_LE,
	/** Signed 16 bit Big Endian */
	SND_PCM_FORMAT_S16_BE,
	/** Unsigned 16 bit Little Endian */
	SND_PCM_FORMAT_U16_LE,
	/** Unsigned 16 bit Big Endian */
	SND_PCM_FORMAT_U16_BE,

Is the audio data stored in the alBuffer signed or unsigned ?


Takashi Iwai wrote:
> At Sat, 20 Aug 2005 16:30:31 +0800,
> Raymond wrote:
> 
>>Manuel Jander wrote:
>>
>>>On Wed, 2005-08-17 at 19:25 +0200, Takashi Iwai wrote:
>>>
>>>
>>>>At Wed, 17 Aug 2005 12:42:26 -0400,
>>>>Lee Revell wrote:
>>>>
>>>>
>>>>>On Wed, 2005-08-17 at 20:42 +0800, Raymond wrote:
>>>>>
>>>>>
>>>>>>Do anyone have a list of the sound cards ( alsa driver ) which
>>>>>>support the above features ?
>>>>>
>>>>>Vortex and emu10k1/2 at least...
>>>>
>>>>You can count ymfpci and trident, too.
>>>
>>>
>>>ESS Maestro. The 3D HRTF pipelines does not seem to be clear how they
>>>can be used, but AFAIK the hardware mixing and pitch programming
>>>should be possible.
>>>
>>
>>Since ALSA support multiple sound cards, it is possible to use onboard
>>sound chip as capturing device.
>>
>>Is it feasible to use one or more sound cards for playback ? (e.g. 
>>on-board sound chip with dmix is capable of playing stereo background 
>>music, or you have two sound cards which support hardware mixing)
> 
> 
> It's feasible via alsa-lib multi plugin.
> 
> 
>>Refer to 4.3.2 Source Attributes
>>
>>Get/Set Offset
>>
>>AL_SEC_OFFSET - the playback position expressed in seconds.
>>...
>>This value is based on byte position, so a pitch-shifted source will
>>have an exaggerated playback speed. For example you can be 0.500 seconds
>>into a buffer having taken only 0.250 seconds to get there if the pitch
>>is set to 2.0
>>
>>AL_SAMPLE_OFFSET - the playback position  expressed in samples
>>
>>AL_BYTE_OFFSET - the playback position, expressed in bytes.
>>
>>
>>Do "SNDRV_PCM_RATE_CONTINUOUS" in snd_hardware_t mean that sample rate 
>>can be any integer between .rate_min and .rate_max ?
> 
> 
> Basically, yes.  A driver might add another restriction but in such a
> case it should use RATE_KNOT instead.
> 
> 
>>Since changing sample rate while playing is not offically supported by
>>ALSA. The audio are usually play in LOOP, is it feasible to change the
>>sample rate at the start of each loop if doppler effect is required ?
> 
> 
> Changing the rate during the DMA is running is not officially
> supported.  This reads: you have to stop the stream once to change the
> parameter.  This isn't what you want, I guess.
> 

Any significant change of frequency shift which can be detected by the 
human ears. ( e.g. listener/source accelerate/decelerate or change 
direction )

Refer to 3.5.2 Velocity dependent Doppler Effect.

The doppler effect will depends on
1) Source velocity
2) Listener velocity
3) AL_SPEED_OF_SOUND (speed of the sound in medium, default value 343.3)
4) AL_DOPPLER_FACTOR (zero = disable doppler effect, default 1.0)


Any sound card (alsa-driver) can produce doppler effect using special
device/synth device other than changing sample rate ?

> 
> 
>>Refer to src/alc_device.c
>>
>>#define _ALC_DEF_FREQ 44100
>>#define _ALC_NUM_PERIODS 2
>>#define _ALC_BUFFER_SIZE 4096
>>
>>
>>	if (snd_pcm_hw_params_set_channels(src->handle, hw_params, 2))
>>		return ALC_FALSE;
>>

Refer to 5.3.4 Specifying Buffer Content

Buffer contains audio with more than one channels will be played with 3D
spatialization features - these formats are normally used for background
music.

This means alcOpenDevice will base on the channels of the audio to find
the suitable device from the available sound cards.

The structure AL_source should contain format/channels of the audio and
device/subdevice or "device name" to allow sound card use different
devices to handle mono stream for 3D spatialization and the background 
music.

There is no existing ALSA-LIB functions which can set the pcm volume 
control of the subdevice to the speakers for all sound cards.

Each device of different sound cards may have different kcontrols to 
change left/right volume , front/rear volume, reverb, delay, ...

What is the best/fast method to identify the devices of different sound 
cards in order to call the hardware depdendent routine ?

const char *snd_pcm_info_get_id(const snd_pcm_info_t *obj);
const char *snd_pcm_info_get_name(const snd_pcm_info_t *obj);
const char *snd_pcm_info_get_subdevice_name(const snd_pcm_info_t *obj);


>>	src->freq = dev->freq;
>>	if (snd_pcm_hw_params_set_rate_near(src->handle, hw_params, &src->freq, 0))
>>		return ALC_FALSE;
>>
>>	src->periods = _ALC_NUM_PERIODS;
>>	if (snd_pcm_hw_params_set_periods_near(src->handle, hw_params, 
>>&src->periods,0))
>>		return ALC_FALSE;
>>
>>
>>	size = _ALC_BUFFER_SIZE;
>>	if (snd_pcm_hw_params_set_buffer_size_near(src->handle, hw_params, &size))
>>		return ALC_FALSE;
>>
>>
>>1) most of the audio are mono except those stereo backgroud music.
>>2) is there any special reason to use _near() function to set rate, 
>>period_size and buffer_size in that order ?
> 
> 
> The requested rate isn't supported always.

These should not be a problem if the device support 
SNDRV_PCM_RATE_CONTINUOUS.

Is there any software SRC ALSA plugin ?

> 
> The order of hw_params calls may influence the resultant parameters.
> Especially, the parameters for period and buffer sizes are very
> sensitive.
> 
> Usually, the order of period_size -> buffer_size is more stable than
> buffer_size -> period_size.
> 

Do any devices of the sound cards in the above list require a special 
period_size/buffer_size to produce special effect ?

>>Are the following result normal when using the following fuctions on
>>device "plughw:x,x" ?
>>
>>rate_min=4000 for snd_pcm_hw_params_get_rate_min()
>>rate_max=-1   for snd_pcm_hw_params_get_rate_max()
>
>
> Judging the plug layer from such values is not recommended at all.
> If you want to skip the software SRC, set 0 to
> snd_pcm_hw_params_set_rate_resample().
>

The OpenAL 1.1 specification do not have restriction on frequency and
format when capturing audio.

Do ALSA support rate_resample/reformat when using "plughw:0,0" to 
capture 8/16 bits mono/stereo audio ?






-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
