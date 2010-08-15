From: "Sebastian H." <vand2@gmx.de>
Subject: Re: Alsamixer-Qt4 0.4.0 released
Date: Sun, 15 Aug 2010 15:14:35 +0200
Message-ID: <4C67E83B.4020605@gmx.de>
References: <4C595A52.7030401@gmx.de>	<AANLkTin0b0yBvVeVEGrWdkXUYh1J5Hwvj7Hu29iw3oV2@mail.gmail.com>	<4C600BDA.5090400@gmx.de>
	<AANLkTimGjUEcwsLOQCXuSieOJrgKq0zDoZwMnqaq1OU2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 3F65824399
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Aug 2010 15:13:15 +0200 (CEST)
In-Reply-To: <AANLkTimGjUEcwsLOQCXuSieOJrgKq0zDoZwMnqaq1OU2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Niels Mayer <nielsmayer@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> That's why I decided to improve envy24control ( aka mudita24 ) for
> those w/ envy24-based cards.

The screenshots look good! (Don't have the card)

>> Ok, I thought that the main area - for simplicity - should only contain
>> combined mono sliders and if people really want to alter channels they
>> could use the channel mixer (button on the sidebar).
>>
>> But if a combined mono slider is not appropriate at all for a
>> multi channel element I wonder how get to known about it from
>> the ALSA API. Or to put in an other way: When should all channel
>> sliders be displayed instead of a combined mono slider?
>> Is it when
>>  snd_mixer_selem_has_playback_volume_joined ( elem ) == 0?
>> or when
>>  snd_mixer_selem_is_capture_mono ( elem ) == 0?
>> or must there be a string comparison plus element
>> database in the mixer application (not desireable IMHO)?
> 
> I believe the compromise solution to this problem is to check for
> capture mono versus capture stereo. If the values are different, put
> up either two sliders for the different levels (which wastes a lot of
> screen space), or put up a single level slider and a panpot control
> directly below it to indicate it's a stereo channel and where L->R the
> signal ends up going.

I prefer two parallel sliders but that sounds good.
So the rule would be:
Show all channel sliders if not all channels have the same value
(slider or check).

This would not handle the case where all channels have the same value
but easily could have different values. In that case the "channel mixer"
dialog must be fired up once. Maybe by right clicking the slider (not
implemented, yet).

> This is already available w/ the 'channel mixer' but it's hidden under
> a popup. IMHO, if the existing L/R mix values are different, then it
> is a bug to display them as a single slider, usually showing the LHS
> value (from what I observed). Likewise, if the mute values are
> different, then the actual values should be displayed, rather than
> just "sampling" a single channels worth of information.

Agreed, in such cases all channel sliders/checls should show up in the
main area.

> Ive seen
> countless situations where people have needed to ask for basic audio
> help because they used a GUI that hid important information, instead
> of allowing the user to notice some oddball value as they scroll
> through 'alsamixer'.

Hehe, that's exactly my experience. Everyone who e.g. fires up
flashy Skype fires up the _console_ alsamixer at maximum five
minutes later and not one of the GUI mixers.

> 'alsamixer' can display these stereo mixer channels correctly -- the
> ASCII-block "faders" are split into narrow stereo pairs for the
> channels where the levels are different. Unfortunately, it doesn't
> handle displaying the stereo mute like envy24control/mudita24.

I don't like showing both channels _always_ because in most situations
this is more information than needed and it floods precious
screen space. But in cases it should be possible to show up all channels
in the main area.


>>> (Btw "Delta IEC958 Input Status" should not be "writeable" -- it's a
>>> status indicator, but in alsamixer-qt4, it doesn't turn on when then
>>> digital input has signal).
>>
>> Ok, this surely can be fixed, too. But how do I know that an element is
>> not writeable.
> 
> Not sure about that. "IEC958 input status" is a new card-specific
> feature I just added to mudita24. Since I've only seen it on M-Audio
> delta cards, I added yet more card-specific checks and support to
> mudita24 for all delta cards w/ digital inputs.
> 
> However, as an indicator, alsamixer-qt4 should show it "lighting up"
> when I have a valid digital input signal. This is useful, for example,
> in preventing a lockup if you switch the clock-sync input to the
> digital in, you want to know there's something there to lock on to....
> Which is why I added it to mudita24.

Alsamixer-Qt4 just shows what it gets from the alsa-lib.
If alsa-lib doesn't trigger a "changed" event when the digital input has
signal then there's little the mixer can do about it.
Except polling of course. But that doesn't look like a case where
polling from the mixer should be neccessary.

One thing the mixer could try to determine writability is to write back
the first value it read and check if e.g.
snd_mixer_selem_set_playback_switch ( )
returns an error.

> 
> -- Niels
> http://nielsmayer.com
> 
> PS: digression -- has anybody used Vala to create a "mixer
> construction kit" out of nicely wrapped ALSA constructs and
> expeditiously-leveraged existing C/C++ code? ( i was thinking any
> serious hacking on envy24control/mudita24 deserves at least this
> centuries' programming languages&desktop support --
> http://www.linuxaudio.org/mailarchive/lad/2010/8/11/172721 ).... IMHO
> this approach could be leveraged into something more useful for ALSA
> -- an ALSA "wizard" that could extract a high-level description of
> hardware, apply a rule-base of test/solutions to solving traditional
> and ongoing audio-setup or upgrading problems, and help visually
> construct a custom system control panel interface to all the audio and
> media devices on a particular person's system. It should also do the
> dishes. :-)

Well, I could help with the dishes but the first part is slightly
beyond my comprehension. :-)

Best,
Sebastian
