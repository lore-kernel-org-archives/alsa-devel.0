From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: Intel: Add Haswell and Broadwell
 PCM platform driver
Date: Sun, 23 Feb 2014 12:19:58 +0900
Message-ID: <20140223031958.GX25940@sirena.org.uk>
References: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392932927-9725-3-git-send-email-liam.r.girdwood@linux.intel.com>
 <20140221051603.GC25940@sirena.org.uk>
 <s5htxbtvt2n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5091254992257269139=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 590CF261A18
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 04:20:12 +0100 (CET)
In-Reply-To: <s5htxbtvt2n.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5091254992257269139==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1MaLZ7+w12+PvFyj"
Content-Disposition: inline


--1MaLZ7+w12+PvFyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 21, 2014 at 08:11:12AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Interesting one here.  On the one hand we always say to present the
> > hardware features as directly as possible to the application layer.  On
> > the other hand I'd not be surprised if some userspaces failed to deal
> > constructively with a full 31 bits of linearly mapped volume control
> > (but I'm not sure how common they are and really they ought to be
> > fixed).  Anyway, not a problem more just a comment.

> A straightforward implementation would be just to expose this 31bit
> raw value and declare it as a linear dB via TLV.  The proper dB
> conversion is done in alsa-lib.

Yes, exactly.  This should work well with most userspaces, the only
thing that would worry me would be something basic that makes the user
manually step through thousands of tiny volume steps.  I don't think any
modern application layer should have an issue there though and I'm not
sure if I'd care about such application layers myself.

> BTW, you need no table for this volume value at all.  volume_map[] can
> be replaced like
> 	#define volume_map(i)	((1U << (i) - 1)

It does mean it's easier to update the chosen steps in future though.

> > > +	if (!pcm_data->stream) {
> > > +		pcm_data->volume[0] =
> > > +			hsw_mixer_to_ipc(ucontrol->value.integer.value[0]);
> > > +		pcm_data->volume[1] =
> > > +			hsw_mixer_to_ipc(ucontrol->value.integer.value[1]);
> > > +		mutex_unlock(&pcm_data->mutex);
> > > +		return 0;
> > > +	}

> > It looks like we only record the volume when the stream is idle.  What
> > happens if the user changes the volume while it's idle, starts playing,
> > changes again then stops playing?  It's possible I missed the bit where
> > it gets saved but I did look.

> This seems restored in hsw_pcm_open().

Yes, it's restored there - what concerned me was that the variables
didn't seem to be being updated while the stream was running, it only
wrote to the hardware so if the volume had subsequently been changed on
a running stream then the older value from a closed stream would be
written out.  It'd at least be more obviously correct to just update the
variables no matter what.

--1MaLZ7+w12+PvFyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWjbAAoJELSic+t+oim9JKoP/2u48/Y8e+8ub+0f3VB8aW4m
p8uv25h1+E+4/NDQ8Ti1eQXc6og4Ec1O5ASGgVWVvVLP9NNxbn8q2xXTRrWqyo6A
CfuKZaL+zGPUWmbn91N08NBmWrgc562kn2pzebWW9ZppDGDhDPk9fAIdOaLsFsaP
OLb3dKB3Cw5ZdObUaBOjf1QfJ6I5QHpRG2+oK85oZqzfCQcJUBuEY5OgbC7hkJ5g
zv25OcPmeuvuwve9X6cV2DmdLEY/MiakKZM6F0WDWSgqNcdtKMDTUkQRSRytXel7
r7MU+jXvGMo/B+obrs7eOPAX8q6JH5jtJov0HHzrxDst+KLkiElyR4RCq4ZDbzp7
8yh7wJAGHO4dYx0Km+cScH85+RsDcsxDJbN1XdcZofmncgHg/mqJZ7YTAV/2C8uD
566Xv/Y/mUH5e8nrYgX8hS7tEMTrhpVbjWaSKsrnwwZ6gx5AbiEHKtrFR2veCAN7
P2VVPdaOG2hbzKWcq7vF1bO7Nx/K31Piopq2/n6G85Yub8NoNNQHnpPnv178Z1pk
DqbdGM8X7HftK0+ngbUFFTLPbnqEXTpuMbv1JZrBkn8Kup3ucTxBtWaZrrN9sAGq
IFIrfVlP0GJ09vGWOV32Da/08EuOmcDnkXOMkJLJDpjLGYHjScSMCT9z1Tv2Uydy
dGfoq+XeHLO6JXoJALjj
=/fSj
-----END PGP SIGNATURE-----

--1MaLZ7+w12+PvFyj--

--===============5091254992257269139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5091254992257269139==--
