From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Problem with multiopen on SB Audigy 2 / Mixer setting.
Date: Wed, 08 Oct 2003 23:36:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F84915D.5000006@superbug.demon.co.uk>
References: <3F82F126.4000800@superbug.demon.co.uk> <s5h4qylkmbk.wl@alsa2.suse.de> <3F833B40.9070009@superbug.demon.co.uk> <Pine.LNX.4.53.0310081307320.1357@pnote.perex-int.cz> <s5hekxnalsl.wl@alsa2.suse.de> <Pine.LNX.4.53.0310081545030.1357@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0310081545030.1357@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Wed, 8 Oct 2003, Takashi Iwai wrote:
> 
> 
>>At Wed, 8 Oct 2003 13:08:38 +0200 (CEST),
>>Jaroslav wrote:
>>
>>>On Tue, 7 Oct 2003, James Courtier-Dutton wrote:
>>>
>>>
>>>>Takashi Iwai wrote:
>>>>
>>>>>At Tue, 07 Oct 2003 18:00:22 +0100,
>>>>>James Courtier-Dutton wrote:
>>>>>
>>>>>
>>>>>>I have 2 sound cards, card 0 is the motherboard intel/alc650 one, and
>>>>>>card 1 is a SB Audigy2
>>>>>>
>>>>>>Playing two streams at once on device "front:1" works: -
>>>>>>aplay -D front:1 filename.wav
>>>>>>aplay -D front:1 filename.wav
>>>>>>So, this is playing two files to the SB Audigy2 front speakers.
>>>>>>I can hear the two files being mixed together and output together to a
>>>>>>single set of speakers.
>>>>>>
>>>>>>Playing two streams at once on device "rear:1" fails: -
>>>>>>aplay -D rear:1 filename.wav
>>>>>>aplay -D rear:1 filename.wav
>>>>>>So, this is trying to play two files to the SB Audigy2 rear speakers.
>>>>>>
>>>>>>The first files comes out of the rear speakers, but the output from the
>>>>>>second aplay command fails with: -
>>>>>>
>>>>>>bash-2.05b# aplay -D rear:1 filename.wav
>>>>>>Playing WAVE 'filename.wav' : Signed 16 bit Little Endian, Rate 44100
>>>>>>Hz, Stereo
>>>>>>ALSA lib setup.c:94:(snd_sctl_install) Cannot lock ctl elem
>>>>>>aplay: set_params:876: Unable to install hw params:
>>>>>>ACCESS:  RW_INTERLEAVED
>>>>>>FORMAT:  S16_LE
>>>>>>SUBFORMAT:  STD
>>>>>>SAMPLE_BITS: 16
>>>>>>FRAME_BITS: 32
>>>>>>CHANNELS: 2
>>>>>>RATE: 44100
>>>>>>PERIOD_TIME: (125011 125012)
>>>>>>PERIOD_SIZE: 5513
>>>>>>PERIOD_BYTES: 22052
>>>>>>PERIODS: 2
>>>>>>BUFFER_TIME: (250022 250023)
>>>>>>BUFFER_SIZE: 11026
>>>>>>BUFFER_BYTES: 44104
>>>>>>TICK_TIME: 1000
>>>>>>
>>>>>>Can you explain why this might be happening?
>>>>>
>>>>>
>>>>>this is because the "Wave Surround Playback Volume" control is locked
>>>>>by the first rear stream.
>>>>>you can find it in /usr/share/alsa/cards/Audigy2.conf.
>>>>>please try to remove the lock.
>>>>>
>>>>>
>>>>>Takashi
>>>>>
>>>>
>>>>Thanks that fixed the problem.
>>>>Please see attached patch files, for the SB Live and Audigy2, both of
>>>>which have been tested.
>>>
>>>Yes, but the question is, if we want this behaviour. We expect that the
>>>rear channel will go only via rear speakers thus setting of Wave Surround
>>>Volume is required.
>>
>>but the signals from "rear" pcm stream should come in fact only from
>>the rear channels, regardless of "Wave Surround Playback Volume",
>>because it sets max send-volume to FX bus 2/3, and zero to others.
>>
>>setting "Wave Surround Playback" would allow other pcm streams to
>>route the front signals to the surround, but it's a user's choice.
>>i don't think this exclusive behavior is necessary.
>>
>>
>>or am i missing something?
> 
> 
> Yes, my idea was to route signal from stereo applications to all channels,
> but if DVD (or other 4+.0+ format) is used, then use channels
> independently. It appears that James is trying to do something
> non-standard (perhaps playing two DVDs simultaneously), so I am not sure,
> if we should have these things in our configurations.
> 
> It's something like "auto" stuff, but I would like to avoid user
> confusion.
> 
> Anyway, users are already confused with emu10k1+ mixers, so we have to do
> things more simple.
> 
> 						Jaroslav
> 
The person who reported the "rear" issue was playing only games.
"front" had headphones plugged in, because that it is where the 
headphone amp is, and "rear" was connected to speakers. (or the other 
way arround, I don't remember).
The user was playing games so wanted sound coming out of the speakers, 
together with any backround music they wanted. (so 2 opens on speakers 
needed) and also using an application called "teamspeak", where the 
person had a set of headphones with a mic, and they could use them to 
talk to other players on their own team during play. They also wanted to 
possibly play other sound sources into the headphones at the same time.

So, basically, hardware mixing 2 sources to "front", and at the same 
time hardware mixing 2 sources to "rear", and with the help of my patch 
files, they managed to do it.

As the SB Live and Audigy2 both allow this, then I don't think we should 
prevent this sort of setup from working.

Regarding the mixers. I don't think we have to make things more simple 
exactly. We should first decide which sliders we want for playback, and 
what they should be called, and then decide how to implement them for 
each sound card. That way, the naming will be consistent, and also 
intuative to the user.

Maybe we should add the the config files config for mixer's as well as 
the current pcm config, and let alsa-lib take what hardware mixer 
controls there are, and via config files manipulate them to provide the 
standard set that we wish all cards to present.

For example (what the user sees) : -
Master (controls all output channels at once)
Front (controls volume of front speakers)
Headphone (controls volume of headphones)
Rear  (controls volume of rear speakers)
Center/LFE (controls volume of Center/LFE speakers)

If the Headphone's are linked to Front, then combine those 2 sliders.
The conversion from what the user sees, to which registers actually get 
set on the sound card, could be controlled by the config file, and 
therefore allow for Mixer name changing, adding "Front/Rear Fader" could 
all be added by the user into the config file, without any source code 
having to change.

I think that the lack of a clear "mixer view to the user" has led to 
mixer controls having non-intuitive names, and functions.

One think about the Windows mixer that I like, is that one has one 
"playback mixer view" for controlling playback of sound from PC to 
Speakers, and a totally different "recording mixer view" for when 
recording from some source back into the PC.

Also, with this "mixer config file", we might be able to add features 
like "0 db" levels, if the user so wishes.

There are already card specific config files, so having card specific 
mixer config files should not be to difficult to implement.

Cheers
James



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
