From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Thu, 24 May 2018 15:18:42 +0100
Message-ID: <20180524141842.GW4828@sirena.org.uk>
References: <20180522165842.233949-1-groeck@google.com>
 <s5hmuwqpjdd.wl-tiwai@suse.de>
 <20180523135609.GK4828@sirena.org.uk>
 <CABXOdTeCr-ExO9O3XAHK-DnNf5yLGO0TPkXgs60TB90jGNB2_Q@mail.gmail.com>
 <20180523155811.GO4828@sirena.org.uk>
 <CABXOdTePWquSQaFQsoNTrVNmYydZLqF534zeoTfz0RfLDHSseA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8290608594914876041=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 64FE8267345
 for <alsa-devel@alsa-project.org>; Thu, 24 May 2018 16:18:48 +0200 (CEST)
In-Reply-To: <CABXOdTePWquSQaFQsoNTrVNmYydZLqF534zeoTfz0RfLDHSseA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guenter Roeck <groeck@google.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Patel,
 Chintan M" <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============8290608594914876041==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ItroYk2LVxvwOvi/"
Content-Disposition: inline


--ItroYk2LVxvwOvi/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 23, 2018 at 09:17:23AM -0700, Guenter Roeck wrote:
> On Wed, May 23, 2018 at 8:58 AM Mark Brown <broonie@kernel.org> wrote:

> > I'm saying we should move them there.  They're clearly part of the
> > userspace ABI and therefore belong in uapi, it was a mistake to let them
> > be elsewhere.

> They define a firmware file format. Not sure if I would call that userspace
> ABI.

It's a binary provided by userspace to the kernel, I'd say that's
clearly an ABI.

> I don't mind adding the structures to
> sound/soc/intel/skylake/skl-tplg-interface.h,
> but it seems a bit out of scope to tie this with moving the file to
> include/uapi/sound.
> I think that should be a separate discussion.

Is there some reason not to just do it while we're looking at this?  I
don't see why we wouldn't want to do this.

--ItroYk2LVxvwOvi/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsGycEACgkQJNaLcl1U
h9AdLwf/QbknuFoYVCNkUSaND4yd83yRRB4Dk8wpC2M92DJnv1h1OoiUpHN6It9L
h4Tq5K9sK7QzJUiQZ8RN1upzl8YWg/Ar0M/op6APK+vXBliyf24bJBxa1aFXYIJ7
pUs4MAWX5eR3Xz5BbZXTjt4gX0E7/Ur6MWlUdfLjm44q40mGtRjKAySfquWOYZ4v
U1p5Jr3LV9sUZRH/vKGyjWlgd/5bAvxAtRRZfqdFU99bhLhl/NilEbPSMVDjh2Gv
vCMkJj7GvlFZ2hcuCUNt3hHGQ1jgMTF3Q6UyppfxoHLyeBX84abeWxrnu3QbXrpm
vZY4UZuXuU6yF4kWzwVkaZ7iUD9J4Q==
=ukzP
-----END PGP SIGNATURE-----

--ItroYk2LVxvwOvi/--

--===============8290608594914876041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8290608594914876041==--
