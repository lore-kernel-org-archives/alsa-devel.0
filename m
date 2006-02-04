From: Rimas Kudelis <rq@akl.lt>
Subject: Intel HDA and Realtek ALC 260
Date: Sat, 04 Feb 2006 12:17:40 +0200
Message-ID: <43E47F44.2010200@akl.lt>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0747D0C6E68C9A5D42B696C4"
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0747D0C6E68C9A5D42B696C4
Content-Type: text/plain; charset=windows-1257
Content-Transfer-Encoding: 7bit

Hello,

I'm one of the people affected by
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1618. And I
thought that maybe there's something I could to to help fix this bug
(that would mean adding another model description to the
patch_realtek.c). But when I look at that file, i don't quite understand
all those structures in it. So I have a question for the maintainer of
that module (I guess that's jwoithe) - would it be possible to add a
"test" model, like in case of ALC880, which would have controls for all
of the chipset pins available? I guess that would simplify things a lot...

On the other hand, if the latter is not really possible for some reason,
maybe you could send me the file patched the way you mentioned in the
last comment to that bug  (or just a patch to that file), so that I
could just recompile the modules and play with the controls until I get
the results, andreport them here or to the bugreport later?

regards,
Rimas "RQ" Kudelis


--------------enig0747D0C6E68C9A5D42B696C4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD5H9IAlYAh8azrv8RAmeBAJ0S9qeyKoGc+NVcFpU97trDfnox0wCghE3X
9wGD5gcDTvGLymim4rmv3J4=
=j92+
-----END PGP SIGNATURE-----

--------------enig0747D0C6E68C9A5D42B696C4--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
