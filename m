From: iriXx <m@iriXx.org>
Subject: errors in symlinks in alsa-oss rc1 with mandrake 9.0
Date: Sun, 15 Dec 2002 17:44:58 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DFCBF9A.2090108@iriXx.org>
Reply-To: m@iriXx.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi all
just a note to say i had to modify the symlinks to 'missing',
'mkinstalldirs' and 'install-sh' to get alsa-oss-0.9.0rc1 to install
under mandrake 9.0.

it seems that from 9.0 mandrake puts automake in /usr/share/automake-1.4
rather than /usr/share/automake. i dont know if anyone wants to add a
detection for this to the config script?

bw
m~
- --
iriXx
www.iriXx.org

copyleft: creativity, technology and freedom?
info@copyleftmedia.org.uk
www.copyleftmedia.org.uk

~ _
( )  ascii ribbon against html email
~ X
/ \    cat /dev/sda1 > /dev/dsp


~  *** stopping make sense ***
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9/L+aGlmEEIa9/8YRApeaAJsGVSg/Bn9n0V+DdnapAFIR1C8boQCgqhHH
9M1ZetQs3d0qpvS/5mmN9Q0=
=cpwH
-----END PGP SIGNATURE-----



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
