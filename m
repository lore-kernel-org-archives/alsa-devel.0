From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Master vs. Front/Rear/LFE/... elements
Date: Tue, 12 May 2009 15:15:22 +0200
Message-ID: <20090512131522.GE29607@tango.0pointer.de>
References: <20090506175824.GA30355@tango.0pointer.de>
	<s5hbpq5s3fx.wl%tiwai@suse.de>
	<ad2655cb0905120047g69887a4bg5e0794bbd21eac27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DFBC103840
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 15:15:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ad2655cb0905120047g69887a4bg5e0794bbd21eac27@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 12.05.09 08:47, James Courtier-Dutton (james.dutton@gmail.com) wrote:

> Isn't that a bit of overkill.
> I don't think the API is the problem.
> I thought about re-writing the API mixer api when I was updating the
> alsamixer.c for dB settings.
> When you look into it in more detail, there really is no easy way to
> do a better api than the one we already have and still support all the
> different sound cards out there.
> For pro applications, one also has large USB attached mixer control
> decks, with sliders etc, and one would have to write code to ensure
> they link up correctly with the correct mixer controls. I.e. A user
> moves a slider on the control deck, and it moves the correct slider in
> alsamixer.
> I think what we really do need is a global definition of each control.
> I.e. Master Playback control
> 1) Must exist.
> 2) Adds another gain/attenuation after the "front, side, rear etc."
> controls. (I.e between the front control and the speaker.
> 3) Should the control be presented as 3 stereo controls, or one 6
> channel control?
> 4) Is the control linked to a PCM, or is it a global control on the
> output side of the sound chip.

That would probably not be sufficient, but I do like the approach of
exposing a simplified more focussed mixer instead of more powerful
complicated one. I have done a little bit researchabout what I need to
expose in PA and what I shouldn't and where the difficulties when
implementing this lie.

1) Definition of Mic vs. Capture is not clear. Usually Mic controls
the feedback volume, while Capture controls the actual volume on the
ADC. On some USB cards that's different and Mic actually does control
the ADC.

2) Input selection is really not unified. The are controls 'Input
Source Select', 'Input Source', 'Mic Select', 'Capture Source', that
all need to be covered. Some cards even have two of those. The
enumerated options they have are usually some form Mic and Line-In and
a few others, but the names vary wildly. i.e. There is 'Mic',
'Microphone', 'iMic', 'i-Mic', 'DMic', 'Int Mic', 'IntMic', 'Internal
Mic', 'Internal Microphone', 'Front Mic', 'Front Microphone', 'Mic 1',
'Mic1', ... Also, some of the input selection enums appear as playback
enums, not as record enums. Then there are these enums, but also
selectin of the input source via switches on the elements. From PA's
perspective all I want to support is routing from exactly one input
source, and have a very generic cageorization of the input. (i.e. is
it Line-In? Is it Mic?  But not any more detail.)

3) There are various Mic boosts available, and I generally have no
idea to what dB factor they relate. I found at least 'Mic Boost',
'Capture Boost', 'Front Mic Boost', 'Mic Boost (+20dB)'. I'd rather
see those boosts exposed as volume sliders that go from 0dB to their
dB factor in a only 1 step. 

4) Output selection isn't much better. There are usually no enums
involved. But there are switches involved. And that in non obvious
ways: i.e. sometimes the 'Headphone' switch is dependant on the
'Master' switch and sometimes this seems not to be the case. 

5) Mapping to jack sensing devices is not clear to me.

6) Not sure what to do about the 'External Amplifier' setting.

7) I need to know the order of volume sliders on the path from the DAC
to the speakers. 

8) The channels of all sliders/switches need to identifiable. For
example, if Master only exposes two channels it would be good to know
which chanells this actually influences. i.e. the channel idshould be
a bitfield, not a single integer.

9) Some cards seem to connect LFE to "Master Mono". It would be good
if that slider could be called LFE then.

So, from the PA perspective all I need is a way to enumerate and
select inputs. Only one input at a time. I need to enuemrate outputs,
and select outputs. Only one output at a time. Those inputs/outputs
should have geneirc, parsable names. And I need the sliders that are
on the pipeline from the DAC/ADC to the outputs/inputs. Beyond that
there are very few additional controls I might need to know anything
about.

> I personally think that the user should set the global speaker
> settings, the master, front, rear etc. controls and then just leave
> them.

I don't think so. I think 'Master' is the one that should be the one
that is usually controlled since it is most likely controls an analog
amp if there is any.

> I think applications should only control their own PCM channel volume,
> and not touch the master volume at all. PA could then further control
> PCM channel volumes, by for example automatically attenuating the
> sound of an application when it gets put in the backround, if the user
> so wishes. Applications should not have to talk to the alsa mixer at
> all. Just modify a value associated with the PCM stream they are
> outputting to adjust its gain/attenuation.
> I.e.
> int value;
> handle = snd_pcm_open();
> snd_pcm_set_hwparam/swparams etc.;
> snd_pcm_set_gain(handle, &value);
> snd_pcm_get_gain(handle, &value);

Not sure if this is really enough. Recording apps might want to
control the Mic Boost too.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
