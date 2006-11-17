From: Bas Wijnen <wijnen@debian.org>
Subject: Setting the period size
Date: Fri, 17 Nov 2006 11:59:36 +0100
Message-ID: <20061117105936.GB29436@pcbcn10.phys.rug.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1006573904=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alsa Development mailing list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1006573904==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry if this came up before, the archives are so full of spam that I didn't
spend too much time browsing them. :-(

I'm writing several programs in C++ which use sound.  (For non-C++ people,
don't worry, there's not much non-C about this question.)  In a wrapper
library I want to hide all the nasty details.  I'm having some trouble with
that part.

When setting up the device, I use the code below.  Depending on the sound
card, I get "unable to set period size to 1024".  I can't imagine that no
valid size can be found.  Can someone tell me what's wrong with the code?

This is using the plughw device, so I'm extra surprised that even the
set_*_near function doesn't manage to find a usable value.

A sound card on which it fails is:
Intel 82801DB-ICH4 with AD1981B at 0xfebff800, irq 201

For some context, the full code is available at
https://pcbcn10.phys.rug.nl/cgi-bin/trac.cgi/browser/trunk/libshevek/sound-=
player.cc
(function player::thread::l_setup_device)

Please don't use it for your own projects yet, I intend to make major chang=
es
to the interface. :-)

Thanks,
Bas

Ps: shevek_error is a macro which is usually defined equivalently to
#define shevek_error(x) do { std::cerr << x; exit (1); } while (0)
so all the left-shift-operators are really insertions to standard error.


err =3D snd_pcm_hw_params_any (m_handle, m_hwparams);
if (err < 0)
{
	shevek_error ("unable to initialise parameter structure: "
			<< snd_strerror (err));
	return;
}

=2E....

err =3D snd_pcm_hw_params_set_channels (m_handle, m_hwparams,
		m_settings.channels);
if (err < 0)
{
	shevek_error ("unable to set channels: " << snd_strerror (err));
	return;
}
snd_pcm_uframes_t frames =3D 1 << (m_periodsize_log2 - m_frame_size_log2);
err =3D snd_pcm_hw_params_set_period_size_near
	(m_handle, m_hwparams, &frames, 0);
if (err < 0)
{
	shevek_error ("unable to set period size to " << frames << ": "
			<< snd_strerror (err));
	return;
}
err =3D snd_pcm_hw_params (m_handle, m_hwparams);
if (err < 0)
{
	shevek_error ("unable to set parameter structure: "
			<< snd_strerror (err));
	return;
}

--=20
I encourage people to send encrypted e-mail (see http://www.gnupg.org).
If you have problems reading my e-mail, use a better reader.
Please send the central message of e-mails as plain text
   in the message body, not as HTML and definitely not as MS Word.
Please do not use the MS Word format for attachments either.
For more information, see http://pcbcn10.phys.rug.nl/e-mail.html

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFXZYYFShl+2J8z5URAk6xAKC2KPfI8Fstz/ZTCubpT1/G124d5gCg0FC+
TDXNRrlTH0rIX1bTuEsZgFA=
=9On2
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--


--===============1006573904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1006573904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1006573904==--
