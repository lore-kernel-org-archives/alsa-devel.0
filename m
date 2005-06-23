From: Raymond <rayau@netvigator.com>
Subject: Re: Speaker-test improvements
Date: Thu, 23 Jun 2005 18:20:59 +0800
Message-ID: <42BA8D0B.5060501@netvigator.com>
References: <20050414204147.78276.qmail@web60808.mail.yahoo.com> <s5hzmw0chyq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzmw0chyq.wl@alsa2.suse.de>
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


>>>Takashi Iwai <tiwai@suse.de> writes:
>>>
>>>
>>>>At Wed, 13 Apr 2005 21:02:31 +0100,
>>>>James Courtier-Dutton wrote:
>>>>
>>>>>Hi,
>>>>>
>>>>>I have got some voice samples saying things like "Front Right" etc. that
>>>>>I want the speaker-test program to output instead of the loud sine wave
>>>>>it currently does. The sine wave will stay there as an option as I find
>>>>>it useful for some things.
>>>>>
>>>>>The samples are 10 .wav files in 48khz mono S16_LE format.
>>>>>Where abouts should I put them in the CVS, and where abouts should they
>>>>>get installed to, so that speaker-test can find them?
>>>>

It seem most onboard audio (intel8x0,hda) have ".channels_min = 2".

You may need to merge the mono "Left" and "Right" wav to a stereo
left_right.wav


static snd_pcm_hardware_t snd_intel8x0_stream =
{
     .channels_min =        2,
     .channels_max =        2,
}


aplay -D hw:1,0 speaker-test/samples/*.wav
Playing WAVE 'speaker-test/samples/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
aplay: set_params:887: Channels count non available


aplay -Dplughw:1,0 speaker-test/samples/*.wav
Playing WAVE 'speaker-test/samples/Front_Left.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
Playing WAVE 'speaker-test/samples/Front_Right.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono


>>
>>
>>I made up a sound file similar to this and it was quite helpful.  One of the
>>files had individual voices (one at a time) to identify the speakers, and being
>>with the proper 4-channel specifications for broadcast they were identified as
>>"left front", "right front", "left BACK" and "right BACK".  In doing so it
>>eliminated the abbreviation of "R" being both "rear" and "right" (not very
>>clear).
>>
>>Another test was having all of the channels identified "simultaneously",
>>usually in a loop.  This allowed me to play with mixer controls which always
>>get mixed up and get the correct things in the correct places.  When you hook
>>up sound cards and amplifiers and other external gear, it helps to have the
>>channel identified.  Some mixer controls on some cards fold the "back" channels
>>into the "front" channels, and then you need to poke around in your mixer
>>program ('alsamixer' is but one) to turn on/off "mutes" to get it right. 
> 
> 
> This sounds like a good idea.
> 
> 
>>Having the speaker test "loop" with spoken words was VERY helpful to me.
>>
>>The only "problem" I see is having the samples at one speed.  Sometimes it is
>>helpful to have the program send the sounds out at a specific speed to the ALSA
>>api, where it does further operations (another re-sampling).
> 
> 
> It should be fine when you specify the PCM with "plug" layer, e.g.
> 
> 	% speaker-test -Dplug:surround51 -c6
> 


# speaker-test -D hw:1,0

speaker-test 0.0.8

Playback device is hw:1,0
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Channels count (1) not available for playbacks: Invalid argument
Setting of hwparams failed: Invalid argument


# speaker-test -Dplughw:1,0

speaker-test 0.0.8

Playback device is plughw:1,0
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 8 to 16384
Period size range from 8 to 16384
Periods = 4
Buffer time size 2525
To choose buffer_size = 15052
To choose period_size = 3763
was set period_size = 3763
was set buffer_size = 15052
  0 - Front Left
Time per period = 2.667026
  0 - Front Left
Time per period = 2.978708
  0 - Front Left




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
