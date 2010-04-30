From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 4/4] ASoC: tlv320dac33: Support for turning
	off the codec in BIAS_STANDBY
Date: Fri, 30 Apr 2010 13:55:25 +0300
Message-ID: <201004301355.25797.peter.ujfalusi@nokia.com>
References: <1272612715-13387-1-git-send-email-peter.ujfalusi@nokia.com>
	<201004301310.14378.peter.ujfalusi@nokia.com>
	<20100430102309.GD21607@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F116103910
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 12:56:04 +0200 (CEST)
In-Reply-To: <20100430102309.GD21607@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Friday 30 April 2010 13:23:10 ext Mark Brown wrote:
> On Fri, Apr 30, 2010 at 01:10:14PM +0300, Peter Ujfalusi wrote:
> > On Friday 30 April 2010 12:56:37 ext Mark Brown wrote:
> > > Then just use
> > > the hooks in the normal audio stream bringup/teardown surely?  It's
> > > possible that I'm missing something as a result of your list of use
> > > cases but I'd expect this to flow fairly naturally from the normal ca=
ll
> > > flow.
> > =

> > The thing is, that I want to handle the chip power in one place, and
> > dac33_set_bias_level is a really good place for that.
> =

> Sure, but it shouldn't need to be worrying about playback at all.

Valid point ;)

> =

> > At the time when pcm_prepare is called the codec is still in OFF.
> > So I just postponed the dac33_prepare_chip call for later, when the cod=
ec
> > switches BIAS level.
> > Than I enable the power and if there is a stream, than I do the
> > preparation. Note: the BIAS level change is still within the pcm_prepare
> > call chain...
> =

> Surely a much more straightforward solution to this is just to add a
> post-DAPM prepare() callback to the DAI ops?  It seems like a perfectly
> reasonable thing to have that callback and it means you can rely on the
> existing mechanisms having taken care of the power for you.

Hmm, right... Well.
This is not going to work, I think.
I need to keep the dac33_pcm_prepare level of configuration for cases, when=
 the =

codec is in ON and a playback is starting (and if the codec is not ON, than =

respond it for later, when it is switch on), right?
I _need_ to do the things, which is done in the dac33_prepare_chip function =

every time, when a stream is starting :(

Now, if I use DAPM_SUPPLY attached to the DAC:
If the codec has been brought up because the loopback is enabled, than the
dac33_prepare_chip will be called twice: once from dac33_pcm_prepare, and t=
hen =

from the SUPPLY event.
This might be also the case if I use the post-DAPM prepare (or pre)

I do agree, that it is not really nice to have playback related thing in th=
e =

dac33_set_bias_level, but so far I think that is the only way to avoid =

additional hassle (which means more places to have error, problems).

> =

> > In this way I don't need to do any additional housekeeping while managi=
ng
> > the power of the codec.
> =

> My point here is that it seems like you need to do more housekeeping
> than you should :)

HeHe :)
My problem with that, is the additional house keeping needs more code, whic=
h =

usually means more place, where some corner case is not handled correctly.
Well, more code =3D=3D more place for bugs ;)

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- =

P=E9ter
