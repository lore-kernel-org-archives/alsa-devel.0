From: Lars Heineken <Lars.Heineken@gmx.de>
Subject: Re: Request for change in /usr/share/alsa/cards/ICE1712.conf
Date: Fri, 12 Dec 2003 14:36:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FD9C46F.20300@gmx.de>
References: <3FD5EDEE.3040402@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FD5EDEE.3040402@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lars Heineken <Lars.Heineken@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Did someone take notice of my mail, at least :-)

Lars Heineken wrote:

| I tried some capturing through the spdif input today, and it didn't
| worked, but after some googleing found this mail from jaroslav:
|
| | Known bug. The problem is that playback and capture channels are
| | assymetric for the envy24 chip and we cannot define dual configuration
| | separate for playback and capture.
| |
| | You may change the line in /usr/share/alsa/cards/ICE1712.conf from
| |
| | slave.channels 10
| |
| | to
| |
| | slave.channels 12
| |
| | and capture will work, but playback will failure.
| |
| | Or define new S/PDIF PCM for capture in ~/.asoundrc:
| |
| | pcm.spdif_cap {
| |         ... copy contents of ICE1712.pcm.iec958.0 {} from ICE1712.conf
| here ...
| |         ... and replace 10 with 12 ...
| | }
|
| After setting the value to "12" I could capture AND playback !
|
| I suggest to set the value to 12 as default, would that be OK ?
|
| Regards,
|
| Lars.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/2cRvrp9JEomxNXERAu5dAJ9n9lKU9bmM3XB2AHf6v1nwyDKEhwCffuk8
TCCi8YfelFCgge2asS3HmZ0=
=iF8M
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
