From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: fix headphone click/crack
 noise on Dell XPS 9343 I2S mode
Date: Mon, 13 Mar 2017 13:30:52 +0000
Message-ID: <20170313133052.vjw6vkrfbxvpdupa@sirena.org.uk>
References: <20170123053514.6193-1-kai.heng.feng@canonical.com>
 <20170216192230.mg6htsgqbu756e6y@sirena.org.uk>
 <CAAd53p5LgLDfRbhHvwzN6KKhsqW+yHU-bKnyXKdciCXsu0Vq2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0761965232427678357=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C0B17266BDA
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 14:31:03 +0100 (CET)
In-Reply-To: <CAAd53p5LgLDfRbhHvwzN6KKhsqW+yHU-bKnyXKdciCXsu0Vq2Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0761965232427678357==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fz63bvi32ftu4oej"
Content-Disposition: inline


--fz63bvi32ftu4oej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 13, 2017 at 08:41:41AM +0000, Kai-Heng Feng wrote:
> On Fri, Feb 17, 2017 at 3:22 AM Mark Brown <broonie@kernel.org> wrote:

> > On Mon, Jan 23, 2017 at 01:35:14PM +0800, Kai-Heng Feng wrote:

> > > +static void dell_dino_mute_hpo(struct snd_soc_codec *codec)
> > > +{
> > > +     snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO, AMP_OUT_MUTE);
> > > +}
> > > +

> > How does this ever get unmuted, should it be an _AUTODISABLE control
> > instead?

> I think the AMP is overrode by another value when playing sound, but I am
> not sure.

That's bad, we shouldn't have multiple inconsistent ways of controlling
the same thing - this tends to lead to bugs as they need to be
coordinated and things might change in one or both mechanisms.

> Can there be multiple callbacks hooked to the same widget?
> In this case, in addition to hpol_enable_control(), can I register another
> callback to "HPO L"?

You can have a callback that calls other callbacks to share code, you
can't do this directly in the framework itself.

--fz63bvi32ftu4oej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljGnwwACgkQJNaLcl1U
h9AxSQf9HKJLnxMjoRT85BPqQH9fuYrMa20EZE7+IfREL5mXOYHHMvDQHg0JZRCP
Kl0RdnG+3wWBU/yL3+JwSEvvDtEM7gbxwKpD1R/q8RVRXnobWnPyOVocdDchF4B5
oM7+D+Q/zdSqQW1dtBeE4v7tEqMw0P0v1dwVykGJd9kXKvg1Cl+gI4ARBap7Aw2c
QXUEFdyoZel4J4B/sUaMEwJrBGtKiS21qacRuBFA4XIDQ1hm1MNJzi3/RB1zf44m
3J4ymJEux3q40y0etmI+wyN8p9brJb1efO+HFqwQ92c7xpF7VKHN91W+HJSH22bQ
fxu7cONTHxr5tDm4i8VFEaGj8kor+A==
=awgR
-----END PGP SIGNATURE-----

--fz63bvi32ftu4oej--

--===============0761965232427678357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0761965232427678357==--
