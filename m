From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: twl4030 - Add VDL path support
Date: Tue, 24 Mar 2009 08:35:56 +0200
Message-ID: <200903240835.57308.peter.ujfalusi@nokia.com>
References: <49BF5F40.3020000@samsung.com>
	<200903171122.22136.peter.ujfalusi@nokia.com>
	<4e1455be0903182244i26ce5e4dt6b3bdab3bedfded1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 15FEB1037F9
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 07:36:08 +0100 (CET)
In-Reply-To: <4e1455be0903182244i26ce5e4dt6b3bdab3bedfded1@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Joonyoung Shim <dofmind@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>, =?utf-8?q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, =?utf-8?q?=EB=AF=BC=EB=B3=91=ED=98=B8?= <bhmin@samsung.com>, ext Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 19 March 2009 07:44:23 ext Joonyoung Shim wrote:
> Hi, my thunderbird progrem breaked down, so i send from gmail
>
> > The reason to have the VALUE_ENUM for the audio path selection is that
> > according to the TRM only one of the paths can be enabled at the time.
>
> It's not true. I tested playback about Predrive Right audio path(My target
> is not connected with Predriver Left)
> The AudioL2 and AudioR2 was enabled and i played audio wav file of three
> type following;
>     1. wav file recorded only left channel
>     2. wav file recorded only right channel
>     3. wav file recorded left and right channel
> The result is that all was sounded. If the controller is mux, the case of=
 1
> or 2 haven't to sound.
>
> > While the voice path can be mixed with one of the audio paths (at least
> > that is my understanding).
> > So:
> > AudioL*/AudioR* (DACL*/DACR*) =3D Mux
> > Voice, AudioL/R* (DACL/R*) =3D Mix
> >
> > I think it would be better to leave the current VALUE_ENUMS for the aud=
io
> > path and add a switch for the Voice enable/disable for the outputs and
> > route them through a mixer to the output.
>
> The mixer DAPM is suitable the structure of control registers(0x21, 0x22,
> 0x25, 0x26, 0x27, 0x28) of path except Handsfree path because each bit for
> path is switchable.
> If we use the mixer DAPM, the switch DAPM for voice path doesn't need.
>
> > Probably than it makes sense to rename the "Earpice Mux" and friends to
> > something like "Earpiece aduio Mux"...
> > So we would have two controls per outputs:
> > "Earpiece aduio Mux" (Off, DACL1, DACL2, DACR1)
> > "Earpiece voice Switch" (on, off)
> > and internally we can have "Earpiece output mixer", which mixes them
> > together.

I have given a try to your patch, although it does not work out of the box, =

but I can verify that you are indeed right.
I have been also wondering about these mixer/mux controls for the outputs a=
nd =

the block diagrams in the TRM has MIX in these outputs, but in other places=
 it =

hints that they are a mixture of mux and mixers.

PS 01: you have been missing this part from your patch, which is needed for =

DAPM to power on the path:
        /* outputs */
        {"OUTL", NULL, "ARXL2_APGA"},
        {"OUTR", NULL, "ARXR2_APGA"},
-       {"EARPIECE", NULL, "Earpiece Mux"},
-       {"PREDRIVEL", NULL, "PredriveL Mux"},
-       {"PREDRIVER", NULL, "PredriveR Mux"},
-       {"HSOL", NULL, "HeadsetL Mux"},
-       {"HSOR", NULL, "HeadsetR Mux"},
-       {"CARKITL", NULL, "CarkitL Mux"},
-       {"CARKITR", NULL, "CarkitR Mux"},
+       {"EARPIECE", NULL, "Earpiece Mixer"},
+       {"PREDRIVEL", NULL, "PredriveL Mixer"},
+       {"PREDRIVER", NULL, "PredriveR Mixer"},
+       {"HSOL", NULL, "HeadsetL Mixer"},
+       {"HSOR", NULL, "HeadsetR Mixer"},
+       {"CARKITL", NULL, "CarkitL Mixer"},
+       {"CARKITR", NULL, "CarkitR Mixer"},
        {"HFL", NULL, "HandsfreeL Mux"},
        {"HFR", NULL, "HandsfreeR Mux"},

If you add this to your patch, I'll be happy to ack it.

PS 02: I have hard time to get 'git am' to apply the patch:
git am ../[PATCH\]\ ASoC\:\ twl4030\ -\ Add\ VDL\ path\ support.mbox
fatal: cannot convert from ks_c_5601-1987 to utf-8

Does anyone know how to handle this?


-- =

P=E9ter
