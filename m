From: Florian Schlichting <Florian.Schlichting@gmx.de>
Subject: Re: debugging nm256: some results, many questions
Date: Mon, 13 Mar 2006 22:55:34 +0800
Message-ID: <20060313145534.GA7995@tigerbay>
References: <20060223185253.GA7954@tigerbay> <s5hfym8vd0k.wl%tiwai@suse.de> <20060311174421.GB7775@tigerbay> <20060313064627.GA3864@tigerbay> <s5h4q22mu89.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h4q22mu89.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2006 at 12:58:46PM +0100, Takashi Iwai wrote:
>=20
> The writes in snd_nm256_ac97_reset() break the PM resume.  You should
> check reg_accessed[] and use the cached value if already written.

Yes, I just noticed the broken PM resume... The following is just to
check that I don't misunderstand things:

I originally wanted to write the initial values in snd_nm256_mixer(),
but there ac97 is still an ac97_template_t and doesn't have a register
cache. Still, reg_accessed[] is set there, meaning "register may be
touched". Consequently, in snd_nm256_ac97_reset() all usable
reg_accessed[] are already set, which the first time means nothing (and
all registers should be written), but during a resume means the value
shouldn't be touched... So there needs to be another way to distinguish
between these two states.

(I couldn't find any documentation about reg_accessed[], which to me
seems to indicate both "register can be accessed" and later "register
value is cached" - which really are two different things and I wonder
whether they should be kept apart?)

Assuming that when first initialized, all cache registers are set to
0x0000, which is also a valid volume setting, I could probably test for
a non-zero value in AC97_VENDOR_ID1, which would mean I've already done
the initial writing to the cache and it's a resume; otherwise all
registers are to be written.

> Additionally, we may use a static resolution table to skip the volume
> resolution detection with the latest ac97_codec.

I couldn't find any indication of that in 1.0.11rc3. Can you give me a
hint?

Florian

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEFYfm/R0+cAphf/kRAthYAJ40MZF1H+6d5DiSUOLBNXYV3fKzXQCfcEbu
3hFYV29BEv02LMw+q/LO8WE=
=9d6w
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
