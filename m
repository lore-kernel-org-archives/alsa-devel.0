From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Master vs. Front/Rear/LFE/... elements
Date: Tue, 12 May 2009 10:02:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905120951120.25064@eeebox2.perex-int.cz>
References: <20090506175824.GA30355@tango.0pointer.de>
	<s5hbpq5s3fx.wl%tiwai@suse.de>
	<ad2655cb0905120047g69887a4bg5e0794bbd21eac27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1719668010-1242115362=:25064"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 310E3246E4
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 10:02:43 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1719668010-1242115362=:25064
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 12 May 2009, James Courtier-Dutton wrote:

> 2009/5/7 Takashi Iwai <tiwai@suse.de>:
>>
>> IMO, the best would be a total rewrite of the current mixer API, as I
>> mentioned some times. =C2=A0Right now it's more complicated than needed,
>> but not powerful enough to handle exceptional cases.
>>
>> I know designing a generic and fully-working API is pretty difficult,
>> though...
>>
>
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
>
> I would like to see a global "Speaker arrangement" setting, where the
> user can tell alsa how they have their speakers arranged. E.g. They
> have 2 speakers, or they have 5.1 speakers, or that have 2 speakers
> and one set of headphones and where each are plugged in. The driver
> would restrict the options depending on the hardware possibilities.
> The alsa mixer could then present a consistent view in each case.
>
> Once we have the global definition, we can then fix each driver to
> comply with it. In some cases we will have to add virtual controls.
> I.e. Create a software master control and use software to make it
> behave like a real hardware control.
> I think this global definition is all that PA really needs. They can
> then implement it using a single method, and then they can highlight
> all the sound card drivers that need fixing to match it.
>
> I personally think that the user should set the global speaker
> settings, the master, front, rear etc. controls and then just leave
> them.
> I think applications should only control their own PCM channel volume,
> and not touch the master volume at all. PA could then further control
> PCM channel volumes, by for example automatically attenuating the
> sound of an application when it gets put in the backround, if the user
> so wishes. Applications should not have to talk to the alsa mixer at
> all. Just modify a value associated with the PCM stream they are
> outputting to adjust its gain/attenuation.
> I.e.
> int value;
> handle =3D snd_pcm_open();
> snd_pcm_set_hwparam/swparams etc.;
> snd_pcm_set_gain(handle, &value);
> snd_pcm_get_gain(handle, &value);
>
> That should be all the user app or PA needs to do
> The user app should not have to talk to the alsa mixer api at all.
> Only a single global mixer control app should need to do that.

In my opinion, it would be better to offer a reduced mixer for playback=20
and capture PCMs. Something like:

int snd_amixer_open(snd_amixer_t **amixer, const char *name,
                     snd_pcm_t *playback_pcm, snd_pcm_t *capture_pcm,
                     int mode);

For playback, 2 controls will be available:

Master=09=09- master playback volume
PCM=09=09- PCM stream volume

For capture, a set of controls bellow will be available:

Capture=09=09- capture volume
Source=09=09- source (enum list)
###=09=09- other mixed sources (volume (optional) + switch (required))

If some pcm handle is zero, the mixer direction might be skipped.
If both pcm handles are zero, global mixer will be available to app.

The reasons to pass partial mixer to app:

dB ranges
value change event handling

 =09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-1719668010-1242115362=:25064
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1719668010-1242115362=:25064--
