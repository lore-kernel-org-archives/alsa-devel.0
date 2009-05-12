From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Master vs. Front/Rear/LFE/... elements
Date: Tue, 12 May 2009 08:47:31 +0100
Message-ID: <ad2655cb0905120047g69887a4bg5e0794bbd21eac27@mail.gmail.com>
References: <20090506175824.GA30355@tango.0pointer.de>
	<s5hbpq5s3fx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f167.google.com (mail-bw0-f167.google.com
	[209.85.218.167])
	by alsa0.perex.cz (Postfix) with ESMTP id B0B5F103847
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 09:47:32 +0200 (CEST)
Received: by bwz11 with SMTP id 11so3355713bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 12 May 2009 00:47:31 -0700 (PDT)
In-Reply-To: <s5hbpq5s3fx.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

2009/5/7 Takashi Iwai <tiwai@suse.de>:
>
> IMO, the best would be a total rewrite of the current mixer API, as I
> mentioned some times. =A0Right now it's more complicated than needed,
> but not powerful enough to handle exceptional cases.
>
> I know designing a generic and fully-working API is pretty difficult,
> though...
>

Isn't that a bit of overkill.
I don't think the API is the problem.
I thought about re-writing the API mixer api when I was updating the
alsamixer.c for dB settings.
When you look into it in more detail, there really is no easy way to
do a better api than the one we already have and still support all the
different sound cards out there.
For pro applications, one also has large USB attached mixer control
decks, with sliders etc, and one would have to write code to ensure
they link up correctly with the correct mixer controls. I.e. A user
moves a slider on the control deck, and it moves the correct slider in
alsamixer.
I think what we really do need is a global definition of each control.
I.e. Master Playback control
1) Must exist.
2) Adds another gain/attenuation after the "front, side, rear etc."
controls. (I.e between the front control and the speaker.
3) Should the control be presented as 3 stereo controls, or one 6
channel control?
4) Is the control linked to a PCM, or is it a global control on the
output side of the sound chip.

I would like to see a global "Speaker arrangement" setting, where the
user can tell alsa how they have their speakers arranged. E.g. They
have 2 speakers, or they have 5.1 speakers, or that have 2 speakers
and one set of headphones and where each are plugged in. The driver
would restrict the options depending on the hardware possibilities.
The alsa mixer could then present a consistent view in each case.

Once we have the global definition, we can then fix each driver to
comply with it. In some cases we will have to add virtual controls.
I.e. Create a software master control and use software to make it
behave like a real hardware control.
I think this global definition is all that PA really needs. They can
then implement it using a single method, and then they can highlight
all the sound card drivers that need fixing to match it.

I personally think that the user should set the global speaker
settings, the master, front, rear etc. controls and then just leave
them.
I think applications should only control their own PCM channel volume,
and not touch the master volume at all. PA could then further control
PCM channel volumes, by for example automatically attenuating the
sound of an application when it gets put in the backround, if the user
so wishes. Applications should not have to talk to the alsa mixer at
all. Just modify a value associated with the PCM stream they are
outputting to adjust its gain/attenuation.
I.e.
int value;
handle =3D snd_pcm_open();
snd_pcm_set_hwparam/swparams etc.;
snd_pcm_set_gain(handle, &value);
snd_pcm_get_gain(handle, &value);

That should be all the user app or PA needs to do
The user app should not have to talk to the alsa mixer api at all.
Only a single global mixer control app should need to do that.
