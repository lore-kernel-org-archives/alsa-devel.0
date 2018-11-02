From: Scott Bahling <sbahling@suse.com>
Subject: Re: Controlling the Tascam FW-1884
Date: Fri, 02 Nov 2018 10:26:06 +0100
Message-ID: <bd6c69dbb0cb7347f9023728a598e65f0b297323.camel@suse.com>
References: <9cec059e1ff1a558f21a3f0729c5a69a3d506573.camel@suse.com>
 <0e469670-0520-5953-230b-8d2da5e4c357@sakamocchi.jp>
 <985b1f6dc5b0af2aae049e0b6fcf976ab400d34d.camel@suse.com>
 <55afba82-ad24-fe70-b784-d28a38e291c9@sakamocchi.jp>
 <7a0f35eea26ce475bc3f6953db97f83205ad0a58.camel@suse.com>
 <fc278639-12da-02b8-685d-681e06b044e4@sakamocchi.jp>
 <10a99ea9c672ac6d0c9d5536e9d85a15f5a32d95.camel@suse.com>
 <47f66c7d-4337-52da-72da-cdb3f0638dc4@sakamocchi.jp>
 <d63527a1ab830c50c621664946ad9eafdb37d578.camel@suse.com>
 <f4537970-775e-6480-acc4-6b5dd050d597@sakamocchi.jp>
 <fed5ab3a-c39a-4de9-6802-c064a33140eb@sakamocchi.jp>
 <246b8baaa3c415a0accdb76d3b524dec5e0429f9.camel@suse.com>
 <97e54edf-1e47-d422-e438-a2c859083fd3@sakamocchi.jp>
 <58ef33b1fffec178217044e0f0d5f2b6aecfc31d.camel@suse.com>
 <4a971bd3716ddf43662b637904209f5230ccbf02.camel@suse.com>
 <daf2b08b-dfdf-b4a3-8820-0a5f3ab78fc4@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1708779319597906402=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 01F9E26751A
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2018 10:26:08 +0100 (CET)
In-Reply-To: <daf2b08b-dfdf-b4a3-8820-0a5f3ab78fc4@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org


--===============1708779319597906402==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-28bCAeuhZY5l+ja3L4i8"


--=-28bCAeuhZY5l+ja3L4i8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-10-30 at 18:34 +0900, Takashi Sakamoto wrote:
> Hi Scott,
>=20
> Sorry to be late for reply, but I was a bit busy with travel for
> Audio
> miniconference 2018 and tests for v4.20 merge window.
>=20
> On 2018/10/22 20:47, Scott Bahling wrote:
> > I have tried this, but the endianness of the status bits passed via
> > this
> > method seems to be wrong.
> >=20
> > I noticed in your latest kernel code[1], that you don't convert the
> > firewire
> > data to local CPU endian when storing in the "after" variable which
> > ends up
> > getting pushed into the status structure as big endian:
> >=20
> >=20
> >      after =3D buffer[s->data_block_quadlets - 1];
> > ...
> > ...
> > ...
> >      tscm->status[index] =3D after;
> >=20
> >=20
> > Shouldn't that be:
> >=20
> >      after =3D be32_to_cpu(buffer[s->data_block_quadlets - 1]);
> >=20
> > which also would remove the need for later conversions in that
> > block of
> > code?
> >=20
> > I have a tested patch which I will send as a pull request once
> > github is
> > functioning again.
>=20
> Ah, indeed. I completely overlooked it, sorry...
>=20
> At first place, I just focused on reduction of CPU usage in
> packet processing, then cache big-endianness values from packets.
> Queued events have converted host-endiannness value from the cache.
> On the other hand, data returned by
> SNDRV_FIREWIRE_IOCTL_TASCAM_STATUS
> ioctl is just copied from the cache, then it's still big-endiannness,
> as you found.
>=20
> Thanks for your PR[1] and it works well. But here I suggest that
> we can judge the frequency to call SNDRV_FIREWIRE_IOCTL_TASCAM_STATUS
> ioctl is surely less than the frequency on packet processing. If we
> attempt to keep low CPU usage in the packet processing, current
> implementation can be kept as is. Instead, a patch for handler of the
> ioctl is worth for commit.

Makes perfect sense.

> For example, This patch will fix the issue.
>=20
> ```
> $ git diff
> diff --git a/sound/firewire/tascam/tascam-hwdep.c=20
> b/sound/firewire/tascam/tascam-hwdep.c
> index ad164ad..dff7dc4 100644
> --- a/sound/firewire/tascam/tascam-hwdep.c
> +++ b/sound/firewire/tascam/tascam-hwdep.c
> @@ -189,10 +189,23 @@ static int hwdep_unlock(struct snd_tscm *tscm)
>=20
>   static int tscm_hwdep_status(struct snd_tscm *tscm, void __user
> *arg)
>   {
> -       if (copy_to_user(arg, tscm->status, sizeof(tscm->status)))
> -               return -EFAULT;
> +       struct snd_firewire_tascam_status *status;
> +       int i;
> +       int err =3D 0;
>=20
> -       return 0;
> +       status =3D kmalloc(sizeof(*status), GFP_KERNEL);
> +       if (!status)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < SNDRV_FIREWIRE_TASCAM_STATUS_COUNT; ++i)
> +               status->data[i] =3D be32_to_cpu(tscm->status[i]);
> +
> +       if (copy_to_user(arg, status, sizeof(*status)))
> +               err =3D -EFAULT;
> +
> +       kfree(status);
> +
> +       return err;
>   }
> ```
>=20
> I'd like you to test with this patch, before granting your PR.

I have tested and the patch above works as expected.

-Scott

--=-28bCAeuhZY5l+ja3L4i8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQjvzoZ9RLbHiUT/sAst8aI6UpxIFAlvcGC4ACgkQAst8aI6U
pxJ/OA/+NOpZbvvxDjBZIvdKbsugFHw4dQDgb0r0xzuKu6H33/rQR2Iq63J+90fV
JCoGp1jdxcPz2yKaYRYihxVRwusTjWcSlPsPmI7ugXsgzwGUDQsAWJLu58fSnUc8
gT9GTB2knI7hVVRnK+kJjC0cOkqKXraj9wCR+bSXsYEn+VBjHO6IHm7zR6RyFRqT
Xh02Y3QrUXB7hc7KgtJbrhyK2W253YEWESDgQfF+09ttJxlQz3/voKYGButzDgIO
lGA7CyR1bp+cHXqyoneu9Ek1QhIK/Y393jvx4Kp7CMt1AIRIZWXgls+nILv/4kI4
iaXMnLoXxacT3Z1GcM1CIHYGgmRFYjgvwgrKXOVNk6pZUK7EONPTzJx/IDh+4xFX
Ffp/+4t8tO+2YReFXX0xJlcR0raVfI48fN5b5Q3dj8HwE8K0+RdwdSlI5g67EdHl
VwhpJRV2egql+Ksyh+81eJr2fTwnf/Eq1/xOAjBrJOkhQscu6w+0qBBZmtjEzscw
VqYQF0zllv2sBef6WVeNmkdQ8etvF+vd7IllDWZLNLMbu3MKWR+H6ULtBxvAPKeW
UORN00lKUVgZPog7g59Elwki8YRtlGYdohBJBfK1wmfaKSbSNTWZAz6KuMRoG1xP
OxPQlseNYi6GRAhOa4SZFju7Ynor/IB7zBda1jNnc1WXug3aSYc=
=jRMf
-----END PGP SIGNATURE-----

--=-28bCAeuhZY5l+ja3L4i8--


--===============1708779319597906402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1708779319597906402==--
