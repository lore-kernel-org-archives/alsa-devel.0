From: Baptiste Jonglez <baptiste@bitsofnetworks.org>
Subject: Re: Assertion failure in alsa-lib crashing
 applications (snd_pcm_area_copy: Assertion `dst < src || dst >= src +
 bytes' failed)
Date: Fri, 1 Jul 2016 12:19:08 +0200
Message-ID: <20160701101908.GC28109@lud.polynome.dn42>
References: <20160607172935.GC25444@lud.polynome.dn42>
 <20160614210221.GB5107@lud.polynome.dn42>
 <20160614223939.GB3039@lud.polynome.dn42>
 <20160626182832.GA29321@lud.polynome.dn42>
 <s5hfurwdsh2.wl-tiwai@suse.de>
 <20160629135959.GA2159@lud.polynome.dn42>
 <s5h8txodqsc.wl-tiwai@suse.de> <s5h1t3gdlu5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8546477547466544231=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mails.bitsofnetworks.org (rezine.polyno.me [193.33.56.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 41E3A2614A7
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2016 12:19:12 +0200 (CEST)
In-Reply-To: <s5h1t3gdlu5.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8546477547466544231==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2016 at 06:02:58PM +0200, Takashi Iwai wrote:
> Now I reread the code again, and I guess it's really the racy
> accesses.  Basically you can't call alsa-lib functions concurrently.
> For example, calling snd_pcm_avail_update() from multiple threads
> concurrently may lead to such an error.  Internally it copies /
> converts the content (e.g. for softvol plugin), and this would
> conflict when called in parallel.
>=20
> You can try a hackish patch below to see whether it emits any
> messages.  It has no mutex, so the code itself is racy, but it should
> be enough just as a check.
>=20
> Meanwhile, the crash itself might be avoided by disabling
> "pcm->mmap_shadow =3D 1" line in pcm_softvol.c.  Then it'll be copied to
> the external buffer.

Thank you Takashi, I will give it a try!

Baptiste

> ---
> diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
> index 8527783c3569..571defad6e12 100644
> --- a/src/pcm/pcm_plugin.c
> +++ b/src/pcm/pcm_plugin.c
> @@ -483,17 +483,25 @@ snd_pcm_plugin_mmap_commit(snd_pcm_t *pcm,
> =20
>  static snd_pcm_sframes_t snd_pcm_plugin_avail_update(snd_pcm_t *pcm)
>  {
> +	static snd_pcm_t *check =3D NULL;
>  	snd_pcm_plugin_t *plugin =3D pcm->private_data;
>  	snd_pcm_t *slave =3D plugin->gen.slave;
>  	snd_pcm_sframes_t slave_size;
>  	int err;
> =20
> +	if (!check)
> +		check =3D pcm;
> +	else if (pcm =3D=3D check)
> +		fprintf(stderr, "XXX RACY CALL\n");
> +
>  	slave_size =3D snd_pcm_avail_update(slave);
>  	if (pcm->stream =3D=3D SND_PCM_STREAM_CAPTURE &&
>  	    pcm->access !=3D SND_PCM_ACCESS_RW_INTERLEAVED &&
>  	    pcm->access !=3D SND_PCM_ACCESS_RW_NONINTERLEAVED)
>  		goto _capture;
>          *pcm->hw.ptr =3D *slave->hw.ptr;
> +	if (pcm =3D=3D check)
> +		check =3D NULL;
>          return slave_size;
>   _capture:
>   	{
> @@ -545,11 +553,15 @@ static snd_pcm_sframes_t snd_pcm_plugin_avail_updat=
e(snd_pcm_t *pcm)
>  			slave_size -=3D slave_frames;
>  			xfer +=3D frames;
>  		}
> +		if (pcm =3D=3D check)
> +			check =3D NULL;
>  		return (snd_pcm_sframes_t)xfer;
> =20
>  	error_atomic:
>  		snd_atomic_write_end(&plugin->watom);
>  	error:
> +		if (pcm =3D=3D check)
> +			check =3D NULL;
>  		return xfer > 0 ? (snd_pcm_sframes_t)xfer : err;
>  	}
>  }

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXdkOcAAoJEL4B7CKgTi5GaBUQAIp0U0TSI8HRESqJdoS7Gq9K
1Udo6d7Z+GSySMYZGqeawoRuTCgCZrBhwpgjCcfemUfUT9fMyQE6U44RoGQZePkT
Hj7VfxhOqgq+TV+pODA8jmQbWA0lc/CMowxjtwpSZ8nfNgWT6IoxOoVRIu7WUEeG
lDJ8aFYAlxq7G7QT1fwN4A2ZW1h1HmOOUo5bTyvSbc70kWoClHMVwHlD1YiV2+fw
71j0NdYNga8fLFNxBBKCvgL89m7DeBBi7GtSpewpbAqGjrMA3nbDspzx0KHLIQ/A
h68oQsp+PHVJA3kxLnJv5KC/868FEPd0vK/52QNlZ/i9bVpsetTKBQ3edS51Ba+u
/x3peld4xGBoLvtAugM3hEQAbHouaehe4KwgkdGMLr/Ag5vxSfGwngUQYDBbmcTV
1cC7cYHrZS4t1nNM/VU2jExBUB/AxoY0j+3jXdOtGWtkp7g8n/tgpH7uUDoz+D2M
OUw6r6xrD3FQZLnvdKOlxuloSlChFJSerB+4EhsF3htCZ2qtKwp3Fiqno4JZA5B+
rlX0NUj7V05gVL848ZQu2oO2KW7yxxiD9WDl2gYJ9BUWGzVzUEwD/6SkEEmxn2Mj
qEJgf0essxpER2Oc0Y1y2RdhZooL1dbpjwPDzgIelYR7w5QlaJNgyzq+H5gntVgi
+ZLt3Kp2T8+xNmHel1/U
=9gl8
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--

--===============8546477547466544231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8546477547466544231==--
