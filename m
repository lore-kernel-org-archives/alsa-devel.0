From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: [Openvortex-dev] Re: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Wed, 8 Jun 2005 15:29:50 +0200
Message-ID: <200506081529.53532.alien999999999@users.sourceforge.net>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org> <200506081313.48981.alien999999999@users.sourceforge.net> <s5h4qc9kpyl.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1359121.th7pfgTYAU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qc9kpyl.wl@alsa2.suse.de>
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
Cc: Igor Kovalenko <garrison@mail.ru>, openvortex-dev@nongnu.org, Raymond <rayau@netvigator.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--nextPart1359121.th7pfgTYAU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Op woensdag 8 juni 2005 14:12, schreef Takashi Iwai:
> At Wed, 8 Jun 2005 13:13:46 +0200,
>
> Alien wrote:
> > > You don't need to define values if the static array is initialize to
> > > zero.  In this case,
> > >
> > > 	static u16 eq_levels[64];
> > >
> > > would be better.
> > >
> > >
> > > Takashi
> >
> > you sure that this will initialize to 0 ? i seem to remember that C
> > doesn't init arrays to 0... unless there's a memset somewhere, of course,
> > i never wrote kernel stuff...
>
> It's sure.  Remeber that I mentioned "static" arrray.
>
>
> Takashi

hmm, i never knew static arrays were initialized to 0...

--nextPart1359121.th7pfgTYAU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCpvLRuBWKXETrtdcRAhMkAJ0YEyonC1ZlSe7oRONvZnnOpYr+ewCdErve
NrYn0RbqkE+nCoFwg4vsdmQ=
=2K8v
-----END PGP SIGNATURE-----

--nextPart1359121.th7pfgTYAU--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
