From: Rimas Kudelis <rq@akl.lt>
Subject: Re: Test model
Date: Tue, 21 Feb 2006 12:17:28 +0200
Message-ID: <43FAE8B8.4000400@akl.lt>
References: <200602202317.k1KNHPMb021810@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602202317.k1KNHPMb021810@auster.physics.adelaide.edu.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

>> I think I pointed both capture sources at MIC1 (my internal/external
>> microphone), then selected both channels for capture in capture mixer.
>>    =20
> What program did you then use to do the recording?=20
Gnome sound recorder.

> In a vast majority of
> cases this will only record from the first PCM, so even though alsamixe=
r had
> both ADCs selected, odds are you were still only recording one of them.
> This probably explains the silence in your initial test - you were stil=
l
> only recording ADC0, but in that case it didn't have any source enabled.
>
> Therefore the only odd thing about that test is the fact that you didn'=
t
> get any signal from the mic.
>  =20
Yes, and I also wonder, where could that hiss have come from...

>>> What kind of microphone were you using?  Did you have a bias setting
>>> configured for the jack the mic was connected to?
>>>      =20
>> I tried it with the internal mic. I could clearly hear in the speakers
>> when I tapped the computer with my fingers, so I assumed I should be
>> able to record that sound too. However, all I got was the hiss ...
>>    =20
> I would have expected that to work.  Which speakers did you hear the ta=
pping
> in?  The internal ones and the headphone jack aren't currently function=
al,
> so that leaves only the external mic jack operating as an output, doesn=
't
> it?  If so then perhaps it's some kind of coupling.
>  =20
No, I used the Line-In jack (LINE1 channel) operating as output. Mic
(MIC1 channel) was set to 50pc or 80pc mic, of course. I could clearly
hear my tapping from the external amplified speakers connected to the
Line-In jack, but nothing was recorded no matter which ADC(s) I selected
for capture.

>>>> Also, not sure if it's alsamixer's or driver's fault, alsamixer alwa=
ys=20
>>>> says "Input Source 1" is "1", even though it selects the required so=
urce.
>>>>        =20
>>> I'm confused by this - "1" isn't an option AFAIK.  "MIC1", "MIC2", "L=
INE1",
>>> "LINE2" etc are the options.
>>>      =20
>> Right. So I can select MIC1, LINE1 etc in the alsamixer, but the
>> indicator at the top always says "1" no matter what I select.
>>    =20
> I'll have to check this on my laptop tonight - in particular, I'm not s=
ure
> what the "indicator at the top" is off-hand.
>  =20
There's an informational block at top-left of alsamixer.

>> OTOH, I haven't recompiled ALSA utils (I think, Im using what Ubuntu h=
as
>> provided me with), so it might just be version incompatibility.
>>    =20
> Which version of alsautils is that - the version number should be at th=
e top
> of alsamixer.
>  =20
I can't check it now.

> The initverbs for the test model unmute both the input and output of NI=
Ds
> 0x0f to 0x15, so they are ready for whichever mode is configured by the=
 mode
> switch.  This is why there are no explicit switches in the mixer for th=
is.
> Having switches for this would add significantly to the number of thing=
s a
> tester would have to think about.  It was clear from my tests that havi=
ng
> both input and output unmuted didn't cause any trouble (beyond perhaps
> contributing to a slight increase in the noise level when sampling), so
> there was no basis to include manual switches for these.
>  =20
That's why I said it should probably go to the extended test model.
However, on the other hand, if unmuting those ports indeed increases
noise level, maybe it would indeed be better to mute certain unused
ports in certain models that don't have anything connected to them anyway=
s.

> Having said all that, I think it's actually possible to include manipul=
ation
> of these mute switches as part of the jack mode control.  Doing so will=
 reduce
> the ADC noise level slightly.
>  =20
That's a positive effect.

> This is simply to enable or disable the SPDIF control.  Having it disab=
led=20
> puts it into the Hi-Z state, which is short for "high impedence".  Esse=
ntially
> this means that the current driver/receiver is disconnected from the pi=
n.
> It doesn't mean that analog audio is enabled.
>  =20
Oh, I see.

Another thing: hda_local.h defines six pinctl values:
#define PIN_IN 0x20
#define PIN_VREF80 0x24
#define PIN_VREF50 0x21
#define PIN_OUT 0x40
#define PIN_HP 0xc0
#define PIN_HP_AMP 0x80
Did you miss the PIN_HP_AMP option when adding channel mode switchers,
or is it not available for ALC260, or what? If it's available in ALC260,
I think it should be added to the list of options. Just to make sure
we're not missing anything...

Another weird detail. Look at the picture here:
http://notebooky.idnes.cz/obrazek/acer_tm4600_aspire1690_09.jpg. On my
mothers notebook (which is almost identical to the one in the pic), the
outside of Line In and Mic jacks is made of metal, while the outside of
Headphones jack is made of black plastic. I wonder what is the reason
for this...

>>> The only way I would have thought the digital outputs could come into=
 play
>>> is if for some reason the internal speaker and headphone jack were dr=
iven
>>> off an external DAC.  As I mentioned in a previous post though this d=
oesn't
>>> seem sensible from where we stand.
>>>      =20
>> Well, having no sound from internal speakers in Linux, while having it
>> in Windows, doesn't seem sensible too... ;) It's as I said - when no
>> sane options are left, it's probably the time to try those that seem
>> insane. Just to make sure.
>>    =20
> No arguments there.  I can't help but think that we're missing somethin=
g
> though.
I think so too. However, there's one weird thing - one user of a similar
laptop said on Ubuntu forums that the sound worked for him initially.
However, it seems like he's too =84untechnical=93 and unmotivated to give
any detail or even engage into a dialog... :( I wouldn't even be
surprised to find out that his notebook is not a member of the
Travelmate 4060 series at all...

RQ



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
