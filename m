From: Lars Heineken <Lars.Heineken@gmx.de>
Subject: Additional info: Opening dev/dsp takes very long
Date: Sat, 13 Mar 2004 21:24:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40536DE0.5070303@gmx.de>
References: <40536881.4030903@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40536881.4030903@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

.. some more infos on the issue:

- - The delay does not affect output via alsa directly, only the
OSS-emulation.

- - Using XMMS and jumping around in the song (via the main slider)
creates the same delay every time the player jumps to the new position.

- - Some applications suffer from more delay than others, the worst one is
wavbreaker (3-4 seconds), it's barely usable.


Lars.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAU23grp9JEomxNXERAtzYAKCdWb4GWo9CO1m69V8Lid6qIscEbgCggOT8
5ZMWcX8TxhL5/AlFzCKHJJg=
=e554
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
