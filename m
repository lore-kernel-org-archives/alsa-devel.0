From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Mixer functions
Date: Tue, 07 Oct 2003 20:19:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F8311D0.50605@superbug.demon.co.uk>
References: <3F7EDBB8.30900@superbug.demon.co.uk> <s5hu16mobof.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu16mobof.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sat, 04 Oct 2003 15:39:52 +0100,
> James Courtier-Dutton wrote:
> 
>>Hi,
>>
>>With 5.1 channel sound being used quite a lot now, I was wondering what
>>to do about volume controls.
>>For example, I have: -
>>Front speakers controlled by PCM and Master slider.
>>Rear speakers controlled by Surround slider
>>Center controlled by Center Slider
>>LFE controlled by LFE slider.
>>
>>I would assume that a "Master" slider would control all 6 channels at
>>the same time.
>>So, in this setup, the Master slider is not actually acting as a Master,
>>but instead, only a Front speaker control.
>>
>>I suggest that in these cases, "Master" gets renamed to something else,
>>and then alsa-lib takes over providing a "Master"
>>alsa-lib could then also use config files, to define the mixer elements.
>>We could then provide mixer elements that do proper "Master",
>>"Front/Rear Fader" etc.
> 
> 
> i agree with this idea.
> the term "Master" is misuse in this case.
> "Front" sounds more reasonable.
> 
> 
>>I know you said earlier that you are in the process of developing a
>>better mixer, possibly having 0db points etc.
>>Could you add these suggestions, so that they are possible as well.
>>
>>Another problem I have come across, is that some sound cards have a
>>headphone amplifier on the front speaker output, and some sound cards
>>have a headphone amplifier on the rear/surround outputs.
>>E.g. ALC650 has headphone on front output.
>>AD1985 has headphone on surround (but is switchable to front).
>>Does anyone know if the AC97 standard is headphones on front, or
>>headphones on rear/surround ?
> 
> 
> no standard.  it depends on the implementation.
> 
> on the recent AC97 codecs, the headphone is no longer headphone, but
> it means "true line-out" for the consumer devices.  sigh, this change
> is the real confusion!  ac97 spec recommends the detection by the bit
> flag in the RESET register and ac97 revision, but in fact, the
> hardware vendor sets the old bit for the compatibility reason.  grrr.
> 
> anyway, on AD198x, most devices use the SURR/HP_OUT for the front
> output, and in fact, alsa driver swaps the outputs as default.
> 
> i'm thinking whether this switch should be provided in control API,
> too, so that user can switch the behavior if the device is not
> auto-detected.
> 
> 
>>I was talking to a user who has sound coming out of a speaker output,
>>but not the headphone or center/lfe outputs, also the slider name
>>controlling the speaker output was "surround".
> 
> 
> on AD1985, now "ADI-compat" mode is set as default.  on this mode, the
> volume control is assigned to "headphone" rather than "surround".
> (hey, another confusion :)  the "surround" effect seems appearing if
> this mode is not set ("AC97-compat" mode), which is used still on
> AD1980.
> 
> on ADI-compat mode, "headphone" and "master" do play really as the
> "master" volume.  there are DAC attenuations in addition.
> in this case, we should control both "master" and "headphone"
> (i.e. register 0x02 and 0x04) as a single "master" control, IMO.
> 
> 
>>It would be nice to find out from yourselves what the AC97 standard says
>>it should be, and I will then post a PATCH to get the AD1985 to act in
>>the same way as all other sound cards.
> 
> 
> 
> Takashi
> 
> 
So, can we standardise on all these playback terms in the mixer: -
1) Front Output
2) Rear Output
3) Center Output
4) LFE Output
5) Front PCM
6) Rear PCM
7) Center PCM
8) LFE PCM
9) Master Output only present if it effects all of (1) to (4), but I 
think it would be better to implement this in software, so that it 
controls 1,2,3,4 depending on whether one is playing 2-channel, 
4-channel or 5.1 channel audio.

And depending on where the headphone amplifier is: -
Front/Headphone Output instead of (1)
or
Rear/Headphone Output instead of (2).

With "output" refering to a control that directly effects a particular 
physical audio jack, and "PCM" refering to the data as it passes from 
the PC to the DSP/Codec.

If a particular card has a DSP, then the controls should happen/be 
implemented in the DSP, and all analogue codec mixer controls hidden, 
and set to 0db level.

I think that maybe a nice modification could be, having the sound card 
hardware report all the possible hardware mixers, together with a 
description of what they do, and then let alsa-lib and a config file 
modify this to present a "common sense" view to the user.

That would then also let the user change the config file to suit 
themselves, without having to change source code.

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
