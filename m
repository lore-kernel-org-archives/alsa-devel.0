From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: SiS7019
Date: Tue, 24 May 2005 00:02:28 +0200
Message-ID: <429252F4.8080409@winischhofer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hello,

for some reason people keep asking me (=SiS graphics developer) for a
sound driver for the SiS55x series (SoC) which contain a PCI sound
device with the ID 0x7019.

Since all other SiS sound devices (7018, 7012) are nearly identical to
other hardware (7018 = trident; 7012 = intel8x0) I don't really believe
that the 7019 is an exception.

Now for my question to you sound driver gurus: Does this

http://www.yasuoka.net/~yasuoka/sis7019.patch

look in any way familiar to any of you? This code is a NetBSD driver for
the SiS7019. Does this look similar to any driver what already exists?

Please cc: me as I am not subscribed.

Thomas

- --
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCklL0zydIRAktyUcRAnFLAKDHXXZ8JXbXNZINBlf/tWLAIb6TSACgtdwV
clnUqtoT/J3rQP26eqC7Gjc=
=Xe4m
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
