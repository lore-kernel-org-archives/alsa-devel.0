From: Raymond <rayau@netvigator.com>
Subject: Re: Alsa mix in HW
Date: Sat, 20 Aug 2005 16:30:31 +0800
Message-ID: <4306EA27.7060000@netvigator.com>
References: <42EBAE72.9090608@e4a.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42EBAE72.9090608@e4a.it>
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

Manuel Jander wrote:
> On Wed, 2005-08-17 at 19:25 +0200, Takashi Iwai wrote:
>
>>At Wed, 17 Aug 2005 12:42:26 -0400,
>>Lee Revell wrote:
>>
>>>On Wed, 2005-08-17 at 20:42 +0800, Raymond wrote:
>>>
>>>>Do anyone have a list of the sound cards ( alsa driver ) which
>>>>support the above features ?
>>>
>>>Vortex and emu10k1/2 at least...
>>
>>You can count ymfpci and trident, too.
>
>
> ESS Maestro. The 3D HRTF pipelines does not seem to be clear how they
> can be used, but AFAIK the hardware mixing and pitch programming
> should be possible.
>

Since ALSA support multiple sound cards, it is possible to use onboard
sound chip as capturing device.

Is it feasible to use one or more sound cards for playback ? (e.g. 
on-board sound chip with dmix is capable of playing stereo background 
music, or you have two sound cards which support hardware mixing)


Refer to 4.3.2 Source Attributes

Get/Set Offset

AL_SEC_OFFSET - the playback position expressed in seconds.
...
This value is based on byte position, so a pitch-shifted source will
have an exaggerated playback speed. For example you can be 0.500 seconds
into a buffer having taken only 0.250 seconds to get there if the pitch
is set to 2.0

AL_SAMPLE_OFFSET - the playback position  expressed in samples

AL_BYTE_OFFSET - the playback position, expressed in bytes.


Do "SNDRV_PCM_RATE_CONTINUOUS" in snd_hardware_t mean that sample rate 
can be any integer between .rate_min and .rate_max ?

Since changing sample rate while playing is not offically supported by
ALSA. The audio are usually play in LOOP, is it feasible to change the
sample rate at the start of each loop if doppler effect is required ?


Refer to src/alc_device.c

#define _ALC_DEF_FREQ 44100
#define _ALC_NUM_PERIODS 2
#define _ALC_BUFFER_SIZE 4096


	if (snd_pcm_hw_params_set_channels(src->handle, hw_params, 2))
		return ALC_FALSE;

	src->freq = dev->freq;
	if (snd_pcm_hw_params_set_rate_near(src->handle, hw_params, &src->freq, 0))
		return ALC_FALSE;

	src->periods = _ALC_NUM_PERIODS;
	if (snd_pcm_hw_params_set_periods_near(src->handle, hw_params, 
&src->periods,0))
		return ALC_FALSE;


	size = _ALC_BUFFER_SIZE;
	if (snd_pcm_hw_params_set_buffer_size_near(src->handle, hw_params, &size))
		return ALC_FALSE;


1) most of the audio are mono except those stereo backgroud music.
2) is there any special reason to use _near() function to set rate, 
period_size and buffer_size in that order ?






-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
