From: marcus.weigelt@fwd-online.de
Subject: Re-2: [PATCH 2/6] ASoC: ad1980: fix names of a few
 kcontrols
Date: Mon, 30 Aug 2010 11:52:52 +0000
Message-ID: <0034DBC1.4C7BB7B3@mail.fwd-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.fwd-online.de (mail.fwd-online.de [217.243.225.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FA4D10385C
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 13:52:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de
Cc: alsa-devel@alsa-project.org, sonic.zhang@analog.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Subject: Re: [alsa-devel] [PATCH 2/6] ASoC: ad1980: fix names of a few kcon=
trols (27-Aug-2010 20:32)
From:    Mark Brown <broonie@opensource.wolfsonmicro.com>
To:      marcus.weigelt@fwd-online.de

> On Tue, Aug 24, 2010 at 03:09:40PM +0200, Uwe Kleine-K??nig wrote:
> > From: Marcus Weigelt <marcus.weigelt@fwd-online.de>
> > =

> > The names used before keep alsamixer from showing the appropriate
> > controls for the AD1980.  Mic and phone volume controls were shown in
> > alsamixers' capture tab where they don??t belong to.  Phone playback
> =

> It's not massively obvious that microphone and phone aren't inputs and
> therefore don't sensibly appear in the capture tab?

The volume controls for mic and phone are actually hw mixing volumes that d=
o not affect the recording path, therefore only the record selector belongs=
 to capture tab, but not the volume control.

> =

> > volume did not appear in playback tab and the microphone playback could
> > never be unmuted.  Further it was not possible to select phone as
> > capture source.  Changing the names fixes these problems.
> =

> This doesn't sound real - misnamed controls might cause UI problems but
> you'd have to try *really* hard to make the control name completely
> prevent the setting of the control.

May sound unreal, but if you look at the specific changes I=B4ve done, you =
will notice that I just added "Playback" to the mic volume and mic switch a=
nd changed "Phone Capture" to "Phone Playback". From the ALSA amixer.c I kn=
ow, that there is some string compare on "playback" and "capture", don=B4t =
know if it is the same with the alsamixer, but this would explain the diffe=
rent behaviour after changing the names. I can see the result here - the co=
ntrols are in the right place now and they are doing what they were suppose=
d to.
> =

> What is the actual problem that is is being fixed here?

- microphone playback could not be unmuted before, that means that the hw m=
ixing path from mic in to spk out/line out could never work - fixed by this
- microphone volume was shown twice in "All" tab of Alsamixer, but running =
synchroniously, if you change one, the other will follow with the same valu=
e - fixed by this
- if microphone voulme was changed in capture tab, the volume also changed =
in playback tab - fixed by this
- microphone was never shown as active capture source, even if it was selec=
ted correctly, neither in capture tab nor in all-tab - fixed by this
- phone was shown as selected capture source in capture tab, but actually i=
t was not selected, instead it was muted/unmuted everytime one tries to sel=
ect it as capture source - fixed by this

> =

> > Signed-off-by: Marcus Weigelt <marcus.weigelt@fwd-online.de>
> > Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
> =

> Please remember to CC maintaintainers on patches.
> =

> > ---
> >  sound/soc/codecs/ad1980.c |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> > =

> > diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
> > index 35c0580..c1550b8 100644
> > --- a/sound/soc/codecs/ad1980.c
> > +++ b/sound/soc/codecs/ad1980.c
> >                     SOC_SINGLE("PCM Capture Switch", AC97_REC_GAIN, 15,=
 1, =

> > 1),
> >  SOC_SINGLE("Mono Playback Volume", AC97_MASTER_MONO, 0, 31, 1),
> >  SOC_SINGLE("Mono Playback Switch", AC97_MASTER_MONO, 15, 1, 1),
> >  =

> > -SOC_SINGLE("Phone Capture Volume", AC97_PHONE, 0, 31, 1),
> > -SOC_SINGLE("Phone Capture Switch", AC97_PHONE, 15, 1, 1),
> > +SOC_SINGLE("Phone Playback Volume", AC97_PHONE, 0, 31, 1),
> > +SOC_SINGLE("Phone Playback Switch", AC97_PHONE, 15, 1, 1),
> >  =

> > -SOC_SINGLE("Mic Volume", AC97_MIC, 0, 31, 1),
> > -SOC_SINGLE("Mic Switch", AC97_MIC, 15, 1, 1),
> > +SOC_SINGLE("Mic Playback Volume", AC97_MIC, 0, 31, 1),
> > +SOC_SINGLE("Mic Playback Switch", AC97_MIC, 15, 1, 1),
> >  =

> >  SOC_SINGLE("Stereo Mic Switch", AC97_AD_MISC, 6, 1, 0),
> >  SOC_DOUBLE("Line HP Swap Switch", AC97_AD_MISC, 10, 5, 1, 0),
> > -- =

> > 1.7.1
> > =

> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> =

> -- =

> "You grabbed my hand and we fell into it, like a daydream - or a fever."


To: broonie@opensource.wolfsonmicro.com
    u.kleine-koenig@pengutronix.de
Cc: alsa-devel@alsa-project.org
    sonic.zhang@analog.com
    lrg@slimlogic.co.uk
