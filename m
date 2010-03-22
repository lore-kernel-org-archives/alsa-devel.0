From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: PM fix for output amplifiers
Date: Mon, 22 Mar 2010 17:31:14 +0200
Message-ID: <201003221731.14380.peter.ujfalusi@nokia.com>
References: <1269264967-2003-1-git-send-email-peter.ujfalusi@nokia.com>
	<201003221646.08974.peter.ujfalusi@nokia.com>
	<20100322150602.GD1379@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id B81B8103822
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 16:31:33 +0100 (CET)
In-Reply-To: <20100322150602.GD1379@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Monday 22 March 2010 17:06:03 ext Mark Brown wrote:
> On Mon, Mar 22, 2010 at 04:46:08PM +0200, Peter Ujfalusi wrote:
> > On Monday 22 March 2010 16:15:44 ext Mark Brown wrote:
> > > I don't see any fundamental problem here - mostly this just maps on to
> > > "if the widget is powered on write this value, otherwise write the
> > > value configured by the control.".
> > =

> > Hmm, I suppose it could be possible to pass the name of the DAPM widget,
> > a bitmask to a control...
> > Than in the handler in the core we could walk through the DAPM widgets,
> > and find the one, check the status, and if it is on, we allow the write,
> > otherwise we could use the mask to write only the things, that it is
> > needed.
> =

> Something like that, yes - the walk could happen at startup time to
> avoid having to do it repeatedly.

Make sense.

> =

> > But, in TWL case I'd like to filter out also the writes which is done by
> > the DAPM widgets (which is visible from the user space, the mixers). As
> > it is now, if user changes the mixer, which is associated with DAPM
> > widget (and it is different than the PGA, they are DAPM_MIXER), than
> > that write goes directly to the register, and this write takes the
> > cached value, makes the changes and than writes it to register. This
> > also enables the gain (which enables the amp, which takes power).
> =

> Remember, the register cache is below the controls and transparent to
> them - if the controls haven't written a value to the chip then it will
> not appear in the register cache so other controls will not be affected.

Yes, but it also means, that the change will be not visible at all.
I mean, if we did not update the reg_cache (when we should not write to the=
 HW), =

than that change will be gone.
So you will only be able to change the gain on the output, when the path is =

active?

Also, I think, if we can somehow prevent the gain change on the HW, when th=
e =

associated DAPM widget is not active, we would still have the problem of th=
e =

DAPM_MIXER. That operates from the cache, and if the cache has no 0 for the =

gain, than that will be written to the chip.

How I see this: we can go and introduce new controls, DAPM widgets for all =
type =

just for the sake of the TWL codec. But at the end it will be still TWL =

specific.

I'm not saying that other codecs could not use some generic way (in a way, =
that =

you have described) to make their amps muted when they are not needed.
What I'm saying, is that I don't see a generic way which can handle the TWL =

codec.

> > > Well, I was rather hoping I could convince you to make this more
> > > generic.  But if that's not possible then yes, please do make the
> > > commit message clearer.
> > =

> > I need to study other codes as well, before I could start doing somethi=
ng
> > more generic, which I totally agree would be beneficial for others as
> > well. But for now, I would like to update the commit message, and come
> > back later, and revisit the possibility of similar, and more generic
> > ways of doing this.
> =

> I guess.

I hope that I can convince you, that - again - the TWL codec is so special,=
 it =

has to handled a bit differently.

-- =

P=E9ter
