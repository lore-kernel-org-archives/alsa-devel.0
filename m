From: John Steele Scott <toojays@toojays.net>
Subject: how to resume pcm streams in driver? (esp. powermac snapper)
Date: Thu, 25 Nov 2004 17:48:12 +1030
Message-ID: <877joa1jnv.fsf@fuzz.toojays.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

--=-=-=

Hi,

In the last week or so Benjamin Herrenschmidt has released a kernel patch which
enables the sleep functionality on the iBook G4 and AlBook laptops.

I have an iBook G4 with Powermac Snapper audio. Most of the suspend/resume
functionality is fine, but one issue I am having a problem with is that pcm
streams are not being resumed.

The streams _are_ being suspended, but how are the supposed to be resumed? What
is the opposite of snd_pcm_suspend_all()?

I know the actual sound hardware is being restored (mostly) correctly, because
the "beep" functionality of the pmac driver works.

Any thoughts?

cheers,

John

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Messages with missing or bad signatures may have been forged or modified in transit!

iD8DBQBBpYdH0BW7kPcXjRURAg/IAKC0SACF6jtRz0yruBqgVv282aa6MgCg4ttr
oXrMhyy/ugGfTubj5w8xjfE=
=7vAW
-----END PGP SIGNATURE-----
--=-=-=--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
