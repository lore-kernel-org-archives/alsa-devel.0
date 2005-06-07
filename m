From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Tue, 7 Jun 2005 17:16:02 +0200
Message-ID: <200506071716.05194.alien999999999@users.sourceforge.net>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org> <s5h8y1n7af3.wl@alsa2.suse.de> <42A5B7D4.50201@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1434067.ulGS3fvDm2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42A5B7D4.50201@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Raymond <rayau@netvigator.com>, openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

--nextPart1434067.ulGS3fvDm2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op dinsdag 7 juni 2005 17:05, schreef Raymond:
> The patch (diff11.diff) cause segmenation fault on my 32bit machine
> during /etc/init.d/alsasound start
>
> http://savannah.nongnu.org/patch/?func=3Ddetailitem&item_id=3D3948
>
> Do anyone know why readl() and writel() behave different in i386
> (32bits) and AMD64 (64bits) ?
>
> http://sourceforge.net/mailarchive/message.php?msg_id=3D10773530
>
>
> #ifndef CONFIG_X86_64
>
> #define        hwread(x,y) readl((x)+((y)>>2))
> #define        hwwrite(x,y,z) writel((z),(x)+((y)>>2))
>
> #else
>
> #define        hwread(x,y) readl((x)+(y))
> #define        hwwrite(x,y,z) writel((z),(x)+(y))
>
> #endif

that doesn't look good, unless the mmio is void* in 32bit and unsigned long=
*=20
in x86_64...

'unsigned long* mmio' should be preferred and together with '#define       =
=20
hwread(x,y) readl((x)+(y))' , this works for both platforms

> Takashi Iwai wrote:
> > At Mon, 06 Jun 2005 10:09:26 +0800,
> >
> > Raymond wrote:
> >>The au88x0 driver need patch to run on 64-bits platform.
> >>
> >>http://savannah.nongnu.org/patch/?func=3Ddetailitem&item_id=3D3948
> >
> > Could you feed the patch to alsa-devel ML for review?
> > (The addition of Signed-off-by would be preferred, too)
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you
> shotput a projector? How fast can you ride your desk chair down the office
> luge track? If you want to score the big prize, get to know the little gu=
y.
> Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=3D20
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--nextPart1434067.ulGS3fvDm2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCpbo1uBWKXETrtdcRAlOpAJsGzHN51iln1TMxmtoFKXEdGaEwZwCZAV5Q
pJ50eOExgcIY1sNUbbpmvhQ=
=6n8r
-----END PGP SIGNATURE-----

--nextPart1434067.ulGS3fvDm2--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
