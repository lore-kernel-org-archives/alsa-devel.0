From: Laurielle LEA <lauriellelea@yahoo.fr>
Subject: RE: Sound with metal effect
Date: Fri, 1 Apr 2005 17:17:42 +0200 (CEST)
Message-ID: <20050401151743.70754.qmail@web25110.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: 6667
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander@users.sourceforge.net
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In fact, in my read function,=20

count =3D 320;
rc =3D snd_pcm_readi(audio_hdl, (short*)ptr, count);
I have to have rc =3D 320 but I receive just 160.

You tell me about other algorithms but I don't
understand everything. Maybe I have to add other init
hardware parameters ?

--- Manuel Jander <manuel.jander@usm.cl> wrote:
> Hi,
>=20
> On Fri, 2005-04-01 at 09:39 +0200, Giuliano Pochini
> wrote:
> > On 31-Mar-2005 Laurielle LEA wrote:
> >=20
> > > I'm integrating ALSA to my voipclient
> (softphone) and
> > > my problem is the sound received by the remote
> user is
> > > with metal effect.
> >=20
> > VoIP uses 8KHz sampling rate IIRC. What did you
> expect ?
>=20
> Metal effect indicates bad antialiasing filters.
> That may be caused by
> bad hardware, bad hardware setup or a very bad
> software emulation. 8KHz
> sound obviously does not sound CD-quality, but it
> should not have
> aliasing noise. It should just sound with lower
> bandwidth, specially
> higher frequencies being cutoff. Standard phone
> bandwidth is between
> 300-3400 Hz.
> Software resampling through removing or adding
> samples, and doing some
> mean value cooking is far from optimal. It would be
> better to use a
> recursive Z-tranform (or whatever math tool you
> prefer) synthesised
> algorithm. Even a small IIR filter for
> postprocessing would barely
> consume any CPU power. Such algorithms are well
> known and available.
>=20
> Best Regards
> --=20
> Manuel Jander
> Dipl.-Ing. Fachrichtung Elektronik
>=20
>=20
>=20
>
-------------------------------------------------------
> This SF.net email is sponsored by Demarc:
> A global provider of Threat Management Solutions.
> Download our HomeAdmin security software for free
> today!
> http://www.demarc.com/Info/Sentarus/hamr30
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/alsa-devel
>=20


=09

=09
	=09
__________________________________________________________________
D=E9couvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos=
 mails !=20
Cr=E9ez votre Yahoo! Mail sur http://fr.mail.yahoo.com/


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
