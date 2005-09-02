From: Raymond <rayau@netvigator.com>
Subject: Re: Alsa mix in HW
Date: Fri, 02 Sep 2005 21:07:17 +0800
Message-ID: <43184E85.3090100@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
Cc: Dino Puller <dino@e4a.it>, Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>, Manuel Jander <manuel.jander@gmail.com>
List-Id: alsa-devel@alsa-project.org

> Dino wrote:
>> Raymond wrote:
>>
>> Dino,
>>
>> Do your sound cards has devices (snd_hardware_t) support the
>> following  features ?
>>
> I've got an Hercules Fortissimo II (cs46xx)

>> 1) Hardware mixing (no. of subdevices > 1 ??? )

> Yes 31 subdevices

>> 2) Panning mono to 2 or more speakers (.channels_min = 1 and pcm
>> volume/panning control for each subdevice)

> Nope i'm working on volume control per voice but i need more help from
> alsa developers. I can access to each volume control but when i change
> the volume the bass are cutting off and i don't know why :(

The patch for the volume control per voice of au88x0 has just been sent
to openvortex for review. For attenutation by distance, what dB range
can be provided by the volume control of cs46xx ?

16-bits audio data need gain when passing through cs46xx to
18-bits/20-bits DAC of AC97

Does anyone know the dB_to_volume conversion forumla of those pcm volume
control of trident, ymfpci, maestro3, emu10k1 ?

>> 3) Playback 8/16 bits mono/stereo audio (.format )

> Yep

>> Valid Formats are AL_FORMAT_MONO8, AL_FORMAT_MONO16,
>> AL_FORMAT_STEREO8  and AL_FORMAT_STEREO16.

Although cs46xx and trident support S8 ,U8, S16 and U16.

ymfpci, au88x0, maestro3 and emu10k1 only support U8 snd S16

It would be better to store audio in U8 and S16.

The structure AL_source should contain format/channels of the audio to
mono stream for 3D spatialization and the background music.

THe au88x0 driver may use different devices to spatialize mono audio
and stereo background music.

>> 3) Doppler Effect (.rate = SNDRV_PCM_RATE_CONTINUOUS )

> Nope but i souldn't spent too much time for this issue. Pitch shifting
> cost us only 1 addiction in floating point for each word.

Do cs46xx have hardware to perform pitch shift ?

>> 4) Recording API (capture 8/16 bits mono/stereo audio)

> Yep but openal-alsa doesn't support it yet

Do the alsa driver (.info = SNDRV_PCM_INFO_PAUSE) 
snd_pcm_hw_params_can_pause() perform the alcCaptureStop() by calling 
snd_pcm_pause(pcm, 1) and restart by calling snd_pcm_pause(pcm, 0) 
without calling snd_pcm_close() ?

Capture audio

If the application doesn't need to capture audio for an amount of time,
they can halt the device without closing it via the alCaptureStop entry
point.

The implementation is encouraged to optimize for this case. The amount
of audio samples available after restarting a stopped capture device is
reset to zero. The application does not need to stop the capture device
to read from it.

>> 5) Background music (.channels_max >= 2 )

> Yes

>>
>>
>> Valid Formats are AL_FORMAT_MONO8, AL_FORMAT_MONO16,
>> AL_FORMAT_STEREO8  and AL_FORMAT_STEREO16.
>>
>> Refer to alsa-lib/include/pcm.h
>>
>> /** Signed 8 bit */
>> SND_PCM_FORMAT_S8 = 0,
>> /** Unsigned 8 bit */
>> SND_PCM_FORMAT_U8,
>> /** Signed 16 bit Little Endian */
>> SND_PCM_FORMAT_S16_LE,
>> /** Signed 16 bit Big Endian */
>> SND_PCM_FORMAT_S16_BE,
>> /** Unsigned 16 bit Little Endian */
>> SND_PCM_FORMAT_U16_LE,
>> /** Unsigned 16 bit Big Endian */
>> SND_PCM_FORMAT_U16_BE,
>>
>> Is the audio data stored in the alBuffer signed or unsigned ?

> Is 16bit(also for 8bit wave) signed.

Do the audio convert to U8 and S16 in alutLoadWav?

> But openal-alsa works for you? Did you noticed a system improvement?
> I've obtained 2fps in ut2004 about 5% not bad :)

NO,  I cannot link any demo using the re-compiled openal-alsa library.

> bye,
> Dino









-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
