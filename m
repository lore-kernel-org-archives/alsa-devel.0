From: Laurielle LEA <lauriellelea@yahoo.fr>
Subject: Re: Overrun buffer
Date: Mon, 4 Apr 2005 21:39:42 +0200 (CEST)
Message-ID: <20050404193942.81331.qmail@web25106.mail.ukl.yahoo.com>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

To solve the overrun buffer, I found I can use
threshold:

snd_pcm_hw_params_free (hw_params);
if ((err =3D snd_pcm_sw_params_malloc (&sw_params)) < 0)
{
  fprintf (stderr, "cannot allocate software parameter
structure (%s)\n", snd_strerror (err));
  exit (1);
}
if ((err =3D snd_pcm_sw_params_current (audio_hdl,
sw_params)) < 0) {
  fprintf (stderr, "Unable to determine current
swparams (%s)\n", snd_strerror (err));
  exit (1);
}=09
if ((err =3D snd_pcm_sw_params_set_stop_threshold
(audio_hdl, sw_params, 0x7fffffff)) < 0)=20
{
  fprintf (stderr, "Unable to set stop threshold mode
(%s)\n", snd_strerror (err));
  exit (1);
}
if ((err =3D snd_pcm_sw_params (audio_hdl, sw_params)) <
0)=20
{
  fprintf (stderr, "cannot set sw-parameters (%s)\n",
snd_strerror (err));
  exit (1);
}=20
snd_pcm_sw_params_free (sw_params);


But now, I have a endless loop when I use DTMF, it
looks like the sound stay in card and it plays in
loop.
I would like to remove this sound in order to when I
press on one key it plays just this sound ?

Do you see what I mean?

Thanks.
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
