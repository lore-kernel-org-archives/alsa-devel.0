From: Laurielle LEA <lauriellelea@yahoo.fr>
Subject: RE: Sound with metal effect
Date: Mon, 4 Apr 2005 15:48:39 +0200 (CEST)
Message-ID: <20050404134839.62450.qmail@web25107.mail.ukl.yahoo.com>
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
To: Lee Revell <rlrevell@joe-job.com>
Cc: mjander@users.sourceforge.net, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--- Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2005-04-01 at 17:17 +0200, Laurielle LEA
> wrote:
> > In fact, in my read function,=20
> >=20
> > count =3D 320;
> > rc =3D snd_pcm_readi(audio_hdl, (short*)ptr, count);
> > I have to have rc =3D 320 but I receive just 160.
> >=20
> > You tell me about other algorithms but I don't
> > understand everything. Maybe I have to add other
> init
> > hardware parameters ?
> >=20
>=20
> Your read function takes the third argument in
> bytes.  But snd_pcm_readi
> expects "count" to be in frames.  It looks like you
> have an 8 bit stereo
> stream, or 2 bytes per frame.  So you did get 160
> frames (320 bytes).
> It looks like you need to set the device to 8 bit
> mono.
>=20
> Please see alsa-lib/test/latency.c for an example of
> the correct usage.
>=20
> Lee
>=20

But I have set=20
snd_pcm_hw_params_set_channels (audio_hdl,
hw_params,1)

If I write:

int
AudioDriversALSA::readBuffer (void *ptr, int bytes) {
  ssize_t count =3D bytes/2;   /* bytes=3D320 */
  ssize_t rc;
  do {
    rc =3D snd_pcm_readi(audio_hdl, (short*)ptr, count);
  } while (rc =3D=3D -EAGAIN);
 =20
  if (rc =3D=3D -EPIPE) {
    snd_pcm_prepare(audio_hdl);
  }
=20
  return rc;
}

I need to write  "rc =3D rc * 2;" before return rc in
order to send enough data, otherwise I receive metal
sound (microphone required 320 frames but got 160).
Maybe the variable names aren't chosen well.

Can you help me again ?
Does this pb generate  my overrun pb?

Thanks a lot.

Laurielle.


=09

=09
	=09
__________________________________________________________________
D=E9couvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos=
 mails !=20
Cr=E9ez votre Yahoo! Mail sur http://fr.mail.yahoo.com/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
