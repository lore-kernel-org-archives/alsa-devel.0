From: Glenn Maynard <g_sf@zewt.org>
Subject: Re: ALSA and select, poll, ... (interrupted system calls)
Date: Thu, 24 Jun 2004 04:12:07 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040624081207.GD25899@zewt.org>
References: <Pine.HPX.4.33n.0406181920390.9993-100000@studcom.urz.uni-halle.de> <E1Bci5z-0007D7-00@mailer.emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E1Bci5z-0007D7-00@mailer.emlix.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 22, 2004 at 12:01:38PM +0200, Nicolas H=FCppelsh=E4user wrote=
:
> > > By now I workaround with a mixture of nanosleep/"time polling" (tra=
cking
> > > elapsed system time in a loop).  Is there a better way?
> >
> > If you're waiting anyway, why don't you simply wait with poll?
>=20
> I need to wait a defined amount of time.
> And it doesn't make a differecne whether using poll or nanosleep since
> both get interrupted by alsa async signals.

What's wrong with nanosleep?  Its entire purpose is for sleeping across s=
ignals:

timespec ts =3D { 10, 0 }, rem;
while( nanosleep( &ts, &rem ) =3D=3D -1 && errno =3D=3D EINTR )
	ts =3D rem; // keep waiting

--=20
Glenn Maynard


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
