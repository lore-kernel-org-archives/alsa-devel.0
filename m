From: Peter Kirk <pwk.linuxfan@gmx.de>
Subject: Re: smart and automatic use of dmix and dsnoop - feature suggestion.
Date: Mon, 17 Nov 2003 21:28:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311172128.34259.pwk.linuxfan@gmx.de>
References: <200311171936.hAHJaW1B013634@oud.linuxaudiosystems.com> <Pine.LNX.4.53.0311172102250.16992@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0311172102250.16992@pnote.perex-int.cz>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net, Paul Davis <paul@linuxaudiosystems.com>
List-Id: alsa-devel@alsa-project.org

WARNING: Unsanitized content follows.
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Montag, 17. November 2003 21:05 schrieb Jaroslav Kysela:
> On Mon, 17 Nov 2003, Paul Davis wrote:
> > >what you say seems to be valid to me, but not if you implement smart
> > > dmix the way I said =3D). The way I suggested *every* application wou=
ld
> > > connect to smart dmix, and none directly to alsa lib (except those th=
at
> > > use devices like hw: - and those should never be mixed). Since every
> > > stream is connected to smart dmix, there is no need to *reroute*
> > > anything in the case of needed mixing. The only thing that has to
> > > happen, is that the new stream, that has to be mixed into the existing
> > > one due to hardware limitations has to be resampled etc. to make mixi=
ng
> > > possible.
> >
> > believe or not, i actually think that peter is right here. if dmix
> > works well enough to be used by any application, then i think it
> > should be used for all non-hw accesses unless the user configures it
> > otherwise. if it doesn't work this well, it should :)
>
> Ok, maybe we all talk about same thing. Sure, if the code is matured
> enough, we can use it as default. But I only want to note that dmix
> - even with one stream - won't be ever equal to the raw hardware access
> (hw:#,#).

Hum,

about the "maturity" of dmix - I cant realy comment on it. All I know is, t=
hat=20
it should be possible to do what I am suggesting eventualy. Since I am not =
a=20
coder I dont have any idea on the restrictions/limitations of the current=
=20
dmix implementation, and how hard it is to overcome them.
All I know is: Its possible, and you are the best guys on the job, so you c=
an=20
do it =3D). It would (in my opinion) be the biggest achievment in easiness =
to=20
setup soundcards since many years. And its worth some effort to make it wor=
k.
How dmix would handle a single stream - I dont know why it should be modifi=
ed=20
by dmix. But appart from that, the "smartdmix" would just pass through sing=
le=20
soundstreams, they wouldnt ever get near any dmixing...

Peter
- --=20
The Shuttle is now going five times the sound of speed.
		-- Dan Rather, first landing of Columbia
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/uS9cg2ieGvTmHiURAkiIAJ46SAlueVdrPsSyL594m+iiUitm5wCeN0SF
9gUG4BsY1zNnCPNaruOjLso=3D
=3DWzuy
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
