From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: softvol plugin [Fwd: Re: [Alsa-devel] [PATCH V0.1]
 C-Media	CMI9761A ]
Date: Sun, 20 Feb 2005 22:15:50 +0000
Message-ID: <1108937751.21538.3.camel@bastov>
References: <1108782279.23185.38.camel@bastov>  <4216B586.70602@gmx.de>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4216B586.70602@gmx.de>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: t.schorpp@gmx.de
Cc: Jakob Schurdak <jakobs@myrealbox.com>, alsa-user@lists.sourceforge.net, alsa-devel@sc8-sf-spam2.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello=20
the patch give a compile error see above :

thanks,=20

On Sat, 2005-02-19 at 04:41 +0100, thomas schorpp wrote:=20
> uh-oh :)

> THEN update to head and apply both patches attached further below from=20
> takashi and report (especially if you get pcm sound after unmute of "ie=
c=20
> capture" switch.)

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.c,v
> retrieving revision 1.72
> retrieving revision 1.73
> diff -u -r1.72 -r1.73
> --- ac97_patch.c	11 Feb 2005 09:56:09 -0000	1.72
> +++ ac97_patch.c	16 Feb 2005 16:21:04 -0000	1.73
> @@ -2094,6 +2094,34 @@
>   	return 0;
>   }
>=20
> +/* CM9761-A is incompatible with CM9761 */
> +int patch_cm9761a(ac97_t *ac97)
> +{
> +	unsigned short val;
> +
> +	ac97->build_ops =3D &patch_cm9761_ops;

patch_cm9761_ops is not defined in any place , compiler give an error
undeclare and use for the first time ....


--=20
S=E9rgio M.B.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
