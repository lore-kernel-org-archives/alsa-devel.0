From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Re: alsa-lib patches
Date: Mon, 16 May 2005 12:53:29 +0400
Message-ID: <20050516085329.GA15479@master.mivlgu.local>
References: <20050515172102.GA13135@procyon.home> <MDKETX111E5W3.417177801CEUALA@kevquinn.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <MDKETX111E5W3.417177801CEUALA@kevquinn.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Kevin F. Quinn" <co@kevquinn.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 15, 2005 at 10:24:03PM +0200, Kevin F. Quinn wrote:
> On 15/5/2005 19:21:02, Sergey Vlasov (vsu@altlinux.ru) wrote:
[skip]
> > static int snd_mixer_qsort_compare(const void *a, const void *b)
> > {
> > 	snd_mixer_elem_t *elem_a =3D *(snd_mixer_elem_t **)a;
> > 	snd_mixer_elem_t *elem_b =3D *(snd_mixer_elem_t **)b;
> >
> > 	return elem_a->class->mixer->compare(elem_a, elem_b);
> > }
> >
> > static int snd_mixer_sort(snd_mixer_t *mixer)
> > {
> > 	unsigned int k;
> > 	assert(mixer);
> > 	assert(mixer->compare);
> > 	INIT_LIST_HEAD(&mixer->elems);
> > 	qsort(mixer->pelems, mixer->count, sizeof(snd_mixer_elem_t*),
> > snd_mixer_qsort_compare);
> > 	for (k =3D 0; k < mixer->count; k++)
> > 		list_add_tail(&mixer->pelems[k]->list, &mixer->elems);
> > 	return 0;
> > }
>=20
> You also need to make it thread-safe, as Clements mentioned; the PaX
> team's proposal at https://bugs.gentoo.org/attachment.cgi?id=3D58918 does
> that as well:

It does that only because it uses a static variable:

> +static snd_mixer_t *compare_mixer;
> +static int mixer_compare(const void *a, const void *b) {
> +	return compare_mixer->compare(*(const snd_mixer_elem_t * const *) a,
> +				      *(const snd_mixer_elem_t * const *) b);
> +}

Because compare_mixer in this implementation is shared between all
threads, locking is required to make sure that different threads do not
attemt to use this variable at the same time.  My code does not use static
variables and therefore does not need such locking.

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCiF+JW82GfkQfsqIRAlaYAJ428WTLLldI4OFgtZEer2j9paDEyACfVxUG
kenaZjZxb1UThqhFaDXN2Ok=
=c1eo
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
