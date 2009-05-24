From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V2 5/9] Main rewite of the mpc5200 audio
	DMA code
Date: Sun, 24 May 2009 16:10:52 -0400
Message-ID: <9e4733910905241310n59952fd2oaafd7f1363db324@mail.gmail.com>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231305.17919.12239.stgit@terra>
	<20090524185509.GA3561@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id AB9EC243BF
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 22:10:53 +0200 (CEST)
Received: by qyk1 with SMTP id 1so3852158qyk.16
	for <alsa-devel@alsa-project.org>; Sun, 24 May 2009 13:10:53 -0700 (PDT)
In-Reply-To: <20090524185509.GA3561@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Sun, May 24, 2009 at 2:55 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>> Rewrite the mpc5200 audio DMA code to support both I2S and AC97. Make it=
 more robust.
>
> Why is it more robust?

I've implemented retries for when the AC97 hardware doesn't reset on
first try. About 10% of the time both the Efika and pcm030 AC97 codecs
don't reset on first try and need to be poked multiple times.  Failure
is indicated by not having the link clock start ticking. Every once in
a while even five pokes won't get the link started and I have to power
cycle.

I don't have an oscilloscope, after I get these basic drivers in maybe
someone can put a scope on this and figure out why reset is failing.
I've read the various datasheets and I believe my reset pulses have
the correct timings.

>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | Wo=
lfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkoZmA0ACgkQD27XaX1/VRvugwCgsluxfp1rJH2MVFMTH6Yqo8bX
> dnIAn1z0QRIFEUJa0XpGFE937siwf8Cy
> =3DM0wP
> -----END PGP SIGNATURE-----
>
>



-- =

Jon Smirl
jonsmirl@gmail.com
