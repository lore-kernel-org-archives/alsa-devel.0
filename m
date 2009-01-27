From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 6/6] ASoC: TWL4030: Add analog loopback
	support
Date: Tue, 27 Jan 2009 15:05:34 +0200
Message-ID: <200901271505.34354.peter.ujfalusi@nokia.com>
References: <1233048584-29662-1-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-7-git-send-email-peter.ujfalusi@nokia.com>
	<20090127113737.GA1794@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 9047F1037F2
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 14:05:41 +0100 (CET)
In-Reply-To: <20090127113737.GA1794@sirena.org.uk>
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
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Tuesday 27 January 2009 13:37:38 ext Mark Brown wrote:
> On Tue, Jan 27, 2009 at 11:29:44AM +0200, Peter Ujfalusi wrote:
> > It seams that the analog loopback needs the DAC powered on on the
> > channel, where the loopback is selected. The switch for the DACs has be=
en
> > moved from
>
> Oh, well...

Yes, it took a while to figure out what is wrong...

>
> > After the loopback registers are changed, the event callback will update
> > the bypass bitfield, so we will know if any of the bypass paths are
> > enabled. If the codec is in STANDBY mode, the decision is made to
> > keep/switch the codec off or keep/switch the codec on to allow the
> > bypass.
> > Also after the codec switches from ON to STANDBY the same check will be
> > done.
>
> The original implementation was done that way due to the lack of DAPM -
> it did *all* power management in the bias configuration.  Now that you
> have DAPM support it should be possible for the driver to function more
> normally and avoid these checks.  What most drivers do is bring all the
> chip wide power up when coming into standby then power on the rest under
> DAPM.

Well, I had the implementation like that. There were few 'issues' which =

resulted the current code - and that code is long gone :(.
So the codec was powered at all time, except, if it would recieve the =

SND_SOC_BIAS_OFF event.
To put things into context, let's say that the power consumption of the boa=
rd =

when the codec turned off is 0 A.
When the bypass was enabled (to external speaker) it jumped to 0.016 A, whi=
ch =

is fine, since an external amp is powered also.
Than if the bypass got disabled it jumped back to 0.01 A. After a bit of =

debugging I found the reason:
We have outputs with dedicated gain controls (PreDriveL/R, HeadsetL/R, =

CarkitL/R, Earpiece), they have to be put to power-down mode (gain bits to =

0). We do have volume controls for these, they are not in DAPM, but they ca=
n =

be modified. But now the problem is that something has to track the bypass =

states in userspace:
if the bypass disabled, than has to mute all outputs, when enabled, it has =
to =

remember, what was the original gain for the outputs. So it's going to be a =

mess.
Still after powering these down I have 0.006 A...
Than I found another thing: PLL power. Swtiching it off APPL_CTL:APPL_EN bi=
t =

resulted with 0.002 A. Now it is close enough.
But than I played a bit with the registers, enabled the bypass (while the P=
LL =

was off) and the readings were: 0.020 A, in short:
bypass on  + PLL on  =3D 0.016 A
bypass on  + PLL off =3D 0.020 A
bypass off + PLL on  =3D 0.006 A
bypass off + PLL off =3D 0.002 A

Grrr, and I gave up. Oh, and we don't have control for the PLL (it is enabl=
ed =

all the time at the moment). I was thinking to use the SND_SOC_DAPM_PRE and =

SND_SOC_DAPM_POST for it but I don't know how to use those.

So I thought that I will write it in a way I have sent it and revisit later=
, =

when I (or someone else) have better idea to handle this.

Sorry for the long and most probably boring details...

>
> Support for turning the codec completely off should really be provided
> by the core as an optional thing that can be done when the subsystem has
> been idle for a while using the regular bias level stuff like the
> existing delay before falling back to standby.  It needs to be optional
> since won't be appropriate for all applications since bringing the bias
> levels up cleanly may take too long for some systems.
>
> A few more specific issues in the rest of the code below.  I've also got
> a patch I'm going to push to Takashi later today which conflicts with
> this one, see the for-2.6.30 branch of:
>
> 	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

I can wait till it gets there and send the series on top of it.

>
> >  static void twl4030_codec_enable(struct snd_soc_codec *codec, int
> > enable) {
> > +       struct twl4030_priv *twl4030 =3D
> > +               (struct twl4030_priv *)codec->private_data;
>
> Casts away from void aren't needed, there's quite a few of those here
> and in the rest of the patch code.  Please fix these - they're usually a
> sign that something is wrong if they're needed.
>
> >         codec =3D kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
> >         if (codec =3D=3D NULL)
> >                 return -ENOMEM;
> >
> > +       twl4030 =3D kzalloc(sizeof(struct twl4030_priv), GFP_KERNEL);
> > +       if (twl4030 =3D=3D NULL) {
>
> Not essential but you could collapse these into a single allocation.

I'll fix these.

Thanks,
P=E9ter
