From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97
	driver
Date: Wed, 1 Jul 2009 09:32:46 -0400
Message-ID: <9e4733910907010632g10706084o66720d4616e40865@mail.gmail.com>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
	<20090630061847.GA24164@pengutronix.de>
	<9e4733910906300642o4f1c0e2cn45423c426e3aff7e@mail.gmail.com>
	<20090701085633.GB3144@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f189.google.com (mail-vw0-f189.google.com
	[209.85.212.189])
	by alsa0.perex.cz (Postfix) with ESMTP id C51482433A
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jul 2009 15:32:47 +0200 (CEST)
Received: by vwj27 with SMTP id 27so368929vwj.16
	for <alsa-devel@alsa-project.org>; Wed, 01 Jul 2009 06:32:46 -0700 (PDT)
In-Reply-To: <20090701085633.GB3144@pengutronix.de>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 1, 2009 at 4:56 AM, Wolfram Sang<w.sang@pengutronix.de> wrote:
> Hi Jon,
>
>> Wolfram, do you have any way to test the on the Phytec hardware? The
>> WM9712 on the baseboard supports a touchscreen, is it brought out to a
>> header?
>
> Sorry, I didn't get it: Shall I test something specific?

I don't own a touchscreen.

AFAIK no one has ever plugged a touchscreen into the PCM-973 to see if
works since there hasn't been a driver previously. Just do a general
test so that you can tell customers that it works.

>
> The touchscreen connector is X19 BTW (assuming a PCM-973 baseboard).
>
> Regards,
>
> =A0 Wolfram
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
> iEYEARECAAYFAkpLJMEACgkQD27XaX1/VRs/cwCgn7p7ffxr8WGoW7MwALkBMKtD
> VtYAoIa5/viinyvFF5cQP3BvH9WP3a5I
> =3DZrq3
> -----END PGP SIGNATURE-----
>
>



-- =

Jon Smirl
jonsmirl@gmail.com
