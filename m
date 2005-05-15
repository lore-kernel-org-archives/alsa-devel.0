From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Re: alsa-lib patches
Date: Sun, 15 May 2005 21:21:02 +0400
Message-ID: <20050515172102.GA13135@procyon.home>
References: <4VSQHX111E5W3.1736062366PHUYD5@kevquinn.com> <42878740.30103@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <42878740.30103@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: "Kevin F.Quinn" <co@kevquinn.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 15, 2005 at 06:30:40PM +0100, James Courtier-Dutton wrote:
> What is wrong with the current CVS code?:
>=20
> typedef int (*qsort_func)(const void *, const void *);
> static int snd_mixer_sort(snd_mixer_t *mixer)
> {
>         unsigned int k;
>         assert(mixer);
>         assert(mixer->compare);
>         INIT_LIST_HEAD(&mixer->elems);
>         qsort(mixer->pelems, mixer->count, sizeof(snd_mixer_elem_t*),
> (qsort_func)mixer->compare);
>         for (k =3D 0; k < mixer->count; k++)
>                 list_add_tail(&mixer->pelems[k]->list, &mixer->elems);
>         return 0;
> }
>=20
> We are not executing any code on the stack. This should not effect the
> NX bit so what I the problem here?

The problem was cited above:

> >>So the actual problem is that qsort() calls us with a pointer to a
> >>pointer to the mixer_elem_t, but the compare function takes a single
> >>pointer.

mixer->pelems is an array of pointers to snd_mixer_elem_t, and qsort()
passes pointers to array elements as arguments to the compare
function - which becomes (snd_mixer_elem_t **).  But mixer->compare
expects to get (snd_mixer_elem_t *) as arguments.

However, seems that mixer elements have an indirect pointer to the
mixer they belong to - elem->class->mixer.  So, how about this:

static int snd_mixer_qsort_compare(const void *a, const void *b)
{
	snd_mixer_elem_t *elem_a =3D *(snd_mixer_elem_t **)a;
	snd_mixer_elem_t *elem_b =3D *(snd_mixer_elem_t **)b;

	return elem_a->class->mixer->compare(elem_a, elem_b);
}

static int snd_mixer_sort(snd_mixer_t *mixer)
{
	unsigned int k;
	assert(mixer);
	assert(mixer->compare);
	INIT_LIST_HEAD(&mixer->elems);
	qsort(mixer->pelems, mixer->count, sizeof(snd_mixer_elem_t*), snd_mixer_qs=
ort_compare);
	for (k =3D 0; k < mixer->count; k++)
		list_add_tail(&mixer->pelems[k]->list, &mixer->elems);
	return 0;
}

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCh4T+W82GfkQfsqIRAofCAJ9wOtUsOpdCV+vUeuujDcMGPWTpcQCfS/e8
6F1pyHj8gLRAbTVX91+KH8I=
=ois1
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
